# frozen_string_literal: true

require 'fileutils'
require 'csv'
require 'thor'
require 'byebug'
require 'yaml'

require_relative '../lib/repository/agenda_repository'
require_relative '../lib/repository/contact_repository'
require_relative '../lib/entity/agenda'
require_relative '../lib/entity/contact'

# EX
# $ cli-scheduler start escola csv
#
# -> Criar YML, ~/cli-scheduler/config.yml
# agendas:
#   name: escola
#   path: "~/cli-scheduelr/agendas/escola.csv"
#   storage: csv

# CLI for the agenda.
class CLI < Thor
  desc 'start AGENDA_NAME STORAGE_TYPE', 'add headers to our csv file'

  def start_agenda(agenda_name, storage_type)
    file_path = "../agendas/#{agenda_name}.#{storage_type}"
    AgendaRepository.new(storage_client: Csv.new(file: file_path)).start(agenda_name, storage_type)

    yaml_file_path = '../config.yml'
    if File.exists?(yaml_file_path) == false
      File.open(yaml_file_path, 'a+') do |yaml|
        yaml.write("agendas: \n\n")
      end
    end

    File.open(yaml_file_path, "a+") do |yaml|
      yaml.write(" name: #{agenda_name} \n")
      yaml.write(" path: ../agendas/#{agenda_name}.#{storage_type} \n")
      yaml.write(" storage: #{storage_type} \n \n")
    end
  end

  desc 'add AGENDA_NAME STORAGE_TYPE, NAME, EMAIL', 'add contacts to our csv file'
  def add_contact(agenda_name, storage_type, name, email)
    file_path = "../agendas/#{agenda_name}.#{storage_type}"
    ContactRepository.new(storage_client: Csv.new(file: file_path).add(name, email))
  end

  desc 'search AGENDA_NAME STORAGE_TYPE, NAME', 'search a contact using the contact name'
  def search_contact(agenda_name, storage_type, name)
    file_path = "../agendas/#{agenda_name}.#{storage_type}"
    ContactRepository.new(storage_client: Csv.new(file: file_path).search(name))
  end

  desc 'delete NAME', 'deleta a contact using the contact name'
  def delete_contact(agenda_name, storage_type, name)
    file_path = "../agendas/#{agenda_name}.#{storage_type}"
    ContactRepository.new(storage_client: Csv.new(file: file_path).delete(name))
  end
end
