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
class Platform extends Sprite 
{
	var img:BitmapData;
	var sprite:Sprite;
	var tall:Int;
	public var wide:Int;

	public function generate(x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool):B2Body
	{
		this.graphics.beginFill(0x56495f);
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
		fixtureDefinition.density = 1;
		fixtureDefinition.friction = 1;
		
		var body = Game.World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		return body;
	}
}