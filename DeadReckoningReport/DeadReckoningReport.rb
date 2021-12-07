require './Utilities/DataLoader.rb'

class DeadReckoningReport < DataLoader

  def initialize(path)
    super
    @data = @@data.map do |command| 
      dir, val = command.split
      [dir, val.to_i]
    end
  end

  def calculate_new_position
    totals = @data.group_by(&:first).transform_values do |groups|
      groups.map(&:last).sum
    end
    forward, down, up = totals.values_at('forward', 'down', 'up')
    new_position = forward * (down - up)
    new_position
  end
end