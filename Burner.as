package {
import net.flashpunk.*;
import net.flashpunk.utils.*;
import net.flashpunk.graphics.*;

public class Burner extends Movable {
[ Embed(source = 'media/killmoth.mp3') ] public static var KM:Class;
	public static var kmSfx:Sfx = new Sfx(KM);

	public var alpha:Number = 1;
	public var kills:Array = [];

	public function Burner () {
		radius = (FP.world as Game).player.radius;
		centerOrigin();
		layer = 1;
		FP.tween(this, {radius: 75, alpha: 0.3}, 5,
		         { complete: this.done });
	}

	// We need to update after the player, so make the player do it. We may
	// not yet have been added to the world, but that doesn't seem to
	// matter.
	override public function update () : void {}

	public function update_real () : void {
		super.update();

		var p:Player = (FP.world as Game).player;
		x = p.x;
		y = p.y;

		var moths:Array = [];
		FP.world.getClass(Moth, moths);

		for each (var m:Moth in moths) {
			if (distance(m) < radius + m.radius) {
				kills.push(m.pos);
				FP.world.remove(m);
				kmSfx.play();
			}
		}
	}

	override public function render () : void {
		Draw.circlePlus(x, y, radius, 0xFFFF00, alpha, true);
	}

	public function done () : void {
		var score:String = (kills.length*10).toString();
		game.score += kills.length * kills.length * 10;
		for (var i:int = 0; i < kills.length; i++) {
			var p:vec = kills[i];
			var t:TextParticle = new TextParticle(p.x, p.y, score);
			for (var j:int = 0; j < i; j++) {
				t.update(); t.update();
			}
			world.add(t);
		}
		game.maybeNextWave();
		game.player.burner = null;
		world.remove(this);
	}
}
}
