require "minitest/autorun"
require 'csv'
require_relative '../lib/contacts'


#TODOS: 
# Arquivo de teste está vindo sem os headers

class AgendaTest < Minitest::Test
    def test_add_info

        contact = Contacts.new(name: 'michel', email: 'bernils.michel@gmail.com')

        header = ["name","email"]

        CSV.open("../files/contacts_test.csv","a") do |csv|
            row = CSV::Row.new(header,[])
            row["name"] = contact.name
            row["email"] = contact.email
            csv << row
        end


        # CSV.open('../files/contacts_test.csv', "a+") do |csv|
        #     
        # end

        actual_csv = File.open('../files/contacts.csv').read
        expected_csv = File.open('../files/contacts_test.csv').read

        assert_equal actual_csv, expected_csv
    end
end