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
require_relative '../lib/storages/storage_handler.rb'

# CLI for the agenda.
class CLI < Thor
  desc 'start AGENDA_NAME STORAGE_TYPE', 'add headers to our csv file'

  def start_agenda(agenda_name, storage_type)
    file_path = "../agendas/#{agenda_name}.#{storage_type}"
    config_manager = ConfigManager.new(agenda_name: agenda_name, storage_type: storage_type)
    config_manager.write_file_information
    AgendaRepository.new(storage_client: config_manager.storage_client).start(file_path)
  end

  desc 'add AGENDA_NAME STORAGE_TYPE, NAME, EMAIL', 'add contacts to our csv file'
  def add_contact(agenda_name, storage_type, name, email)
    file_path = "../agendas/#{agenda_name}.#{storage_type}"
    ContactRepository.new(storage_client: Csv.new(file: file_path).add_contact(name, email))
  end

  desc 'search AGENDA_NAME STORAGE_TYPE, NAME', 'search a contact using the contact name'
  def search_contact(agenda_name, storage_type, name)
    file_path = "../agendas/#{agenda_name}.#{storage_type}"
    ContactRepository.new(storage_client: Csv.new(file: file_path).search_contact_using_name(name))
  end

  desc 'delete NAME', 'deleta a contact using the contact name'
  def delete_contact(agenda_name, storage_type, name)
    file_path = "../agendas/#{agenda_name}.#{storage_type}"
    ContactRepository.new(storage_client: Csv.new(file: file_path).delete_contact_using_name(name))
  end
end
