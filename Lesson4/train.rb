class Train
  attr_reader :speed, :name, :station_index, :station, :route, :wagons, :type

  def initialize(name)
    @name = name
    @wagons = []
    @speed = 0
  end

  def speed_gather(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def attach_wagon(wagon)
    return unless speed == 0
    @wagons << wagon
  end

  def detach_wagon # Не понимаю зачем методу принимать удаляемый объект - вагон. Вагоны удаляются по 1 же.
    @wagons.delete_at(-1) if self.speed == 0 && @wagons.count > 1
  end

  def add_route(route)
    @route = route
    self.station = route.stations[0]
    self.station_index = route.stations.index(station)
    station.arrived(self)
  end

  def next_station
    route.stations[station_index + 1]
  end

  def previous_station
    return unless station_index > 0
    route.stations[station_index - 1]
  end

  def current_station
    route.stations(station_index)
  end

  def move_forward
    if next_station
      current_station.departed(self)
      next_station.arrived(self)
      self.station_index += 1
    end
  end

  def move_back
    if previous_station
      current_station.departed(self)
      previous_station.arrived(self)
      self.station_index -= 1
    end
  end

  protected

  attr_writer :speed, :name, :station_index, :station, :route, :wagons, :type
  # Не нужно ,чтобы ползователь имел возможность изменять их самостоятельно
  # используя произвольные значения.

end
