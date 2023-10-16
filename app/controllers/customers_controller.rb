require_relative '../views/customers_view'
require_relative '../models/customer'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  # user actions
  def add
    # have the view ask for name
    name = @customers_view.ask_for('name')
    # have the view ask for address
    address = @customers_view.ask_for('address')
    # create an instance with name/address
    customer = Customer.new(
      name: name,
      address: address
    )
    # give the instance to the repository
    @customer_repository.create(customer)
  end

  def list
    # get all the customers from the repo
    customers = @customer_repository.all
    # give the customers to the view for displays
    @customers_view.display(customers)
  end
end
