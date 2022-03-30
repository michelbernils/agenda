class Contacts
    attr_reader :name, :email, :file_name

    def initialize(name: nil, email: nil, file_name: nil)
        @name = name
        @email = email
        @file_name = file_name
    end

end