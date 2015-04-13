require_relative 'reverse_letters'

def find_anagram(word)
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
