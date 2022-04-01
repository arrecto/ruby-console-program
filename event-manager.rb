def phone_number(number)
  if number.length == 11 && number[0]!=1
    number = number[1..]
    puts 'bad number'
  elsif number.length == 10
    puts 'good number'
  else
    puts 'bad number'
    number = nil
  number
end
