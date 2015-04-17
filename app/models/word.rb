#require 'open-uri'

class Word < ActiveRecord::Base
    
    def self.reverse_letters(letters)
        length = letters.length
        reversed_letters = Array.new(length)

        letters.each_with_index do |letter, index|
            reversed_letters[length - index - 1] = letter
        end
    
        reversed_letters
    end
    
    def self.find_anagram(word)
        
        combinations = []
        
        letters = word.split(//)

        
        letters.each do |letter|
        remaining = letters.select {|l| l !=letter}
            
        combinations << letter + remaining.join('')
        combinations << letter + reverse_letters(remaining).join('')
            
        end
        combinations.permutation(&:join).map
        
        Word.where("text in (?)", combinations)
    end 
                

end