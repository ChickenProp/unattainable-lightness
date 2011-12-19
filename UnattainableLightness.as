package {
import net.flashpunk.*;
import net.flashpunk.utils.*;

[SWF(width = "480", height = "480")]

public class UnattainableLightness extends Engine {
        public function UnattainableLightness () {
                super(480, 480, 30, true);
                Data.load(Game.dataFile);
        }

        override public function init():void {
                FP.world = new Game;
        }

	override public function update () : void {
		super.update();
		if (Input.pressed(Key.P))
			FP.world.active = ! FP.world.active;
	}
}
}
