class StringCategorizer
  def self.nice?(string) 
    has_three_vowels = string =~ /([aeiou].*){3}/
    has_double_letters = string =~ /([a-z])\1/
    has_forbidden_strings = string =~ /ab|cd|pq|xy/

    !!(has_three_vowels and has_double_letters and has_forbidden_strings.nil?)
  end
end
