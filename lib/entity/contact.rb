# frozen_string_literal: true

# Contacts class
class Contacts
  attr_accessor :name, :email

  def initialize(name: nil, email: nil)
    @name = name
    @email = email
  end
end
