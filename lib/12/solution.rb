require 'json'

class DocumentAnalyzer
  def initialize string
    @document = JSON.parse(string)
  end

  def sum
    @sum = 0
    traverse @document
    @sum
  end

  def traverse node
    node.each do |e|
      if e.is_a? Array or e.is_a? Hash
        traverse e
      end

      @sum += e if e.is_a? Integer
    end
  end
end
