package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;

public class Movable extends Entity {
        public var vel:vec = new vec(0,0);
	public var friction:Number = 0;
	public var bouncing : Object = new Object();
	public var radius : Number = 0;
	public var solidType : Object;

        public function Movable() {
		bouncing['x-'] = false;
                bouncing['x+'] = false;
                bouncing['y-'] = false;
                bouncing['y+'] = false;
        }

        public function accel(x2:Number, y2:Number) : void {
                vel.x += x2;
                vel.y += y2;
        }

        public function applyFriction() : void {
                accel(-vel.x*friction, -vel.y*friction);
        }

        public function move() : void {
		applyFriction();
		moveBy(vel.x, vel.y, solidType);
        }

        override public function update() : void {
                move();
		super.update();
        }

	public function maybeBounce (e:String, min:Number, max:Number,
	                             restitution:Number)
	: void {
                var dir:String = '';

                if (pos[e] - radius < min) {
                        vel[e] = Math.abs(vel[e]);
                        dir = '+';
                }
                else if (pos[e] + radius > max) {
                        vel[e] = -Math.abs(vel[e]);
                        dir = '-';
                }

                if (dir) {
			if (!bouncing[e + dir]) {
				bouncing[e + dir] = true;
				vel[e] *= restitution;
			}
                }
                else {
                        bouncing[e + '+'] = false;
                        bouncing[e + '-'] = false;
                }
        }

	override public function moveCollideX (e:Entity) : Boolean {
		vel.x = 0;
		return true;
	}

	override public function moveCollideY (e:Entity) : Boolean {
		vel.y = 0;
		return true;
	}

	public function distance (e:Entity) : Number {
		return pos.sub(new vec(e.x, e.y)).length;
	}

	public function get game () : Game {
		return world as Game;
	}

	internal var _pos:vec = new vec(0, 0);
	public function get pos () : vec {
		_pos.set(x, y);
		return _pos;
	}
	public function set pos (v:vec) : void {
		_pos = v;
		x = v.x;
		y = v.y;
	}

        public function get image() : Image {
                return _image;
        }
        public function set image(i:Image) : void {
                _image = i;
                graphic = i;
        }
        internal var _image:Image;
}
}
