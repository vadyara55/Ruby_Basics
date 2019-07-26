class CargoTrain < Train
  def initialize(name, number)
    super
    @type = "Грузовой"
  end
end
