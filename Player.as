package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;
import net.flashpunk.utils.*;
import net.flashpunk.tweens.motion.*;

public class Player extends Movable {
[ Embed(source = 'media/burn.mp3') ] private const BURN:Class;
	public var burnSfx:Sfx = new Sfx(BURN);
[ Embed(source = 'media/background.mp3') ] private const BG:Class;
	public var bgSfx:Sfx = new Sfx(BG);

	public var shine:Number = 1;
	public var shineTween:CircularMotion;
	public var burner:Burner;
	public var burnPower:Number = 0.5;
	public var courage:int = 0;

	public function Player () {
		x = 240;
		y = 240;
		width = 20;
		height = 20;
		radius = 10;
		friction = 0.2;

		image = Image.createCircle(10, 0xFFFFFF);
		image.centerOrigin();
		centerOrigin();

		shineTween = new CircularMotion(null, Tween.LOOPING);
		shineTween.setMotion(0.5, 0, 0.5, 0, true, 100);
		addTween(shineTween);

		bgSfx.loop();
	}

	override public function update () : void {
		super.update();

		x = FP.clamp(Input.mouseX, 40+radius, 440-radius);
		y = FP.clamp(Input.mouseY, 40+radius, 440-radius);

		var fear:Number = 0;
		var moths:Array = [];
		world.getClass(Moth, moths);
		for each (var m:Moth in moths) {
			if (distance(m) <= 100) {
				fear += 1 - Math.floor(distance(m)/10)/10;
			}
		}
		fear = Math.min(fear, 5);

		var newshine:Number = FP.clamp(shine - (fear-0.5)/50, 0, 1);
		if (newshine > shine || courage <= 0)
			shine = newshine;
		bgSfx.volume = shine;

		if (shine == 0)
			FP.world = new Game();

		if (Input.pressed(Key.SPACE) || Input.mouseDown) {
			if (game.won)
				FP.world = new Game;
			else if (game.started)
				burn();
			else
				game.start();
		}

		if (burner)
			burner.update_real();

		courage--;
	}

	public function burn () : void {
		if (shine <= burnPower || burner)
			return;

		shine -= burnPower;
		burnSfx.play();
		courage = 15;
		burner = game.add(new Burner) as Burner;
	}

	override public function render () : void {
		super.render();

		var glowRadius:Number = (radius - 2)*shine;
		Draw.circlePlus(x, y, glowRadius, 0xFFFF00);
	}
}
}
