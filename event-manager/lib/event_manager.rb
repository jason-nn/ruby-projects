require 'csv'

def clean_zipcode(zipcode)
  return '00000' if zipcode.nil?
  return zipcode[0..4] if zipcode.length > 5
  return zipcode.rjust(5, '0') if zipcode.length < 5
  return zipcode
end

puts 'Event Manager initialized'

if File.exists? 'event_attendees.csv'
  rows =
    CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

  rows.each do |row|
    first_name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])

    puts "#{first_name} #{zipcode}"
  end
end
