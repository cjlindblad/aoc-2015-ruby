class ReindeerJudge
  def initialize
    @reindeers = []
  end

  def add input
    input.match /^(\w+) .* (\d+) .* (\d+) .* (\d+)/
    name = $1.to_s
    plan = ([$2.to_i] * $3.to_i) + ([0] * $4.to_i)
    reindeer = Reindeer.new name, plan
    @reindeers.push reindeer
  end

  def race duration
    duration.times do |i|
      @reindeers.each do |reindeer|
        reindeer.update i
      end
    end
  end

  def winning_distance
    @reindeers.sort_by { |reindeer| reindeer.distance }
      .reverse!
      .first
      .distance
  end
end

class Reindeer
  attr_reader :name, :plan, :distance

  def initialize name, plan
    @name = name
    @plan = plan
    @distance = 0
  end

  def update index
    @distance += @plan[index % @plan.length]
  end
end
