require "open-uri"

class GamesController < ApplicationController
  before_action :set_word,  only: :score
  def new
    @letters = ("a".."z").to_a .sample(10)
  end

  def score
    @letters = params[:letters].chars
    word = params[:word]
  unless @valid["found"]
    @result = "Sorry but #{word} does not seem to be a valid English word"
    return
  end

  unless word.chars.all? { |char| word.count(char) <= @letters.count(char) }
    @result = "Sorry but #{word} can't be built out of #{@letters}"
    return
  end

  @result = "Congratulations! #{word} is a valid English word!"
  end

  def set_word
    word = params[:word]
    word_url = "https://dictionary.lewagon.com/#{word}"
    @valid = JSON.parse(URI.parse(word_url).read)
  end
end
