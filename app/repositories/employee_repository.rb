require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv if File.exist?(@csv_file_path)
  end

  def find_by_username(username)
    @employees.find do |employee|
      employee.username == username
    end
  end

  def find(id)
    @employees.find do |employee|
      employee.id == id
    end
  end

  def all_riders
    @employees.select do |employee|
      employee.rider?
    end
  end


  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # before creating the instance, we have to convert any non-string data
      attributes[:id] = attributes[:id].to_i
      employee = Employee.new(attributes)
      @employees << employee
    end
  end
end
