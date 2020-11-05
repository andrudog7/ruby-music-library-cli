require 'pry'
class MusicLibraryController
    attr_accessor :path
    
    def initialize(path = './db/mp3s')
        @path = path 
        import = MusicImporter.new(path)
        import.import 
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        loop do 
            puts "What would you like to do?"
            user_input = gets.strip 
        if user_input == "list songs"
            list_songs
        elsif user_input == "list artists"
            list_artists
        elsif user_input == "list genres"
            list_genres
        elsif user_input == "list artist"
            list_songs_by_artist
        elsif user_input == "list genre"
            list_songs_by_genre
        elsif user_input == "play song"
            play_song
        elsif user_input == "exit"
            break
        end
    end
    end

    def list_songs
        Song.all.sort{|a, b| a.name <=> b.name}.each.with_index{|song, i| puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end

    def list_artists
        Artist.all.sort{|a, b| a.name <=> b.name}.map.with_index{|artist, i| puts "#{i+1}. #{artist.name}"}
    end

    def list_genres
        Genre.all.sort{|a, b| a.name <=> b.name}.map.with_index{|genre, i| puts "#{i+1}. #{genre.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_input = gets.strip
        Song.all.select{|song| song.artist.name == user_input}.sort{|a,b| a.name <=> b.name}.each.with_index{|song, i| puts "#{i+1}. #{song.name} - #{song.genre.name}"}
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets.strip 
        Song.all.select{|song| song.genre.name == user_input}.sort{|a,b| a.name <=> b.name}.each.with_index{|song, i| puts "#{i+1}. #{song.artist.name} - #{song.name}"}
    end

    def play_song
        puts "Which song number would you like to play?"
        user_input = gets.strip.to_i
        if user_input >= 1 && user_input < Song.all.count
        Song.all.sort{|a, b| a.name <=> b.name}.each.with_index{|song, i| 
        if i+1 == user_input
            puts "Playing #{song.name} by #{song.artist.name}"
        else nil
        end}
    end
    end

end
