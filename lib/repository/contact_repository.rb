# frozen_string_literal: true

require_relative '../../lib/entity/contact'
require_relative '../../lib/config_manager'

require 'csv'
load('../lib/agenda.thor')

# This class contains all the logic necessary for Contact Repository
class ContactRepository
  attr_accessor :storage_client

  def initialize(storage_client:)
    @storage_client = storage_client
  end

  def add_contact(category, name, email)
    storage_client.add(category, name, email)

    Contacts.new(name: name, email: email)
  end

  def update_contact(id, category, name, email)
    storage_client.update(id, category, name, email)

    Contacts.new(name: name, email: email)
  end

  def search_contact(id)
    storage_client.search(id)
  end

  def delete_contact(id)
    storage_client.delete(id)
  end
end
