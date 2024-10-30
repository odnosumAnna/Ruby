require 'rspec'
require_relative 'task_manager'

RSpec.describe TaskManager do
  let(:file_path) { 'test_tasks.json' }
  let(:task_manager) { TaskManager.new(file_path) }

  after(:each) do
    File.delete(file_path) if File.exist?(file_path)
  end

  describe '#add_task' do
    it 'додає нову задачу' do
      task_manager.add_task('Перша задача', '2024-12-31')
      expect(task_manager.instance_variable_get(:@tasks).size).to eq(1)
      expect(task_manager.instance_variable_get(:@tasks)[0].title).to eq('Перша задача')
    end
  end

  describe '#remove_task' do
    before do
      task_manager.add_task('Задача для видалення', '2024-12-31')
    end

    it 'видаляє задачу за індексом' do
      task_manager.remove_task(1)
      expect(task_manager.instance_variable_get(:@tasks)).to be_empty
    end

    it 'не видаляє задачу з некоректним індексом' do
      expect { task_manager.remove_task(2) }.to output(/не знайдена/).to_stdout
    end
  end

  describe '#edit_task' do
    before do
      task_manager.add_task('Задача для редагування', '2024-12-31')
    end

    it 'редагує існуючу задачу' do
      task_manager.edit_task(1, 'Редагована задача', '2024-11-30')
      edited_task = task_manager.instance_variable_get(:@tasks)[0]
      expect(edited_task.title).to eq('Редагована задача')
      expect(edited_task.deadline).to eq(Date.parse('2024-11-30'))
    end

    it 'не редагує задачу з некоректним індексом' do
      expect { task_manager.edit_task(2, 'Задача', '2024-11-30') }.to output(/не знайдена/).to_stdout
    end
  end
end
