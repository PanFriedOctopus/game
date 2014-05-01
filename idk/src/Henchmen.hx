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
	var tall:Int;
	var body:B2Body;
	public var wide:Int;
	
	public function new(x:Int, y:Int) 
	{
		super();
	}
	
	public function generate(x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool):B2Body
	{
		var s = new Sprite();
		var b = new Bitmap(Assets.getBitmapData("img/henchman.png"));
		b.width = width;
		b.height = height;
		s.addChild(b);
		this.addChild(s);
		this.x = x;
		this.y = y;
		
		this.graphics.beginFill(0x008000);
		this.graphics.drawRoundRect(x, y, width, height, 4);
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * Game.PHYSICS_SCALE, y * Game.PHYSICS_SCALE);
		
		if (dynamicBody) {
			
			bodyDefinition.type = B2Body.b2_dynamicBody;
			
		}
		
		var polygon = new B2PolygonShape();
		polygon.setAsBox ((width / 2) * Game.PHYSICS_SCALE, (height / 2) * Game.PHYSICS_SCALE);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
		fixtureDefinition.density = 2;
		fixtureDefinition.friction = 1;
		
		body = Game.World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		return body;
	}
	
	public function destroy()
	{
		Game.World.destroyBody(body);
	}
}