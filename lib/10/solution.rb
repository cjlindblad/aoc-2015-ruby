class LookAndSay
  def self.next n
    result = n.gsub(/(.)\1*/).to_a.reduce(StringIO.new) {|a, c| a << "#{c.length}#{c[0]}" }
    result.string
  end
end
