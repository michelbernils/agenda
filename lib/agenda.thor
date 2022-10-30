# frozen_string_literal: true

require 'fileutils'
require 'csv'
require 'thor'
require 'byebug'
require 'yaml'

require_relative '../lib/config_manager'
require_relative '../lib/repository/agenda_repository'
require_relative '../lib/repository/contact_repository'
require_relative '../lib/entity/agenda'
require_relative '../lib/entity/contact'

# CLI for the agenda.
class CLI < Thor

  desc 'start AGENDA_NAME STORAGE_TYPE', 'add headers to our csv file'
  option :url, :type => :string
  def start_agenda(agenda_name, storage_type)
    config_manager = ConfigManager.new(agenda_name: agenda_name, storage_type: storage_type)
    config_manager.write_file_information(options[:url]) if options[:url]
    AgendaRepository.new(storage_client: config_manager.storage_client).start
  end
  
  desc 'add AGENDA_NAME STORAGE_TYPE, NAME, EMAIL', 'add contacts to csv or api'
  def add_contact(agenda_name, storage_type, category, name, email)
    config_manager = ConfigManager.new(agenda_name: agenda_name, storage_type: storage_type)
    ContactRepository.new(storage_client: config_manager.storage_client).add_contact(category, name, email)
  end

  desc 'update AGENDA_NAME STORAGE_TYPE, NAME, EMAIL', 'add contacts to csv or api'
  def update_contact(agenda_name, storage_type, id, category, name, email)
    config_manager = ConfigManager.new(agenda_name: agenda_name, storage_type: storage_type)
    ContactRepository.new(storage_client: config_manager.storage_client).update_contact(id, category, name, email)
  end

  desc 'search AGENDA_NAME STORAGE_TYPE, ID', 'search a contact id'
  def search_contact(agenda_name, storage_type, id)
    config_manager = ConfigManager.new(agenda_name: agenda_name, storage_type: storage_type)
    ContactRepository.new(storage_client: config_manager.storage_client).search_contact(id)
  end

  desc 'delete AGENDA_NAME, STORAGE_TYPE, ID', 'deleta a contact id'
  def delete_contact(agenda_name, storage_type, id)
    config_manager = ConfigManager.new(agenda_name: agenda_name, storage_type: storage_type)
    ContactRepository.new(storage_client: config_manager.storage_client).delete_contact(id)
  end
end
