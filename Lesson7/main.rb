require_relative 'corporation'
require_relative 'instance_counter'
require_relative 'train'
require_relative 'wagon'
require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'route'
require_relative 'station'

class Main

  MENU = [
    'Создать станцию',
    'Создать поезд',
    'Создать маршрут',
    'Добавить станцию',
    'УДалить станцию',
    'Назначить маршрут поезду',
    'Добавить вагоны к поезду',
    'Отцепить вагоны от поезда',
    'Переместить поезд по маршруту вперед',
    'Переместить поезд по маршруту назад',
    'Просмотреть список станций',
    'Просмотреть список поездов на станции',
    'Посмотреть список вагонов поезда',
    'Занять место или объем в вагоне'
  ]
  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def run
    loop do
      show_main_menu
      action = gets.to_i
      case action
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then add_station
      when 5 then delete_station
      when 6 then add_route_to_train
      when 7 then attach_wagon
      when 8 then detach_wagon
      when 9 then train_to_next_station
      when 10 then train_to_previous_station
      when 11 then show_stations
      when 12 then train_on_station
      when 13 then wagon_list
      when 14 then change_wagons_value
      when 0 then break
      end
    end
  end

  def show_main_menu
    MENU.each.with_index(1) do |item, index|
      puts "#{index} - #{item}"
    end
    puts "0 - выход"
  end

  def create_station
    print "Введите название станции:"
    name = gets.chomp
    @stations.push(Station.new(name))
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_train
    print "Введите номер поезда в формате XXX-XX или XXXXX: "
    number = gets.chomp
    show_train_type_menu
    case gets.to_i
    when 1 then @trains << PassengerTrain.new(number)
    when 2 then @trains << CargoTrain.new(number)
    end
  rescue StandardError => e
    puts e.message
    retry
  end

  def show_train_type_menu
    puts "Выберите тип поезда: "
    puts "1 - Пассажирский"
    puts "2 - Грузовой"
  end

  def create_route
    if @stations.count < 2
      puts "Чтобы создать маршрут,нужно хотя бы 2 станции."
      return
    end
    show_stations(@stations)
    print "Введите номер начальной станции: "
    first_station = select_from_collection(@stations)
    print "Введите номер конечной: "
    last_station = select_from_collection(@stations)
    return if first_station.nil?
    @routes << Route.new(first_station, last_station)
  rescue StandardError => e
    puts e.message
    retry
  end

  def select_from_collection(collection)
    index = gets.to_i - 1
    return if index.negative?
    collection[index]
  end

  def add_station
    show_routes
    route = select_from_collection(@routes)

    show_stations(@stations)
    station = select_from_collection(@stations)

    route.add_station(station)
  end

  def delete_station
    show_routes
    route = select_from_collection(@routes)

    show_stations(route.stations)
    station = select_from_collection(route.stations)
    route.delete(station)
  rescue StandardError => e
    puts e.message
    retry
  end

  def show_stations(stations = @stations)
    puts "Список станций:"
    stations.each.with_index(1) do |item, index|
      puts "#{index} - #{item.name}"
    end
  end

  def show_routes
    puts "Выберите маршрут"
    @routes.each.with_index(1) do |item, index|
      puts "#{index}. #{item.stations.first.name} - #{item.stations.last.name}"
    end
  end

  def show_trains
    puts " Список поездов:"
    @trains.each.with_index(1) do |item, index|
      puts "#{index} - #{item.number} - #{item.type}"
    end
  end

  def wagon_list
    show_trains
    @train_list = select_from_collection(@trains)
    @train_list.each_wagon_with_index do |van, index|
      puts "№.#{index} *#{van.type}* Свободно:#{van.place} Занято:#{van.taked_place}"
    end
  end

  def stations_of_route
      puts "Список станций маршрута:"
      @routes[@route_number - 1].stations.each { |station| puts "#{@routes[@route_number - 1].stations.index(station) + 1} #{station.name}" } # перебирает станции маршрута, выводит станцию с ее индексом.
  end

  def add_route_to_train
    show_trains
    train = select_from_collection(@trains)

    show_routes
    route = select_from_collection(@routes)
    train.add_route(route)
  end

  def attach_wagon
    show_trains
    train = select_from_collection(@trains)

    if train.type == "Passenger"
      print "Введите количество мест (от 16 до 54):"
      seats = gets.chomp.to_i
      return if !(16..54).include?(seats)
      wagon = PassengerWagon.new(seats)
    elsif train.type == "Cargo"
      print "ВВедите объем вагона (от 88 до 138):"
      volume = gets.chomp.to_f
      return if !(88.0..138.0).include?(volume)
      wagon = CargoWagon.new(volume)
    end

    train.attach_wagon(wagon)
  end

  def detach_wagon
    show_trains
    train = select_from_collection(@trains)
    train.detach_wagon
  end

  def train_to_next_station
    show_trains
    train = select_from_collection(@trains)
    train.move_forward
  end

  def train_to_previous_station
    show_trains
    train = select_from_collection(@trains)
    train.move_back
  end

  def train_on_station
    show_stations(@stations)
    station = select_from_collection(@stations)
    return error if station.nil?
    puts "Список поездов на станции :"
    station.each_train_with_index do |key, value|
      puts "№.#{key} - Поезд: #{value.number}, тип поезда - #{value.type} - кол-во вагонов: #{value.wagons.count}"
    end
  end

  def change_wagons_value
    wagon_list
    print "Выберите вагон:"
    wagon = select_from_collection(@train_list.wagons)

    if wagon.type == "Passenger"
      wagon.take_volume
    elsif wagon.type == "Cargo"
      print "Введите занимаемый объем:"
      volume = gets.chomp.to_f
      return if !(0..138).include?(volume)
      wagon.take_volume(volume)
    end
  end

  def blank
    puts "
    !!!!!!!!!!!!!!!
    !!Список пуст!!
    !!!!!!!!!!!!!!!"
  end

  def error
    puts "
    !!!!!!!!!!
    !!Ошибка!!
    !!!!!!!!!!"
  end
end

test = Main.new
test.run
