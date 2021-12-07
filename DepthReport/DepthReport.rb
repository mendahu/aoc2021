require './Utilities/DataLoader.rb'

class DepthReport < DataLoader

  def initialize(path)
    super
    @data = @@data.map(&:to_i)
  end

  def read_increases_by_group_size(group_size) 
    count_increases(@data, group_size)
  end

  def count_increases(data, group_size)
    increases = 0
    prev_line = nil

    data.each do |line|      
        reading = line
      
        is_higher = prev_line && prev_line < reading
      
        increases += 1 if is_higher
        prev_line = reading
    end

    increases
  end
end