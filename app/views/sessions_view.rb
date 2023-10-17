class SessionsView
  def ask_for_username
    puts "username?"
    gets.chomp
  end

  def ask_for_password
    puts "password?"
    gets.chomp
  end

  def welcome(employee)
    puts "Welcome #{employee.username}!"
  end

  def wrong_credentials
    puts "Sorry wrong credentials"
  end
end
