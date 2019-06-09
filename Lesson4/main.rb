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
      when 7 then attach_van
      when 8 then unhook_van
      when 9 then train_to_next_station
      when 10 then train_to_previous_station
      when 11 then checklist
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
    print "Введите название станции: "
    name = gets.chomp
    @stations.push(Station.new(name)) # создает станцию как объект и в массив отправляет
  end

  def create_train # создать поезд
    print "Введите название поезда: "
    name = gets.chomp
    @trains.each { |train|  error if train.name == name } # аналогично станции
    puts "Выберите его тип:
      1 - Пассажирский;
      2 - Грузовой."
    picked = gets.chomp.to_i
    if picked == 1
      @trains.push(PassengerTrain.new(name)) # отправляет в массив как пассажирский или грузовой поезд
    elsif picked == 2
      @trains.push(CargoTrain.new(name))
    else
      error
    end
  end

  def create_route # создать маршрут
    if @stations.count < 2
      puts "Чтобы создать маршрут,нужно хотя бы 2 станции."
      return
    end
    show_stations
    print "Введте номер начальной станции: "
    first_station = select_from_collection(@stations)
    print "Введите номер конечной: "
    last_station = select_from_colletion(@stations)
    return if first_station.nil?
    return if first_station == last_station
    @routes << Route.new(first_station, last_station)
  end

  def select_from_collection(collection) # выбрать из коллекции
    index = gets.to_i - 1
    return if index.negative?
    collection[index]
  end

  def add_station #добавить станцию
    route_choise
    show_stations
    control
    @routes[@route_number - 1].stations.each { |station| error if @stations[@number - 1] == station }# проверка есть ли станция уже в маршруте
    @routes[@route_number - 1].add(@stations[@number - 1]) #добавляет станцию в маршрут
  end

  def delete_station # удалить станцию
    route_choise
    return error if @routes[@route_number - 1].stations.count == 2#  проверка,чтоб в маршруте не осталось станций меньше 2
    stations_of_route
    control
    @routes[@route_number - 1].delete(@stations[@number - 1]) # удаляет нужную станцию из массива
  end

  def show_stations # показать станцию
    if !@stations.empty? # проверка пустой ли массив станций. empty? используется смассивами,хешами,строками ,когда их длина = 0.
      puts "Список станций:"
      @stations.each.with_index(1) do |item, index|
      puts "#{index} - #{item}"
      end
    else
      blank
    end
  end

  def stations_of_route # станции маршрута
      puts "Список станций маршрута:"
      @routes[@route_number - 1].stations.each { |station| puts "#{@routes[@route_number - 1].stations.index(station) + 1} #{station.name}" } # перебирает станции маршрута, выводит станцию с ее индексом.
  end

  def route_choise # выбор маршрута
    if !@routes.empty? # аналогично массиву станций
      puts "Выберите и введите номер маршрута: "
      @routes.each { |value| puts "#{@routes.index(value) + 1}) #{value.list}" } # не нашел метод list в гугл. По логике он выводит массив из станций этого маршрута.
      @route_number = gets.chomp.to_i
      error if !(1..@routes.length).include?(@route_number) # ошибка,если введен номер маршрута ,которого нет. Так понял
    else
      blank
    end
  end

  def control # контроль
    print "Введите номер станции: "
    @number = gets.chomp.to_i
    error if !(1..@stations.length).include?(@number)# аналогично верхнему
  end

  def add_route_to_train # добавить поезд к маршруту
    train_choise
    route_choise
    @trains[@train_number - 1].add_route(@routes[@route_number - 1]) # к поезду из массива поездов указывается маршрут из массива массивов
  end

  def attach_wagon # прикрепить вагон
    train_choise
    wagon = PassengerWagon.new() if @trains[@train_number - 1].type == "Пассажирский" # к пассажирскому добавляется только пассажирский
    wagon = CargoWagon.new() if @trains[@train_number - 1].type == "Грузовой" # аналогично верхнему
    @trains[@train_number - 1].attach_wagon(wagon) # присоединяем
  end

  def unhook_van # отцепить вагон
    train_choise
    @trains[@train_number - 1].detach_wagon # отцепляем
  end

  def train_to_next_station # поезд на следующую станцию
    train_choise
    @trains[@train_number - 1].move_forward #
  end

  def train_to_previous_station # поезд на предыдущую станцию
    train_choise
    @trains[@train_number - 1].move_back
  end

  def train_on_station # поезда на станции, ЗДЕСЬ ИСПОЛЬЗОВАЛ МЕТОД select_from_sation
    show_stations
    print "Введите номер станции: "
    station = select_from_collection
    return if station.nil?
    return error if !(1..@stations.length).include?(index) # проверка
    puts "Список поездов на станции: "
    puts station.trains # поезда на станции
  end

  def train_choise # выбор поезда
    if !@trains.empty? # пустой ли массив поездов
      puts "Выберите номер поезда: "
      @trains.each { |value| puts "#{@trains.index(value) + 1}) #{value.name}"} # переберет и покажет индекс и имя поезда
      @train_number = gets.chomp.to_i
      error if !(1..@trains.length).include?(@train_number) # ошибка ,если нет этого номера в массиве
    else
      blank
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
