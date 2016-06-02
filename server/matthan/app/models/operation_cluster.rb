class OperationCluster

  attr_accessor :time_from,
                :time_to,
                :seat_pos_from,
                :seat_pos_to,
                :has_passenger,
                :only_driver,
                :engine_status

  def self.from_operations(operations)
    oc = OperationCluster.new
    operations.each do |o|
      if !oc.time_from || oc.time_from > o.time
        oc.time_from = o.time
        oc.seat_pos_from = o.seat_positions
      end
      if !oc.time_to || oc.time_to < o.time
        oc.time_to = o.time
        oc.seat_pos_to = o.seat_positions
      end
    end
    oc.has_passenger  = operations.first.seat_positions =~ /^..*1.*$/
    oc.only_driver    = operations.first.seat_positions =~ /^10+$/
    oc.engine_status  = operations.first.engine_status
    return oc
  end

  def duration_text
    seconds = time_to - time_from
    hours = seconds / (60 * 60)
    seconds = seconds % (60 * 60)
    minutes = seconds / 60
    seconds = seconds % 60
    return "#{left_pad(hours)}:#{left_pad(minutes)}:#{left_pad(seconds)}"
  end

  def seat_pos_from_text
    return seat_pos_text(seat_pos_from)
  end

  def seat_pos_to_text
    return seat_pos_text(seat_pos_to)
  end

  def engine_status_text
    engine_status == Operation::ENGINE_STATUS_ON ? "Mở" : "Tắt"
  end

  private

  def left_pad(n)
    sprintf('%02d', n)
  end

  def time_text(time)
    if time
      return Time.strftime()
    else
      return nil
    end
  end

  def seat_pos_text(seat_pos)
    if seat_pos
      available_seats = []
      seat_pos.split('').each_with_index do |part, i|
        if part == '1'
          available_seats << i + 1
        end
      end
      return available_seats.join(', ')
    else
      return ''
    end
  end
end