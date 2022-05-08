file = File.open('input-output/text.txt', 'w') # will clear existing text if any

file.puts 'New line with break at end'

file.close

# ----------------------------------------

file = File.open('input-output/text.txt', 'a') # will not clear existing text

file.write('Will not add a break at end ')

file.write('Will not add a break at end ')

file.close

# ----------------------------------------

file = File.open('input-output/text.txt', 'r')

puts file.read

file.close

# ----------------------------------------

file = File.open('input-output/text.txt', 'r')

file.readlines.each.with_index { |line, index| puts "#{index} #{line}" }

file.close

# ----------------------------------------

file = File.open('input-output/text.txt', 'r')

while !file.eof?
  line = file.readline
  puts line
end

file.close

# ----------------------------------------

if File.exists? 'input-output/text.txt'
  puts 'File exists'
else
  puts 'File does not exist'
end

# ----------------------------------------

dirname = 'input-output/data'

Dir.mkdir(dirname) unless File.exists? dirname

file = File.open("#{dirname}/data.txt", 'w')

file.puts 'Sample data'

file.close

# ----------------------------------------

puts Dir.glob('wordle/*')

puts Dir.glob('wordle/*').length
