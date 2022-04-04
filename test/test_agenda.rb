require "minitest/autorun"
require 'csv'
require_relative '../lib/contacts'
require 'thor'
require 'byebug'
load('../lib/agenda.thor')


#add, busca, delete, create
#testar os dois separados



describe "testing add, search and delete method" do

    it "testing file path" do
        expected_file_name = "agenda_teste"

        agenda = Agenda.new(file_name: expected_file_name)

        assert_equal agenda.file_name, expected_file_name
    end

    it "test_instance_agenda" do
        expected_header_1 = "name"
        expected_header_2 = "email"
        expected_file_name = "agenda_teste"

        agenda = Agenda.new(file_name: expected_file_name)

        CLI.start_agenda("../files/#{agenda.file_name}.csv")
        headers = CSV.read("../files/#{agenda.file_name}.csv", headers: true).headers

        assert_equal headers, [expected_header_1, expected_header_2]
    end

    # it "test_add_name" do
    #     expected_name = "michel"
    #     expected_email = "bernils"

    #     agenda = Agenda.new
    #     agenda.start_agenda('../files/contacts_test.csv')
    #     table = CSV.parse(File.read("../files/contacts_test.csv"), headers: true)

    #     agenda.add_contact(expected_name, expected_email)

    #     assert_equal table[0]["name"], expected_name.to_s
    # end


    # it "test_add_email" do
    #     expected_name = "michel"
    #     expected_email = "bernils"

    #     agenda = Agenda.new
    #     agenda.start_agenda('../files/contacts_test.csv')
    #     table = CSV.parse(File.read("../files/contacts_test.csv"), headers: true)

    #     agenda.add_contact(expected_name, expected_email)

    #     assert_equal table[0]["email"], expected_email
    # end


    # it "test_search_by_name" do
    #     expected_name = "michel"


    #     agenda = Agenda.new
    #     agenda.start_agenda('../files/contacts_test.csv')
    #     table = CSV.parse(File.read("../files/contacts_test.csv"), headers: true)

    #     agenda.search_contact(expected_name)

    #     assert_equal table[0]["name"], expected_name
    # end

    # it "test_delete_by_name" do
    #     expected_name = "michel"
    #     agenda = Agenda.new
    #     agenda.start_agenda('../files/contacts_test')
    #     table = CSV.parse(File.read("../files/contacts_test.csv"), headers: true)

    #     agenda.delete_contact(expected_name)

        
    # end
  
end





# class AgendaTest < Minitest::Test




# end