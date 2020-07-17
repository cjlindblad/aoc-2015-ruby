require '19/solution'
require 'set'

describe Parser do
  it "parses input" do
    input = <<-INPUT
    H => O
    O => H
    O => HH
    HO => OH

    HOHOHO
    INPUT

    parser = Parser.new(input)
    expect(parser.replacements).to eq [["H", "O"], ["O", "H"], ["O", "HH"], ["HO", "OH"]]
    expect(parser.molecule).to eq "HOHOHO"
  end
end

describe MoleculeReplacer do
  it "handles single replacement one time" do
    molecule = "HO"
    replacements = {"H" => "O"}
    replacer = MoleculeReplacer.new(molecule, replacements)
    distinct_variants = replacer.replace
    expect(distinct_variants).to eq ["OO"]
  end

  it "handles single replacement multiple times" do
    molecule = "HOH"
    replacements = [["H", "O"]]
    replacer = MoleculeReplacer.new(molecule, replacements)
    distinct_variants = replacer.replace
    expect(distinct_variants).to eq ["OOH", "HOO"]
  end 

  it "handles multiple replacements one time" do
    molecule = "HO"
    replacements = [["H", "O"], ["O", "H"]]
    replacer = MoleculeReplacer.new(molecule, replacements)
    distinct_variants = replacer.replace
    expect(distinct_variants).to eq ["OO", "HH"]
  end

  it "handles multiple replacements multiple times" do
    molecule = "HOH"
    replacements = [
      ["H", "HO"],
      ["H", "OH"],
      ["O", "HH"]
    ]
    replacer = MoleculeReplacer.new(molecule, replacements)
    distinct_variants = replacer.replace
    expect(distinct_variants).to eq ["HOOH", "HOHO", "OHOH", "HHHH"]
  end

  it "handles replacement keys with multiple character" do
    molecule = "H2O"
    replacements = [["H2", "X"]]
    replacer = MoleculeReplacer.new(molecule, replacements)
    distinct_variants = replacer.replace
    expect(distinct_variants).to eq ["XO"]
  end

  it "solves part 1" do
    input = File.read('lib/19/input.txt')
    parser = Parser.new(input)
    replacer = MoleculeReplacer.new(parser.molecule, parser.replacements)
    distinct_variants = replacer.replace
    expect(distinct_variants.length).to eq 535
  end
end

describe MoleculeFinder do
  it "finds HOHOHO from test input" do
    replacements = [
      ["e", "H"],
      ["e", "O"],
      ["H", "HO"],
      ["H", "OH"],
      ["O", "HH"]
    ]

    goal = "HOHOHO"
    finder = MoleculeFinder.new(replacements, goal)
    iterations = finder.find
    expect(iterations).to eq 6
  end

  it "solves part 1" do
    input = File.read('lib/19/input.txt')
    parser = Parser.new(input)
    finder = MoleculeFinder.new(parser.replacements, parser.molecule)
    iterations = finder.find
    expect(iterations).to eq 212
  end
end

