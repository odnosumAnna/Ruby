def increment_array_elements(arr)
  arr.each do |element|
    yield(element)  # викликаємо блок для кожного елемента
  end
end

# Виклик методу з блоком
incremented_array = []
increment_array_elements([1, 2, 3, 4]) do |number|
  incremented_array << number + 1  # додаємо 1 до числа
end

puts incremented_array  # виведе: [2, 3, 4, 5]

