require_relative 'instance_counter'
require_relative 'validations'
require_relative 'interface_constants'

class Station
  include InstanceCounter
  include Validations

  attr_reader :name, :trains

  @@instances = []

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    @@instances << self
    register_instance
    validate!
  end

  def accept_train(train)
    @trains << train
  end

  def trains_by_type(type)
    @trains.select { |train| train == type }
  end

  def send_train(train)
    @trains.delete(train)
  end

  protected

  def validate!
    raise EMPTY_NAME if name.empty?
  end
end
