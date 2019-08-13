# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validations'

class Station
  include InstanceCounter
  include Validations

  EMPTY_NAME = 'Не указано наименование'

  attr_reader :name, :trains

  @@instances = []

  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@instances << self
    register_instance
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

  def each_train
    trains.each { |train| yield(train) }
  end
end
