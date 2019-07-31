class Train
  include Corporation
  include InstanceCounter

  attr_reader :speed, :station_index, :route, :wagons, :type, :number

  TRAIN_NUMBER_FORMAT = /^[а-я0-9]{3}(-|)[а-я0-9]{2}$/i
  TRAIN_TYPE = /^(Passenger|Cargo)$/
  INCORRECT_NUMBER = "Некорректный номер"
  INCORRECT_TRAIN_TYPE = "Некорректный тип поезда"

  @@trains = {}

  def initialize(number, type)
    @number = number
    @wagons = []
    @type = type
    @speed = 0
    validate!
    @@trains[number] = self
    register_instance
  end

  def self.find(number)
    @@trains[number]
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
    @station_index = 0
    current_station.arrived(self)
  end

  def next_station
    route.stations[station_index + 1]
  end

  def previous_station
    return unless station_index > 0
    route.stations[station_index - 1]
  end

  def current_station
    route.stations[station_index]
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

    def valid?
      validate!
      true
    rescue
      false
    end
  end

  protected

  attr_writer :speed, :station_index, :route, :wagons, :type, :number

  def validate!
    raise INCORRECT_NUMBER if number !~ TRAIN_NUMBER_FORMAT
    raise INCORRECT_TRAIN_TYPE if type !~ TRAIN_TYPE
  end
end
