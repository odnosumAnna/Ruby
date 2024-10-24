def all_numbers?(array)
  return false if array.empty?

  return false if array.include?(nil)

  array.all? { |element| element.is_a?(Numeric) }
end

#  використання
puts all_numbers?([1, 2, 3])          #  true
puts all_numbers?([1, '2', 3])        #  false
puts all_numbers?([])                 #  false
puts all_numbers?([1, 2, nil])        #  false
puts all_numbers?([1, 2.5, 3])        #  true
puts all_numbers?([1, 2, 'three'])    #  false
