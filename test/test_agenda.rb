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

    assert_equal file_name, agenda.file_name
  end
end
