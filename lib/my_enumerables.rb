module Enumerable
  def my_each_with_index
    index = 0
    self.each do |elem|
      yield elem, index
      index += 1
    end
    self
  end

  def my_select
    arr = []
    self.each_with_index do |elem, index|
      truthy_elem = (yield elem, index)
      arr.push elem if truthy_elem == true
    end
    arr
  end

  def my_all?
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
