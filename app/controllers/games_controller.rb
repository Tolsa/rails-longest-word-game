require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @new_word = params['word']
    @letters = params[:letters].split("")
    word_array = @new_word.upcase.split("")
    array_test = []
    word_array.each do |letter|
      if @letters.include? letter
        array_test << letter
      end
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@new_word}"
    url_response = open(url).read
    url_parsing = JSON.parse(url_response)

    if array_test.length == word_array.length
      if url_parsing['found']
        @message = "Congratulations! #{@new_word} is a valid English word!!"
      else  @message = "SORRY! This word does not exist"
      end
    end
  end



end
