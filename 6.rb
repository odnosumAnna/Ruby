require 'trig_calculator'

puts "Enter an angle in radians:"
angle = gets.chomp.to_f

begin
  puts "Sine: #{TrigCalculator.sin(angle)}"
  puts "Cosine: #{TrigCalculator.cos(angle)}"
  puts "Tangent: #{TrigCalculator.tan(angle)}"
  puts "Cotangent: #{TrigCalculator.cot(angle)}"
  puts "Secant: #{TrigCalculator.sec(angle)}"
  puts "Cosecant: #{TrigCalculator.csc(angle)}"
rescue ZeroDivisionError => e
  puts "Error: #{e.message}"
end
