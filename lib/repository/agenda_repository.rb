# frozen_string_literal: true

require_relative '../../lib/config_manager'
require_relative '../../lib/entity/contact'
require_relative '../../lib/entity/agenda'
require_relative '../../lib/storages/csv'
require_relative '../../lib/storages/api'

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
  end
end
