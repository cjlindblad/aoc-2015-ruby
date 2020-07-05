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

      update_score
    end
  end
  
  def update_score
    sort_reindeers_by :distance
    leading_distance = @reindeers.first.distance
    @reindeers.select { |reindeer| reindeer.distance == leading_distance }
      .each { |reindeer| reindeer.add_point }
  end

  def sort_reindeers_by property
    @reindeers.sort_by! { |reindeer| reindeer.send(property) }.reverse!
  end

  def winning_distance
    sort_reindeers_by :distance
    @reindeers.first.distance
  end

  def winning_score
    sort_reindeers_by :points
    @reindeers.first.points
  end
end

class Reindeer
  attr_reader :name, :plan, :distance, :points

  def initialize name, plan
    @name = name
    @plan = plan
    @distance = 0
    @points = 0
  end

  def update index
    @distance += @plan[index % @plan.length]
  end

  def add_point
    @points += 1
  end
end
