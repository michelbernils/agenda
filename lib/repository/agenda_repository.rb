# frozen_string_literal: true

require_relative '../../lib/config_manager'
require_relative '../../lib/entity/contact'
require_relative '../../lib/entity/agenda'
require_relative '../../lib/storages/csv'

require 'csv'
require 'byebug'

# This class contains all the logic necessary for Agenda Repository
class AgendaRepository
  attr_accessor :storage_client

  def initialize(storage_client:)
    @storage_client = storage_client
  end

  def start
    storage_client.start
    Agenda.new(file_name: storage_client.file)
  end
end
