require 'json'

class DocumentAnalyzer
  def initialize string
    @document = JSON.parse(string)
  end

  def sum avoid=nil
    @sum = 0
    traverse @document, avoid
    @sum
  end

  def traverse node, avoid
    node.each do |e|
      if e.is_a? Hash and avoid != nil and e.has_value? avoid
        next
      end

      if e.is_a? Array or e.is_a? Hash
        traverse e, avoid
      end

      @sum += e if e.is_a? Integer
    end
  end
end
