class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word) #constructor
    @word = word
    @wordArr = @word.split('')
    @guesses = ''
    @wrong_guesses = ''
  end

  def word #get word
    return @word
  end

  def guesses #get guesses
    return @guesses
  end

  def wrong_guesses #get wrong guesses
    return @wrong_guesses
  end

  def guess g #make a guess with a character g
    raise ArgumentError if g == nil
    raise ArgumentError if g.empty? #if g is empty string, throw argument error
    raise ArgumentError if (g.ord < 65 or g.ord > 90) and (g.ord < 97 or g.ord > 122) #if g is not an ascii letter (A-Z, a-z), throw argument error
    #if guess character is already in the guesses or wrong guesses string, do not add character to anything
    #downcase g for case insensitivity
    if @guesses.include? g.downcase or @wrong_guesses.include? g.downcase 
      return false
    elsif @word.include? g #if guess character is in the word, add to guesses
      @guesses += g
    else
      @wrong_guesses += g #if guess character is not in the word, add to wrong guesses
    end
  end

  def word_with_guesses #display word as the user sees it, with blanks in spots that have not been guessed
    @wordCensored = ""
    @guessesArr = @guesses.split('')
    @charAdded = false
    for i in @wordArr do
      for j in @guessesArr do
        if i == j
          @charAdded = true
          @wordCensored += i
          break
        end
      end
      if @charAdded == false
        @wordCensored += "-"
      end
      @charAdded = false
    end
    return @wordCensored
  end

  def check_win_or_lose
    @finalGuessWord = word_with_guesses
    if @finalGuessWord == @word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end

# @game = WordGuesserGame.new('foobar')
# @game.guess('a')
# @game.guess('z')
# @game.guess('x')
# @game.guess('o')
# puts @game.word_with_guesses