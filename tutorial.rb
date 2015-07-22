require 'gosu'
require_relative "./backdrop"
require_relative "./player"

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Gosu Tutorial Game"

    @backdrop = Backdrop.new(self, "background.jpg")
    @player   = Player.new
    @beep     = Gosu::Sample.new("media/teste.mp3")
    @font     = Gosu::Font.new(20)
  end

  def update
    if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
      @player.left
    end
    if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
      @player.right
    end
  end

  def draw
    @backdrop.draw
    @player.draw
    @beep.play
    @font.draw("STREET FIGHTER", 10, 10, 3, 1.0, 1.0, 0xff_ffff00)
  end
end

window = GameWindow.new
window.show
