require_relative '../models/order'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @orders
  end

  def create(order) # instance
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # before creating the instance, we have to convert any non-string data
      attributes[:id] = attributes[:id].to_i
      attributes[:delivered] = attributes[:delivered] == 'true'
      attributes[:meal_id] = attributes[:meal_id].to_i
      meal = @meal_repository.find(attributes[:meal_id])
      attributes[:meal] = meal

      attributes[:customer] = @customer_repository.find(attributes[:customer_id].to_i)
      attributes[:employee] = @employee_repository.find(attributes[:employee_id].to_i)

      order = Order.new(attributes)
      @orders << order
      @next_id = order.id + 1
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << Order.headers
      @orders.each do |order|
        csv << order.build_row
      end
    end
  end
end
