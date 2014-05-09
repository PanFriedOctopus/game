package;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.media.SoundChannel;
import flash.media.Sound;
import flash.media.SoundTransform;
import openfl.Assets;

/**
 * ...
 * @author ...
 */
class Menu extends Sprite 
{
	
	public var check:Bool = false;
	public var myChannel:SoundChannel;
	var sound:Sound;
	
	public function new() 
	{
		super();
		var sprite = new Sprite();
		var menu = new Bitmap(Assets.getBitmapData("img/menu.png"));
		sound = Assets.getSound("audio/cello.wav");
		myChannel = sound.play(0, 100);
		sprite.addChild(menu);
		this.addChild(sprite);
		var sprite2 = new Sprite();
		var playbutton = new Bitmap(Assets.getBitmapData("img/playbutton.png"));
		sprite2.addChild(playbutton);
		sprite2.x = 320;
		sprite2.y = 175;
		this.addChild(sprite2);
		sprite2.addEventListener(MouseEvent.MOUSE_DOWN, setgame);
		
	}
	
	public function setgame(e : MouseEvent)
	{
		check = true;
		myChannel.stop;
	}
}