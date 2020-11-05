class Song
    attr_accessor :name, :genre, :artist
    @@all = []
    
    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist=(artist) unless artist == nil
        self.genre=(genre) unless genre == nil
    end

    def genre=(genre)
        @genre = genre 
        genre.songs << self unless genre.songs.include?(self)
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end
    
    def self.all
        @@all
    end
    
    def save
        self.class.all << self
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        song = Song.new(name)
        song.save 
        song
    end

    def self.find_by_name(name)
        self.all.select{|song|song.name == name}.first
    end

    def self.find_or_create_by_name(name)
        if Song.find_by_name(name)
           Song.find_by_name(name)
        else Song.create(name)
        end
    end

    def self.new_from_filename(filename)
        name = filename.split(" - ")[1]
        new_artist = Artist.find_or_create_by_name(filename.split(" - ")[0])
        new_genre = Genre.find_or_create_by_name(filename.split(" - ")[2].sub(".mp3", ""))
        if self.find_by_name(name)
        else Song.new(name, new_artist, new_genre)
        end
    end

    def self.create_from_filename(filename)
        song = Song.new_from_filename(filename)
        song.save
    end
end