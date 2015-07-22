class Laser
  attr_reader :x, :y

  def initialize(player, window)
    @player   = player
    @window   = window
    @shooting = false
    @x        = @player.x
    @y        = @player.y
    @image    = Gosu::Image.new(@window, "media/laser.png", true)
  end

  def shoot
    @shooting = true
  end

  def update
    if @shooting
      @y -= 10
      if @y < 0
        @shooting = false
      end
    else
      @x = @player.x
      @y = @player.y
    end
  end

  def draw
    if @shooting
      @image.draw(@x, @y, 4)
    else
      @image.draw(@player.x, @player.y, 4)
    end
  end
end
