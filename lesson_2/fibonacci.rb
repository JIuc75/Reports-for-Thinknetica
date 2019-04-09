end_fibonacci = 100
fibonacci = [0, 1]
num = 1
while num < end_fibonacci
  fibonacci << num
  num = fibonacci.last(2).reduce(:+)
end
puts fibonacci
