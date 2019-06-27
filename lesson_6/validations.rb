module Validations
  def valid?
    validate!
    true
  rescue
    false
  end
end
