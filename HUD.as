package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;

public class HUD extends Movable {
	public var shineWidth:Number = 100;
	public var scoreText:Text;
	public function HUD () {
		layer = 1;
	}

	override public function update () : void {
		var text:String = game.score + "/" + game.highScore;
		scoreText = new Text(text, 200, 10);
		graphic = scoreText;
	}

	override public function render () : void {
		super.render();

		Draw.rectPlus(40, 40, 400, 400, 0x000000, 1, true, 0, 20);

		shineWidth = FP.approach(shineWidth, game.player.shine*100, 5);

		Draw.rectPlus(40, 10, shineWidth, 20, 0xFFFF00);
		var blX:Number = 40 + game.player.burnPower * 100;
		Draw.line(blX, 10, blX, 30, 0xFF00000);
	}
}
}
