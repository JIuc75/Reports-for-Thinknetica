# frozen_string_literal: true

class Wagon
  attr_reader :type, :number

  def initialize(number, type)
    @number = number
    @type = type
  end
end
