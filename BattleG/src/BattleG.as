/**
 *
 
 
 绝地求生大逃杀简易版 - 学习3D引擎的demo
 
 
 一、学习目标
 1、了解基础的3D坐标系 2、3D模型加载使用控制 3、3D的碰撞以及简单的几何运算 4、了解3D相关灯光，场景，模型结构。
 
 二、demo名《刺激战场简化版》
 1、拥有人物，枪支，场景 2、简单的枪战 3、10分钟内结束。
 
 阶段一
 场景构建，人物角色构建（数据，控制，管理类） 构建基础逻辑
 
 
 */


package  {
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.media.Camera;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
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
	
	import view.map.Ground;
	
	/**
	 * Alternativa3D complete demo.
	 */
	
	
	public class BattleG extends Sprite {
		
		
		
		private var stage3D:Stage3D;
		
		private var scene:Object3D = new Object3D();
		private var camera:Camera3D;
		private var controller:SimpleObjectController;
		
		private var heartbeat:Timer = new Timer(100); 
		
		
		private var _sphere1:GeoSphere = new GeoSphere(30, 3, false, new FillMaterial(0xFFFF00, 0.85));
		private var _sphere2:GeoSphere = new GeoSphere(30, 3, false, new FillMaterial(0x0099AA, 0.85));
		private var _sphere3:GeoSphere = new GeoSphere(30, 3, false, new FillMaterial(0x0099AA, 0.85));
		
		
		
		public function BattleG() {
			stage.scaleMode = StageScaleMode.NO_SCALE;//缩放模式的值
			stage.align = StageAlign.TOP_LEFT;
			
			stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, init);
			stage3D.requestContext3D(Context3DRenderMode.SOFTWARE);
			
						
						//Start the heartbeat timer 
			heartbeat.addEventListener( TimerEvent.TIMER, onHeartbeat ); 
			heartbeat.start(); 
			
			
			
			
			
			
		}
		
		
		
		private function onHeartbeat( event:TimerEvent ):void 
		{ 
			//handle heartbeat event 
			
			//			var time:int = Math.random()*100;
			//			trace("----"+time%3+"----------"+time);
			//			
			//			_sphere2.x += rand[time%3]*10;
			//			_sphere2.y += rand[time%3]*10;
			//			
			//			_sphere3.x -= rand[time%3]*10;
			//			_sphere3.y += rand[time%3]*10;
			
			_sphere2.x += 1;
			_sphere2.y += 1;
			
			if(_sphere2.x > 1000)
			{
				_sphere2.y--;
				
				if(_sphere2.y < 500)
				{
					_sphere2.x--;
					
					if(_sphere2.x <500)
					{
						_sphere2.x++;
						_sphere2.y++;
					}
				}
			}
			
			_sphere3.x -= 1;
			_sphere3.y += 2;
			
			
		} 
		
		
		
		private function init(e:Event):void {
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
			
			//			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			
			scene.addChild(camera);
			
			
			//			角色
			_sphere1.mouseEnabled = false;
			_sphere1.geometry.upload(stage3D.context3D);
			scene.addChild(_sphere1);
			
			//		           机器人
			
			_sphere2.x = 50;
			_sphere2.y = 50;
			_sphere2.mouseEnabled = false;
			_sphere2.geometry.upload(stage3D.context3D);
			scene.addChild(_sphere2);
			
			//		           机器人	
			_sphere3.x = 50;
			_sphere3.y = 50;
			_sphere3.mouseEnabled = false;
			_sphere3.geometry.upload(stage3D.context3D);
			scene.addChild(_sphere3);
			
			var ground:Ground = new Ground();
			ground.uploadContext3D(stage3D.context3D);
			scene.addChild(ground);
			
			
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.RESIZE, onResize);
			
		}
		
		
		private var _speed:Number = 10;
		private var _keyDic:Dictionary = new Dictionary();			
		
		//		protected function onKeyDown(e:KeyboardEvent):void
		//		{
		//			_keyDic[e.keyCode] = true;
		//			switch(e.keyCode)
		//			{
		//				case Keyboard.A:
		//					if(_keyDic[Keyboard.W])
		//					{
		//						_sphere1.x -= _speed*0.5;
		//						_sphere1.y += _speed*0.5;
		//						trace("球的位置",_sphere1.x,_sphere1.y);
		//					}
		//					else
		//					{
		//						_sphere1.x -= _speed;
		//					}
		//					break;
		//				case Keyboard.S:
		//					_sphere1.y -= _speed;
		//					break;
		//				case Keyboard.D:
		//					_sphere1.x += _speed;
		//					break;
		//				case Keyboard.W:
		//					_sphere1.y += _speed;
		//					break;
		//				default:
		//					break;
		//			}
		//			
		//		}
		
		
		private function onEnterFrame(e:Event):void {
			
			
			controller.update();	
			camera.render(stage3D);
			
		}	
		
		//		重绘窗口相关
		private function onResize(e:Event = null):void {
			
			camera.view.width = stage.stageWidth;
			camera.view.height = stage.stageHeight;
		}
		
	}
}