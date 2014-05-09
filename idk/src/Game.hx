package ;

import haxe.rtti.CType.Platforms;
import haxe.Timer;
import Math;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.media.SoundChannel;
import flash.media.Sound;
import flash.media.SoundTransform;
import openfl.Assets;
import flash.Lib;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;

/**
 * ...
 * @author Vic
 */
class Game extends Sprite
{

	public static var PHYSICS_SCALE:Float = 1.0 / 30;
	public static var World:B2World;
	public var PhysicsDebug:Sprite;
	public var herbert:Herbert;
	public var mountains:Sprite;
	public var mountains2:Sprite;
	public var MOUNTAINS:Bitmap;
	public var MOUNTAINS2:Bitmap;
	public var grass:Sprite;
	public var grass2:Sprite;
	public var grassbool:Bool;
	public var mntbool:Bool;
	public var mntcount:Int = 0;
	public var sky:Sprite;
	public var fence:Sprite;
	public var fence2:Sprite;
	public var fencebool:Bool;
	public var fencecount:Int = 0;
	public var sheepprev:Float;
	public var resetbutton:Sprite;
	public var resetbuttonpicture:Bitmap;
	public static var game;
	public static var powercount:Int;
	var countup:Bool;
	public var background:Background;
	public var platform:Platform;
	public var henchmen:List<Henchmen>;
	public var henchman:Henchmen;
	public var rand:Float;
	var counter:Int = 0;
	var myChannel:SoundChannel;
	var sound:Sound;
	var transfor:SoundTransform;
	public var check:Bool = false;
	public var playyet:Bool = false;
	
	
	
	public function new() 
	{
		super();
		game = this;
		
		PhysicsDebug = new Sprite ();
		addChild (PhysicsDebug);
		World = new B2World(new B2Vec2 (0, 10.0), true);
		
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		debugDraw.setFlags (B2DebugDraw.e_centerOfMassBit + B2DebugDraw.e_shapeBit+ B2DebugDraw.e_aabbBit );// + B2DebugDraw.e_aabbBit);
		World.setDebugDraw (debugDraw);
		
		platform = new Platform();
		platform.generate(0, 250, 1500, 10, false);
		this.addChild(platform);

		/*var enemySpawn:Timer = new haxe.Timer(4500);
		enemySpawn.run = function():Void
		{
			for (henchman in henchmen)
			{
				if (henchman.x < herbert.x - 100)
				{
					henchmen.remove(henchman);
					henchman.destroy();
					trace("Hench-y go bye bye");
				}
			}
		rand = Math.random();
		rand *= 100;
		if ((rand > 97) || (counter > 4)) 
		{
			var baddiesize = Math.random();
			baddiesize *= 80;
			henchman = new Henchmen(herbert.x + 1000, 0, baddiesize + 20, baddiesize * 2, true);
			henchmen.push(henchman);
			this.addChild(henchman);
			trace("Made a baddie");
			counter = 0;
		}
		else
		counter++;
		};*/
		
		//henchman = new Henchmen(500, 0, 100, 150, false);
		//this.addChild(henchman);
		//henchman.destroy();
		//this.removeChild(henchman);
		
		sky = new Sprite();
		var SKY = new Bitmap(Assets.getBitmapData("img/sky.png"));
		sky.addChild(SKY);
		this.addChild(sky);
		
		
		mntbool = false;
		
		
		mountains = new Sprite();
		mountains2 = new Sprite();
		MOUNTAINS = new Bitmap(Assets.getBitmapData("img/mountains.png"));
		MOUNTAINS.width = 1200;
		MOUNTAINS2 = new Bitmap(Assets.getBitmapData("img/mountains.png"));
		MOUNTAINS2.width = 1200;
		mountains.addChild(MOUNTAINS);
		mountains2.addChild(MOUNTAINS2);
		this.addChild(mountains);
		this.addChild(mountains2);
		mountains.x = 0;
		mountains.y = 10;
		mountains2.x = 1200;
		mountains2.y = 10;
		
		
		
		
		fencebool = false;
		
		fence = new Sprite();
		fence2 = new Sprite();
		var FENCE = new Bitmap(Assets.getBitmapData("img/fence.png"));
		FENCE.width = 1600;
		var FENCE2 = new Bitmap(Assets.getBitmapData("img/fence.png"));
		FENCE2.width = 1600;
		fence.addChild(FENCE);
		fence2.addChild(FENCE2);
		this.addChild(fence);
		this.addChild(fence2);
		fence.x = 0;
		fence.y = -230;
		fence2.x = 1600;
		fence2.y = -230;
		
		/*
		grassbool = false;
		
		grass = new Sprite();
		grass2 = new Sprite();
		var GRASS = new Bitmap(Assets.getBitmapData("img/grass.png"));
		GRASS.width = 482;
		var GRASS2 = new Bitmap(Assets.getBitmapData("img/grass.png"));
		GRASS2.width = 482;
		grass.addChild(GRASS);
		grass2.addChild(GRASS2);
		this.addChild(grass);
		this.addChild(grass2);
		grass.x = 0;
		grass.y = 220;
		grass2.x = 964;
		grass2.y = 220;
		*/
		
		herbert = new Herbert(300, 200);
		this.addChild(herbert);
		sheepprev = herbert.x;
		
		sky.x = herbert.x;
		sky.y = herbert.y - 400;
		//sound = Assets.getSound("audio/bongos.mp3");
		//myChannel = sound.play(0, 100);
		//transfor = new SoundTransform();
		//transfor.volume = 2.0;
		//trace(herbert.x);
		//trace(herbert.y);
		resetbutton = new Sprite();
		//trace(resetbutton.x);
		resetbuttonpicture = new Bitmap(Assets.getBitmapData("img/resetbutton.png"));
		resetbutton.addChild(resetbuttonpicture);
		this.addChild(resetbutton);
		resetbutton.x = this.x + 850;
		resetbutton.y = this.y - 100;
		resetbutton.addEventListener(MouseEvent.MOUSE_DOWN, setmenu);
		
		herbert.addEventListener(MouseEvent.MOUSE_DOWN, herbert.fire);
		
	}
	
