require './Utilities/DataLoader.rb'

class DeadReckoningReport < DataLoader

  def initialize(path)
    super
    @data = @@data.map(&:to_i)
  end
end