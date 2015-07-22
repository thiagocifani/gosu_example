class Player
  attr_reader :lives, :x, :y, :laser

  def initialize(window)
    @window    = window
    @image     = Gosu::Image.new(@window, "media/player.png", true)
    @x         = 0
    @y         = window.height - 80
    @explosion = Gosu::Image.new(@window, "media/explosion.png", true)
    @exploded  = false
    @lives     = 3
    @laser     = Laser.new(self, @window)
  end

  def draw
    if @exploded
      @explosion.draw(@x, @y, 4)
    else
      @image.draw(@x, @y, 1)
      @laser.draw
    end
  end

  def update
    if @window.button_down? Gosu::Button::KbLeft
      move_left
    end
    if @window.button_down? Gosu::Button::KbRight
      move_right
    end
    if @window.button_down? Gosu::Button::KbSpace
      @laser.shoot
    end
    @laser.update
  end

  def move_left
    @x -= 3
    if @x < 0
      @x = 0
    end
  end

  def move_right
    @x += 3
    if @x > @window.width-50
      @x = @window.width-50
    end
  end

  def hit_by?(bullets)
    @exploded = bullets.any? { |bullet| Gosu::distance(bullet.x, bullet.y, @x, @y) < 20 }

    if @exploded
      @lives -= 1
    end

    @exploded
  end

  def reset_position
    @x = rand(@window.width)
  end
end
