require_relative 'task_manager'

def main
  task_manager = TaskManager.new('tasks.json')

  loop do
    puts "\nМеню:"
    puts "1. Додати задачу"
    puts "2. Видалити задачу"
    puts "3. Редагувати задачу"
    puts "4. Показати всі задачі"
    puts "5. Змінити статус задачі"
    puts "6. Фільтрувати задачі за статусом"
    puts "7. Фільтрувати задачі за термінами"
    puts "8. Вийти"
    print "Оберіть опцію: "
    option = gets.chomp.to_i

    case option
    when 1
      print "Введіть назву задачі: "
      title = gets.chomp
      print "Введіть дедлайн (YYYY-MM-DD): "
      deadline = gets.chomp
      task_manager.add_task(title, deadline)
    when 2
      task_manager.show_tasks
      print "Введіть номер задачі для видалення: "
      index = gets.chomp.to_i
      task_manager.remove_task(index)
    when 3
      task_manager.show_tasks
      print "Введіть номер задачі для редагування: "
      index = gets.chomp.to_i
      print "Введіть нову назву задачі: "
      new_title = gets.chomp
      print "Введіть новий дедлайн (YYYY-MM-DD): "
      new_deadline = gets.chomp
      task_manager.edit_task(index, new_title, new_deadline)
    when 4
      task_manager.show_tasks
    when 5
      task_manager.show_tasks
      print "Введіть номер задачі для зміни статусу: "
      index = gets.chomp.to_i
      task_manager.change_status(index)
    when 6
      print "Введіть статус для фільтрації (Виконано/Невиконано): "
      status = gets.chomp
      task_manager.filter_tasks_by_status(status)
    when 7
      print "Введіть дату для фільтрації (YYYY-MM-DD): "
      date_input = gets.chomp
      task_manager.filter_tasks_by_deadline(date_input)
    when 8
      puts "Дякуємо за використання програми!"
      break
    else
      puts "Невірна опція. Спробуйте ще раз."
    end
  end
end

if __FILE__ == $0
  main
end