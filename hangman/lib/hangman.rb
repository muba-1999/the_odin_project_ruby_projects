require 'yaml'
class Hangman
  def initialize
    @word = random_word
    @word_letters = @word.split("")
    @used_letters = []
    @user_letter = Array.new(@word.length, '-')
    @tries = 12
  end

  def start
    puts "\t\t******************************************************************\n"
    puts "\t\tWelcome to the game of Hangman"
    puts "\t\tYou have 12 chances to guess the word"
    puts "\t\tAre you ready to play if your answer is yes"
    puts "\t\tPress 1 to start a new game or 2 to load a saved game"
    puts "\n\t\t******************************************************************"
    print "\t\tpress 1 or 2:> "
    input = gets.chomp
    if input == '1'
      game
    elsif input == '2'
      load_game
    end
  end

  def random_word
    File.open('google-10000-english-no-swears.txt', 'r') do |words|
      word = words.readlines.sample
      while word.nil? || word.length <= 5 || word.length >= 12
        word = words.readlines.sample
      end
      return word.strip.upcase
    end
  end

  def game
    guess = 0
    while @tries > 0
      print "Enter a letter or press 1 to save game:> "
      user_input = gets.chomp.upcase

      if user_input == '1'
        save
        break

      elsif user_input.length > 1 || user_input == ""
        puts "You have entered an invalid letter please enter a valid letter:"
      elsif 
        @used_letters.include?(user_input)
        puts "you have already used this letter try again:"
      else
        for i in (0...@word.length)
          if @word_letters[i] == user_input
            @user_letter[i] = @word_letters[i]
            @used_letters << user_input
            @used_letters = @used_letters.uniq
          else
            @used_letters << user_input
            @used_letters = @used_letters.uniq
          end 
        end
        guess += 1
        puts "============================================"
        print "\nused letters: #{@used_letters.join(" ")}\n\n#{@user_letter.join("")}\n\n"
        puts "============================================"
        if is_winner
          puts "\n\t\t*************************************\n\n"
          puts "\t\tCongratulatons you guessed the word"
          puts "\t\tyou guessed the word in #{guess} tries"
          puts "\n\t\t*************************************"
          break
        end
        @tries -= 1
        puts "\nyou have #{@tries} tries left\n\n"
        if @tries == 0
          puts "\n\t\t*************************************\n\n"
          puts "\t\tsorry you are out of tries better luck next time"
          puts "\t\tthe word was #{@word}"
          puts "\n\t\t*************************************"
        end
      end
    end
  end

  def is_winner
    if @word == @user_letter.join("")
      return true
    end
    return false
  end

  def save
    puts "\nsaving----------"
    File.open('save.txt', 'w') do |file|
      file.write(self.to_yaml)
    end
    puts "Saved\n"
  end

  def load_game
    puts "\nloading saved game--------\n"
    puts "You have #{@tries} tries remaining"
    game_file = File.open('save.txt', 'r') {|file| file.read}
    _game = YAML.load(game_file)
    _game.game
  end
end

g = Hangman.new
g.start

