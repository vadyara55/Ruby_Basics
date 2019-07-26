class PassengerTrain < Train
  def initialize(name, number)
    super
    @type = "Пассажирский"
  end
end
