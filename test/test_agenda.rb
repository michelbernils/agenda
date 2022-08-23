# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/entity/agenda'

# test for the agenda class
class AgendaTest < Minitest::Test
  def test_instance_contacts
    agenda = Agenda.new
    assert_instance_of Agenda, agenda
  end

  def test_agenda_return_file_name
    file_name = 'agenda.csv'
    agenda = Agenda.new(file_name: file_name)

repository-pattern
    assert_equal file_name, agenda.file_name
end

describe "testing add, search and delete method" do

    after do
        File.delete("../files/agenda_teste.csv")
    end

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

    it "test_add_name" do
        expected_name = "michel"
        expected_email = "bernils"
        expected_file_name = "agenda_teste.csv"

        agenda = Agenda.new(file_name: expected_file_name)
        cli = CLI.new

        cli.start_agenda("../files/#{agenda.file_name}")
        cli.add_contact(expected_file_name, expected_name, expected_email)

        table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)

        assert_equal table[0]["name"], expected_name.to_s
    end


    it "test_add_email" do
        expected_name = "michel"
        expected_email = "bernils"
        expected_file_name = "agenda_teste.csv"

        agenda = Agenda.new(file_name: expected_file_name)
        cli = CLI.new

        cli.start_agenda("../files/#{agenda.file_name}")
        cli.add_contact(expected_file_name, expected_name, expected_email)

        table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)
        assert_equal table[0]["email"], expected_email.to_s
    end

    it "test_search_by_name" do
        expected_name = "michel"
        expected_email = "bernils"
        expected_file_name = "agenda_teste.csv"

        agenda = Agenda.new(file_name: expected_file_name)
        cli = CLI.new

        cli.start_agenda("../files/#{agenda.file_name}")
        cli.add_contact(expected_file_name, expected_name, expected_email)
    
        table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)

        cli.search_contact(expected_file_name, expected_name)

        assert_equal cli.search_contact(expected_file_name, expected_name), expected_name.to_s
    end

    it "test_delete_by_name" do
        expected_name = "michel"
        expected_email = "bernils"
        expected_file_name = "agenda_teste.csv"

        agenda = Agenda.new(file_name: expected_file_name)
        cli = CLI.new

        cli.start_agenda("../files/#{agenda.file_name}")
        cli.add_contact(expected_file_name, expected_name, expected_email)
        cli.delete_contact(expected_file_name, expected_name)

        table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)
        assert_nil table[0]
        
    end

    it "test_file_not_found_add_contact" do
        expected_name = "michel"
        expected_email = "bernils"
        expected_file_name = "agenda_teste.csv"
        file_name_with_error = "agenda_teste_2.csv"

        agenda = Agenda.new(file_name: expected_file_name)
        cli = CLI.new

        cli.start_agenda("../files/#{agenda.file_name}")

        assert_equal cli.add_contact(file_name_with_error, expected_name, expected_email), :file_or_directory_not_found
    end


    it "test_file_not_found_search_contact" do
        expected_name = "michel"
        expected_email = "bernils"
        expected_file_name = "agenda_teste.csv"
        file_name_with_error = "agenda_teste_2.csv"

        agenda = Agenda.new(file_name: expected_file_name)
        cli = CLI.new

        cli.start_agenda("../files/#{agenda.file_name}")

        assert_equal cli.search_contact(file_name_with_error, expected_name), :file_or_directory_not_found
    end

    it "test_file_not_found_delete_contact" do
        expected_name = "michel"
        expected_email = "bernils"
        expected_file_name = "agenda_teste.csv"
        file_name_with_error = "agenda_teste_2.csv"

        agenda = Agenda.new(file_name: expected_file_name)
        cli = CLI.new

        cli.start_agenda("../files/#{agenda.file_name}")

        assert_equal cli.delete_contact(file_name_with_error, expected_name), :file_or_directory_not_found
    end
end
