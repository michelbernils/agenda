# frozen_string_literal: true

require_relative '../../lib/entity/contact'

require 'csv'
load('../lib/agenda.thor')

# This class contains all the logic necessary to run the agenda
class ContactRepository
  def start_agenda(file_name)
    agenda = Agenda.new(file_name: file_name)
    file_path = "../files/#{agenda.file_name}"
    headers = %w[name header]
    CSV.open(file_path, 'a+') do |csv|
      csv << headers if csv.count.eql? 0
    end
  end

  def add_contact_to_csv(file_name, name, email)
    return unless File.exist?("../files/#{file_name}")

    contact = Contacts.new(file_name: file_name, name: name, email: email)
    file_path = "../files/#{contact.file_name}"

    CSV.open(file_path, 'a+') do |csv|
      csv << [contact.name, contact.email]
    end
  end

  def search_contact_on_csv_using_name(file_name, name)
    return unless File.exist?("../files/#{file_name}")

    contact = Contacts.new(file_name: file_name, name: name)
    file_path = "../files/#{contact.file_name}"
    csv = CSV.parse(File.read(file_path), headers: true)
    if csv.find { |row| row['name'] == contact.name }
      puts 'Usuario encontrado'
      puts contact.name
    else
      puts 'User not found'
    end
  end

  def delete_contact_on_csv_using_name(file_name, name)
    return unless File.exist?("../files/#{file_name}")

    contact = Contacts.new(file_name: file_name, name: name)
    file_path = "../files/#{contact.file_name}"
    table = CSV.table(file_path)
    table.delete_if do |row|
      row[:name] == contact.name
    end
    File.open(file_path, 'w') do |f|
      f.write(table.to_csv)
    end
  end

  private

  def file_exists?(file_name)
    if File.exist?("../files/#{file_name}")
      true
    else
      false
    end
  end
end
