import openfl.display.Graphics;

class WaveColor {
	public var width:Int;
	public var height:Int;
	public var lines:Array<WaveLine>;
	public function new(waveLine1:WaveLine, waveLine2:WaveLine) {
		this.lines = new Array<WaveLine>();
		this.lines.push(waveLine1);
		this.lines.push(waveLine2);
	}

	public function draw(g:Graphics) {
		var y = this.getPos(0);
		g.lineStyle(0, Main.MAIN_COLOR);
		g.beginFill(Main.MAIN_COLOR);
		g.moveTo(0, y);
		for (t in 1...this.width) {
			y = this.getPos(t);
			g.lineTo(t, y);
		}
		g.lineTo(this.width, this.height);
		
		g.lineTo(0, this.height);
		
		g.lineTo(0, this.getPos(0));
		g.endFill();
	}

	public function getPos(i:Int) {
		var point1 = this.lines[0].getPos(i);
		var point2 = this.lines[1].getPos(i);
		if (point1 > point2) {
			return point1;
		} else {
			return point2;
		}
	}
}
