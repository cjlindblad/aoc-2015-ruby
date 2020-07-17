require 'set'

class Parser
  attr_reader :replacements, :molecule
  def initialize input
    @input = input
    @replacements = []
    input.each_line do |line|
      if line =~ /(\w+) => (\w+)/
        @replacements.push([$1, $2])
      end
    end
    @molecule = input.split("\n").last.strip
  end
end

class MoleculeReplacer
  attr_accessor :molecule

  def initialize(molecule, replacements)
    @molecule = molecule
    @replacements = replacements
  end

  def replace
    variants = Set.new
    @replacements.each do |key, value|
      variants.merge(variants_for(key, value))
    end
    variants.to_a
  end

  def variants_for(key, value)
    matching_indices(key).map do |match_index|
      pre_match = @molecule[0...match_index]
      post_match = @molecule[(match_index + key.length)..]
      "#{pre_match}#{value}#{post_match}"
    end
  end

  def matching_indices(search_string)
    # https://stackoverflow.com/questions/43329481/find-all-indices-of-a-substring-within-a-string/43329626#43329626
    @molecule.enum_for(:scan, /(?=#{search_string})/).map do
      Regexp.last_match.offset(0).first
    end
  end
end

class MoleculeFinder
  def initialize(replacements, goal)
    @replacements = replacements
    @goal = goal
  end

  def find
    sorted_replacements= @replacements.sort {|e| e.last.length}
    molecule = @goal
    iterations = 0
    until molecule == "e"
      sorted_replacements.each do |replacement|
        if molecule =~ /#{replacement.last}/
          molecule.sub!(replacement.last, replacement.first)
          break
        end
      end
      iterations += 1
    end
    iterations
  end
end

