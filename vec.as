package {

public class vec {
	public var x:Number = 0;
	public var y:Number = 0;

	public function vec(_x:Number, _y:Number) {
		x = _x;
		y = _y;
	}

	public static function polar (r:Number, theta:Number) : vec {
		return new vec(r * Math.cos(theta), r * Math.sin(theta));
	}

	public function set (_x:Number, _y:Number) : void {
		x = _x;
		y = _y;
	}

	public function get length() : Number {
		return Math.sqrt(x*x + y*y);
	}

	public function eq (v:vec) : Boolean {
		return x == v.x && y == v.y;
	}

	public function add(v:vec):vec {
		return new vec(x + v.x, y + v.y);
	}
	public function setadd(v:vec):vec {
		x += v.x; y += v.y;
		return this;
	}

	public function sub(v:vec):vec {
		return new vec(x - v.x, y - v.y);
	}

	public function mul(n:Number):vec {
		return new vec(x * n, y * n);
	}
	public function setmul(n:Number):vec {
		x *= n; y *= n;
		return this;
	}

	public function normalize(newlength:Number = 1) : vec {
		var l:Number = length;

		if (l == 0)
			return new vec(0,0);
		else
			return new vec(newlength * x/l, newlength * y/l);
	}

	public function setNormalize() : vec {
		var l:Number = length;
		
		if (l == 0)
		{
			x = 0;
			y = 0;
		}
		else
		{
			x = x/l;
			y = y/l;
		}
		
		return this;
	}

	// Returns a vector perpendicular to this one, with an anticlockwise
	// twist.
	public function perp() : vec {
		return new vec(-y, x);
	}

	public function toString () : String {
		return "(" + x.toFixed(3) + ", " + y.toFixed(3) + ")";
	}

	// Returns the point of intersection of the (infinite) lines passing
	// through v1 and v2, and v3 and v4. NB. This may not be in the finite
	// line segments bounded by these points.

	// If the lines are parallel, this returns (NaN, NaN), even if they
	// overlap.
	public static function intersection (v1:vec, v2:vec, v3:vec, v4:vec)
		: vec
	{
		var denom:Number = ( (v1.x - v2.x)*(v3.y - v4.y)
		                     - (v1.y - v2.y)*(v3.x - v4.x) );

		if (denom == 0)
			return new vec(NaN, NaN);

		var px:Number = ( (v1.x*v2.y - v1.y*v2.x)*(v3.x - v4.x)
		                  - (v1.x - v2.x)*(v3.x*v4.y - v3.y*v4.x) ) ;
		var py:Number = ( (v1.x*v2.y - v1.y*v2.x)*(v3.y - v4.y)
		                  - (v1.y - v2.y)*(v3.x*v4.y - v3.y*v4.x) ) ;

		return new vec(px/denom, py/denom);
	}

	// Returns true if the finite line segments bounded by v1 and v2, and v3
	// and v4, are intersecting. Parallel lines are assumed not to
	// intersect, even if they do. NB. this is stricter than "intersection":
	// if that would return a point not contained in one of the vectors,
	// this returns false.
	public static function intersecting (v1:vec, v2:vec, v3:vec, v4:vec)
		: Boolean
	{
		var inter:vec = intersection(v1, v2, v3, v4);
		var ep:Number = 0.000000001; // avoid rounding errors
		if (isNaN(inter.x)
		    || inter.x + ep < v1.x && inter.x + ep < v2.x
		    || inter.x + ep < v3.x && inter.x + ep < v4.x
		    || inter.y + ep < v1.y && inter.y + ep < v2.y
		    || inter.y + ep < v3.y && inter.y + ep < v4.y
		    || inter.x - ep > v1.x && inter.x - ep > v2.x
		    || inter.x - ep > v3.x && inter.x - ep > v4.x
		    || inter.y - ep > v1.y && inter.y - ep > v2.y
		    || inter.y - ep > v3.y && inter.y - ep > v4.y)
			return false;

		return true;
	}

	// Returns a normalized vector bisecting the anticlockwise angle between
	// this and v. If they are parallel, the angle between them is
	// considered to be 2pi (so this returns a vector antiparallel to them).
	public function bisectAngle(v:vec) : vec {
		var p1:vec = perp().normalize();
		var p2:vec = v.perp().normalize();
		var p3:vec = p1.add(p2).normalize();

		if (p3.eq(new vec(0,0))) // they are antiparallel
			return p1;
		else
			return p3.perp();
	}

}
}
