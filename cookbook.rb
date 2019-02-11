require_relative 'recipe'
require 'csv'
# Repo
class Cookbook
  def initialize(csv_path)
    @recipes = []
    @csv_path = csv_path
    csv_load
  end

  def all
    @recipes
  end

  def add(recipe)
    @recipes << recipe
    csv_write
  end

  def remove(index)
    @recipes.delete_at(index)
    csv_write
  end

  def mark(index)
    @recipes[index].mark_as_done!
    csv_write
  end

  private

  def csv_load
    CSV.foreach(@csv_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4] == 'true')
    end
  end

  def csv_write
    CSV.open(@csv_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [
          recipe.name, recipe.blurb,
          recipe.gravity,
          recipe.preptime,
          recipe.done?
        ]
      end
    end
  end
end
