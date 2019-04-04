puts "Введите длинну основания треугольника"
height = gets.to_i
if height <= 0
  puts "Введите корректную длинну основания треугольника"
  height = gets.to_i
end
puts "Введите высоту треугольника"
base = gets.to_i
if base <= 0
    puts "Введите корректную высоту треугольника"
    base = gets.to_i
end
puts "Площадь треугольника = #{0.5 * (height * base)}"