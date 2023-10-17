class EmployeesView < BaseView

  def display(employees)
    if employees.any?
      employees.each_with_index do |employee, index|
        puts "#{index + 1}.) #{employee.username}"
      end
    else
      puts 'No employees yet :('
    end
  end
end
