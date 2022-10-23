module Enumerable
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    my_each do |elem|
      yield elem, index
      index += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    arr = []
    my_each_with_index do |elem, index|
      truthy_elem = (yield elem, index)
      arr.push elem if truthy_elem == true
    end
    arr
  end

  def my_all?
    my_each do |elem|
      if block_given? && yield(elem) == false
        return false
      elsif elem == false
        return false
      end
    end
    true
  end

  def my_any?(pattern = nil)
    # My own code. (A mess)
    truthy = 0
    my_each do |elem|
      if block_given? && yield(elem) == true
        truthy += 1
      elsif pattern == elem
        truthy += 1
      end
    end
    truthy.positive? ? true : false

    
    # Code is a reference from crespire's code. For observation purpose.
    
    # def my_any?(pattern = nil)
    #   expr = block_given? ? ->(elem) { yield elem } : ->(elem) { pattern === elem }
    #   my_each { |elem| return true if expr.call(elem) }
    #   false
    # end
  
    # Another code that shows how to use Proc

    # def my_any?(argv=nil, &block)
    #   block = Proc.new { |item| item unless item.nil? || !item } unless block_given?
    #   block = Proc.new { |item| item if argv === item} unless argv.nil?
    #   self.my_each { |item| return true if block.call(item)}
  
    #   false
    # end
  end

  def my_none?
    falsy = 0
    my_each do |elem|
      if block_given? && yield(elem) == false
        falsy += 1
      elsif elem == false
        falsy += 1
      end
    end
    falsy == count ? true : false
  end

  def my_count
    count = 0
    my_each do |elem|
      if block_given? && yield(elem) == true
        count += 1
      elsif block_given? == false
        count += 1
      end
    end
    count
  end

  def my_map
    array = []
    each do |elem|
      return to_enum(:my_map) unless block_given?

      array << yield(elem)
    end
    array
  end

  def my_inject(int_val = 0)
    sum = int_val.to_i
    each do |elem|
      sum = yield(sum, elem)
    end
    sum
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    return to_enum(:my_each) unless block_given?
    i = 0
    while i < count
      yield self[i]
      i += 1
    end
    self

    # for el in self
    #   yield el
    # end
  end
end
