require './Utilities/DataLoader.rb'

class DepthReport < DataLoader

  def initialize(path)
    super
    @data = @@data.map(&:to_i)
  end

  def read_increases_by_group_size(group_size)
    # From @tckmn/polyaoc-2021 - I don't know why this works, it isn't summing the whole window?
    @data[0...-group_size].zip(@data[group_size..-1]).count { |x,y| x<y }
  end
end