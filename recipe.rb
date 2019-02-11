# Model
class Recipe
  attr_reader :name, :blurb, :gravity, :preptime
  def initialize(name, blurb, gravity = nil, preptime = nil, done = false)
    @name = name
    @blurb = blurb
    @gravity = gravity
    @preptime = preptime
    @done = done
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
