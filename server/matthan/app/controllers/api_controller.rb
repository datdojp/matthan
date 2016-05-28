class ApiController < ActionController::Baseß

  def report
    # validate
    unless validate_params_exist(:sx, :vtn, :tg, :ttmm, :vt, :txc)
      return
    end

    # get car
    license_plate = params[:sx]
    car = Car.where(license_plate: license_plate).first
    unless car
      render json: {
        err: ERR_OBJECT_NOT_FOUND,
        err_msg: "Can not find car having license plate '#{license_plate}'"
      }
      return
    end

    # create operator
    operation = Operation.new
    operation.car = car
    operation.seat_positions = params[:vtn]
    operation.time = Time.strptime("#{params[:tg]}#{FIXED_TIMEZONE}", '%Y%m%d%H%M%S%z')
    operation.engine_status = params[:ttmm]
    operation.speed = params[:vt].to_f
    operation.transaction_id = params[:txc]
    operation.save

    # response
    render json: {
      err: 0
    }
  end

  private

  def validate_params_exist(*fields)
    fields.each do |f|
      unless f
        render json: {
          err: ERR_INVALID_PARAM,
          err_msg: "'#{f}' is required"
        }
        return false
      end
    end
    return true
  end
end