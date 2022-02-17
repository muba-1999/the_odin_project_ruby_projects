require 'yaml'
def random_word
  File.open('../google-10000-english-no-swears.txt', 'r') do |words|
    word = words.readlines.sample
    if word.length < 5 || word.length > 12 && word == nil
      word = words.readlines.sample
    end
    return word.strip
  end
end


# def hangman
# 	word = random_word.upcase
# 	puts word
# 	word_letter = word.split("")
# 	used_letters = []
# 	letters = Array.new(word.length, "-")

# 	puts "Enter a letter:"
# 	user_letter = gets.chomp.upcase

# 	while letters.join("") != word
		# if user_letter.length > 1 || user_letter == ""
		# 	puts "You have entered an invalid letter please enter a valid letter:"
		# 	user_letter = gets.chomp.upcase
		# elsif 
		# 	used_letters.include?(user_letter)
		# 	puts "you have already used this letter try againg:"
		# 	user_letter = gets.chomp.upcase
		# end
# 		for i in (0...word.length)
# 			if word_letter[i] == user_letter
# 				letters[i] = word_letter[i]
# 				used_letters << user_letter
# 			else
# 				used_letters << user_letter
# 			end
# 		end
# 		print "#{letters.join("")}\nyou have used: #{used_letters.uniq.join(" ")}\n"
# 		i += 1
# 		puts "enter a letter"
# 		user_letter = gets.chomp.upcase
# 	end
# end

p random_word