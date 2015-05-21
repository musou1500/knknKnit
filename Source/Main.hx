package;

import motion.Actuate;
import motion.easing.Linear;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.Event;
using Std;

class Main extends Sprite {
	
	public static var LINE_NUM = 4;
	public static var LINE_COLOR = 0x181512;
	public static var MAIN_COLOR = 0xFCC800;
	public static var BASE_X = 0;
	public static var BASE_Y = 200;

	public var waves:Array<WaveLine>;
	public var lineShape:Shape;
	public var colorShape:Shape;
	public var waveColor:WaveColor;
	public function new () {
		
		super ();
		this.lineShape = new Shape();
		this.colorShape = new Shape();
				this.waves = new Array<WaveLine>();
		for (i in 0...Main.LINE_NUM) {
			var wave = this.genRundomWave();
			Actuate.tween (wave, 4, { baseY: Main.BASE_Y }).ease(Linear.easeNone);
			this.waves.push(wave);
		}
		this.waveColor = new WaveColor(this.waves[0], this.waves[1]);
		this.waveColor.width = this.stage.stageWidth;
		this.waveColor.height = this.stage.stageHeight;


		this.stage.addChild(colorShape);
		this.stage.addChild(lineShape);
		this.stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		this.stage.addEventListener(Event.RESIZE, onResize);
		
	}

	public function onResize(e:Event) {
		this.waveColor.width = this.stage.stageWidth;
		this.waveColor.height = this.stage.stageHeight;
		for (wave in this.waves) {
			wave.width = this.stage.stageWidth;
		}
	}
	private var prevTimer:Int = Lib.getTimer();
	public function onEnterFrame(e:Event)
	{
		var timer = Lib.getTimer();
		if (timer - prevTimer > 1 / 30) 
		{
			this.lineShape.graphics.clear();
			for (wave in this.waves) {
				wave.draw(this.lineShape.graphics);
			}
			this.colorShape.graphics.clear();
			this.waveColor.draw(this.colorShape.graphics);

			this.prevTimer = timer;
		}
	}


	public function genRundomWave():WaveLine
	{
		var wave = new WaveLine();
		wave.baseX = Main.BASE_X;
		wave.baseY = this.stage.stageHeight;
		wave.amplitude = ((0.1+Math.random()) * 30).int();
		wave.freq = Math.random() * 0.009 + 0.001;
		wave.initPhase = (Math.random() + 600 - 300).int();
		wave.width = this.stage.stageWidth;
		wave.speed = 0.06 + Math.random() * 0.02;
		wave.thickness = 2.random() + 1;
		return wave;
	}
	
}
