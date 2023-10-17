require 'csv'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def create(meal) # instance
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  def find(id)
    @meals.find do |meal|
      meal.id == id
    end
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # before creating the instance, we have to convert any non-string data
      attributes[:id] = attributes[:id].to_i
      attributes[:price] = attributes[:price].to_i
      meal = Meal.new(attributes)
      @meals << meal
      @next_id = meal.id + 1
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << Meal.headers
      @meals.each do |meal|
        csv << meal.build_row
      end
    end
  end
end
