require './DepthReport/DepthReport'
require './DeadReckoningReport/DeadReckoningReport'
require './DiagnosticReport/DiagnosticReport'

class Submarine
  def initialize
    @report_map = {
      'depth' => DepthReport
      'dead-reckoning' => DeadReckoningReport
      'diagnostics' => DiagnosticReport,
    }
    @data = Hash.new
  end

  def load_data(label, path)
    @data[label] = @report_map[label].new(path)
  end

  def report_depth_increases_by_group_size(group_size)
    depth = @data['depth']
    increases = depth.read_increases_by_group_size(group_size)
    puts "#{increases} measurements are larger than the previous measurement."
  end

end
