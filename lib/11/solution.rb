class PasswordIterator
  def initialize password
    @password = password
  end

  def next_password
    char_index = -1
    wrapped = false

    loop do
      prev_ch = @password[char_index]
      next_ch = next_char(prev_ch)
      @password[char_index] = next_ch 
      char_index -= 1
      wrapped = wrapped?(prev_ch, next_ch)
      break if !wrapped || char_index.abs > @password.length
    end

    @password
  end

  def wrapped? prev_char, next_char
    prev_char.ord > next_char.ord
  end

  def next_char char
    ord_offset = 97
    letters = 26
    ((char.ord - ord_offset + 1) % letters + ord_offset).chr
  end
end

class PasswordValidator
  def valid? password
    has_consecutive_triplet = password.match /abc|bcd|cde|def|efg|fgh|ghi|hij|ijk|jkl|klm|lmn|mno|nop|opq|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz/
    has_forbidden_characters = password.match /i|o|l/
    has_two_doubles = password.match(/([a-z])\1.*([a-z])\2/) and $1 != $2
    !!(has_consecutive_triplet && !has_forbidden_characters && has_two_doubles)
  end
end

class PasswordCalculator
  def self.next_valid password
    validator = PasswordValidator.new
    iterator = PasswordIterator.new password
    pwd = ""
    loop do
      pwd = iterator.next_password
      break if validator.valid? pwd
      illegal_char = pwd.match(/i|o|l/).to_s
      if illegal_char != ""
        base = pwd.split(illegal_char)[0]
        next_char = ((illegal_char.ord) + 1).chr
        next_password = base + next_char +  "a" * (pwd.length - (base.length + 1))
        iterator = PasswordIterator.new next_password
      end
    end
    pwd
  end
end
