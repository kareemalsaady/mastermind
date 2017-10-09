class Code
  attr_reader :code
  def initialize(code)
    @code = code
  end
end

class Guess
  attr_accessor :guess
  def initialize(guess)
    @guess = guess
  end
end

class Mastermind
  @@possible_numbers = [1,2,3,4,5,6]
  def initialize
    propmt_user
  end

  def propmt_user
    selection = ""
    puts "Do you want to generate the code? (Y/N)"
    until selection == "Y" || selection == "N" do
      puts "Please enter (Y)es or (N)o"
      selection = gets.chomp.upcase.to_s
    end
    if selection == "Y"
      user_generate_code
      ai_solve
    elsif selection == "N"
      generate_code
      play_mastermind
    end
  end

  def ai_solve
    turns = 12
    while turns > 0
      p "Computer has #{turns} guesses remaining!"
      turns -= 1
      ai_guess
    end
    if turns == 0
      p "Computer has lost, the code was #{$code.code}"
    end
  end

  def ai_guess
    computer_guess = []
    4.times {computer_guess << @@possible_numbers[rand(0..5)]}
    p computer_guess
    check_computer_win(computer_guess)
  end


  def generate_code
    generated_code = []
    4.times {generated_code << @@possible_numbers[rand(0..5)]}
    $code = Code.new(generated_code)
    p $code.code
    puts ""
  end

  def user_generate_code
    generated_code = []
    until (1111..6666).include?(generated_code) do
      puts "Enter your 4 digit code"
      generated_code = gets.chomp.to_i
    end
    generated_code = generated_code.to_s.chars.map(&:to_i)
    $code = Code.new(generated_code)
    p $code.code
  end

  def player_guess
    guessed_code = []
    guessed_numbers = ""
    until (1111..6666).include?(guessed_numbers) do
      puts "Enter your 4 digit guess, between 1111 and 6666"
      guessed_numbers = gets.chomp.to_i
    end
    guessed_code = guessed_numbers.to_s.chars.map(&:to_i)
    new_guess = Guess.new(guessed_code)
    check_win(new_guess.guess)
  end

  def check_win(guess)
    if guess == $code.code
      p guess
      p $code.code
      abort("You win!")
    else
      give_feedback(guess)
    end
  end

  def check_computer_win(guess)
    if guess == $code.code
      p guess
      p $code.code
      abort("You win!")
    else
      give_feedback(guess)
    end
  end

  def give_feedback(guess)
    answer = $code.code
    visited = []
    correct_value = 0
    correct_position = 0
    guess.each_with_index do |n,i|
      if n == answer[i]
        correct_position += 1
        visited << n
      end
    end
    guess.each_with_index do |n|
      if (answer-visited).include?(n)
        correct_value += 1
      end
    end
    puts "Number of the correct values in the correct position = #{correct_position}"
    puts "Number of correct values in the wrong position = #{correct_value}"
    puts ""
  end

  def play_mastermind
    turns = 12
    while turns > 0
      p "Take a guess, you have #{turns} guesses remaining!"
      player_guess
      turns -= 1
    end
    if turns == 0
      p "You lost, the code was #{$code.code}"
    end
  end


end

def new_game
  Mastermind.new
end

new_game

#guesses = []
#puts "enter slot 1"
#guesses[0] = gets.chomp.to_s
#puts "enter slot 2"
#guesses[1] = gets.chomp.to_s
#puts "enter slot 3"
#guesses[2] = gets.chomp.to_s
#puts "enter slot 4"
#guesses[3] = gets.chomp.to_s
#guess = Guess.new(guesses)
#p guess
