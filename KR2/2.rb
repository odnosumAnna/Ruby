# Прокуа для перевірки, чи є рядок паліндромом
is_palindrome = Proc.new do |str|
  str == str.reverse
end

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
