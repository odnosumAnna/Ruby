class Bank
  def initialize
    @accounts = []
  end
  def open_account(account_name)
    return puts "Ім'я рахунку не може бути порожнім!" if account_name.strip.empty?

    if @accounts.include?(account_name)
      puts "Рахунок '#{account_name}' вже існує!"
    else
      @accounts << account_name
      puts "Рахунок '#{account_name}' успішно відкрито!"
    end
  end
  def list_accounts
    if @accounts.empty?
      puts "Список рахунків порожній."
    else
      puts "Список рахунків:"
      @accounts.each { |account| puts account }
    end
  end
end
# використання
bank = Bank.new
bank.open_account("Рахунок 1")
bank.open_account("Рахунок 2")
bank.open_account("Рахунок 1")
bank.list_accounts
