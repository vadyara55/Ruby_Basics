class CargoWagon < Wagon
  SPACE_VOLUME = "Выбрано неверное значение"
  def initialize(volume)
    super
    @type = "Cargo"
    validate!(volume)
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def validate!(volume)
    raise SPACE_VOLUME if !(88..138).include?(volume)
  end
end
