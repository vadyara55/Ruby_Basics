require_relative 'corporation'
require_relative 'instance_counter'
require_relative 'train'
require_relative 'van'
require_relative 'cargo_train'
require_relative 'cargo_van'
require_relative 'passenger_train'
require_relative 'passenger_van'
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
    'Просмотреть список поездов на станции'
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
      when 0 then break
      end
    end
  end

  def show_main_menu # показать главное меню
    MENU.each.with_index(1) do |item, index|
      puts "#{index} - #{item}"
    end
    puts "0 - выход"
  end

  def create_station # создать станцию
    print "Введите название станции:"
    name = gets.chomp
    @stations.push(Station.new(name))
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_train # создать поезд
    print "Введите номер поезда в формате XXX-XX или XXX XX: "
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
    puts "Выберите тип поезда:"
    puts "1 - Пассажирский"
    puts "2 - Грузовой"
  end

  def create_route # создать маршрут
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

  def select_from_collection(collection) # выбрать из коллекции
    index = gets.to_i - 1
    return if index.negative?
    collection[index]
  end

  def add_station #добавить станцию
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

  def show_stations(stations = @stations) # показать станцию
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
      puts "#{index} - #{item.number}"
    end
  end

  def stations_of_route # станции маршрута
      puts "Список станций маршрута:"
      @routes[@route_number - 1].stations.each { |station| puts "#{@routes[@route_number - 1].stations.index(station) + 1} #{station.name}" } # перебирает станции маршрута, выводит станцию с ее индексом.
  end

  def add_route_to_train # добавить поезд к маршруту
    show_trains
    train = select_from_collection(@trains)

    show_routes
    route = select_from_collection(@routes)
    train.add_route(route)  # к поезду из массива поездов указывается маршрут из массива массивов
  end

  def attach_wagon # прикрепить вагон
    show_trains
    train = select_from_collection(@trains)

    wagon = case train
            when PassengerTrain then PassengerWagon.new
            when CargoTrain then CargoTrain.new
            end
    train.attach_wagon(wagon) # присоединяем
  end

  def detach_wagon # отцепить вагон
    show_trains
    train = select_from_collection(@trains)
    train.detach_wagon # отцепляем
  end

  def train_to_next_station # поезд на следующую станцию
    show_trains
    train = select_from_collection(@trains)
    train.move_forward
  end

  def train_to_previous_station # поезд на предыдущую станцию
    show_trains
    train = select_from_collection(@trains)
    train.move_back
  end

  def train_on_station # поезда на станции, ЗДЕСЬ ПЫТАЛСЯ ИСПОЛЬЗОВАТЬ МЕТОД select_from_sation, но не вышло. Вернул к первоначальному виду
    show_stations(@stations)
    station = select_from_collection(@stations)
    return error if station.nil?
    puts "Поезда на станции #{station.name}"
    puts station.trains
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
