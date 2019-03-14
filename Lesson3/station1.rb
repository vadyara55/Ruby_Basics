class Station  # класс станция

  attr_reader :name, :trains  # геттер name и trains

  def initialize(name) # конструктор для name
    @name = name # name присваивается инстанс переменной @name
    @trains = [] # пустой массив поездов
    puts "Построена станция #{name}"
  end

  def get_train(train) #  метод принимает значение поезда
    trains << train #  добавляет в массив 
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def send_train(train) # метод отправления поезда со станции
    trains.delete(train) # удаляет поезд из массива
    train.station = nil # устанавливет значение переменной train на определенной станции пустым
    puts "Со станции #{name} отправился поезд №#{train.number}"
  end

  def show_trains(type = nil)# метод задает тип поезда, прибывшего на станцию
      if type # если type
        puts "Поезда на станции #{name} типа #{type}: "
        trains.each{|train| puts train.number if train.type == type} # из массива по одному перебираются поезда, выводится индекс поезда если тип соотвествует типу
      else # иначе
        puts "Поезда на станици #{name}: "
        trains.each{|train| puts train.number} # из массива перебираются поезда и выводит индексы поезда
       end
  end
end
