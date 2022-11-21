class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses 
  attr_accessor :word_with_guesses

  def initialize(word)
    @word = word
    @guesses =''
    @wrong_guesses = ''
    @word_with_guesses = '-' * @word.size()
  end

  def check_win_or_lose()
    if @word_with_guesses == @word
      return :win  
    elsif @wrong_guesses.size() >= 7
      return :lose  
    else
      return :play
    end  
  end  

  def guess(letter)
    validate(letter)
    if !correctLetter(letter)
      wrongLetter(letter)
      return false
    end 
    display()
    return true
  end  

  def correctLetter(letter)
    n = 0
    while n < word.size
      if letter.downcase == @word[n].downcase 
        if usedLetter(letter)
         @guesses +=letter.downcase
         return true
        end 
      end
      n += 1
    end  
    return false
  end

  def usedLetter(letter)
    x = 0
    while x <@guesses.size
      if letter.downcase == @guesses[x].downcase
        return false
      end
     x += 1 
    end 
    y = 0
    while y < @wrong_guesses.size
      if letter.downcase == @wrong_guesses[y].downcase
        return false
      end
     y +=1 
    end 
    return true;
  end

  def wrongLetter(letter)
    a = 0
    while a < @wrong_guesses.size
      if letter.downcase == @wrong_guesses[a].downcase
        return false
      end
     a += 1 
    end 
   @wrong_guesses+=letter.downcase  
  return true    
  end  

  def validate(letter)
    if letter.nil?
      raise ArgumentError.new("Please enter a letter")
    end  
    unless letter.match?(/[[:alpha:]]/)
      raise ArgumentError.new("Please enter a letter")
    end
    
  end 
  
  def validateLetter(letter)
 
    unless letter.match?(/[[:alpha:]]/)
      return false
    end
    return true
  end 

  def display()
    t = 0
    result = ""
    while t < @word.size()
      u = 0
      while u < @guesses.size()
         if @guesses[u] == @word[t]
           result += @word[t]
         end 
       u += 1
      end
     if result.size() <= t
        result+="-"
     end  
     t += 1 
    end 
    @word_with_guesses=result
  end  
  
  def  differentLetters(game, manyLetters)
    @word = word
    @guesses = guesses
    @wrong_guesses = wrong_guesses
    @word_with_guesses = '-' * @word.size()
    x = 0
    
    while x < manyLetters.size
       guess(manyLetters[x])
       x += 1
    end
    display()
    
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


