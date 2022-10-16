# frozen_string_literal: true

require_relative '../../lib/entity/contact'

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

  def search_contact_using_name(name)
    storage_client.search(name)

    Contacts.new(name: name)
  end

  def delete_contact_using_name(name)
    storage_client.delete(name)
  end
end
