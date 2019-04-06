puts 'Введите коэффициент А'
a = gets.to_f
puts 'Введите коэффициент B'
b = gets.to_f
puts 'Введите коэффициент C'
c = gets.to_f
d = b**2 - 4 * a * c
if d.positive?
  sqrt = Math.sqrt(d)
  x1 = (-b + sqrt) / (2.0 * a)
  x2 = (-b - sqrt) / (2.0 * a)
  puts "Дискриминант= #{d}"
  puts "Kорень x1= #{x1}"
  puts "Корень x2= #{x2}"
elsif d.zero?
  x1 = (-b) / (2 * a)
  puts "Дискриминант= #{d}"
  puts "Kорень x1,x2= #{x1}"
else
  puts "Дискриминант= #{d}"
  puts 'Корней нет.'
end
