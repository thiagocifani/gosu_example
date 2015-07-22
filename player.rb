class Player
  def initialize
    @animation = [Gosu::Image.new("media/ryu/idle-1.gif"),
                  Gosu::Image.new("media/ryu/idle-2.gif"),
                  Gosu::Image.new("media/ryu/idle-3.gif")]

    @image = Gosu::Image.new("media/ryu/idle-1.gif")
    @x = 400.0
    @y = 150.0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def left
    @x -= 3.0
  end

  def right
    @x += 3.0
  end

  def draw
    img = @animation[Gosu::milliseconds / 100 % @animation.size];
    img.draw(@x, @y,0, 3, 3)
  end
end
