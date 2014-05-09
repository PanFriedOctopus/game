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
	var mainmenu:Menu;
	var playbutton:Sprite;
	var playyet:Bool = false;

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
		
		mainmenu = new Menu();
		game = new Game();
		this.addChild(mainmenu);
		//this.y = 300;
		
		//game = new Game();
		//this.addChild(game);

		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
		
		addEventListener (Event.ENTER_FRAME, playgame);
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
		//trace("caiowfeiofdiowfe");
		//removeChild(mainmenu);
		game.act();
		if (game.playyet == true)
		{
			this.x = -Game.game.herbert.x + 75;
			if (game.herbert.y > -7500)
			{
				this.y = -Game.game.herbert.y + 400 * .75;
			}
			game.resetbutton.x = -this.x + 600;
			game.resetbutton.y = -this.y;
			if (this.playyet = false)
			{
				mainmenu.myChannel.stop();
				playyet == true;
			}
		}
		//this.y = 0;
		
		if (game.playyet == false)
		{
			game.reset();
			playyet == false;
		}
	}
	
	function playgame(e)
	{
		if (mainmenu.check == true)
		{
			game.playyet = true;
			//trace(mainmenu.check);
			removeChild(mainmenu);
			this.addChild(game);
			addEventListener(Event.ENTER_FRAME, action);
			mainmenu.check = false;
		}
		
		if (game.check == true)
		{
			trace(this.x + " " + this.y + " " + mainmenu.x + " " + mainmenu.y);
			game.playyet = false;
			removeChild(game);
			this.addChild(mainmenu);
			removeEventListener(Event.ENTER_FRAME, action);
			game.check = false;
			game.x = 0;
			game.y = 0;
			mainmenu.x = 0;
			mainmenu.y = 0;
			this.x = 0;
			this.y = 0;
			//trace(game.x + " " + game.y);
			//mainmenu.x = this.x + 200;
			//mainmenu.y = this.y + 100;
		}
	}
	
	
}
