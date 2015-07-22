require 'gosu'
require_relative "./bullet"
require_relative "./player"
require_relative "./laser"
require_relative "./timer"

class GameWindow < Gosu::Window
  attr_accessor :score
  def initialize
    super(600, 400, false)

    @background    = Gosu::Image.new(self, "media/starry-night.png", true)
    @player        = Player.new(self)
    @bullets       = 10.times.map { Bullet.new(self) }
    @running       = true
    @font          = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @game_over     = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @score_font   = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @timer         = Timer.new(self, @bullets)
    @score        = 0
    @game_over_now = false
  end

  def update
    if @running
      if @player.hit_by? live_bullets
        @running = false
      else
        run_game
      end
    end

    if @running == false and button_down? Gosu::Button::KbR and @player.lives > 0
      @running = true
      @player.reset_position
    end

    if @player.lives == 0
      @game_over_now = true
    end
  end

  def run_game
    live_bullets.each { |bullet| bullet.update(@player.laser) }
    @player.update
    @timer.update
  end

  def live_bullets
    @bullets.select { |bullet| bullet.alive == true }
  end

  def draw
    @background.draw(0,0,1)
    @player.draw
    live_bullets.each { |bullet| bullet.draw}
    @font.draw("Lives: #{@player.lives}", 10, 10, 3.0, 1.0, 1.0, 0xffffffff)
    @score_font.draw("Score: #{@score}",  100, 10, 3.0, 1.0, 1.0, 0xffffffff)

    if @game_over_now
      @game_over.draw("GAME OVER", (self.width/2)-50, self.height/2, 3.0, 1.0, 1.0, 0xffffffff)
    end

  end
end

window = GameWindow.new
window.show
