require_relative '../lib/contacts'
require 'fileutils'
require 'csv'


class MyCLI < Thor

  # não deixar repetir contato.
  # retornar o nome do contato e email em search.
  # deletar contato

  desc "start", "add headers to our csv file"
  def start_agenda()
    headers = ['name','email']
    CSV.open('../files/contacts.csv', 'a+') do |csv|
      csv << headers if csv.count.eql? 0 
    end
  end
  

  desc "add NAME, EMAIL", "add contacts to our csv file"
  def add_contact(name, email)
    contact = Contacts.new(name: name, email: email)
    CSV.open('../files/contacts.csv', "a+") do |csv|
      # if csv.include? contact.name
      #   csv << [contact.name, contact.email] 
      # else
      #   puts "Contato já adicionado"
      # end
      csv << [contact.name, contact.email] 
    end
  end

  desc "search NAME", "search a contact using the contact name"
  def search_contact(name)
    contact = Contacts.new(name: name)
    csv = CSV.parse(File.read("../files/contacts.csv"), headers: true)
    if (csv.find {|row| row["name"] == contact.name})
      puts "User found"
      puts contact.name 
    else
      puts "User not found"
    end
  end

  desc "delete NAME", "deleta a contact using the contact name"
  def delete_contact(name)

    contact = Contacts.new(name: name)    
    table = CSV.table("../files/contacts.csv")
    table.delete_if do |row|
      row[:name] == contact.name
    end

    File.open("../files/contacts.csv", 'w') do |f|
      f.write(table.to_csv)
    end


  end

  
end