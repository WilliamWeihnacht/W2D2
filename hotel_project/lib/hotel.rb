require_relative "room"

class Hotel

    def initialize(name,rooms)
        @name = name
        @rooms = {}
        rooms.each_pair do |k,v|
            @rooms[k] = Room.new(v)
        end
    end

    def name
        arr = @name.split
        arr.map! do |x|
            x.capitalize
        end
        arr.join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(name)
        return true if @rooms.has_key?(name)
        false
    end

    def check_in(person,room)
        if !room_exists?(room)
            puts "sorry, room does not exist"
            return false
        else
            if @rooms[room].add_occupant(person)
                puts "check in successful"
            else
                puts "sorry, room is full"
            end
        end
    end

    def has_vacancy?
        @rooms.each_pair do |k,v|
            if !v.full?
                return true
            end
        end
        false
    end

    def list_rooms
        @rooms.each_pair do |k,v|
            print k
            print v.available_space
            puts
        end
    end
  
end
