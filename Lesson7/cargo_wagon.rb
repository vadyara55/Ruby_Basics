class CargoWagon < Wagon
  def initialize(volume)
    @number = 5.times.map { rand(0..9) }.join
    @type = "Cargo"
    @place = volume.to_f.abs
    @taked_place = 0
  end

  def take_volume(volume)
    super
  end
end
