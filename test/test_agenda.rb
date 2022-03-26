require "minitest/autorun"
require 'csv'
require_relative '../lib/contacts'
require 'thor'
require 'byebug'
load('../lib/agenda.thor')


#add, busca, delete, create
#testar os dois separados



describe "testing add, search and delete method" do

    after do
        File.delete('../files/contacts_test.csv')
    end

    def test_instance_agenda
        expected_header_1 = "name"
        expected_header_2 = "email"

        agenda = Agenda.new
        agenda.start_agenda('../files/contacts_test.csv')
        headers = CSV.read("../files/contacts_test.csv", headers: true).headers

        assert_equal headers, [expected_header_1, expected_header_2]
    end

    def test_add_name
        expected_name = "michel"
        expected_email = "bernils"

        agenda = Agenda.new
        agenda.start_agenda('../files/contacts_test.csv')
        table = CSV.parse(File.read("../files/contacts_test.csv"), headers: true)

        agenda.add_contact(expected_name, expected_email)

        assert_equal table[0]["name"], expected_name.to_s
    end


    def test_add_email
        expected_name = "michel"
        expected_email = "bernils"

        agenda = Agenda.new
        agenda.start_agenda('../files/contacts_test.csv')
        table = CSV.parse(File.read("../files/contacts_test.csv"), headers: true)

        agenda.add_contact(expected_name, expected_email)

        assert_equal table[0]["email"], expected_email.to_s
    end


    def test_search_by_name
        expected_name = "michel"


        agenda = Agenda.new
        agenda.start_agenda('../files/contacts_test.csv')
        table = CSV.parse(File.read("../files/contacts_test.csv"), headers: true)

        agenda.search_contact(expected_name)

        assert_equal table[0]["name"], expected_name.to_s
    end

    # def test_delete_by_name
    #         expected_name = "michel"


    #     table = CSV.parse(File.read("../files/contacts_test.csv"), headers: true)

    #         agenda.delete_contact(expected_name)


    # end
  
end





# class AgendaTest < Minitest::Test




# end