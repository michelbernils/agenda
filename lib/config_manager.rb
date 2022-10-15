# frozen_string_literal: true

require_relative 'storages/api.rb'
require 'fileutils'
require 'byebug'

# YAML config class
class ConfigManager
  attr_accessor :yaml_file_path, :agenda_name, :storage_type

  def initialize(agenda_name:, storage_type:, yaml_file_path: '../config.yaml')
    @yaml_file_path = yaml_file_path
    @agenda_name = agenda_name
    @storage_type = storage_type
  end

  def write_file_information
    File.new(yaml_file_path, 'a+') unless File.exist?(yaml_file_path)

    return unless File.exist?(yaml_file_path)

    File.open(yaml_file_path, 'a+') do |yaml|
      yaml.write("#{agenda_name}: \n")
      yaml.write("  path: ../agendas/#{agenda_name}.#{storage_type} \n")
      yaml.write("  storage: #{storage_type} \n \n")
    end
  end

  def storage_client
    file_path = "../agendas/#{agenda_name}.#{storage_type}"
    hash = YAML.safe_load File.read(@yaml_file_path)
    case hash[@agenda_name]['storage']
    when 'csv'
      Csv.new(file: file_path)
    when 'api'
      Api.new(database_name: agenda_name)
    else
      :error
    end
  end
end
