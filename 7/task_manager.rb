require 'date'
require 'json'

class Task
  attr_accessor :title, :deadline, :status

  def initialize(title, deadline)
    @title = title
    @deadline = Date.parse(deadline)
    @status = 'Невиконано'
  end

  def mark_as_completed
    @status = 'Виконано'
  end

  def to_h
    {
      'title' => @title,
      'deadline' => @deadline.to_s,
      'status' => @status
    }
  end

  def to_s
    "#{@title} (Дедлайн: #{@deadline}, Статус: #{@status})"
  end
end

class TaskManager
  def initialize(file_path)
    @file_path = file_path
    @tasks = load_tasks
  end

  def add_task(title, deadline)
    task = Task.new(title, deadline)
    @tasks << task
    save_tasks
    puts "Задача \"#{task.title}\" додана з дедлайном \"#{task.deadline}\"."
  end

  def remove_task(index)
    return puts "Задача з номером #{index} не знайдена." if index < 1 || index > @tasks.size

    task = @tasks.delete_at(index - 1)
    save_tasks
    puts "Задача \"#{task.title}\" видалена."
  end

  def edit_task(index, new_title, new_deadline)
    return puts "Задача з номером #{index} не знайдена." if index < 1 || index > @tasks.size

    task = @tasks[index - 1]
    task.title = new_title
    task.deadline = Date.parse(new_deadline)
    save_tasks
    puts "Задача \"#{task.title}\" оновлена з новим дедлайном \"#{task.deadline}\"."
  end

  def show_tasks
    if @tasks.empty?
      puts "Немає задач."
    else
      @tasks.each_with_index do |task, index|
        puts "#{index + 1}. #{task}"
      end
    end
  end

  def change_status(index)
    return puts "Задача з номером #{index} не знайдена." if index < 1 || index > @tasks.size

    task = @tasks[index - 1]
    task.mark_as_completed
    save_tasks
    puts "Задачу \"#{task.title}\" позначено як виконану."
  end

  def filter_tasks_by_status(status)
    filtered_tasks = @tasks.select { |task| task.status == status }
    if filtered_tasks.empty?
      puts "Немає задач зі статусом \"#{status}\"."
    else
      filtered_tasks.each_with_index do |task, index|
        puts "#{index + 1}. #{task}"
      end
    end
  end

  def filter_tasks_by_deadline(target_date)
    target_date = Date.parse(target_date) rescue nil
    return puts "Некоректна дата." unless target_date

    filtered_tasks = @tasks.select { |task| task.deadline <= target_date }

    if filtered_tasks.empty?
      puts "Задачі не знайдено для вказаної дати."
    else
      filtered_tasks.each_with_index do |task, index|
        puts "#{index + 1}. #{task}"
      end
    end
  end

  private

  def load_tasks
    return [] unless File.exist?(@file_path)

    file = File.read(@file_path)
    JSON.parse(file).map do |task_data|
      task = Task.new(task_data['title'], task_data['deadline'])
      task.status = task_data['status']
      task
    end
  end

  def save_tasks
    File.write(@file_path, @tasks.map(&:to_h).to_json)
  end
end
