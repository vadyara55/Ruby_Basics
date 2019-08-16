class Wagon
  include Corporation
  include InstanceCounter
  attr_accessor :type, :number, :total_place, :taked_place

  def initialize(volume)
    @number = 5.times.map { rand(0..9) }.join
    @total_place = volume
    @taked_place = 0
  end

  def take_volume(volume)
    volume = volume.to_f.abs
    @taked_place += volume
    available_place
  end

  def available_place
    @total_place - @taked_place
  end
end
