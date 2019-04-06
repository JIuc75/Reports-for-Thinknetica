puts 'Введите сторону'
a = gets.to_f
puts 'Введите сторону'
b = gets.to_f
puts 'Введите сторону'
c = gets.to_f
a1, b1, c1, = [a, b, c].sort!
right_triangle = a1**2 + b1**2 == c1**2
if right_triangle || a1 == b1
  puts 'Треугольник прямоугольный, равнобедренный.'
elsif a1 == b1 && a1 == c1 && c1 == b1
  puts 'Треугольник равносторонний не прямоугольный.'
elsif right_triangle
  puts 'Треугольник прямоугольный.'
end
