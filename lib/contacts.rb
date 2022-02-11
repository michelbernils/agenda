class Contacts
    attr_reader :name, :email

    def initialize(name: nil, email: nil)
        @name = name
        @email = email
    end

end