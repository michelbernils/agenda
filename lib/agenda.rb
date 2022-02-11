class Agenda
    attr_accessor :list

    def initialize(list: nil)
        @list = list
    end

    def add_contact(name, email)
        new_contact = Contacts.new(name, email)

        File.open("../files/contacts.txt", "a"){
            |f| f.write "#{contact.name}, #{contact.email}"
        }
    end



    add_contact("michel", "michel@gmail.com")

end