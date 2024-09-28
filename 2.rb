# Зробити невеликий скрипт
#На вхід передаємо математичний вираз у звичному нам вигляді
# На виході бачимо його у RPN
# EX: input --> 2 + 1 × 4
#     output --> 2 1 4 * +

class RPN
  def precedence(op)
    case op
    when '+', '-'
      return 1
    when '*', '/'
      return 2
    else
      return 0
    end
  end

  def operator?(char)
    ['+', '-', '*', '/'].include?(char)
  end

  def divide_by_zero?(tokens)
    tokens.each_with_index do |token, index|
      if token == '/' && tokens[index + 1] == '0'
        return true
      end
    end
    false
  end

  def to_rpn(expression)
    operators = []
    output = []

    #  зайві оператори
    if expression.strip[-1] =~ /[+\-*\/]/
      raise "Помилка: вираз не може закінчуватися оператором."
    end

    tokens = expression.gsub('(', ' ( ').gsub(')', ' ) ').split

    if divide_by_zero?(tokens)
      raise "Помилка: ділення на нуль."
    end

    tokens.each_with_index do |token, index|
      if token =~ /-?\d+(\.\d+)?/  # для дробових і від'ємних чисел
        output.push(token)
      elsif token == '('
        operators.push(token)
      elsif token == ')'
        while operators.any? && operators.last != '('
          output.push(operators.pop)
        end
        operators.pop
      elsif operator?(token)
        while operators.any? && precedence(operators.last) >= precedence(token)
          output.push(operators.pop)
        end
        operators.push(token)
      end
    end

    while operators.any?
      output.push(operators.pop)
    end

    output.join(' ')
  end
end

converter = RPN.new

# тестування
begin
  expression = "4 - 5 + (-4 + 5)"
  rpn_result = converter.to_rpn(expression)
  puts "RPN вираз: #{rpn_result}"
rescue => e
  puts e.message
end
