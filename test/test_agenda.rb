require "minitest/autorun"
require 'minitest/hooks/default'
require 'csv'
require_relative '../lib/contacts'
require 'thor'
require 'byebug'
load('../lib/agenda.thor')


#add, busca, delete, create
#testar os dois separados



describe "testing add, search and delete method" do

    after do
        File.delete("../files/agenda_teste.csv")
    end

    # desc "testing if the file path is being create correctly"
    it "testing file path" do
        expected_file_name = "agenda_teste"

        agenda = Agenda.new(file_name: expected_file_name)

        assert_equal agenda.file_name, expected_file_name
    end

    # desc "testing if the headers are being created correctly"
    it "test_instance_agenda" do
        expected_header_1 = "name"
        expected_header_2 = "email"
        expected_file_name = "agenda_teste.csv"

        agenda = Agenda.new(file_name: expected_file_name)
        cli = CLI.new

        cli.start_agenda("../files/#{agenda.file_name}")
        headers = CSV.read("../files/#{agenda.file_name}", headers: true).headers

        assert_equal headers, [expected_header_1, expected_header_2]
    end

    # desc "testing if the name are being added correctly"
    it "test_add_name" do
        expected_name = "michel"
        expected_email = "bernils"
        expected_file_name = "agenda_teste.csv"

        agenda = Agenda.new(file_name: expected_file_name)
        cli = CLI.new

        cli.start_agenda("../files/#{agenda.file_name}")
        table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)

        cli.add_contact(expected_file_name, expected_name, expected_email)

        assert_equal table[0]["name"], expected_name.to_s
    end

    # desc "testing if the name is not added on an unexistent agenda"
    # it "test_add_name_when_agenda_dont_exist" do

    # end

    # desc "testing if the email are being added correctly"
    it "test_add_email" do
        expected_name = "michel"
        expected_email = "bernils"
        expected_file_name = "agenda_teste.csv"

        agenda = Agenda.new(file_name: expected_file_name)
        cli = CLI.new

        cli.start_agenda("../files/#{agenda.file_name}")
        table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)

        cli.add_contact(expected_file_name, expected_name, expected_email)

        assert_equal table[0]["email"], expected_email.to_s
    end

    # desc ""
    # it "test_add_email_when_agenda_dont_exist" do

    # end

    # desc ""
    it "test_search_by_name" do
        expected_name = "michel"
        expected_file_name = "agenda_teste.csv"

        agenda = Agenda.new(file_name: expected_file_name)
        cli = CLI.new

        cli.start_agenda("../files/#{agenda.file_name}")
        table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)

        cli.search_contact( expected_file_name, expected_name)

        assert_equal table[0]["name"], expected_name
    end

    # desc ""
    # it "test_search_by_name_when_agenda_dont_exist" do

    # end

    # desc ""
    # it "test_delete_by_name" do
    #     expected_name = "michel"
    #     expected_file_name = "agenda_teste.csv"

    #     agenda = Agenda.new(file_name: expected_file_name)
    #     cli = CLI.new

    #     cli.start_agenda("../files/#{agenda.file_name}")
    #     table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)

    #     cli.delete_contact(expected_name)

        
    # end
  
end
