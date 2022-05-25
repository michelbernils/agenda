# frozen_string_literal: true

require_relative '../lib/entity/agenda'
require_relative '../lib/entity/contact'
require_relative '../lib/repository/contact_repository'
require 'fileutils'
require 'csv'
require 'thor'
require 'byebug'

# CLI for the agenda.
class CLI < Thor
  desc 'start', 'add headers to our csv file'
  def start_agenda(file_name)
    agenda = Agenda.new(file_name: file_name)
    file_path = "../files/#{agenda.file_name}"
    headers = %w[name header]

    CSV.open(file_path, 'a+') do |csv|
      csv << headers if csv.count.eql? 0
    end
  end

  desc 'add FILE_NAME NAME, EMAIL', 'add contacts to our csv file'
  def add_contact(file_name, name, email)
    contact_repository = ContactRepository.new
    contact_repository.add_contact_to_csv(file_name, name, email)
  end

  desc 'search NAME', 'search a contact using the contact name'
  def search_contact(file_name, name)
    contact_repository = ContactRepository.new
    contact_repository.search_contact_on_csv_using_name(file_name, name)
  end

  desc 'delete NAME', 'deleta a contact using the contact name'
  def delete_contact(file_name, name)
    contact_repository = ContactRepository.new
    contact_repository.delete_contact_on_csv_using_name(file_name, name)
  end
end
