class Station
  include InstanceCounter

  @@all_stations = []

  attr_reader :trains, :name

  STATION_NIL = "Имя не может быть пустым"
  STATION_EXIST = "Станция уже создана"

  def initialize(name)
    @trains = {}
    @name = name
    validate!
    @@all_stations.push(self)
    register_instance
  end

  def self.all
    @@all_stations
  end

  def arrived(train)
    @trains.store(train.number, train.type)
  end

  def type(type)
    number = 0
    @train.each_value { |value| number += 1 if value == type}
    {"#{type}" => number}
  end

  def departed(train)
    @trains.delete(train.number)
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!
    raise STATION_NIL if name.empty?
    raise STATION_EXIST if @@all_stations.find { |station| station.name == name }
  end
end
