class Route # класс маршрут

  attr_accessor :stations, :from, :to # геттеры и сеттеры

  def initialize(from, to) # конструктор переменных from , to
    @stations = [from, to] # массив станций от и до
    puts "Создан маршрут #{from.name} - #{to.name}"
  end

  def add_station(station) # метод добавляет станции
    self.stations.insert(-2, station) # добавляется станция на значение индекса -2 в массиве
    puts "К маршруту #{stations.first.name} - #{stations.last.name} добавлена станци #{station.name}"
  end

  def remove_station(station) # удаляет станцию из маршрута
    if [stations.first, station.last].include?(station) # проверяет является ли станция первой или последней станцией маршрута в данном массиве,если да, выводит
      puts "Первую и последнюю станции маршрута удалять нельзя!"
    else
      self.stations.delete(station) # иначе удаляет эту станцию из массива
      puts "Из маршрута #{staions.first.name} - #{stations.last.name} удалена станция #{station.name}"
    end
  end

  def show_stations # метод показывает станции
    puts "В маршрут #{stations.first.name} #{stations.last.name} входят станции: "
    stations.each{|station| puts " #{station.name}" } # перебирает станации входящие в массив и выводит их имена
  end
end
