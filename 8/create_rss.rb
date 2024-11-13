require 'rss'
require 'time'

# Функція для створення RSS-стрічки з текстових файлів
def create_rss_from_files(files)
  rss = RSS::Maker.make('2.0') do |maker|
    maker.channel.title = "Моя RSS-стрічка"
    maker.channel.link = "http://example.com"
    maker.channel.description = "RSS-стрічка з текстових файлів"

    files.each do |file|
      content = File.read(file)
      maker.items.new_item do |item|
        item.title = File.basename(file, ".*") # Заголовок з імені файлу
        item.link = "http://example.com/#{File.basename(file, ".*")}"
        item.description = content
        item.pubDate = Time.now.rfc2822
      end
    end
  end

  # Отримання результату RSS в форматі XML
  rss_xml = rss.to_s

  # Додавання просторів для імен вручну
  rss_xml.sub!('<rss version="2.0">', '<rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:trackback="http://madskills.com/public/xml/rss/module/trackback/">')

  # Додавання тегу dc:date вручну в кожен item
  rss_xml.gsub!(/<item>/) do |item|
    item.sub!('</item>', "<dc:date>#{Time.now.iso8601}</dc:date></item>")
  end

  rss_xml
end

# Збереження RSS в файл
def save_rss_to_file(rss, filename)
  File.open(filename, 'w') do |file|
    file.write(rss)
  end
end

# Тестування функції
def test_create_rss_from_files
  files = ["article1.txt", "article2.txt", "article3.txt"] # Список тестових файлів
  files.each do |file|
    File.open(file, 'w') { |f| f.write("Це вміст #{file}") }
  end

  rss = create_rss_from_files(files)
  save_rss_to_file(rss, "rss_feed.xml")

  # Перевірка, чи файл з RSS створений
  if File.exist?("rss_feed.xml")
    puts "RSS-стрічка була успішно створена!"
  else
    puts "Щось пішло не так при створенні RSS-стрічки."
  end

  # Перевірка вмісту RSS
  rss_content = File.read("rss_feed.xml")
  if rss_content.include?("<rss version=\"2.0\">") && rss_content.include?("<title>Моя RSS-стрічка</title>")
    puts "Тест пройдено успішно!"
  else
    puts "Тест не пройдено!"
  end
end

# Виконати тест
test_create_rss_from_files
