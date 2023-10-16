require_relative '../views/meals_view'
require_relative '../models/meal'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  # user actions
  def add
    # have the view ask for name
    name = @meals_view.ask_for('name')
    # have the view ask for price
    price = @meals_view.ask_for('price').to_i
    # create an instance with name/price
    meal = Meal.new(
      name: name,
      price: price
    )
    # give the instance to the repository
    @meal_repository.create(meal)
  end

  def list
    # get all the meals from the repo
    meals = @meal_repository.all
    # give the meals to the view for displays
    @meals_view.display(meals)
  end
end
