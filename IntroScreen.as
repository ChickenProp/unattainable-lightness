package {
import net.flashpunk.*;
import net.flashpunk.graphics.*;

public class IntroScreen extends Entity {
	public function IntroScreen () {
		var gl:Graphiclist = new Graphiclist;
		var opts:Object = { align:"center" }

		var t1:Text = new Text("THE UNATTAINABLE LIGHTNESS\nOF SOLITUDE", 240, 100, { align:"center", size:24 });
		t1.centerOrigin();
		var t2:Text = new Text("avoid moths to gain power\nclick to burn them\n\nclick to begin", 240, 200, opts);
		t2.centerOrigin();
		gl.add(t1);
		gl.add(t2);

		graphic = gl;
	}
}
}
