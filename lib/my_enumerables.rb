module Enumerable
  def my_each_with_index
    index = 0
    self.my_each do |elem|
      yield elem, index
      index += 1
    end
    self
  end

  def my_select
    arr = []
    self.my_each_with_index do |elem, index|
      truthy_elem = (yield elem, index)
      arr.push elem if truthy_elem == true
    end
    arr
  end

  def my_all?
    self.my_each do |elem|
      if block_given? && yield(elem) == false
        return false
      elsif elem == false
        return false
      end
    end
    true
  end

  def my_any?
    truthy = 0
    self.my_each do |elem|
      if block_given? && yield(elem) == true
        truthy += 1
      elsif elem == true
        truthy += 1
      end
    end
    truthy.positive? ? true : false
  end

  def my_none?
    falsy = 0
    self.my_each do |elem|
      if block_given? && yield(elem) == false
        falsy += 1
      elsif elem == false
        falsy += 1
      end
    end
    falsy == self.count ? true : false
  end

  def my_count
    count = 0
    self.my_each do |elem|
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
    self.each do |elem|
      return to_enum(:my_map) unless block_given?

      array << yield(elem)
    end
    array
  end

  def my_inject(int_val = 0)
    sum = int_val.to_i
    self.each do |elem|
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
    i = 0
    while i < self.count
      yield self[i]
      i += 1
    end
    self
  end
end
