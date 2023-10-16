require 'csv'
require_relative 'base_repository'

class MealRepository < BaseRepository
  def build_element(attributes)
    attributes[:id] = attributes[:id].to_i
    attributes[:price] = attributes[:price].to_i
    Meal.new(attributes)
  end
end
