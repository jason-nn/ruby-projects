continue = true
all_sales = []

while continue
  print 'Enter sales amount: '
  sales = gets.chomp

  if sales.split('').last == 'k'
    sales = sales.split('k').first.to_f * 1000
  else
    sales = sales.to_f
  end

  if sales == 0
    continue = false
  else
    all_sales << sales
  end
end

p all_sales
puts "Count: #{all_sales.length}"
puts "Total: #{all_sales.sum}"
