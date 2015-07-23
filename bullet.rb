class Bullet
  attr_reader :x, :y, :alive

  def initialize(window)
    @window = window
    @image  = Gosu::Image.new(@window, "media/bullet.png", true)
    @y      = -rand(1000)
    @x      = rand(@window.width)
    @alive  = true
  end

  def update(laser)
    @y = @y + 5
    if @y > @window.width
      @y = 0
      @x = rand(@window.width)
    end

    hit_by?(laser)
  end

  def draw
    @image.draw(@x, @y, 3)
  end

  def hit_by?(laser)
    if Gosu::distance(laser.x, laser.y, @x, @y) < 10
      @window.score += 1
      @alive = false
    end
  end
end
