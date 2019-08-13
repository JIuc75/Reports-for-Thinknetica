# frozen_string_literal: true

module Validations
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
