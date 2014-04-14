package ;

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
 * @author Nicholas Seward
 */
class Dude extends Sprite
{
	var WIDTH = 100;
	var body:B2Body;

	public function new(x:Int,y:Int) 
	{
		super();
		var s = new Sprite();
		var b = new Bitmap(Assets.getBitmapData("img/sheep.png"));
		s.addChild(b);
		s.x = -WIDTH / 2;
		s.y = -WIDTH / 2;
		this.addChild(s);
		this.x = x;
		this.y = y;
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * Main.PHYSICS_SCALE, y * Main.PHYSICS_SCALE);
		bodyDefinition.type = B2Body.b2_dynamicBody;
		var polygon = new B2PolygonShape();
		polygon.setAsBox ((WIDTH / 2) * Main.PHYSICS_SCALE, (WIDTH / 2) * Main.PHYSICS_SCALE);
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
		fixtureDefinition.density = 1;
		fixtureDefinition.friction = 1;
		
		body = Main.game.World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
	}
	
	public function isTouching()
	{
		var c = body.m_contactList;
		while (c != null)
		{
			if (c.contact.isTouching())
			{
				return true;
			}
			c = c.next;
		}
		return false;
	}
	
	public function jumpLeft()
	{
		if (isTouching())body.setLinearVelocity(new B2Vec2( -3, -5));
	}
	
	public function jumpRight()
	{
		if (isTouching())body.setLinearVelocity(new B2Vec2( 3, -5));
	}
	
	public function act()
	{
		this.x = body.getPosition().x/Main.PHYSICS_SCALE;
		//trace(body.getPosition().x);
		this.y = body.getPosition().y/Main.PHYSICS_SCALE;
		this.rotation = body.getAngle() * 180  / Math.PI;
	}
	
}