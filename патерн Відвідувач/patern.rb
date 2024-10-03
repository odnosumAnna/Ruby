# Базовий клас Employee (Працівник)
class Employee
  attr_reader :name, :salary

  def initialize(name, salary)
    @name = name
    @salary = salary
  end

  def accept(visitor)
    visitor.visit(self)
  end
end

#  Manager , успадковує від Employee
class Manager < Employee
  def accept(visitor)
    visitor.visit_manager(self)
  end
end

#  Intern , успадковує від Employee
class Intern < Employee
  def accept(visitor)
    visitor.visit_intern(self)
  end
end

# Інтерфейс EmployeeVisitor (Відвідувач)
module EmployeeVisitor
  def visit_manager(manager); end
  def visit_intern(intern); end
end

# (Калькулятор зарплат)
class SalaryCalculator
  include EmployeeVisitor

  def visit(employee)
    puts "Salary for #{employee.name}: #{employee.salary}"
  end

  def visit_manager(manager)
    puts "Salary for #{manager.name} (Manager): #{manager.salary + 5000}"
  end

  def visit_intern(intern)
    puts "Salary for #{intern.name} (Intern): #{intern.salary}"
  end
end

# (Калькулятор бонусів)
class BonusCalculator
  include EmployeeVisitor

  def visit(employee)
    bonus = employee.salary * 0.1
    puts "Bonus for #{employee.name}: #{bonus}"
  end

  def visit_manager(manager)
    bonus = manager.salary * 0.2
    puts "Bonus for #{manager.name} (Manager): #{bonus}"
  end

  def visit_intern(intern)
    bonus = intern.salary * 0.05
    puts "Bonus for #{intern.name} (Intern): #{bonus}"
  end
end

# об'єкти різних типів працівників
employee1 = Employee.new("John Doe", 50000)
employee2 = Manager.new("Jane Smith", 60000)
employee3 = Intern.new("Emily Johnson", 30000)

#  об'єкт SalaryCalculator і розрахунок зарплати
calculator = SalaryCalculator.new
employee1.accept(calculator)  # Виклик базового метода
employee2.accept(calculator)  # Виклик методу для менеджера
employee3.accept(calculator)  # Виклик методу для стажера

# об'єкт BonusCalculator і розрахунок бонусів
bonus_calculator = BonusCalculator.new
employee1.accept(bonus_calculator)  #  базовий метода
employee2.accept(bonus_calculator)  #  метод для менеджера
employee3.accept(bonus_calculator)  # метод для стажера
