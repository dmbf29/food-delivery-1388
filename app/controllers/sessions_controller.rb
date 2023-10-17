require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  # user actions
  def login
    # ask user for username
    username = @sessions_view.ask_for_username
    # ask user for password
    password = @sessions_view.ask_for_password
    # employee = ask employee repository for a user with the username
    employee = @employee_repository.find_by_username(username)
    # check if the password of the user matches with the one given
    # if employee&.password == password
    if employee && employee.password == password
      @sessions_view.welcome(employee)
      return employee
    else
      @sessions_view.wrong_credentials
      login
    end
  end
end
