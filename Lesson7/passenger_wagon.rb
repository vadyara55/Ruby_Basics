class PassengerWagon < Wagon
  def initialize(seats)
    @number = 5.times.map { rand(0..9) }.join
    @type = "Passenger"
    @place = seats.to_i.abs
    @taked_place = 0
  end

  def take_seat(seats)
    seats = seats.to_i.abs
    if place > 0 && place >= seats
      @place -= seats
      @taked_place += seats
    end
  end
end
