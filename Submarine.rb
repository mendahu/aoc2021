require './DepthReport/DepthReport'
require './DeadReckoningReport/DeadReckoningReport'
require './DiagnosticReport/DiagnosticReport'

class Submarine
  def initialize
    @report_map = {
      'depth' => DepthReport,
      'dead-reckoning' => DeadReckoningReport,
      'diagnostics' => DiagnosticReport
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

  def report_new_position
    dead_reckoning = @data['dead-reckoning']
    new_position = dead_reckoning.calculate_new_position
    puts "The submarine's new position is #{new_position}."
  end

  def report_better_new_position
    dead_reckoning = @data['dead-reckoning']
    new_position = dead_reckoning.calculate_better_new_position
    puts "The submarine's new position is #{new_position}."
  end

  def report_power_consumption
    diagnostics = @data['diagnostics']
    puts diagnostics.gamma_rate * diagnostics.epsilon_rate
  end

end
