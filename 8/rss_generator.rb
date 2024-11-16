require 'rss'
require 'fileutils'

class RSSGenerator
  attr_reader :directory, :rss_file

  def initialize(directory, rss_file = 'feed.rss')
    @directory = directory
    @rss_file = rss_file
    create_sample_files if !Dir.exist?(directory)
  end

  def create_sample_files
    Dir.mkdir(directory)
    File.write(File.join(directory, 'sample1.txt'), "Sample content for file 1.")
    File.write(File.join(directory, 'sample2.txt'), "Sample content for file 2.")
    puts "Sample directory and files created in: #{directory}"
  end

  def generate_feed
    raise "Directory not found: #{directory}" unless Dir.exist?(directory)

    items = load_text_files

    rss = RSS::Maker.make("2.0") do |maker|
      maker.channel.title = "RSS Feed from #{directory}"
      maker.channel.link = "http://example.com"
      maker.channel.description = "RSS feed generated from text files in the directory: #{directory}"
      maker.channel.language = "en"

      items.each do |item|
        maker.items.new_item do |rss_item|
          rss_item.title = item[:title]
          rss_item.link = "http://example.com/#{item[:title].gsub(/\s+/, '_')}"
          rss_item.description = item[:content]
          rss_item.pubDate = item[:date]
        end
      end
    end

    File.write(rss_file, rss)
    puts "RSS feed successfully generated: #{rss_file}"
  end

  private

  def load_text_files
    text_files = Dir.glob(File.join(directory, '*.txt'))
    raise "No text files found in the directory: #{directory}" if text_files.empty?

    text_files.map do |file|
      {
        title: File.basename(file, '.txt'),
        content: File.read(file).strip,
        date: File.mtime(file)
      }
    end
  end
end

if __FILE__ == $0
  directory = ARGV[0] || './texts'
  rss_file = ARGV[1] || 'feed.rss'

  begin
    generator = RSSGenerator.new(directory, rss_file)
    generator.generate_feed
  rescue StandardError => e
    puts "Error: #{e.message}"
  end
end


