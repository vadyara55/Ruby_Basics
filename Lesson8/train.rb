class Train
  include Corporation
  include InstanceCounter

  attr_reader :speed, :station_index, :route, :wagons, :type, :number

  TRAIN_NUMBER_FORMAT = /^[а-я0-9]{3}-?[а-я0-9]{2}$/i
  TRAIN_TYPE = /^(Passenger|Cargo)$/
  INCORRECT_NUMBER = 'Некорректный номер'.freeze
  INCORRECT_TRAIN_TYPE = 'Некорректный тип поезда'.freeze

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
    return unless speed.zero?
    @wagons << wagon
  end

  def detach_wagon
    @wagons.delete_at(-1) if speed.zero? && @wagons.count > 1
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
    current_station.departed(self)
    next_station.arrived(self)
    self.station_index += 1
  end

  def move_back
    current_station.departed(self)
    previous_station.arrived(self)
    self.station_index -= 1
  end

  def each_wagon_with_index
    @wagons.each.with_index(1) do |van, index|
      yield van, index
    end
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  attr_writer :speed, :station_index, :route, :wagons, :type, :number

  def validate!
    raise INCORRECT_NUMBER if number !~ TRAIN_NUMBER_FORMAT
    raise INCORRECT_TRAIN_TYPE if type !~ TRAIN_TYPE
  end
end
