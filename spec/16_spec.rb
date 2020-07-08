require '16/solution'

describe "day 16" do
  it "solves part 1" do
    mfcsam = MFCSAM.new
    File.open('lib/16/input.txt') do |file|
      file.each_line do |line|
        mfcsam.add_sue line
      end
    end
    matching_sue = mfcsam.find_matching_sue
    expect(matching_sue).to eq 373
  end

  it "solves part 2" do
    mfcsam = MFCSAM.new :part2
    File.open('lib/16/input.txt') do |file|
      file.each_line do |line|
        mfcsam.add_sue line
      end
    end
    matching_sue = mfcsam.find_matching_sue
    expect(matching_sue).to eq 260
  end
end
