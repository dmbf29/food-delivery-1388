class Order
  attr_reader :meal, :customer, :employee
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # instance
    @customer = attributes[:customer] # instance
    @employee = attributes[:employee] # instance
    @delivered = attributes[:delivered] || false # boolean
  end

  def delivered?
    @delivered
  end

  # order.deliver!
  def deliver!
    @delivered = true
  end

  def build_row
    [@id, @meal.id, @customer.id, @employee.id, @delivered]
  end

  def self.headers
    ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
  end
end
