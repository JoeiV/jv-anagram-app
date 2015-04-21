class Word
 
    def self.reverse_letters(letters)
        length = letters.length
        reversed_letters = Array.new(length)

        letters.each_with_index do |letter, index|
            reversed_letters[length - index - 1] = letter
        end
    
        reversed_letters
    end

    def self.find_anagram(word)
        #takes a string & returns an array of strings
        letters = word.split(//)

        anagrams = []

        letters.each do |letter|
            remaining = letters.select {|l| l !=letter}

            anagrams << letter + remaining.join('')
            anagrams << letter + reverse_letters(remaining).join('')
        end

        anagrams.permutation(&:join)
    end

    
end