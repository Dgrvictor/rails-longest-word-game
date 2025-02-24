require "json"
require "open-uri"

class GamesController < ApplicationController

  def new()
    @letters = []
    10.times {
      @letters << ('a'..'z').to_a.sample
    }
  end

  def score()

    #--------------- WORD IS ENGLISH ??
    url = "https://dictionary.lewagon.com/#{params["user-input"]}"
    word_serialized = URI.parse(url).read
    word = JSON.parse(word_serialized)
    word["found"]


    #--------------- WORD IS in grid ??
    @attempt = params["user-input"]
    @grid = params["grid"].chars

    # verifie si mon input contient bien les lettres de la grille
    letter_in_grid = @attempt.chars.all?{|element| @grid.include?(element)}
    # verifier si mon input contient bien le nombre de lettre maximum contenu dans la grille
    in_grid = @attempt.chars.all? {|element| @attempt.count(element) <= @grid.join.count(element)}

    if letter_in_grid == false
      @result = "Sorry but #{@attempt.upcase} can't built out of #{@grid.join(' ,').upcase}"
    elsif in_grid && word["found"]
      @result = "Congratulations! #{@attempt.upcase} is a valid English Word!"
    else
      @result = "Sorry but #{@attempt.upcase} does not seem to be a valid English word..."
    end
  end
end
