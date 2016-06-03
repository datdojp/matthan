class AppUtil

  def self.duration_text(seconds)
    hours = seconds / (60 * 60)
    seconds = seconds % (60 * 60)
    minutes = seconds / 60
    seconds = seconds % 60
    return "#{left_pad(hours)}:#{left_pad(minutes)}:#{left_pad(seconds)}"
  end

  def self.left_pad(n)
    sprintf('%02d', n)
  end

end