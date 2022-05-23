require_relative '../lib/entity/agenda'
require_relative '../lib/entity/contact'
require_relative '../lib/repository/contact_repository'
require 'fileutils'
require 'csv'
require 'thor'
require 'byebug'

class CLI < Thor

  desc "start", "add headers to our csv file"
  def start_agenda(file_name)
    agenda = Agenda.new(file_name: file_name)
    file_path = "../files/#{agenda.file_name}"
    headers = ['name','email']

    CSV.open(file_path, 'a+') do |csv|
      csv << headers if csv.count.eql? 0 
      end
  end



  desc "add FILE_NAME NAME, EMAIL", "add contacts to our csv file"
  def add_contact(file_name, name, email)
    contact = Contacts.new(file_name: file_name, name: name, email: email)
    file_path = "../files/#{contact.file_name}"


    if(File.exist?("../files/#{contact.file_name}")) 
      CSV.open(file_path, "a+") do |csv|
        csv << [contact.name, contact.email]
      end
    else 
      :file_or_directory_not_found
    end

  end

  desc "search NAME", "search a contact using the contact name"
  def search_contact(file_name, name)
    contact = Contacts.new(file_name:file_name, name: name)
    file_path = "../files/#{contact.file_name}"
    if(File.exist?("../files/#{contact.file_name}")) 
      csv = CSV.parse(File.read(file_path), headers: true)
      if (csv.find {|row| row["name"] == contact.name})
        puts "Usuario encontrado"
        puts contact.name
      else
        puts "User not found"
      end
    else 
      :file_or_directory_not_found
    end
  end

  desc "delete NAME", "deleta a contact using the contact name"
  def delete_contact(file_name, name)

    contact = Contacts.new(file_name: file_name, name: name)    
    file_path = "../files/#{contact.file_name}"

    if(File.exist?("../files/#{contact.file_name}")) 
      table = CSV.table(file_path)

      table.delete_if do |row|
        row[:name] == contact.name
      end
      
      File.open(file_path, 'w') do |f|
        f.write(table.to_csv)
      end
    else 
      :file_or_directory_not_found
    end
  end
  
end