require "minitest/autorun"
require 'csv'
require_relative '../lib/contacts'
require_relative '../lib/agenda'


#TODOS: 
# Arquivo de teste está vindo sem os headers

class AgendaTest < Minitest::Test
    def test_add_info

        contact = Contacts.new(name: 'michel', email: 'bernils.michel@gmail.com')
        add_contact(contact.name, contact.email)
        table = CSV.parse(File.read("../files/contacts.csv"), headers: true)

        assert_equal table.first.to_h, ["nome"=> contact.name, "email"=> contact.email]
    end
end