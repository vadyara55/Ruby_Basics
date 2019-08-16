class PassengerWagon < Wagon
  MIN_VOLUME = 16
  MAX_VOLUME = 54
  INVALID_VOLUME = 'Введено неверное количество'
  def initialize(volume)
    super
    @type = 'Passenger'
    validate!(volume)
  end

  def take_volume
    super(1)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!(volume)
    raise INVALID_VOLUME unless volume.between?(MIN_VOLUME, MAX_VOLUME)
  end
end
