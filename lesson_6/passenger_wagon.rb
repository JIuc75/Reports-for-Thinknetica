# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize(number)
    super(number, 'passenger')
  end
end
