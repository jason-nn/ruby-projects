puts 'Event Manager initialized!'
puts

if File.exists? 'event_attendees.csv'
  file = File.open 'event_attendees.csv'

  while !file.eof?
    line = file.readline
    name = line.split(',')[2]
    puts name
  end
end
