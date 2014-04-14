package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.Lib;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;



class Main extends Sprite 
{
	var inited:Bool;
	public static var game;
	public var dude:Dude;
	public static var PHYSICS_SCALE:Float = 1.0 / 30;
	private var PhysicsDebug:Sprite;
	public var World:B2World;
	public var cgx:Float=300;
	public var cgy:Float=300;
	public var cga:Float = 10;
	private var topBlock:B2Body;

	
	function resize(e) 
	{
		if (!inited) init();
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		game = this;
		PhysicsDebug = new Sprite ();
		addChild (PhysicsDebug);		
		
		World = new B2World(new B2Vec2 (0, 0.0), true);
		
		
		
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		debugDraw.setFlags (B2DebugDraw.e_centerOfMassBit + B2DebugDraw.e_shapeBit+ B2DebugDraw.e_aabbBit );// + B2DebugDraw.e_aabbBit);
		
		World.setDebugDraw (debugDraw);
		dude = new Dude(10, 10);
		this.addChild(dude);
		createBox (250, 300, 900, 100, false);
		topBlock=createBox (405, 0, 100, 100, true);
		var cir:B2Body=createCircle (100, 150, 50, false);
		//cir.setType(B2Body.b2_kinematicBody);
		//cir.applyImpulse(new B2Vec2(1000, 0), cir.getPosition());
		createCircle (400, 100, 50, true);
		
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, jump);


	}
	
	public function jump(e:KeyboardEvent)
	{
		trace(e.keyCode);
		if (e.keyCode == 65)dude.jumpLeft();
		if (e.keyCode == 68) dude.jumpRight();
		if (e.keyCode == 37) cgx -= 1;
		if (e.keyCode == 39) cgx += 1;
		if (e.keyCode == 38) cgy -= 1;
		if (e.keyCode == 40) cgy += 1;
		if (e.keyCode == 90) cga *=10;
		if (e.keyCode == 88) cga /=10;
		trace(cga);
		
	}
	
	private function createBox (x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool):B2Body
	{
		
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
	
	
	private function createCircle (x:Float, y:Float, radius:Float, dynamicBody:Bool):B2Body 
	{
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);
		
		if (dynamicBody) {
			
			bodyDefinition.type = B2Body.b2_dynamicBody;
			
		}
		
		var circle = new B2CircleShape (radius * PHYSICS_SCALE);
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = circle;
		fixtureDefinition.density = 1;
		fixtureDefinition.friction = 1;
		
		var body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		return body;
		
	}

	private function this_onEnterFrame (event:Event):Void 
	{
		//topBlock.applyForce(new B2Vec2(-10,0),topBlock.getPosition());
		//apply forces
		var b = World.getBodyList();
		while (b!=null)
		{
			//trace(b);
			var p = b.getPosition().copy();
			
			p.subtract(new B2Vec2(cgx * PHYSICS_SCALE, cgy * PHYSICS_SCALE));
			p.normalize();
			p.multiply(-cga * b.getMass());
			b.applyForce(p, b.getPosition());
			//b.applyForce(
			b = b.m_next;
		}
		
		World.step (1 / Lib.current.stage.frameRate, 1, 1);
		World.clearForces ();
		dude.act();
		World.drawDebugData ();
		
	}

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
