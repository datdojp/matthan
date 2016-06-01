class OperationsController < AuthenticatedController

  def index
    @license_plate = params[:license_plate] || session[:license_plate]
    @from = params[:from] || session[:from]
    @to = params[:to] || session[:to]

    session[:from] = @from
    session[:to] = @to
    session[:license_plate] = @license_plate

    @cars = Car.where(owner_id: session[:owner]['id']).to_a

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

    @op_clusters = []
    operations = []
    @operations.each_with_index do |o, i|
      if operations.empty? || operations.last.seat_positions == o.seat_positions
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