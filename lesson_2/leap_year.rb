puts 'Введите число:'
day = gets.to_i
puts 'Введите номер месяца:'
month = gets.to_i
puts 'Введите год:'
year = gets.to_i

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

months[1] = 29 if (year % 4).zero? && year % 100 != 0 || (year % 400).zero?

sum = months.first(month - 1).sum + day
puts sum
