options = ['rock', 'scissors', 'paper']

puts "Вітаю у грі 'Rock, Scissors, Paper'!"
puts "Виберіть один з варіантів: rock, scissors або paper"

print "Ваш вибір: "
user_choice = gets.chomp

puts "Ваш вибір: '#{user_choice}'"
if options.include?(user_choice)
  computer_choice = options.sample
  puts "Вибір комп'ютера: #{computer_choice}"

  if user_choice == computer_choice
    puts "Нічия!"
  elsif (user_choice == 'rock' && computer_choice == 'scissors') ||
    (user_choice == 'scissors' && computer_choice == 'paper') ||
    (user_choice == 'paper' && computer_choice == 'rock')
    puts "Ви перемогли!!!"
  else
    puts "Комп'ютер переміг!"
  end
else
  puts "Спробуйте знову, оберіть: rock, scissors, paper."
end
