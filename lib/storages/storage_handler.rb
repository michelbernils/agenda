
# frozen_string_literal: true

require_relative 'csv'

#StorageHandler class
class StorageHandler
  attr_accessor :file_path

  def initialize(yaml_file_path: '../config.yaml', file_path:, agenda_name:)
    @yaml_file_path = yaml_file_path
    @file_path = file_path
    @agenda_name = agenda_name
  end

  def storage_client()
    hash = YAML.load File.read(@yaml_file_path)
    if hash[@agenda_name]['storage'] == 'csv'
      Csv.new(file: file_path)
    elseif hash[@agenda_name]['storage'] == 'txt'
      p 'NOT IMPLEMENTED YET'
    end
  end
end