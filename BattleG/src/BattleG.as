


/**
 * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
 * If it is not possible or desirable to put the notice in a particular file, then You may include the notice in a location (such as a LICENSE file in a relevant directory) where a recipient would be likely to look for such a notice.
 * You may add additional accurate notices of copyright ownership.
 *
 * It is desirable to notify that Covered Software was "Powered by AlternativaPlatform" with link to http://www.alternativaplatform.com/ 
 * */


//使用git工作，刺激战场


package  {
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.media.Camera;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import alternativa.engine3d.animation.AnimationClip;
	import alternativa.engine3d.animation.AnimationController;
	import alternativa.engine3d.animation.AnimationSwitcher;
	import alternativa.engine3d.collisions.EllipsoidCollider;
	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.core.events.MouseEvent3D;
	import alternativa.engine3d.loaders.ParserCollada;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.Material;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.AnimSprite;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.objects.Skin;
	import alternativa.engine3d.primitives.GeoSphere;
	import alternativa.engine3d.resources.BitmapTextureResource;
	
	import evrm.cfg.CfgRef;
	
	import view.map.Ground;
	
	/**
	 * Alternativa3D complete demo.
	 */
	public class BattleG extends Sprite {
		
//		[Embed("level.dae", mimeType="application/octet-stream")] static private const LevelModel:Class;
//		[Embed(source="level.jpg")] static private const LevelTexture:Class;
//		
//		
//		[Embed(source="explosion.png")] static private const EmbedTexture:Class;
		
		
		//		[Embed("character.dae", mimeType="application/octet-stream")] static private const CharacterModel:Class;
		//		[Embed(source="character.jpg")] static private const CharacterTexture:Class;
		
		private var stage3D:Stage3D;
		
		private var scene:Object3D = new Object3D();
		private var camera:Camera3D;
		private var controller:SimpleObjectController;
		
		private var level:Mesh;
		//		private var character:Skin;
		
		private var _cfgRef:CfgRef = new CfgRef();
		private var _speed:Number = _cfgRef.speed();
		private var _fallSpeed:Number;
		private var _keyDic:Dictionary = new Dictionary();
	
		private var _sphere:GeoSphere = new GeoSphere(10, 3, false, new FillMaterial(0xFFFF00, 0.85));
		
		
		
		
		
		//		构造函数
		public function BattleG() {
			stage.scaleMode = StageScaleMode.NO_SCALE;//缩放模式的值
			stage.align = StageAlign.TOP_LEFT;
			
			stage3D = stage.stage3Ds[0];
			
			
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, init);
			stage3D.requestContext3D(Context3DRenderMode.SOFTWARE);
			
			
			
			
			
			
			
		}
		
		private function init(e:Event):void {
			// Camera and view
			camera = new Camera3D(10, 10000);
			camera.view = new View(stage.stageWidth, stage.stageHeight);
			camera.view.antiAlias = 4;
			
			
			
			addChild(camera.view);
			addChild(camera.diagram);
			
			
			//			摄像头的起始位置
			camera.rotationX = -120*Math.PI/180;
			camera.y = -500;
			camera.z = 250;
			camera.lookAt(0,0,0);
			
			
			controller = new SimpleObjectController(stage, camera, 500, 2);
			controller.disable();
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			scene.addChild(camera);
			
			_sphere.mouseEnabled = false;
			_sphere.geometry.upload(stage3D.context3D);
			scene.addChild(_sphere);
			
			var ground:Ground = new Ground();
			ground.uploadContext3D(stage3D.context3D);
			scene.addChild(ground);
			
		
		
			
			
			
		
			
			//			事件侦听相关
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.RESIZE, onResize);
			
			
			
			
		}
		
		
		/**
		 * 
		 * @param e
		 * 
		 */
		protected function onKeyDown(e:KeyboardEvent):void
		{
			_keyDic[e.keyCode] = true;
			switch(e.keyCode)
			{
				case Keyboard.A:
					if(_keyDic[Keyboard.W])
					{
						_sphere.x -= _speed*0.5;
						_sphere.y += _speed*0.5;
					}
					else if(_keyDic[Keyboard.S])
					{
						_sphere.x -= _speed*0.5;
						_sphere.y -= _speed*0.5;
					}
					
					else
					{
						_sphere.x -= _speed;
					}
					break;
				case Keyboard.S:
					if(_keyDic[Keyboard.A])
					{
						_sphere.x -= _speed*0.5;
						_sphere.y -= _speed*0.5;
					}
					else if(_keyDic[Keyboard.D])
					{
						_sphere.x += _speed*0.5;
						_sphere.y -= _speed*0.5;
					}
					else
					_sphere.y -= _speed;
					break;
				case Keyboard.D:
					if(_keyDic[Keyboard.W])
					{
						_sphere.x += _speed*0.5;
						_sphere.y += _speed*0.5;
					}
					else if(_keyDic[Keyboard.S])
					{
						_sphere.x += _speed*0.5;
						_sphere.y -= _speed*0.5;
					}
					else
					_sphere.x += _speed;
					break;
				case Keyboard.W:
					if(_keyDic[Keyboard.A])
					{
						_sphere.x -= _speed*0.5;
						_sphere.y += _speed*0.5;
					}
					else if(_keyDic[Keyboard.D])
					{
						_sphere.x += _speed*0.5;
						_sphere.y += _speed*0.5;
					}
					else
					_sphere.y += _speed;
					break;
				case Keyboard.SPACE:
					_sphere.z += _speed;
					break;
				default:
					break;
			}
			
		}
		protected function onKeyUp(e:KeyboardEvent):void
		{
			_keyDic[e.keyCode] = false;		
		}
		
		
		var collisionPlane:Number = 10;
		protected function collisionDetect(obj:Object3D, obj1:Object3D):Boolean 
		{
			if(Math.abs(obj.x-obj1.x)<collisionPlane
				&& Math.abs(obj.y-obj1.y)<collisionPlane)
				return true;
			return false;
					
		}
		
		
		
		
		
		
		
		private function onEnterFrame(e:Event):void {
			
			_fallSpeed = _cfgRef.getFallSpeed();
			//trace(_fallSpeed)
			//trace("time"+_cfgRef.getDetelTime());
			//trace(getTimer());
			//trace("speed"+_cfgRef.getFallSpeed());
			if(_sphere.z == 0)
			{
				_fallSpeed = 0;
			}
			else {
				//_sphere.z = _fallSpeed;
			}
			//trace("sphere(x,y,z)"+"x = "+_sphere.x+" y = "+_sphere.y+" z = "+_sphere.z);
			//_sphere.z += 0.01;
//			// Time of frame
//			var time:int = getTimer();
//			var deltaTime:Number = timeScale*(time - lastTime)/1000;
//			lastTime = time;
//			
			var displacement:Vector3D = new Vector3D();
		
					
			// Fall speed
//			fallSpeed -= 0.5*gravity*deltaTime*deltaTime;
			//			
			var characterCoords:Vector3D = new Vector3D(_sphere.x, _sphere.y, _sphere.z+90);
			
			// Checking of surface under character
			var collisionPoint:Vector3D = new Vector3D();
			var collisionPlane:Vector3D = new Vector3D();
			camera.startTimer();
		
			
			controller.update();	
			
			camera.render(stage3D);
			
		}
		
		
		
		//		重绘窗口相关
		private function onResize(e:Event = null):void {
			// Width and height of view
			camera.view.width = stage.stageWidth;
			camera.view.height = stage.stageHeight;
		}
		
	}
}











