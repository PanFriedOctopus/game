package;
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
 * @author ...
 */
class Henchmen extends Sprite
{
	var img:BitmapData;
	var sprite:Sprite;
	var s:Sprite;
	var b:BitmapData;
	var body:B2Body;
	public var wide:Int;
	public var WIDTH:Float;

	
	public function new(x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool)
	{
		WIDTH = width;
		super();
		var s = new Sprite();
		var b = new Bitmap(Assets.getBitmapData("img/henchman.png"));
		b.width = width + .5;
		b.height = height;
		s.addChild(b);
		s.x = (-WIDTH / 2);
		s.y = -height / 2;
		this.addChild(s);
		this.x = x;
		this.y = y;
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * Game.PHYSICS_SCALE, y * Game.PHYSICS_SCALE);
		bodyDefinition.type = B2Body.b2_dynamicBody;
		//bodyDefinition.linearDamping = 0.99;
		var polygon = new B2PolygonShape();
		polygon.setAsBox ((WIDTH / 2) * Game.PHYSICS_SCALE, (height / 2) * Game.PHYSICS_SCALE);
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
		fixtureDefinition.restitution = 0;
		fixtureDefinition.density = 1;
		fixtureDefinition.friction = 1;
		
		body = Game.World.createBody(bodyDefinition);
		body.createFixture (fixtureDefinition);
	}
	
	public function destroy()
	{
		Game.World.destroyBody(body);
	}
	
	public function act()
	{
		this.x = body.getPosition().x / Game.PHYSICS_SCALE;
		this.y = body.getPosition().y / Game.PHYSICS_SCALE;
		this.rotation = body.getAngle() * 180 / Math.PI;
	}
}