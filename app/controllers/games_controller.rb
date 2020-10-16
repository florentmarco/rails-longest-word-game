require 'open-uri'

class GamesController < ApplicationController

  # def new
  #     alphabet = ("a".."z").to_a
  #     random_alphabet = (1..10).map do |each|
  #     alphabet.sample
  #     end
  #     @letters = random_alphabet.join(" ")
  #   end

VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end


    def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
    end

    def included?(word, letters)
      word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
    end


    def english_word?(word)
      raw_answer = open("https://wagon-dictionary.herokuapp.com/#{word}")
      hash_answer =JSON.parse(raw_answer.read)
      hash_answer['found']
    end

end
