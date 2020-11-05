class Artist
    attr_accessor :name 
    attr_reader :songs
    @@all = []
    extend Concerns::Findable
    def initialize(name)
        @name = name
        @songs = []
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
        artist = Artist.new(name)
        artist.save
        artist
    end

    def songs 
        @songs
    end

    def add_song(song)
        song.artist = self if song.artist == nil
        if self.songs.include?(song) 
            nil
        else @songs << song
        end
    end

    def genres
        songs.map{|song|song.genre}.uniq
    end
   
end
