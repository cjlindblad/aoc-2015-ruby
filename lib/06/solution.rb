require 'set'

class LightGrid
  def initialize
    @lights = Set.new
  end

  def parse_instruction(instruction)
    command = case instruction
              when /turn on/
                :turn_on
              when /turn off/
                :turn_off
              when /toggle/
                :toggle
              end

    from, to = instruction
      .scan(/\d+,\d+/)
      .map { |e| e.split(',').map{ |e| e.to_i } }

    x_values = (from.first..to.first).to_a
    y_values = (from.last..to.last).to_a

    x_values.product(y_values).each do |coordinate|
      case command
      when :turn_on
        @lights.add coordinate
      when :turn_off
        @lights.delete coordinate
      when :toggle
        if @lights.include? coordinate
          @lights.delete coordinate
        else
          @lights.add coordinate
        end
      end
    end
  end

  def lights_lit
    @lights.size
  end
end
