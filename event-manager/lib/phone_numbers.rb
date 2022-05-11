require 'csv'

def clean_phone_number(phone_number)
  phone_number = phone_number.tr('^0-9', '')
  return phone_number if phone_number.length === 10
  return '0000000000' if phone_number.length > 11 || phone_number.length < 10
  if phone_number.length == 11
    return phone_number[1..10] if phone_number[0] == 1
    return '0000000000'
  end
end

if File.exists? 'event_attendees.csv'
  puts 'Starting process...'

  rows =
    CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

  rows.each do |row|
    phone_number = clean_phone_number(row[:homephone])
    puts phone_number
  end

  puts
  puts 'Process finished'
end
