vowels = {}
alphabet = ('а'..'я')
alphabet.each do |value, index|
  vowels[value] = index + 1 if value == ['а', "у", "о", "ы", "и", "э", "ю", "я"]
end
puts vowels
