require './Utilities/DataLoader.rb'

class DiagnosticBit
  def initialize
    @zero = 0
    @one = 0
  end

  def inc(value)
    if value == "0"
      @zero +=1
    elsif value == "1"
      @one += 1
    end
  end

  def most_common
    @zero > @one ? '0' : '1'
  end

  def least_common
    @zero > @one ? '1' : '0'
  end
end

class DiagnosticReport < DataLoader
  attr_reader :gamma_rate
  attr_reader :epsilon_rate
  # attr_reader :oxygen_generator_rating
  # attr_reader :co2_scrubber_rating

  def initialize(path)
    super
    @data_size = @@data[0].length

    @gamma_rate_binary, @epsilon_rate_binary = find_gamma_and_epsilon_binaries
    
    @gamma_rate = @gamma_rate_binary.to_i(2)
    @epsilon_rate = @epsilon_rate_binary.to_i(2)

    # @oxygen_generator_rating = 0
    # @co2_scrubber_rating = 0
  end

  protected

  def find_gamma_and_epsilon_binaries
    counts = Array.new(@data_size) {DiagnosticBit.new}

    @@data.each do |binary|
      binary.each_char.with_index do |bit, index|
        counts[index].inc(bit)
      end
    end

    gamma_binary = counts.map { |counter| counter.most_common }
    epsilon_binary = counts.map { |counter| counter.least_common }
    [gamma_binary.join, epsilon_binary.join]
  end

end