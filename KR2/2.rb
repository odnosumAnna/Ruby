# Прока для перевірки, чи є рядок паліндромом
is_palindrome = Proc.new do |str|
  str == str.reverse
end

# Метод для тестування проки
def test_is_palindrome(proc, test_cases)
  test_cases.each_with_index do |(input, expected), index|
    result = proc.call(input)
    if result == expected
      puts "Тест #{index + 1}: Успішно! (#{input.inspect} -> #{expected})"
    else
      puts "Тест #{index + 1}: Помилка! (#{input.inspect} -> отримано #{result}, очікувано #{expected})"
    end
  end
end

if __FILE__ == $0
  # список слів
  words = ["level", "world", "racecar", "ruby", "madam"]

  # перевіряємо кожне слово за допомогою проки
  words.each do |word|
    if is_palindrome.call(word)
      puts "#{word} є паліндромом"
    else
      puts "#{word} не є паліндромом"
    end
  end

  # Тестові випадки для перевірки
  test_cases = {
    "level" => true,
    "world" => false,
    "racecar" => true,
    "ruby" => false,
    "madam" => true,
    "12321" => true,
    "hello" => false,
    "" => true,
    "a" => true
  }

  # Запускаємо тести
  puts "\nРезультати тестування:"
  test_is_palindrome(is_palindrome, test_cases)
end
