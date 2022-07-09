continue = true
expenses = []

while continue
  print 'Enter expense amount: '
  expense = gets.chomp.to_f

  if expense == 0
    continue = false
  else
    expenses << expense
  end
end

p expenses
puts "Count: #{expenses.length}"
puts "Total: #{expenses.sum}"
