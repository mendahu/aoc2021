class DataLoader
  def initialize(path)
    file = File.open(path)
    @@data = file.readlines.map(&:chomp)
  end
end