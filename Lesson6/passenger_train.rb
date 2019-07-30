class PassengerTrain < Train
  def initialize(number, type = "Passenger")
    super
    @type = type
  end
end
