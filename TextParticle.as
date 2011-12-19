package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;

public class TextParticle extends Entity {
        public function TextParticle (_x:int, _y:int, text:String) {
                graphic = new Text(text);
                x = _x;
                y = _y;
        }

        override public function update () : void {
                (graphic as Image).alpha -= 0.02;
		y -= 2;

                if ((graphic as Image).alpha <= 0)
                        FP.world.remove(this);
        }
}
}
