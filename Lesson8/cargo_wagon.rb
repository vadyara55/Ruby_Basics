class CargoWagon < Wagon
  MIN_VOLUME = 88
  MAX_VOLUME = 138
  INVALID_VOLUME = 'Выбрано неверное значение'
  def initialize(volume)
    super
    @type = 'Cargo'
    validate!(volume)
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
