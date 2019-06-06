require_relative 'train'
require_relative 'van'
require_relative 'cargo_train'
require_relative 'cargo_van'
require_relative 'passenger_train'
require_relative 'passenger_van'
require_relative 'route'
require_relative 'station'

@stations_list = [] #массив для станций
@trains_list = [] # аналогично поезда
@routes_list = [] # и маршруты

def menu # менюшка
  puts "
  1 Создать станцию
  -----------------
  2 Создать поезд
  -----------------
  3 Создать маршрут
  -----------------
    3.1 Добавить станцию
    -----------------
    3.2 Удалить станцию
    -----------------
  4 Назначить маршрут поезду
  -----------------
  5 Добавить вагоны к поезду
  -----------------
  6 Отцепить вагоны от поезда
  -----------------
    7.1 Переместить поезд по маршруту вперед
    -----------------
    7.2 Переместить поезд по маршруту назад
    -----------------
  8 Просмотреть список станций
  -----------------
  9 Просмотреть список поездов на станции
  -----------------
  0 Выход
  -----------------"
  print "Введите номер выбранного пункта: "
  picked = gets.chomp
  menu_2(picked)
end

def menu_2(picked)
  case picked
  when "1" then create_station
  when "2" then create_train
  when "3" then ctreate_route
  when "3.1" then add_station
  when "3.2" then delete_station
  when "4" then add_route_to_train
  when "5" then attach_van
  when "6" then unhook_van
  when "7.1" then train_to_next_station
  when "7.2" then train_to_previous_station
  when "8" then checklist
  when "9" then train_on_station
  when "0" then return exit
  end
  menu #  не понял зачем здесь метод, если мы впихну в метод выше метод menu_2?????
end

def create_station
  print "Введите название станции: "
  name = gets.chomp
  @stations_list.each { |station| error if station.name == name }# проверка, есть ли созданная нами станция в массиве станций
  @stations_list.push(Station.new(name)) # создает станцию как объект и в массив отправляет
end

def create_train
  print "Введите название поезда: "
  name = gets.chomp
  @trains_list.each { |train|  error if train.name == name } # аналогично станции
  puts "Выберите его тип:
    1 - Пассажирский;
    2 - Грузовой."
  picked = gets.chomp.to_i
  if picked == 1
    @trains_list.push(PassengerTrain.new(name)) # отправляет в массив как пассажирский или грузовой поезд
  elsif picked == 2
    @trains_list.push(CargoTrain.new(name))
  else
    error
  end
end

def ctreate_route
  return puts "Чтобы создать маршрут, нужно хотя бы две стании" if @stations_list.count < 2 # в массиве должно быть не меньше 2 станций
  checklist
  print "Введите номер начальной станции: "
  first_station = gets.chomp.to_i
  print "Введите номер конечной: "
  last_station = gets.chomp.to_i
  check = (1..@stations_list.length).include?(first_station) && (1..@stations_list.length).include?(last_station) && (first_station != last_station)# и первая,и последняя станция должны быть в массиве станций и они не совпадают
  if check
    @routes_list.push(Route.new(@stations_list[first_station - 1], @stations_list[last_station - 1])) # создается маршрут и отправляется в массив маршрутов
  else
    error
  end
end

def add_station
  route_choise
  checklist
  control
  @routes_list[@route_number - 1].stations.each { |station| error if @stations_list[@number - 1] == station }# проверка есть ли станция уже в маршруте
  @routes_list[@route_number - 1].add(@stations_list[@number - 1]) #добавляет станцию в маршрут
end

def delete_station
  route_choise
  return error if @routes_list[@route_number - 1].stations.count == 2#  проверка,чтоб в маршруте не осталось станций меньше 2
  stations_of_route
  control
  @routes_list[@route_number - 1].delete(@stations_list[@number - 1]) # удаляет нужную станцию из массива
end

def checklist
  if !@stations_list.empty? # проверка пустой ли массив станций. empty? используется смассивами,хешами,строками ,когда их длина = 0.
    puts "Список станций:"
    @stations_list.each { |station| puts "#{@stations_list.index(station) + 1} #{station.name}" } # перебирает массив станций . Выводит индекс станции и станцию.
  else
    blank
  end
end

def stations_of_route
    puts "Список станций маршрута:"
    @routes_list[@route_number - 1].stations.each { |station| puts "#{@routes_list[@route_number - 1].stations.index(station) + 1} #{station.name}" } # перебирает станции маршрута, выводит станцию с ее индексом.
end

def route_choise
  if !@routes_list.empty? # аналогично массиву станций
    puts "Выберите и введите номер маршрута: "
    @routes_list.each { |value| puts "#{@routes_list.index(value) + 1}) #{value.list}" } # не нашел метод list в гугл. По логике он выводит массив из станций этого маршрута.
    @route_number = gets.chomp.to_i
    error if !(1..@routes_list.length).include?(@route_number) # ошибка,если введен номер маршрута ,которого нет. Так понял
  else
    blank
  end
end

def control
  print "Введите номер станции: "
  @number = gets.chomp.to_i
  error if !(1..@stations_list.length).include?(@number)# аналогично верхнему
end

def add_route_to_train
  train_choise
  route_choise
  @trains_list[@train_number - 1].add_route(@routes_list[@route_number - 1]) # к поезду из массива поездов указывается маршрут из массива массивов
end

def attach_van
  train_choise
  van = PassengerVan.new() if @trains_list[@train_number - 1].type == "Пассажирский" # к пассажирскому добавляется только пассажирский
  van = CargoVan.new() if @trains_list[@train_number - 1].type == "Грузовой" # аналогично верхнему
  @trains_list[@train_number - 1].attach(van) # присоединяем
end

def unhook_van
  train_choise
  @trains_list[@train_number - 1].unhook # отцепляем
end

def train_to_next_station
  train_choise
  @trains_list[@train_number - 1].move_forward #
end

def train_to_previous_station
  train_choise
  @trains_list[@train_number - 1].move_back
end

def train_on_station
  checklist
  print "Введите номер станции: "
  number = gets.chomp.to_i
  return error if !(1..@stations_list.length).include?(number) # проверка
  puts "Список поездов на станции: "
  puts @stations_list[number - 1].trains # поезда на станции
end

def train_choise
  if !@trains_list.empty? # пустой ли массив поездов
    puts "Выберите номер поезда: "
    @trains_list.each { |value| puts "#{@trains_list.index(value) + 1}) #{value.name}"} # переберет и покажет индекс и имя поезда
    @train_number = gets.chomp.to_i
    error if !(1..@trains_list.length).include?(@train_number) # ошибка ,если нет этого номера в массиве
  else
    blank
  end
end

def blank
  puts "
  !!!!!!!!!!!!!!!
  !!Список пуст!!
  !!!!!!!!!!!!!!!"
  menu
end

def error
  puts "
  !!!!!!!!!!
  !!Ошибка!!
  !!!!!!!!!!"
  menu
end

menu # тоже не пойму почему здесь метод этот
