package ;

import flash.events.Event;
import flash.events.MouseEvent;
import Math;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import openfl.Assets;
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
class Herbert extends Sprite
{
	var WIDTH = 100;
	public var body:B2Body;
	public var count:Int;
	var countup:Bool;
	var that:Float;
	var thing:Float;
	public var cgx:Float=300;
	public var cgy:Float = 5;
	public var cga:Float = 3;
	public var shotsfired:Int = 0;
	
	private function new(x:Int, y:Int)
	{
		super();
		//radius needs to be 57 pixels
		var s = new Sprite();
		var b = new Bitmap(Assets.getBitmapData("img/circlesheep.png"));
		s.addChild(b);
		s.x = (-WIDTH / 2) -20;
		s.y = -WIDTH / 2;
		this.addChild(s);
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * Game.PHYSICS_SCALE, y * Game.PHYSICS_SCALE);
		bodyDefinition.type = B2Body.b2_dynamicBody;
		
		var circle = new B2CircleShape (57 * Game.PHYSICS_SCALE);
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = circle;
		fixtureDefinition.restitution = .55;
		fixtureDefinition.density = 1;
		fixtureDefinition.friction = 10;
		
		body = Game.World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		
	}
	
	/* makes the sheep a square
	public function new(x:Int, y:Int) 
	{
		super();
		var s = new Sprite();
		var b = new Bitmap(Assets.getBitmapData("img/boxsheep.png"));
		//b.width = 100;
		//b.height = 100;
		s.addChild(b);
		s.x = (-WIDTH / 2) -20;
		s.y = -WIDTH / 2;
		this.addChild(s);
		this.x = x;
		this.y = y;
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * Game.PHYSICS_SCALE, y * Game.PHYSICS_SCALE);
		bodyDefinition.type = B2Body.b2_dynamicBody;
		//bodyDefinition.linearDamping = 0.99;
		var polygon = new B2PolygonShape();
		polygon.setAsBox ((WIDTH / 2) * Game.PHYSICS_SCALE, (WIDTH / 2) * Game.PHYSICS_SCALE);
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
		fixtureDefinition.restitution = .55;
		fixtureDefinition.density = 1;
		fixtureDefinition.friction = 1;
		
		body = Game.World.createBody(bodyDefinition);
		body.createFixture (fixtureDefinition);
	}*/
	
	public function fire(e : MouseEvent)
	{
		if (shotsfired == 0)
		{
			//trace ("pewpew");
			body.setAwake(true);
			body.setLinearVelocity(new B2Vec2( 5 * Game.powercount, -4 * Game.powercount));	
			body.setAngularVelocity(2);
			count++;
		}
		else
		{
			//trace("nottoday");
		}
		shotsfired++;
	}	
	
	public function act()
	{
		//trace("THE :" + this.x);
		//trace("THEYEEJEEJJFJSDAJSLFKLSDJALFJ Y:" + this.y);
		//var thing = this.x;
		this.x = body.getPosition().x / Game.PHYSICS_SCALE;
		this.y = body.getPosition().y / Game.PHYSICS_SCALE;
		this.rotation = body.getAngle() * 180 / Math.PI;
		
		//var that = this.x;
		//trace(thing - that);
		//body.applyForce(new B2Vec2(0, 10 * body.getMass()), body.getPosition());
	}
	
}