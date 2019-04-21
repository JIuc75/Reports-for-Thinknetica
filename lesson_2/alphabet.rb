alphabet = ('а'..'я')
vowels = Hash.new(0)
array_vowels = /[ауоыиэюя]/
alphabet.each_with_index do |value, index|
  vowels[value] = index + 1 if value =~ array_vowels
end
puts vowels
