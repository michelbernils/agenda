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

#TODO: 
# 1) make the api call start_agenda, add_contact, update_contact, search_contact, delete_contact in MySql 
  # add_contact: done
  # update_contact: done
  # search_contact: done
  # delete_contact: done

# 2) make the api call start_agenda, add_contact, update_contact, search_contact, delete_contact in Mongodb
  # add_contact: done
  # update_contact: done
  # search_contact: done
  # delete_contact: done


# CLI for the agenda.
class CLI < Thor
  desc 'start AGENDA_NAME STORAGE_TYPE', 'add headers to our csv file'

  def start_agenda(agenda_name, storage_type)
    config_manager = ConfigManager.new(agenda_name: agenda_name, storage_type: storage_type)
    config_manager.write_file_information
    AgendaRepository.new(storage_client: config_manager.storage_client).start
  end
  
  desc 'add AGENDA_NAME STORAGE_TYPE, NAME, EMAIL', 'add contacts to our csv file'
  def add_contact(agenda_name, storage_type, category, name, email)
    config_manager = ConfigManager.new(agenda_name: agenda_name, storage_type: storage_type)
    ContactRepository.new(storage_client: config_manager.storage_client).add_contact(category, name, email)
  end

  desc 'update AGENDA_NAME STORAGE_TYPE, NAME, EMAIL', 'add contacts to our csv file'
  def update_contact(agenda_name, storage_type, id, category, name, email)
    config_manager = ConfigManager.new(agenda_name: agenda_name, storage_type: storage_type)
    ContactRepository.new(storage_client: config_manager.storage_client).update_contact(id, category, name, email)
  end

  desc 'search AGENDA_NAME STORAGE_TYPE, NAME', 'search a contact using the contact name'
  def search_contact(agenda_name, storage_type, name)
    config_manager = ConfigManager.new(agenda_name: agenda_name, storage_type: storage_type)
    ContactRepository.new(storage_client: config_manager.storage_client).search_contact_using_name(name)
  end

  desc 'delete NAME', 'deleta a contact using the contact name'
  def delete_contact(agenda_name, storage_type, name)
    config_manager = ConfigManager.new(agenda_name: agenda_name, storage_type: storage_type)
    ContactRepository.new(storage_client: config_manager.storage_client).delete_contact_using_name(name)
  end
end
