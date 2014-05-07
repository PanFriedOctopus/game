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
	public var sky:Sprite;
	public var fence:Sprite;
	public var fence2:Sprite;
	public var fencebool:Bool;
	public var fencecount:Int = 0;
	public var sheepprev:Float;
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
		
		henchman = new Henchmen(500, 0, 100, 150, false);
		this.addChild(henchman);
		henchman.destroy();
		this.removeChild(henchman);
		platform = new Platform();
		platform.generate(0, 250, 1500, 10, false);
		this.addChild(platform);
		
		sky = new Sprite();
		var SKY = new Bitmap(Assets.getBitmapData("img/sky.png"));
		sky.addChild(SKY);
		//this.addChild(sky);
		
		/*mountains = new Sprite();
		var MOUNTAINS = new Bitmap(Assets.getBitmapData("img/mountains.png"));
		mountains.addChild(MOUNTAINS);
		MOUNTAINS.x = 300;
		MOUNTAINS.y = 200;
		this.addChild(mountains);*/
		
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
		
		
		herbert = new Herbert(300, 200);
		this.addChild(herbert);
		sheepprev = herbert.x;
		
		sound = Assets.getSound("audio/bongos.mp3");
		myChannel = sound.play(0, 100);
		transfor = new SoundTransform();
		transfor.volume = 2.0;
		
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, herbert.fire);
		
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
		World.step(1 / Lib.current.stage.frameRate, 10, 10);
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
		henchman.act();
		//platform.act(herbert.x);
		platform.generate(herbert.x, 250, 2000, 10, false);
		this.addChild(platform);
		//platform.y = platform.y - 7;
		
		trace (herbert.y);
		if (fencecount == 0)
		{
			//trace ("goodle");
			var fencex = fence.x + 1600;
			if (fencex - 25 <= herbert.x && fencex + 25 >= herbert.x)
			{
				//trace ("goodle");
				fence.x = fencex + 1600;
				fencecount = 1;
			}
		}
		if (fencecount == 1)
		{
			
			var fence2x = fence2.x + 1600;
			if (fence2x - 25 <= herbert.x && fence2x + 25 >= herbert.x)
			{
				//trace ("GOOOOOOOOOOOOODLE");
				fence2.x = fence2x + 1600;
				fencecount = 0;
			}
		}
		
		
		
		//World.step(1 / Lib.current.stage.frameRate, 10, 10);
		World.drawDebugData();
		World.clearForces();
	}
	
}