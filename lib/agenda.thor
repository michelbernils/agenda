require_relative '../lib/contacts'
require 'fileutils'

class MyCLI < Thor

  desc "add NAME, EMAIL", "add contacts to our txt file"
  def add_contact(name, email)
    contact = Contacts.new(name: name, email: email)

    File.open("../files/contacts.txt", "a"){
        |f| f.write "#{contact.name} #{contact.email}\n"
    }
  end

  desc "list", "load contacts from our contacts.txt"
  def list_contacts()
    puts File.read("../files/contacts.txt")
  end

  desc "search NAME", "search for a contact using the contact name"
  def search_contact_by_name(name)

    
  end
  
  desc "delete NAME", "delete contacts from our contact.txt"
  def delete(name)

    delete_contact = Contacts.new(name: name)

    open('../files/contacts.txt', 'r') do |f|
      open('../files/contacts_tmp.txt', 'w') do |f2|
        f.each_line do |line|
           f2.write(line) unless line.start_with?("#{delete_contact.name}\n")
        end
      end
    end

    FileUtils.mv '../files/contacts_tmp.txt', '../files/contacts.txt'

  end

end
