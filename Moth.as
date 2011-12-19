package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;

public class Moth extends Movable {
	public function Moth (_x:Number, _y:Number) {
		x = _x;
		y = _y;

		friction = 0.1;

		image = Image.createCircle(7, 0x8b400f);
		image.centerOrigin();
		centerOrigin();
	}

	override public function update () : void {
		var dir:Number = FP.random * 2 * Math.PI;
		var r:vec = vec.polar(2, dir);
		var p:Player = game.player;
		var attract:Number = p.shine + (p.burner?p.burner.radius/30:0);
		var o:vec = p.pos.sub(pos).normalize(attract*2);
		var a:vec = r.add(o);
		accel(a.x, a.y);

		super.update();
	}
}
}
