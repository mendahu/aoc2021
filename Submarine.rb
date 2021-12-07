require './DepthReport/DepthReport'

class Submarine
  def initialize
    @report_map = {
      'depth' => DepthReport
    }
    @data = Hash.new
  end

  def load_data(label, path)
    @data[label] = @report_map[label].new(path)
  end

  def report_depth_increases_by_group_size(group_size)
    depth = @data['depth']
    puts depth.read_increases_by_group_size(group_size)
  end

end
