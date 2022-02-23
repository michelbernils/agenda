require_relative '../lib/contacts'
require 'fileutils'
require 'csv'


class MyCLI < Thor


  desc "add NAME, EMAIL", "add contacts to our txt file"
  def add_contact(name, email)

    CSV.open('../files/contacts.csv', 'w') << %w(nome email)

    contact = Contacts.new(name: name, email: email)
    puts contact.name
    puts contact.email

    CSV.open('../files/contacts.csv', "a+") do |csv|
      csv << {name: contact.name, email: contact.email}
    end

  end

  # desc "list", "load contacts from our contacts.txt"
  # def list_contacts()
  #   CSV.read("../files/contacts.csv")
  # end

  # desc "search NAME", "search a contact using the contact name"
  # def search_contact_by_name(name)
  #   csv = CSV.read( "../files/contacts.csv", header: true )

  #   puts csv.find {|row| row['NAME'] == 'Tom'} #=> returns first `row` that satisfies the block.
  # end
  





  
end