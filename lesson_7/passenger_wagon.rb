class PassengerWagon < Wagon

  def initialize(number, number_of_seats)
    super(number, 'passenger')
    @number_of_seats = number_of_seats
  end

  def take_the_place_of
    @place = @number_of_seats -= 1
  end

end
