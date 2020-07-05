class SeatingPlanner
  def initialize
    @preferences = {}
  end

  def add_preference preference
    name = preference.match(/^\w+/).to_s.to_sym
    prefers = !!(preference.match /gain/)
    units = preference.match(/\d+/).to_s.to_i
    units *= -1 if !prefers
    neighbour = preference.match(/\w+(?=\.$)/).to_s.to_sym

    @preferences[name] = {} unless @preferences.include? name
    @preferences[name][neighbour] = units
  end

  def add_me
    guests = @preferences.keys
    @preferences[:me] = {}
    guests.each { |guest| @preferences[:me][guest] = 0 }

    guests.each do |guest|
      @preferences[guest][:me] = 0
    end
  end

  def optimal_happiness
    best_happiness = 0
    guests = @preferences.keys
    guests.permutation.each do |seating|
      happiness = calculate_happiness seating
      best_happiness = happiness if happiness > best_happiness
    end
    best_happiness
  end

  def calculate_happiness seating
    happiness = 0
    guests = seating.length
    seating.each_with_index do |guest, index|
      next_guest = seating[(index + 1) % guests]
      prev_guest = seating[(index + guests - 1) % guests]
      happiness += @preferences[guest][next_guest]
      happiness += @preferences[guest][prev_guest]
    end
    happiness
  end
end
