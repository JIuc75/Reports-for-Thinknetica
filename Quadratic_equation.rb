puts 'Введите коэффициент А'
a = gets.to_f
puts 'Введите коэффициент B'
b = gets.to_f
puts 'Введите коэффициент C'
c = gets.to_f
d = b**2 - 4 * a * c
sqrt = Math.sqrt(d)
if d.positive?
  x1 = (-b + sqrt) / (2.0 * a)
  x2 = (-b - sqrt) / (2.0 * a)
  puts x1
  puts x2
elsif d.zero?
  puts x1
else
  puts 'Корней нет'
end
