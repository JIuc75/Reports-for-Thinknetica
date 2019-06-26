module InterfaceConstants
  TRAIN_ALREADY_EXIST = 'Поезд с таким номером уже существует!'.freeze
  STATION_ALREADY_EXIST = 'Станция с таким названием уже существует!'.freeze
  ROUTE_ALREADY_EXIST = 'Маршрут с таким номером уже существует'.freeze
  ROUTE_AND_STATION_ALREADY_EXIST = 'Убедитесь в существовании станции и маршрута'.freeze
  ROUTE_AND_TRAIN_ALREADY_EXIST = 'Убедитесь в существовании маршрута и поезда'.freeze
  WAGONS_ALREADY_EXIST = 'Вагон с таким номером уже существует!'.freeze
  WAGONS_AND_TRAIN_ALREADY_EXIST = 'Убедитесь в существовании вагона и поезда'.freeze
  TRAIN_NUMBER_ALREADY_EXIST = 'Поезда с таким номером не существует!'.freeze
  DIVIDER = '---------------------------------'.freeze
  NUMBER_FORMAT = /^[\da-z]{3}-?[\da-z]{2}$/i
  ERROR_NUMBER_FORMAT = 'Неверный формат номера'.freeze
  EMPTY_NAME = 'Не указано наименование'.freeze
  INCORRECT_START_ST  = 'Неверный тип начальной станции'.freeze
  INCORRECT_FINISH_ST = 'Неверный тип конечной станции'.freeze
  SAME_STATIONS = 'Начальные и конечные станции не должны совпадать'.freeze
end

