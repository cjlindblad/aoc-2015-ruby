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
      variant = @molecule.clone
      variant[match_index..(match_index + key.length - 1)] = value
      variant
    end
  end

  def matching_indices(search_string)
    # https://stackoverflow.com/questions/43329481/find-all-indices-of-a-substring-within-a-string/43329626#43329626
    @molecule.enum_for(:scan, /(?=#{search_string})/).map do
      Regexp.last_match.offset(0).first
    end
  end
end
