require 'json'
require 'open-uri'

class PagesController < ApplicationController
  def new
    @letters_shuffled = ('a'..'z').to_a.shuffle[0..12].join('')
  end

  def score
    # raise
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    response_serialized = open(url).read
    response = JSON.parse(response_serialized)

    if response['found'] == false
      @result = 'Loose!'
      @score = 'Your word is not in english dictionnary'
    elsif all_letters_included?(params[:word], params[:letters]) == false
      @result = 'Loose!'
      @score = "Cannot make #{params[:word]} out of #{params[:letters]}"
    else
      @result = 'Won!'
      @score = response['length']
    end
  end

  private

  def all_letters_included?(word, list)
    word.split('').each do |letter|
      list.include?(letter)
    end
    # prendre la liste, la transformer en array
    # pour chaque lettre de word, faire un include? sur l'array
    # si chacune des lettres du mot est inclue alors => true
    #  else => false
  end
end
