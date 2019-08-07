class Wagon
  include Corporation
  attr_accessor :type, :number, :place, :taked_place

  def take_volume(volume)
    volume = volume.to_f.abs
    if @place > 0 && @place >= volume
      @place -= volume
      @taked_place += volume
    end
  end
end
