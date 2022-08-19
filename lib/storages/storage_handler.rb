
# frozen_string_literal: true

require_relative 'csv'
require_relative '../config_manager'


#StorageHandler class
class StorageHandler
  attr_accessor :file_path

  def initialize(yaml_file_path: '../config.yaml', file_path:, agenda_name:)
    @yaml_file_path = yaml_file_path
    @file_path = file_path
    @agenda_name = agenda_name
  end
end
