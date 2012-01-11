package {
import flash.utils.ByteArray;
import net.flashpunk.*;
import net.flashpunk.utils.*;
import net.flashpunk.graphics.*;

public class Game extends World {
[ Embed(source = 'media/newwave.mp3') ] private const NEWWAVE:Class;
	public var newWaveSfx:Sfx = new Sfx(NEWWAVE);

	public static var dataFile:String = "philh-fears-data";
	public static var frame:int = 0;
	public var player:Player;
	public var sleepers:Vector.<Sleeper> = new Vector.<Sleeper>();
	public var waveStarted:int = 0;
	public var started:Boolean = false;
	public var intro:Entity;
	public var won:int = 0;

	public function Game () {
		add(new HUD);
		intro = add(new IntroScreen);
		player = new Player;
		add(player);

		for (i = 450; i >= 10; i -= 20)
			addSleeper(470, i);
		for (i = 10; i <= 450; i += 20)
			addSleeper(10, i);
		for (var i:int = 10; i <= 470; i += 20)
			addSleeper(i, 470);
	}

	public function addSleeper(x:Number, y:Number) : void {
		var s:Sleeper = new Sleeper(x, y);
		add(s);
		sleepers.push(s);
	}

	public function start () : void {
		remove(intro);
		started = true;
		nextWave();
	}

	override public function update () : void {
		super.update();

		if (Input.pressed(Key.R))
			FP.world = new Game;

		frame++;

		if (Input.pressed(Key.F5))
			FP.console.enable();

		if (sleepers.length + classCount(Moth) == 0) {
			var t:Text = new Text("solitude attained\n\nclick to play again", 240, 150);
			t.centerOrigin();
			addGraphic(t);
			won = frame;
		}

		if (started && frame - waveStarted >= 30*3)
			nextWave();
	}

	public function maybeNextWave () : void {
		var moths:Array = [];
		getClass(Moth, moths);
		if (! moths.length)
			nextWave();
	}

	public var waveSizes:Array = [ 2, 2, 3, 3, 3, 4, 4, 4 ];
	public function nextWave () : void {
		if (sleepers.length == 0)
			return;

		newWaveSfx.play(0.2);
		waveStarted = frame;
		var num:int = waveSizes.shift() || 5;

		for (; num > 0; num--) {
			if (sleepers.length == 0)
				return;

			var i:int = FP.rand(sleepers.length);
			sleepers[i].wake();
			sleepers.splice(i, 1);
		}
	}

	public var _score:int = 0;
	public function get score () : int { return _score; }
	public function set score (s:int) : void {
		_score = s;
		if (s > highScore)
			highScore = s;
	}

	public function get highScore () : int {
		return Data.readInt("hiscore", 0);
	}
	public function set highScore (s:int) : void {
		Data.writeInt("hiscore", s);
		Data.save(dataFile);
	}

}
}
