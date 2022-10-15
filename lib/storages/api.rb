# frozen_string_literal: true

require 'faraday'

# All the logic for the API requests
class Api

  def initialize(database_name:)
    @database_name = database_name
  end

  def start
    conn = Faraday.new(
      url: 'http://127.0.0.1:4567',
      headers: {'Content-Type' => 'application/json'}
    )

    response = conn.post('/create-database') do |req|
      req.body = JSON.generate(database_name: @database_name)
    end
  end

  def add(name, email)
    conn = Faraday.new(
      url: 'http://127.0.0.1:4567',
      headers: {'Content-Type' => 'application/json'}
    )

    response = conn.post('/create') do |req|
      req.body = JSON.generate(name: name, email: email)
    end
  end

  def search(name)
    conn = Faraday.new(
      url: 'http://127.0.0.1:4567',
      headers: {'Content-Type' => 'application/json'}
    )

    response = conn.post('/search') do |req|
      req.body = JSON.generate(name: name)
    end
  end

  def update(id, name, email)
    conn = Faraday.new(
      url: 'http://127.0.0.1:4567',
      headers: {'Content-Type' => 'application/json'}
    )

    response = conn.put('/update') do |req|
      req.body = JSON.generate(id, name: name, email: email)
    end
  end

  def delete(name)
    conn = Faraday.new(
      url: 'http://127.0.0.1:4567',
      headers: {'Content-Type' => 'application/json'}
    )

    response = conn.delete('/delete') do |req|
      req.body = JSON.generate(name: name)
    end
  end
end
