class Station # даем название классу Station
  include InstanceCounter # будем использовать модуль InstatanceCounter, include- метод вызывает модуль. помогет избавиться от дублирования кода и вынести его в модуль.
  @@stations = [] # создается пустой массив . @@- переменная класса
  attr_reader :name # геттер для name . принимает значение.

  def initialize(name) # метод initialize - конструктор.
    @name = name # напрямую к инстанс перепенной обратиться нельзя, присваиваем к name
    @trains = []# создается пустой массив из поездов
    @@stations << self# добавление текущего объекта в массив
    register_instance # наверно один из модулей,который будет регестрировать прибывшие поезда
  end

  def self.all# это self в контексте класса он обращается к классу(не понял эту фразу)
    @@stations # вызывает значение инстанс переменной
  end

  def get_train(train) # метод обращается к модулю train
    @trains << train # Добавление объекта в массив??? Этого не понял.
    puts "На станцию #{name} прибыл поезд #{train.number}" #
  end

  def send_train(train) # метод обращается к модулю train
    @trains.delete(train)# из массива удаляет вагон ,который уезжает
    train.station = nil# значение индекса отбывшего поезда равна пустоте nil
    puts "Со станции #{name} отправился поезд #{train.number}"
  end

  def show_trains(type = nil) # метод определяющий тип поезда. В начале пустота nil
    if type # условие для определения типа поезда
      puts "Поезда на станции #{name} типа #{type}: "
      @trains.each{|train| puts train.number if train.type == type}# из массива подставляются значения в блок train, а дальше сравнивается ,только не могу понять что
    else
      puts "Поезда на станции #{name}: "
      @trains.each {|train| puts train.number}# из массива подставляются значения в блок train и выводится на экран значение  
    end
  end
end
