# Метод для інкременту елементів
def increment_array_elements(arr)
  arr.each do |element|
    yield(element)  # викликаємо блок для кожного елемента
  end
end

# Тестові випадки для перевірки
test_cases = {
  [1, 2, 3, 4] => [2, 3, 4, 5],
  [] => [],
  [-1, 0, 1] => [0, 1, 2],
  [1.1, 2.2, 3.3] => [2.1, 3.2, 4.3],
  [100] => [101]
}

# Метод для запуску тестів
def test_increment_array_elements(method, test_cases)
  test_cases.each_with_index do |(input, expected_output), index|
    result = []
    method.call(input) { |number| result << number + 1 }
    if result == expected_output
      puts "Тест #{index + 1}: Успішно (#{input} -> #{result})"
    else
      puts "Тест #{index + 1}: Провалено (#{input} -> #{result}, очікувалось #{expected_output})"
    end
  end
end

# Викликаємо метод з блоком
incremented_array = []
increment_array_elements([1, 2, 3, 4]) do |number|
  incremented_array << number + 1  # додаємо 1 до числа
end

puts incremented_array  # виведе: [2, 3, 4, 5]

# Запускаємо тести
puts "\nРезультати тестування:"
test_increment_array_elements(->(arr, &block) { increment_array_elements(arr, &block) }, test_cases)
