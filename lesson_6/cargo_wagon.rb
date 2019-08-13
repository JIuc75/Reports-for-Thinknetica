# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(number)
    super(number, 'cargo')
  end
end
