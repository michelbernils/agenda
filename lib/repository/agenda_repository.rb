# frozen_string_literal: true

require_relative '../../lib/entity/contact'
require_relative '../../lib/entity/agenda'
require_relative '../../lib/storages/csv'

require 'csv'

# This class contains all the logic necessary for Agenda Repository
class AgendaRepository
  attr_accessor :name, :storage_type, :storage_client

  def initialize(storage_client:)
    @storage_client = storage_client
  end

  def start_agenda(name, storage_type)
    storage_client.start_agenda_csv(name, storage_type)

    Agenda.new(name: name, storage_type: storage_type)
  end
end
