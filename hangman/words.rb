module Words
  def random_word
    words = []

    file = File.open('words.txt')

    while !file.eof?
      word = file.readline[0..-2]
      words << word if word.length > 4 && word.length < 13
    end

    file.close

    return words[rand(words.length)]
  end
end
