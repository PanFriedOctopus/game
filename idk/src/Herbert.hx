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
	var body:B2Body;
	public var count:Int;
	var countup:Bool;
	var that:Float;
	var thing:Float;
	
	public function new(x:Int, y:Int) 
	{
		super();
		var s = new Sprite();
		//var b = new Bitmap(Assets.getBitmapData("img/box.png"));
		//b.width = 100;
		//b.height = 100;
		//s.addChild(b);
		s.x = -WIDTH / 2;
		s.y = -WIDTH / 2;
		this.addChild(s);
		this.x = x;
		this.y = y;
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * Game.PHYSICS_SCALE, y * Game.PHYSICS_SCALE);
		bodyDefinition.type = B2Body.b2_dynamicBody;
		var polygon = new B2PolygonShape();
		polygon.setAsBox ((WIDTH / 2) * Game.PHYSICS_SCALE, (WIDTH / 2) * Game.PHYSICS_SCALE);
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
		fixtureDefinition.density = 1;
		fixtureDefinition.friction = 1;
		
		body = Game.World.createBody(bodyDefinition);
		body.createFixture (fixtureDefinition);
	}
	
	public function fire(e : MouseEvent)
	{
		trace ("pewpew");
		body.setAwake(true);
		body.setLinearVelocity(new B2Vec2( 10*Game.powercount, -8*Game.powercount));	
		count++;
	}
	
	public function launchbar(width)
	{
		//trace("AHHAHAHAHHHAHAHAHAHAHHAHHAHAHHAHAHAHHAHAHAHAHHAHAAHH");
		this.graphics.beginFill(0xb30303);
		this.graphics.drawRoundRect(200, 100, width, 5, 4);
		//graphics.drawRoundRect(
	}
	
	public function act()
	{
		var thing = this.x;
		//this.graphics.clear();
		//trace(count);
		//this.launchbar(count);
		this.x = body.getPosition().x / Game.PHYSICS_SCALE;
		this.y = body.getPosition().y / Game.PHYSICS_SCALE;
		this.rotation = body.getAngle() * 180 / Math.PI;
		var that = this.x;
		trace(thing - that);
		//if (count < 0) countup = true;
		//if (count > 100) countup = false;
		//if (countup == true) count++;
		//else count--;
		//this.graphics.clear();
	}
	
}