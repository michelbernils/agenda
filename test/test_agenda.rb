# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/hooks/default'
require 'csv'
require_relative '../lib/entity/contact'
require_relative '../lib/entity/agenda'
require_relative '../lib/repository/contact_repository'
require 'thor'
require 'byebug'
load('../lib/agenda.thor')

# test for the agemda class

describe 'delete file after each test' do
  after do
    File.delete('../files/agenda_teste.csv')
  end
end

describe 'intantece agenda' do
  it 'test_instance_agenda' do
    expected_header_one = 'name'
    expected_header_two = 'email'
    expected_file_name = 'agenda_teste.csv'

    agenda = Agenda.new(file_name: expected_file_name)
    cli = CLI.new
    cli.start_agenda("../files/#{agenda.file_name}")
    headers = CSV.read("../files/#{agenda.file_name}", headers: true).headers

    assert_equal headers, [expected_header_one, expected_header_two]
  end
end

describe '' do
  it 'test_add_name' do
    expected_name = 'michel'
    expected_email = 'bernils'
    expected_file_name = 'agenda_teste.csv'

    agenda = Agenda.new(file_name: expected_file_name)
    cli = CLI.new

    cli.start_agenda("../files/#{agenda.file_name}")
    cli.add_contact(expected_file_name, expected_name, expected_email)

    table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)

    assert_equal table[0]['name'], expected_name.to_s
  end
end

describe '' do
  it 'test_add_email' do
    expected_name = 'michel'
    expected_email = 'bernils'
    expected_file_name = 'agenda_teste.csv'

    agenda = Agenda.new(file_name: expected_file_name)
    cli = CLI.new

    cli.start_agenda("../files/#{agenda.file_name}")
    cli.add_contact(expected_file_name, expected_name, expected_email)

    table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)
    assert_equal table[0]['email'], expected_email.to_s
  end
end

describe '' do
  it 'test_search_by_name' do
    expected_name = 'michel'
    expected_email = 'bernils'
    expected_file_name = 'agenda_teste.csv'

    agenda = Agenda.new(file_name: expected_file_name)
    cli = CLI.new

    cli.start_agenda("../files/#{agenda.file_name}")
    cli.add_contact(expected_file_name, expected_name, expected_email)

    table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)

    cli.search_contact(expected_file_name, expected_name)

    assert_equal table[0]['name'], expected_name.to_s
  end
end

describe '' do
  it 'test_delete_by_name' do
    expected_name = 'michel'
    expected_email = 'bernils'
    expected_file_name = 'agenda_teste.csv'

    agenda = Agenda.new(file_name: expected_file_name)
    cli = CLI.new

    cli.start_agenda("../files/#{agenda.file_name}")
    cli.add_contact(expected_file_name, expected_name, expected_email)
    cli.delete_contact(expected_file_name, expected_name)

    table = CSV.parse(File.read("../files/#{agenda.file_name}"), headers: true)
    assert_nil table[0]
  end
end

describe '' do
  it 'test_file_not_found_add_contact' do
    expected_name = 'michel'
    expected_email = 'bernils'
    expected_file_name = 'agenda_teste.csv'
    file_name_with_error = 'agenda_teste_2.csv'

    agenda = Agenda.new(file_name: expected_file_name)
    cli = CLI.new

    cli.start_agenda("../files/#{agenda.file_name}")

    assert_equal cli.add_contact(file_name_with_error, expected_name, expected_email), nil
  end
end

describe '' do
  it 'test_file_not_found_search_contact' do
    expected_name = 'michel'
    expected_file_name = 'agenda_teste.csv'
    file_name_with_error = 'agenda_teste_2.csv'

    agenda = Agenda.new(file_name: expected_file_name)
    cli = CLI.new

    cli.start_agenda("../files/#{agenda.file_name}")

    assert_equal cli.search_contact(file_name_with_error, expected_name), nil
  end
end

describe '' do
  it 'test_file_not_found_delete_contact' do
    expected_name = 'michel'
    expected_file_name = 'agenda_teste.csv'
    file_name_with_error = 'agenda_teste_2.csv'

    agenda = Agenda.new(file_name: expected_file_name)
    cli = CLI.new

    cli.start_agenda("../files/#{agenda.file_name}")

    assert_equal cli.delete_contact(file_name_with_error, expected_name), nil
  end
end
