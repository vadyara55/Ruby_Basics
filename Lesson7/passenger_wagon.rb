class PassengerWagon < Wagon
  def initialize(seats)
    @number = 5.times.map { rand(0..9) }.join
    @type = "Passenger"
    @place = seats.to_i.abs
    @taked_place = 0
  end

  def take_volume
    if @place > 0
      @place -= 1
      @taked_place += 1
    end
  end
end
