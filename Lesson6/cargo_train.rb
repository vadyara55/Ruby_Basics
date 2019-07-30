class CargoTrain < Train
  def initialize(number, type = "Cargo")
    super
    @type = type
  end
end
