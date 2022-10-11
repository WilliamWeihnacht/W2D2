class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word()
    DICTIONARY.sample
  end

  def initialize()
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length) {|i| "_"}
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    return true if @attempted_chars.include?(char)
    false
  end

  def get_matching_indices(char)
    arr = []
    @secret_word.each_char.with_index do |x,i|
      if x == char
        arr<<i
      end
    end
    arr
  end

  def fill_indices(char,arr)
    arr.each do |x|
      @guess_word[x] = char
    end
  end

  def try_guess(char)
    if already_attempted?(char)
      puts 'that has already been attempted'
      return false
    else
      @attempted_chars<<char
      if get_matching_indices(char).empty?
        @remaining_incorrect_guesses -= 1
      else
        fill_indices(char,get_matching_indices(char))
      end
      return true
    end
  end

  def ask_user_for_guess
    puts "Enter a char:"
    input = gets.chomp
    return try_guess(input)
  end

  def win?
    if @guess_word.join == @secret_word
      puts "WIN"
      return true
    end
    return false
  end

  def lose?
    if @remaining_incorrect_guesses <= 0
      puts "LOSE"
      return true
    end
    return false
  end

  def game_over?
    if lose? || win?
      puts @secret_word
      return true
    end
    return false
  end

end
