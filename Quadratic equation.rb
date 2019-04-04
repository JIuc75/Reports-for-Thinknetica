puts 'Введите коэффициент А'
a = gets.to_i
puts 'Введите коэффициент B'
b = gets.to_i
puts 'Введите коэффициент C'
c = gets.to_i
d = b**2 - 4 * a * c
if d > 0
  x1 = -b + Math.sqrt(d) / 2 * a
  x2 = -b - Math.sqrt(d) / 2 * a
  puts x1.to_s
  puts x2.to_s
elsif d.zero?
  puts x1.to_s
end
puts 'Корней нет' if d < 0