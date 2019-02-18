class GamesController < ApplicationController
  def new
    @letters =(0...10).map { (65 + rand(26)).chr }
  end

  def score
    require "open-uri"
    url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
    @flats = JSON.parse(open(url).read)
    @testy = params[:answer]

    def included?(guess, grid)
      guess.chars.all? { |letter| guess.split.count(letter) <= grid.count(letter) }
    end

    if included?(@testy.upcase, @letters)
      if @flats['found'] == true
        @answer = "Good Job !"
      else
        @answer = "This is not a valid English word !"
      end
    else
      @answer = "Can't build from given letters"
    end
  end
end
