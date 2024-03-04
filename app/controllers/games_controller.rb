require "json"
require "open-uri"
class GamesController < ApplicationController

  def new
    @letters = ("a".."z").to_a.shuffle.first(10)
  end

  def score
    # on veut d'abord prendre les lettres et les separer
    letters = params[:letters].split
    # on elimime les espaces si il y en a
    given_word = params[:word].gsub(/\s+/, "")
    # transforme le mot du user en array
    word_letters = given_word.chars
    @included = word_letters.all? do |letter| # je verifie si chaque lettre repond a la condition dans le block
      letters.include?(letter) # est-ce que la lettre est inclue dans la grid de lettre
    end
    # si l'une des iteration renvoie false alors @included vaudra false
    # si toute les lettre sont bien inclues dans la grid (letters) alors @included vaudra true

    # faire un appel d'api (sparsing & storing data)
    url = "https://wagon-dictionary.herokuapp.com/#{given_word}"
    word_serialized = URI.open(url).read
    # production du hash dans l'api qui s'appelle word
    json = JSON.parse(word_serialized)
    @english_word = json["found"]
  end
end
