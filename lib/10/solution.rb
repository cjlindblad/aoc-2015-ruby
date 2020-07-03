class LookAndSay
  def self.next n
    result = n.gsub(/(.)\1*/).to_a.reduce("") {|a, c| a += (c.length.to_s + c[0]) }
    result
  end
end
