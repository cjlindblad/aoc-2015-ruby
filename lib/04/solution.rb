require 'digest'

class Miner
  def initialize (key)
    @key = key
  end

  def find (match)
    number = 0
    hash = ''
    until hash =~ match do
      number += 1
      hash = Digest::MD5.hexdigest(@key + number.to_s)
    end
    return number
  end
end
