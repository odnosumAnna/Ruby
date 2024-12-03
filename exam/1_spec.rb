require 'rspec'
require_relative '1'

RSpec.describe FileProcessor do
  let(:file_path) { 'sample.txt' }
  let(:processor) { FileProcessor.new(file_path) }

  #  тестовий файл перед запуском тестів
  before do
    File.open(file_path, 'w') do |file|
      file.puts("Hello world")
      file.puts("Ruby is great")
      file.puts("Hello world")
      file.puts("Lazy evaluation is cool")
      file.puts("Ruby is great")
    end
  end

  # видаляємо тестовий файл після тестування
  after do
    File.delete(file_path) if File.exist?(file_path)
  end

  describe '#unique_lines' do
    it 'повертає унікальні рядки з файлу' do
      expected_lines = [
        "Hello world\n",
        "Ruby is great\n",
        "Lazy evaluation is cool\n"
      ]

      result = processor.unique_lines.to_a  # перетворюємо Enumerator на масив
      expect(result).to match_array(expected_lines)  # перевіряємо, що результати збігаються
    end
  end
end

