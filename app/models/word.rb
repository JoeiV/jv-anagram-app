class Word < ActiveRecord::Base
    
    def add_letters
        characters = self.text.chars
        alphabetized_characters = characters.sort
        self.letters = alphabetized_characters.join
    end
    
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
        combinations.permutation.map(&:join)
        
        Word.where("text in (?)", combinations)
    end 
    
    def three_letters?(input)
        if input.length = 3
            true
        else
            false
        end
    end
    
    def distinct_letters?(input)
        letter_array = input.chars
        unique_letters = letter_array.uniq 
        if unique_letters.length < letter_array.length
            false
        else
            true
        end
    end
 
    def valid_input(input)
        if input.length > 3 && distinct_letters = true
         raise Exception.new("Word must be less than or equal to 3 characters.")
      end
    end

end