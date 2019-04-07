puts 'Введите сторону A'
a = gets.to_f
puts 'Введите сторону B'
b = gets.to_f
puts 'Введите сторону C'
c = gets.to_f
a1, b1, c1, = [a, b, c].sort!
right_triangle = a1**2 + b1**2 == c1**2
if right_triangle && a1 == b1
  puts 'Треугольник прямоугольный, равнобедренный.'
elsif a1 == c1
  puts 'Треугольник равносторонний не прямоугольный.'
elsif right_triangle
  puts 'Треугольник прямоугольный.'
end
