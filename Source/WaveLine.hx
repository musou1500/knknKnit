import openfl.display.Graphics;
class WaveLine {

	// base point of the graph
	public var baseX:Int;
	public var baseY:Int;

	// In japanese "Shinpuku"
	public var amplitude:Int;

	public var freq:Float;
	public var initPhase:Float;

	public var width:Int;
	public var speed:Float;
	public var thickness:Int;
	public var positions:Array<Float>;
	public function new() {
		this.positions = new Array<Float>();
	}
	public function draw(g:Graphics, deltaTime:Int) {
		if (this.initPhase > this.width) {
			this.initPhase = this.initPhase - this.width;
		}
		var y = this.amplitude * Math.sin(this.freq * 0 - this.initPhase);
		g.lineStyle(this.thickness, Main.LINE_COLOR);
		g.moveTo(0, y + this.baseY);
		for (t in 1...this.width) {
			var tmp = this.amplitude * Math.sin(this.freq * t - this.initPhase);
			g.lineTo(t, y + this.baseY);
			g.moveTo(t, y + this.baseY);
			y = tmp;
		}
		this.initPhase += this.speed * deltaTime / 1 / 30;
	}

	public function getPos(t:Int)
	{
		var y = this.amplitude * Math.sin(this.freq * t - this.initPhase);
		return y+this.baseY;
	}
}
