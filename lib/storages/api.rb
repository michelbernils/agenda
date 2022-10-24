# frozen_string_literal: true

require 'faraday'
require 'yaml'
require 'byebug'

# All the logic for the API requests
class Api
  def initialize(database_name:)
    @database_name = database_name
  end

  def start
    :not_implemented
  end

  def add(category, name, email)
    hash = YAML.safe_load File.read('../config.yaml')
    url = hash[@database_name]['server']
    conn = Faraday.new(
      url: "#{url}",
      headers: {'Content-Type' => 'application/json'}
    )
    response = conn.post('/agenda/create') do |req|
      req.body = {category: "#{category}", name: "#{name}", email: "#{email}"}.to_json
    end
  end

  def search(name)
    hash = YAML.safe_load File.read('../config.yaml')
    url = hash[@database_name]['server']
    conn = Faraday.new(
      url: "#{url}",
      headers: {'Content-Type' => 'application/json'}
    )

    response = conn.post('/agenda/search') do |req|
      req.body = {name: "#{name}"}.to_json
    end
  end

  def update(id, category, name, email)
    hash = YAML.safe_load File.read('../config.yaml')
    url = hash[@database_name]['server']
    conn = Faraday.new(
      url: "#{url}",
      headers: {'Content-Type' => 'application/json'}
    )

    response = conn.put('/agenda/update') do |req|
      req.body = {id: "#{id}", category: "#{category}", name: "#{name}", email: "#{email}"}.to_json
    end
  end

  def delete(name)
    hash = YAML.safe_load File.read('../config.yaml')
    url = hash[@database_name]['server']
    conn = Faraday.new(
      url: "#{url}",
      headers: {'Content-Type' => 'application/json'}
    )

    response = conn.delete('/agenda/delete') do |req|
      req.body = {name: "#{name}"}.to_json
    end
  end
end
