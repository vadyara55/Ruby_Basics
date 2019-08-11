class PassengerWagon < Wagon
  SPACE_VOLUME = "Введено неверное количество"
  def initialize(volume)
    super
    @type = "Passenger"
    validate!(volume)
  end

  def take_volume
    super(1)
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!(volume)
    raise SPACE_VOLUME if !(16..54).include?(volume)
  end
end
