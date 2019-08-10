class PassengerWagon < Wagon
  def initialize(volume)
    super
    @type = "Passenger"
  end

  def take_volume
    super(1)
  end
end
