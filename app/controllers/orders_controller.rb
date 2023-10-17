require_relative '../views/orders_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  # user actions

  def list_undelivered_orders
    # orders = get all undelivered orders from the order repository
    orders = @order_repository.undelivered_orders
    # give the orders to the view
    @orders_view.display(orders)
  end

  def list_my_undelivered_orders(employee)
    # orders = get my undelivered orders from the order repository
    orders = @order_repository.my_undelivered_orders(employee)
    # give the orders to the view
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.my_undelivered_orders(employee)
    @orders_view.display(orders)
    # order_index = ask user to choose which order number has been delivered
    order_index = @orders_view.ask_for('number').to_i - 1
    # order = get the instance from the order_index
    order = orders[order_index]
    # deliver the order
    # this order gets saved in the CSV
    @order_repository.mark_as_delivered(order)
  end

  def add
    # get all the meals from the meal repository
    # have the meals view display all the meals
    # have the view ask the user for the number (index)
    # use the index to get the instance of the meal
    meals = @meal_repository.all
    @meals_view.display(meals)
    meal_index = @meals_view.ask_for('number').to_i - 1
    meal = meals[meal_index]

    # get all the customers from the customer repository
    # have the customers view display all the customers
    # have the view ask the user for the number (index)
    # use the index to get the instance of the customer
    customers = @customer_repository.all
    @customers_view.display(customers)
    customer_index = @customers_view.ask_for('number').to_i - 1
    customer = customers[customer_index]

    # get all the riders from the employee repository
    # have the employees view display the riders
    # have the view ask the user for the number (index)
    # use the index to get the instance of the employee
    employees = @employee_repository.all_riders
    @employees_view.display(employees)
    employee_index = @employees_view.ask_for('number').to_i - 1
    employee = employees[employee_index]

    # create an instance of an order
    order = Order.new(
      meal: meal,
      customer: customer,
      employee: employee
    )
    # give it to the order repository
    @order_repository.create(order)
  end
end
