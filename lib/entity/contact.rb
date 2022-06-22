# frozen_string_literal: true

# Contacts class
class Contacts
  attr_accessor :file_name, :name, :email

  def initialize(name: nil, email: nil, file_name: nil)
    @name = name
    @email = email
    @file_name = file_name
  end

end
