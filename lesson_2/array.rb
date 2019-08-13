# frozen_string_literal: true

new_array = []
range = (10..100).step(5)
range.each { |item| new_array << item if (item % 5).zero? }
puts new_array