	private function createBox (x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool):B2Body
	{
		this.graphics.beginFill(0x56495f);
		this.graphics.drawRoundRect(x, y, width, height, 4);
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);
		
		if (dynamicBody) {
			
			bodyDefinition.type = B2Body.b2_dynamicBody;
			
		}
		
		var polygon = new B2PolygonShape();
		polygon.setAsBox ((width / 2) * PHYSICS_SCALE, (height / 2) * PHYSICS_SCALE);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
		fixtureDefinition.density = 1;
		fixtureDefinition.friction = 1;
		
		var body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		return body;
	}
	
	public function launchbar(width)
	{
		//trace("AHHAHAHAHHHAHAHAHAHAHHAHHAHAHHAHAHAHHAHAHAHAHHAHAAHH");
		this.graphics.beginFill(0xb30303);
		this.graphics.drawRect(400, 300, width, 5);
		//graphics.drawRoundRect(
	}
	
	public function act()
	{
		if (playyet == true) 
		{
		World.step(1 / Lib.current.stage.frameRate, 8, 10);
		//trace("X: " + mouseX);
		//trace("Y: " + mouseY);
		//sky.x = herbert.x;
		//sky.y = herbert.y;
		//World.destroyBody(B2Body(platform(body)));
		this.graphics.clear();
		platform.destroy();
		this.graphics.beginFill(0xFAAF00);
		this.graphics.drawRect(396, 300, 4, 5);
		this.graphics.drawRect(500, 300, 4, 5);
		this.launchbar(powercount);
		if (powercount < 1) countup = true;
		if (powercount > 100) countup = false;
		if (countup == true) powercount++;
		else powercount--;
		herbert.act();
		resetbutton.x = this.x + 850;
		resetbutton.y = this.y - 100;
		//platform.act(herbert.x);
		platform.generate(herbert.x, 250, 2000, 10, false);
		this.addChild(platform);
		//platform.y = platform.y - 7;

		
		//trace (herbert.y);
		if (fencecount == 0)
		{		
			
			//trace ("goodle");
			var fencex = fence.x + 1650;
			if (fencex - 25 <= herbert.x && fencex + 25 >= herbert.x)
			{
				//trace ("goodle");
				fence.x = (fencex - 50) + 1600;
				fencecount = 1;
			}
		}
		if (fencecount == 1)
		{
			
			var fence2x = fence2.x + 1650;
			if (fence2x - 25 <= herbert.x && fence2x + 25 >= herbert.x)
			{
				//trace ("GOOOOOOOOOOOOODLE");
				fence2.x = (fence2x - 50) + 1600;
				fencecount = 0;
			}
		}
		
		trace (herbert.x);
		
		
		if (mntbool == true)
		{
			
			var mnt2x = mountains2.x + 1200;
			if (mnt2x - 25 <= herbert.x && mnt2x + 25 >= herbert.x)
			{
				
				mountains2.x = mnt2x +1200;
				mntbool = false;
				//trace (mntbool);
			}
		}
		else if (mntbool == false)
		{
			var mntx = mountains.x + 1200;
			//trace ("goodle");
			if (mntx - 25 <= herbert.x && mntx + 25 >= herbert.x)
			{
				mountains.x = mntx+ 1200;
				mntbool = true;
			}
		}
		
		
		if (grassbool == true)
		{
			
			var grass2x = grass2.x + 964;
			if (grass2x - 25 <= herbert.x && grass2x + 25 >= herbert.x)
			{
				
				grass2.x = grass2x +964;
				grassbool = false;
				//trace (mntbool);
			}
		}
		else if (grassbool == false)
		{
			var grassx = grass.x + 964;
			//trace ("goodle");
			if (grassx - 10 <= herbert.x && grassx + 10 >= herbert.x)
			{
				
				grass.x = grassx+ 964;
				grassbool = true;
			}
		}
		
		
		sky.x = herbert.x * .99;
		//sky.y = herbert.y - 400 * .35;
		if (herbert.y > -6000)
		{
			sky.y = herbert.y  * .99 -480;
		}
		
		
		//mountains.x = herbert.x * .91;
		//mountains2.x = herbert.x * .91;
		
		//World.step(1 / Lib.current.stage.frameRate, 10, 10);
		//World.drawDebugData();
		World.clearForces();
		}
	}
	
	public function reset()
	{
		herbert.shotsfired = 0;
		herbert.x = 300;
		herbert.y = 200;
		herbert.rotation = 0;
		//myChannel.stop();
	}
	
	public function setmenu(e)
	{
		check = true;
	}
	
}