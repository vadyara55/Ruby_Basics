class Wagon
  include Corporation
  include InstanceCounter
  attr_accessor :type, :number, :total_place, :taked_place

  WAGON_PLACE = "Не хватает места"

  def initialize(volume)
    @number = 5.times.map { rand(0..9) }.join
    @total_place = volume
    @taked_place = 0
  end

  def take_volume(volume)
    volume = volume.to_f.abs
    validate_taking_volume!(volume)
    @taked_place += volume
    available_place
  end

  def available_place
    @total_place - @taked_place
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate_taking_volume!(volume)
    raise WAGON_PLACE if volume > available_place
  end
end
