package ;

import flash.Lib;
import flash.events.KeyboardEvent;
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

class Main extends Sprite 
{
	var inited:Bool;
	var game:Game;
	//var mainmenu:Menu;
	var playbutton:Sprite;
	var playyet:Bool = true;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		//mainmenu = new Sprite();
		//var menu = new Bitmap(Assets.getBitmapData("img/menu.png"));
		//mainmenu.addChild(menu);
		
		//playbutton = new Sprite();
		//var playButton = new Bitmap(Assets.getBitmapData("img/playbutton.png"));
		//playbutton.addChild(playButton);
		//playbutton.x = 450;
		//playbutton.y = 350;
		//mainmenu.addChild(playbutton);
		
		//mainmenu = new Menu();
		//this.addChild(mainmenu);
		
		
		
		
		
		
		//this.y = 300;
		
		game = new Game();
		this.addChild(game);

		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
		
		addEventListener (Event.ENTER_FRAME, action);
		//playbutton.addEventListener(MouseEvent.MOUSE_DOWN, playGame);
	}

	/*public function playGame(e:MouseEvent) 
	{
		addEventListener (Event.ENTER_FRAME, action);
		game = new Game();
		this.addChild(game);
		playyet = true;
	}*/
	/* SETUP */

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
	
	public function action(e)
	{
		
		//removeChild(mainmenu);
		if (playyet = true)
		{
			//game.act();
			this.x = -Game.game.herbert.x + 75;
			if (game.herbert.y > -6000)
			{
				this.y = -Game.game.herbert.y + 300 * .75;
			}
		}
		//this.y = 0;
		
	}
}
