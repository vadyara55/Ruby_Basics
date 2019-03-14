class Train # класс поезд

  attr_accessor :speed, :number, :car_count, :route, :station # геттеры и сеттеры переменных.
  attr_reader :type # только геттер . тип поезда меняться не может. Сеттер не нужен

  def initialize(number, type, car_count) # конструктор
    @number = number # присвоение переменной к @инстанс переменной. Которую видно во всем классе.
    @type = type # тип поезда
    @car_count = car_count # количество вагонов
    @speed = 0 # скорость поезда
    puts "Создан поезд № #{number}. Тип: #{type}. Количество вагонов : #{car_count}."
  end

  def stop # метод остановки поезда
    self.speed = 0 # self в данном случае вызывает сеттер
  end

  def add_car # метод прибавляет вагоны
    if speed.zero? # сравнивает скорость с 0. Используем zero, т.к. может быть число с плавающей точкой
      self.car_count += 1 # прибавляет один поезд (через self получаем доступ к объекту)
      puts "К поезду № #{number} прицепили вагон. Теперь их #{car_count}."
    else
      puts "На ходу нельзя прицеплять вагоны!"
    end
  end

  def remove_car # метод удаляет поезд из массива
    if car_count.zero? # сраниваем кол-во вагонов с 0
      puts "Вагонов уже не осталось."
    elsif speed.zero? # сраниваем скорость поезда с нулем
      self.car_count -=1 # получаем доступ к объекту внутри метода и убираем один вагон
      puts "От поезда № #{number} отцепили вагон.Теперь их #{car_count}."
    else
      puts "На ходу нельзя отцеплять вагоны!"
    end
  end

  def take_route(route) # метод задает маршрут поезду
    self.route = route # получаем доступ к переменной внутри метода и устанавливаем значение
    puts "Поезду №#{number} задан маршрут #{route.stations.first.name} - #{route.stations.last.name}"
  end

  def go_to(station) # задаем станцию для прибытия
    if route.nil? # проверяем задан ли маршрут, пуст ли он.
      puts "Без маршрута поезд заблудится."
    elsif @station == station # проверяем стоит ли поезд уже на этой станции
      puts "Поезд №#{number} и так на станции #{@station.name}"
    elsif route.stations.include?(station) # проверка станции в маршруте , но точно не понял
      @station.send_train(self) if @station # Обращается к методу в другом классе ,чтоб добавить станцию в массив
      @station = station # ТАК ПОНЯЛ ПРИСВАИВАЕМ К ИНСТАНС ПЕРЕМЕННОЙ
      station.ger_train(self) #  обращается к методу класса station
    else
      puts "Станция #{station.name} не входит в маршрут №#{number}"
    end
  end

  def stations_around # метод для вывода станциий
    if route.nil? # проверяем задан ли маршрут
      puts "Маршрут не задан"
    else
      station_index = route.stations.index(station) # переменная равна индексу станции в массиве(маршруте)
      puts "Сейчас поезд на станции #{station.name}."
      puts "Предыдущая станция - #{route.station[station_index - 1].name}." if station_index != 0 # если индекс не равен 0, то выведется
      puts "Следущая  - #{route.stations[stations_index + 1].name}." if station_index != route.stations.size - 1 # если не равно индексу предыдущей станции ,то выведется
    end
  end
end
