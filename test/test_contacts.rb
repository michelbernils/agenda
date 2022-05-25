# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/entity/contact'

# test for the contact class
class ContactsTest < Minitest::Test
  def test_instance_contacts
    contacts = Contacts.new
    assert_instance_of Contacts, contacts
  end

  def test_contacts_return_name
    name = 'Michel'
    contacts = Contacts.new(name: name)

    assert_equal name, contacts.name
  end

  def test_contacts_return_email
    email = 'bernils.michel@gmail.com'
    contacts = Contacts.new(email: email)

    assert_equal email, contacts.email
  end
end
