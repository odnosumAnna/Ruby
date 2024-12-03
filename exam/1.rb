class FileProcessor
  def initialize(file_path)
    @file_path = file_path
  end

  #  lazy evaluation для обробки великого файлу
  def unique_lines
    Enumerator.new do |yielder|
      File.foreach(@file_path).lazy.uniq.each { |line| yielder << line }
    end
  end
end

if __FILE__ == $0
  #  шлях до файлу
  print "Введіть шлях до файлу: "
  file_path = gets.chomp

  # перевірка, чи існує файл
  unless File.exist?(file_path)
    puts "Файл не знайдено за вказаним шляхом!"
    exit
  end

  #  екземпляр класу FileProcessor
  processor = FileProcessor.new(file_path)

  #  унікальні рядки
  puts "Унікальні рядки у файлі:"
  processor.unique_lines.each { |line| puts line }
end

