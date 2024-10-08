#метод, який повертатиме true, якщо заданий аргумент строки є IPv4-адресою - чотири числа (0-255), розділені крапками.
#Він повинен приймати лише адреси в канонічному представленні, тобто без ведучих нулів, пропусків тощо.

def valid_ipv4?(ip)
  return false if ip.match?(/\s/)

  parts = ip.split('.')

  return false unless parts.size == 4

  parts.all? do |part|
    return false if part.empty? || (part.start_with?('0') && part != '0') || !part.match?(/^\d+$/)

    # Перевіряємо, що число в межах 0-255
    num = part.to_i
    num.between?(0, 255) && part == num.to_s
  end
end

# Тести
require 'minitest/autorun'

class TestValidIPv4 < Minitest::Test
  def test_valid_ips
    assert_equal true, valid_ipv4?('192.168.1.1')
    assert_equal true, valid_ipv4?('0.0.0.0')
    assert_equal true, valid_ipv4?('255.255.255.255')
  end

  def test_invalid_ips
    assert_equal false, valid_ipv4?('256.256.256.256')
    assert_equal false, valid_ipv4?('192.168.01.1')  # Ведучі нулі
    assert_equal false, valid_ipv4?('192.168.1')     # Менше 4 частин
    assert_equal false, valid_ipv4?('192.168.1.1.1') # Більше 4 частин
    assert_equal false, valid_ipv4?('192.168.1.-1')  # Від'ємне число
    assert_equal false, valid_ipv4?('192.168.a.1')   # Некоректні символи
    assert_equal false, valid_ipv4?('192. 168.1.1')  # Пробіли
  end
end
