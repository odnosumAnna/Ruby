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

  def to_rpn(expression)
    operators = []
    output = []

    tokens = expression.split

    tokens.each do |token|
      if token =~ /\d+/
        output.push(token)
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
# Приклад за умовою
converter = RPN.new
expression = "2 + 1 * 4"
rpn_result = converter.to_rpn(expression)
puts rpn_result