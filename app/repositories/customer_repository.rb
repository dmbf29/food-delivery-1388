class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @customers
  end

  def create(customer) # instance
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  def find(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # before creating the instance, we have to convert any non-string data
      attributes[:id] = attributes[:id].to_i
      customer = Customer.new(attributes)
      @customers << customer
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << Customer.headers
      @customers.each do |customer|
        csv << customer.build_row
      end
    end
  end
end
