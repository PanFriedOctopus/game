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
class Background extends Sprite
{

	public var sky:Sprite;
	public var mountains:Sprite;
	public var fence:Sprite;
	public var fence2:Sprite;
	
	public function new() 
	{
		super();
		/*sky = new Sprite();
		var SKY = new Bitmap(Assets.getBitmapData("img/sky.png"));
		sky.addChild(SKY);
		//this.addChild(sky);*/
		
		mountains = new Sprite();
		var MOUNTAINS = new Bitmap(Assets.getBitmapData("img/mountains.png"));
		mountains.addChild(MOUNTAINS);
		MOUNTAINS.x = 300;
		MOUNTAINS.y = 200;
		this.addChild(mountains);
		
		/*fence = new Sprite();
		fence2 = new Sprite();
		var FENCE = new Bitmap(Assets.getBitmapData("img/fence.png"));
		FENCE.width = 1600;
		var FENCE2 = new Bitmap(Assets.getBitmapData("img/fence.png"));
		FENCE2.width = 1600;
		/*FENCE.x = 0;
		FENCE.y = -230;
		FENCE2.x = 1600;
		FENCE2.y = -230;
		fence.addChild(FENCE);
		fence2.addChild(FENCE2);
		this.addChild(fence);
		this.addChild(fence2);
		fence.x = 300;
		fence.y = 200;
		fence2.x = this.x;
		fence2.y = this.y;
		trace("OODLDLDLDLDLDLD");*/
	}
	
	
	
}