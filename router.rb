class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running    = true
  end

  def run
    puts "Welcome to the Food Delivery!"
    puts "           --           "

    while @running
      @employee = @sessions_controller.login
      # while they're logged in
      while @employee
        if @employee.manager?
          display_manager_tasks
          action = gets.chomp.to_i
          print `clear`
          route_manager_action(action)
        else
          display_rider_tasks
          action = gets.chomp.to_i
          print `clear`
          route_rider_action(action)
        end
      end
    end
  end

  private

  def route_manager_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 9 then stop
    when 0 then logout
    else
      puts "Please press 1 ... 9"
    end
  end

  def route_rider_action(action)
    case action
    when 9 then stop
    when 0 then logout
    else
      puts "Please press 1 ... 9"
    end
  end

  def logout
    @employee = false
  end

  def stop
    logout
    @running = false
  end

  def display_manager_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all meals"
    puts "2 - Add a new meal"
    puts "3 - List all customers"
    puts "4 - Add a new customer"
    puts "9 - Stop and exit the program"
    puts "0 - Log out"
  end

  def display_rider_tasks
    puts ""
    puts "What do you want to do next?"
    puts "9 - Stop and exit the program"
    puts "0 - Log out"
  end
end
