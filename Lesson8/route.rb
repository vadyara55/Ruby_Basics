class Route
  include InstanceCounter

  attr_reader :stations

  ROUTE_STATION = 'Начальная станция не может быть конечной'
  INVALID_TYPE = 'Некорректный тип станции'

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete(station)
    @stations.delete(station)
  end

  def list
    @stations.collect(&:name)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise INVALID_TYPE unless stations.all? { |station| station.is_a?(Station) }
    raise ROUTE_STATION if @first_station == @last_station
  end
end
