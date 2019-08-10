class CargoWagon < Wagon
  def initialize(volume)
    super
    @type = "Cargo"
  end

  def take_volume(volume)
    super
  end
end
