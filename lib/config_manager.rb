# frozen_string_literal: true

require 'fileutils'
require 'byebug'

# YAML config class
class ConfigManager
  attr_accessor :yaml_file_path, :agenda_name, :storage_type
  
  def initialize(yaml_file_path: '../config.yaml', agenda_name:, storage_type:)
    @yaml_file_path = yaml_file_path
    @agenda_name = agenda_name
    @storage_type = storage_type
  end

  def write_file_information
    File.new(yaml_file_path, "a+") unless File.exist?(yaml_file_path)
    
      if File.exists?(yaml_file_path)
        File.open(yaml_file_path, "a+") do |yaml|
          yaml.write("#{agenda_name}: \n")
          yaml.write("  path: ../agendas/#{agenda_name}.#{storage_type} \n")
          yaml.write("  storage: #{storage_type} \n \n")
        end
      end
  end

  def file_path
    file_path = "../agendas/#{@agenda_name}.#{@storage_type}"
  end

  def storage_client
    file_path = "../agendas/#{agenda_name}.#{storage_type}"
    hash = YAML.load File.read(@yaml_file_path)
    case hash[@agenda_name]['storage']
    when 'csv'
      Csv.new(file: file_path)
    else
     :error
    end
  end
end