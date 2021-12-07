class Window
  def initialize(array)
    @val1 = array[0].to_i
    @val2 = array[1].to_i
    @val3 = array[2].to_i
  end

  def sum
    @val1 + @val2 + @val3
  end
end

class Sounding
  def initialize(path)
    file = File.open(path)
    @readings = file.readlines.map { |line| line.chomp.to_i }
    @increases = 0
  end

  def get_window_from_index(index)
    readings = [
      @readings[index],
      @readings[index + 1],
      @readings[index + 2]
    ]
    window = Window.new(readings)
    return window
  end

  def calculate_increases(range)
    i = 0
    max = @readings.length - range

    while i <= max do
      range1 = get_window_from_index(i)
      range2 = get_window_from_index(i + 1)

      @increases += 1 if range1.sum < range2.sum
      i += 1
    end

    @increases
  end

end

sounding = Sounding.new('./01a-data')
puts sounding.calculate_increases(3)