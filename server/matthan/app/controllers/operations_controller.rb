class OperationsController < AuthenticatedController

  STATUS_UNSPECIFIED    = 0
  STATUS_HAS_PASSENGER  = 1
  STATUS_ONLY_DRIVER    = 2
  STATUS_ENGINE_ON      = 3

  def index
    # get argument from params
    @license_plate = params[:license_plate] || session[:license_plate]
    @from = params[:from] || session[:from]
    @to = params[:to] || session[:to]
    @status = (params[:status] || session[:status] || STATUS_UNSPECIFIED).to_i


    # save arguments to session for future display
    session[:license_plate] = @license_plate
    session[:from] = @from
    session[:to] = @to
    session[:status] = @status

    # query list of cars to display in combo box
    @cars = Car.where(owner_id: session[:owner]['id']).to_a

    # query for operations
    query = Operation.all
    if @license_plate
      car = Car.where(license_plate: @license_plate).first
      if car
        query = query.where(car: car)
      end
    end
    if @from && !@from.empty?
      query = query.where(time: {:$gte => to_time(@from)})
    end
    if @to && !@to.empty?
      query = query.where(time: {:$lte => to_time(@to)})
    end
    @operations = query.order_by(time: :asc).to_a

    # group operations into clusters
    @op_clusters = []
    operations = []
    @operations.each_with_index do |o, i|
      if operations.empty? ||
         ( operations.last.seat_positions == o.seat_positions &&
           operations.last.engine_status == o.engine_status )
        operations << o
      else
        operations << o
        @op_clusters << OperationCluster.from_operations(operations)
        operations = [o]
      end
    end
    unless operations.empty?
       @op_clusters << OperationCluster.from_operations(operations)
    end

    # filter clusters
    @op_clusters.select! do |oc|
      if @status == STATUS_HAS_PASSENGER
        oc.has_passenger
      elsif @status == STATUS_ONLY_DRIVER
        oc.only_driver
      elsif @status == STATUS_ENGINE_ON
        oc.engine_status == Operation::ENGINE_STATUS_ON
      else
        true
      end
    end

    # calculate sum time
    @sum_duration = 0
    @op_clusters.each { |oc| @sum_duration += oc.duration }
  end

  private

  def to_time(s)
    if s && !s.empty?
      return Time.strptime("#{s} #{FIXED_TIMEZONE}", "%d/%m/%Y %H:%M %z")
    else
      return nil
    end
  end

end