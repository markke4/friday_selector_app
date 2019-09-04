require "tty-prompt"

def run_option_1(places)
    puts "-----------------------------"
    puts "You should go to..."

    randomized_array = places.shuffle
    puts randomized_array[0].name.white.on_black.underline
    puts randomized_array[0].location
    puts "-----------------------------"
    prompt1 = TTY::Prompt.new
    response = prompt1.select("Are you actually going to go there? Selecting yes will increase the visits count.", %w(Yes No))
    if response == "Yes"
        randomized_array[0].increase_visits
        update_places_csv(places)
        read_csv
    end
end

module OptionTwo
    #methods data_checker (used within module), question_set (used in app.rb), are_you_sure (used in app.rb)
    #is this a self method? used within option 2 methods... 
    def self.data_checker(data, num_or_word)
        if num_or_word == "word"
            if data.length > 0
                return data
            else
                puts "You must enter something!"
            end
        elsif num_or_word == "num"
            if data > 0 && data < 6
                return data
            elsif
                puts "You must enter a rating between 1 and 5!"
            end
        else
            puts "you, the DEVELOPER, need to enter the second argument as either 'num' or 'word'."
        end
    end

    def self.question_set
        name = ""
        while name == ""
            puts "What is the name of the place you wish to add?"
            print "> "
            place_name = gets.strip.capitalize
            if data_checker(place_name, "word").class != NilClass
                name = place_name
            end
        end 
        place = ""
        while place == ""
            puts "What is the location of the place you wish to add? Please type the street number, street and suburb."
            print "> "
            place_location = gets.strip
            if data_checker(place_location, "word").class != NilClass
                place = place_location
            end
        end
        rating = ""
        while rating == ""
            puts "What would you rate this place out of 5? Feel free to use decimal places."
            print "> "
            place_rating = gets.strip.to_f
            if data_checker(place_rating, "num").class != NilClass
                rating = place_rating
            end
        end
        return [name, place, rating]
    end

    def self.are_you_sure(info, places, name)
        place_name = info[0]
        place_location = info[1]
        place_rating = info[2]
    
        status = "incomplete"
        while status == "incomplete"
            puts "You have entered the place as..."
            puts "name: #{place_name}, location: #{place_location}, rating: #{place_rating}".white.on_black.underline
            puts "If this information is correct, #{name}, and you wish to add it to the database, enter 'Y'. Otherwise enter 'N'."
            print "> "
            input = gets.strip.capitalize
            if input == 'Y'
                #code to add to CSV
                places_name = place_name + "1"
                places_name = Place.new({created_by: name, name: place_name, location: place_location, rating: place_rating, visits: 0})
                places.push(places_name)
                #update CSV then re-read the CSV
                update_places_csv(places)
                read_csv
                #exit loop
                status = true
                return places
            elsif input == 'N'
                question_set
            else
                puts "-----------------------------"
                puts "Please enter either 'Y' or 'N'."
                puts "-----------------------------"
            end
        end
    end

end

def option_3_display_all(places)
    puts `clear`
    prompt = TTY::Prompt.new
    response = prompt.select("Do you want to see a list ordered by most visited or highest rated?") do |menu|
        menu.choice "Most visited"
        menu.choice "Highest rated"
    end

    if response == "Most visited"
        puts "-----------------------------"
            sorted_array = places.sort! do |place2, place1| 
                place1.visits.to_i <=> place2.visits.to_i
            end

            sorted_array.each do |place|
                puts "#{place.name} with #{place.visits} visits"
            end
        puts "-----------------------------"
    elsif response == "Highest rated"
        # puts "-----------------------------"
        # places.each do |place|
        #     p "#{place.name}"
        #     #p "#{place.created_by}, #{place.name}, #{place.location}, #{place.rating}, #{place.visits}"

        # end
        # puts "-----------------------------"
    end


end

def option_6
    puts "-----------------------------"
    puts "Thank you for using the app. Good bye and enjoy your night!"
    puts "-----------------------------"
end


def is_valid
    puts "-----------------------------"
    puts "Please enter a valid option"
    puts "-----------------------------"
end