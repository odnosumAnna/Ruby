require 'rspec'
require_relative 'rss_generator'

RSpec.describe RSSGenerator do
  let(:test_directory) { './test_texts' }
  let(:test_rss_file) { 'test_feed.rss' }

  before do
    FileUtils.rm_rf(test_directory) if Dir.exist?(test_directory)
    FileUtils.rm_f(test_rss_file) if File.exist?(test_rss_file)
  end

  after do
    FileUtils.rm_rf(test_directory) if Dir.exist?(test_directory)
    FileUtils.rm_f(test_rss_file) if File.exist?(test_rss_file)
  end

  describe '#initialize' do
    it 'creates the sample directory and files if directory does not exist' do
      generator = RSSGenerator.new(test_directory, test_rss_file)
      expect(Dir.exist?(test_directory)).to be true
      expect(File.exist?(File.join(test_directory, 'sample1.txt'))).to be true
      expect(File.exist?(File.join(test_directory, 'sample2.txt'))).to be true
    end

    it 'does not overwrite existing files in the directory' do
      FileUtils.mkdir_p(test_directory)
      File.write(File.join(test_directory, 'existing.txt'), "Existing content")
      generator = RSSGenerator.new(test_directory, test_rss_file)
      expect(File.exist?(File.join(test_directory, 'existing.txt'))).to be true
      expect(File.read(File.join(test_directory, 'existing.txt'))).to eq("Existing content")
    end
  end

  describe '#generate_feed' do
    it 'generates an RSS feed file with items from text files' do
      generator = RSSGenerator.new(test_directory, test_rss_file)
      generator.generate_feed
      expect(File.exist?(test_rss_file)).to be true

      rss_content = File.read(test_rss_file)
      expect(rss_content).to include("RSS Feed from #{test_directory}")
      expect(rss_content).to include("Sample content for file 1.")
      expect(rss_content).to include("Sample content for file 2.")
    end

    it 'raises an error if the directory does not exist' do
      FileUtils.rm_rf(test_directory)
      generator = RSSGenerator.new(test_directory, test_rss_file)
      allow(generator).to receive(:load_text_files).and_raise("Directory not found: #{test_directory}")
      expect { generator.generate_feed }.to raise_error(RuntimeError, "Directory not found: #{test_directory}")
    end

    it 'raises an error if no text files are found in the directory' do
      FileUtils.mkdir_p(test_directory)
      generator = RSSGenerator.new(test_directory, test_rss_file)
      expect { generator.generate_feed }.to raise_error(RuntimeError, "No text files found in the directory: #{test_directory}")
    end
  end

  describe '#load_text_files' do
    it 'loads all text files from the directory with correct metadata' do
      generator = RSSGenerator.new(test_directory, test_rss_file)
      text_files = generator.send(:load_text_files)
      expect(text_files).to be_an(Array)
      expect(text_files.size).to eq(2)
      expect(text_files[0][:title]).to eq('sample1')
      expect(text_files[0][:content]).to eq('Sample content for file 1.')
      expect(text_files[1][:title]).to eq('sample2')
      expect(text_files[1][:content]).to eq('Sample content for file 2.')
    end
  end
end


#rspec rss_generator_spec.rb