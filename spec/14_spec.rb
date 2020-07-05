require '14/solution'

describe ReindeerJudge do
  it "solves part 1 test input" do
    reindeer_input = [
      "Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.",
      "Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds."
    ]
    judge = ReindeerJudge.new
    reindeer_input.each { |input| judge.add input }
    judge.race 1000
    expect(judge.winning_distance).to eq 1120
  end

  it "solves part 1" do
    judge = ReindeerJudge.new
    File.open('lib/14/input.txt') do |file|
      file.each_line { |line| judge.add line }
    end
    judge.race 2503
    expect(judge.winning_distance).to eq 2696
  end
end
