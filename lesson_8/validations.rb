module Validations
  def valid?
    validate!
    true
  rescue StandardError
    false
  end
end
