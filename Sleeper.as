package {
import net.flashpunk.graphics.*;

public class Sleeper extends Movable {
	public function Sleeper(_x:Number, _y:Number) {
		x = _x;
		y = _y;
		image = Image.createCircle(7, 0x8b400f);
		image.centerOrigin();
		centerOrigin();
	}

	public function wake () : void {
		game.remove(this);
		game.add(new Moth(x, y));
	}
}
}
