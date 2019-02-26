///**
// * This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
// * If it is not possible or desirable to put the notice in a particular file, then You may include the notice in a location (such as a LICENSE file in a relevant directory) where a recipient would be likely to look for such a notice.
// * You may add additional accurate notices of copyright ownership.
// *
// * It is desirable to notify that Covered Software was "Powered by AlternativaPlatform" with link to http://www.alternativaplatform.com/ 
// * */
//
//package {
//	
//	import alternativa.engine3d.animation.AnimationClip;
//	import alternativa.engine3d.animation.AnimationController;
//	import alternativa.engine3d.animation.AnimationSwitcher;
//	import alternativa.engine3d.collisions.EllipsoidCollider;
//	import alternativa.engine3d.controllers.SimpleObjectController;
//	import alternativa.engine3d.core.Camera3D;
//	import alternativa.engine3d.core.Object3D;
//	import alternativa.engine3d.core.View;
//	import alternativa.engine3d.core.events.MouseEvent3D;
//	import alternativa.engine3d.loaders.ParserCollada;
//	import alternativa.engine3d.materials.FillMaterial;
//	import alternativa.engine3d.materials.TextureMaterial;
//	import alternativa.engine3d.objects.Mesh;
//	import alternativa.engine3d.objects.Skin;
//	import alternativa.engine3d.primitives.GeoSphere;
//	import alternativa.engine3d.resources.BitmapTextureResource;
//	
//	import flash.display.Sprite;
//	import flash.display.Stage3D;
//	import flash.display.StageAlign;
//	import flash.display.StageScaleMode;
//	import flash.display3D.Context3DRenderMode;
//	
////	添加的键盘输入包
////	import flash.events.KeyboardEvent;
//	
//	import flash.events.Event;
//	import flash.geom.Vector3D;
//	import flash.utils.getTimer;
//	
//	/**
//	 * Alternativa3D complete demo.
//	 * Пример создания демо сцены.
//	 */
//	public class battleplaygroud extends Sprite {
//		
//		[Embed("level.DAE", mimeType="application/octet-stream")] static private const LevelModel:Class;
//		[Embed(source="level.jpg")] static private const LevelTexture:Class;
//		
//		[Embed("character.DAE", mimeType="application/octet-stream")] static private const CharacterModel:Class;
//		[Embed(source="character.jpg")] static private const CharacterTexture:Class;
////		3D舞台对象
//		private var stage3D:Stage3D;
//		
//		
////		场景
//		private var scene:Object3D = new Object3D();
////		摄像头
//		private var camera:Camera3D;
////		控制器
//		private var controller:SimpleObjectController;
//		
//		private var level:Mesh;
////		皮肤
//		private var character:Skin;
////		动画控制器
//		private var animationController:AnimationController = new AnimationController();
////		动画切换器
//		private var animationSwitcher:AnimationSwitcher = new AnimationSwitcher();
////	           人物的停止动画
//		private var idle:AnimationClip;
////		人物跑的动画
//		private var run:AnimationClip;
////		目标，即新的位置
//		private var target:Vector3D;
//		
//
////		球
//		private var sphere:GeoSphere = new GeoSphere(10, 3, false, new FillMaterial(0xFFFF00, 0.85));
//			
//		//椭球体碰撞器
//		private var collider:EllipsoidCollider = new EllipsoidCollider(50, 50, 90);
////		重力
//		private var gravity:Number = 9800;
////		坠落速度
//		private var fallSpeed:Number = 0;
//		
//		private var lastTime:int;
//		
//		private var timeScale:Number = 0.7;
////		构造函数
//		public function battleplaygroud() {
//			
//			trace("94 battleplaygroud\n");
//			
//			stage.scaleMode = StageScaleMode.NO_SCALE;
//			stage.align = StageAlign.TOP_LEFT;
//			
//			stage3D = stage.stage3Ds[0];
//			stage3D.addEventListener(Event.CONTEXT3D_CREATE, init);
//			stage3D.requestContext3D(Context3DRenderMode.SOFTWARE);
//			
//			
//			trace("104 battleplaygroud\n");
//		}
////		初始化函数
//
//		private function init(e:Event):void {
//			trace("init\n\n");
//			
//			
//			// Camera and view
//			// Создание камеры и вьюпорта
//			camera = new Camera3D(10, 1000);
//			camera.view = new View(stage.stageWidth, stage.stageHeight);
//			camera.view.antiAlias = 4;
////			camera.lookAt(10,20,20);
//			
//			addChild(camera.view);
//			addChild(camera.diagram);
//			
//			
//			// Initial position
//			// Установка начального положения камеры
////			人物的初始位置
////			camera.rotationX = -120*Math.PI/180;
//			camera.rotationX = 45;
//			camera.y = 500;
//			camera.z = 200;
//				
//			controller = new SimpleObjectController(stage, camera, 500, 2);
//			
//			
//			scene.addChild(camera);
//			
//			sphere.mouseEnabled = false;
//			sphere.geometry.upload(stage3D.context3D);
//			scene.addChild(sphere);
//			
//			// Parser of level
//			// Парсер уровня
//			var levelParser:ParserCollada = new ParserCollada();
//			levelParser.parse(XML(new LevelModel()));
//			level = levelParser.getObjectByName("level") as Mesh;
//			var levelResource:BitmapTextureResource = new BitmapTextureResource(new LevelTexture().bitmapData);
//			var levelMaterial:TextureMaterial = new TextureMaterial(levelResource);
//			level.setMaterialToAllSurfaces(levelMaterial);
//			scene.addChild(level);
//			// Upload
//			levelResource.upload(stage3D.context3D);
//			level.geometry.upload(stage3D.context3D);
//			
//			// Adding double click listener
//			// Подписка уровня на двойной клик
//			level.useHandCursor = true;
//			level.doubleClickEnabled = true;			
//			level.addEventListener(MouseEvent3D.CLICK, onDoubleClick);
////			level.addEventListener(KeyboardEvent.KEY_UP, onHandler);
//			
//			// Parser of character
//			// Парсер персонажа
//			var characterParser:ParserCollada = new ParserCollada();
//			characterParser.parse(XML(new CharacterModel()));
//			character = characterParser.getObjectByName("character") as Skin;
//			var characterResource:BitmapTextureResource = new BitmapTextureResource(new CharacterTexture().bitmapData);
//			var characterMaterial:TextureMaterial = new TextureMaterial(characterResource);
//			character.setMaterialToAllSurfaces(characterMaterial);
//			scene.addChild(character);
//			// Upload
//			characterResource.upload(stage3D.context3D);
//			character.geometry.upload(stage3D.context3D);
//			
//			character.mouseEnabled = false;
//			
//			
//			
//			
//			
//			// Character animation
//			// Анимация персонажа
////			人物动画
//			var animation:AnimationClip = characterParser.getAnimationByObject(character);
//			
//			// Slice of animation
//			// Разбиение анимации
////			动画片断，参数起始时间 
//			idle = animation.slice(0, 40/30);
//			run = animation.slice(41/30, 61/30);
//			
//			// Adding 
//			// Добавление анимаций
////			添加新的动画
//			animationSwitcher.addAnimation(idle);
//			animationSwitcher.addAnimation(run);
//			
//			// Running
//			// Запуск анимации
////			激活动画
//			animationSwitcher.activate(idle, 0.1);
//			animationSwitcher.speed = timeScale;
//			
//			animationController.root = animationSwitcher;
//			
//			// Listeners
//			// Подписка на события
////			注册监听器
//			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
//			stage.addEventListener(Event.RESIZE, onResize);
//			
//			lastTime = getTimer();
//		}
//		
//		private function onDoubleClick(e:MouseEvent3D):void {
//			
//			trace("onDoubleClick\n");
//			target = (e.target as Object3D).localToGlobal(new Vector3D(e.localX, e.localY, e.localZ));
//			
//			
////			调试信息
//			trace("x = "+target.x+"\ty = "+target.y+"\tz = "+target.z);
//		}
////		private function onHandler(event:KeyboardEvent):void {			
////			trace("test");
////			target.z += 1;
////			//target = (e.target as Object3D).localToGlobal(new Vector3D(e.localX, e.localY, e.localZ));
////		}
//		
//		private function onEnterFrame(e:Event):void {
//			// Time of frame
//			// Время кадра
//			var time:int = getTimer();
//			
////			打印时间
//			trace("get time \t"+time+"-----------------------\n");
//			
//			
//			var deltaTime:Number = timeScale*(time - lastTime)/1000;
//			lastTime = time;
//			
//			var displacement:Vector3D = new Vector3D();
//			
////			判断球是否发生位移
//			if (target != null) {
//				// Sphere moving
//				// Перемещение сферы
//				
////				更新球的坐标
//				sphere.x += (target.x - sphere.x)*0.3;
//				sphere.y += (target.y - sphere.y)*0.3;
//				sphere.z += (target.z - sphere.z)*0.3;
//				// Direction of character
//				// Расчёт направления движения персонажа
//				
////				人物的位移
//				displacement.x = target.x - character.x;
//				displacement.y = target.y - character.y;
//				
////				判断是否需要移动人物，如果不需要则使用idle，需要则使用run
//				if (displacement.length > 15) {
//					
////					确定人物的移动方向
//					character.rotationZ = Math.atan2(displacement.x, -displacement.y);
//					displacement.scaleBy(deltaTime*600/displacement.length);
//					
////					激活动画run			
//					trace("激活动画run\n");
//					animationSwitcher.activate(run, 0.1);
//				} else {
//					target = null;
////					激活动画idle
//					trace("激活动画idle\n");
//					animationSwitcher.activate(idle, 0.1);
//				}
//			}
//			
//			// Fall speed
//			// Скорость падения
////			人物掉落速度计算公式
//			fallSpeed -= 0.5*gravity*deltaTime*deltaTime;
//			
////			获取最新的人物坐标
//			var characterCoords:Vector3D = new Vector3D(character.x, character.y, character.z + 90);
//			
//			// Checking of surface under character
//			// Проверка поверхности под персонажем
//			var collisionPoint:Vector3D = new Vector3D();
//			var collisionPlane:Vector3D = new Vector3D();
//			
//			
//			camera.startTimer();
////			计算人物是否着陆，如果着陆则下落速度为0
//			var onGround:Boolean = collider.getCollision(characterCoords, new Vector3D(0, 0, fallSpeed), collisionPoint, collisionPlane, level);
//			if (onGround && collisionPlane.z > 0.5) {
//				
//				trace("着陆\n");
//				fallSpeed = 0;
//			} else {
//				trace("自由落体\n");
//				displacement.z = fallSpeed;
//			}
//			
//			// Collision detection
//			// Проверка препятствий
////			计算目标距离大小
//			var destination:Vector3D = collider.calculateDestination(characterCoords, displacement, level);
//			
//			camera.stopTimer();
//			
////			更新人物的坐标
//					
//			character.x = destination.x;
//			character.y = destination.y;
//			character.z = destination.z - 90;
//				
//			trace("onEnterFrame end\n");
////			播放动画
//			animationController.update();
//			
////			计算新的位置
//			
//			controller.update();
//			
////			3D渲染
//			camera.render(stage3D);
//		}
//		
////		重新绘制窗口
//		private function onResize(e:Event = null):void {
//			// Width and height of view
//			// Установка ширины и высоты вьюпорта
//			camera.view.width = stage.stageWidth;
//			camera.view.height = stage.stageHeight;
//			
//			
//		}
//		
//	}
//}



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
		
		
		/**
		 *add code
		 */
		//		private var character_controller:SimpleObjectController;
		
		//		private var animationController:AnimationController = new AnimationController();
		//		private var animationSwitcher:AnimationSwitcher = new AnimationSwitcher();
		//		private var idle:AnimationClip;
		//		private var run:AnimationClip;
		
		//		private var target:Vector3D;
		private var _sphere:GeoSphere = new GeoSphere(10, 3, false, new FillMaterial(0xFFFF00, 0.85));
		
		
		
		
		//		添加两个球
		//		private var sphere1:GeoSphere = new GeoSphere(10, 3, false, new FillMaterial(0xFFFF00, 0.85));
		//		private var sphere2:GeoSphere = new GeoSphere(10, 3, false, new FillMaterial(0xFFFF00, 0.85));
		
		private var collider:EllipsoidCollider = new EllipsoidCollider(50, 50, 90);
		
		private var gravity:Number = 9800;
		private var fallSpeed:Number = 0;
		
		private var lastTime:int;
		
		private var timeScale:Number = 0.7;
		
		
		private var sprite:AnimSprite;
		
		
		
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
			
			// Initial position
			
			//			摄像头的起始位置
			camera.rotationX = -120*Math.PI/180;
			camera.y = -500;
			camera.z = 250;
			camera.lookAt(0,0,0);
			
			
			controller = new SimpleObjectController(stage, camera, 500, 2);
			controller.disable();
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			//			controller = new SimpleObjectController(stage, character, 500, 1);
			//			controller.disable();
			
			
			//			控制球的移动，如果是这种情况只能控制一个球
			//			character_controller = new SimpleObjectController(stage, sphere, 400, 1);
			
			//			character_controller = new SimpleObjectController(stage, sphere1, 400, 1);
			//			character_controller = new SimpleObjectController(stage, sphere2, 400, 1);
			//			character_controller.moveLeft(true);
			
			//			add code
			//			控制人物的移动
			//			character_controller = new SimpleObjectController(stage, character, 500, 2);
			
			//			character_controller.object = character;
			//			character_controller.enable();
			//			character_controller.moveForward(true);
			
			//			controller.moveBack(true);			
			scene.addChild(camera);
			
			_sphere.mouseEnabled = false;
			_sphere.geometry.upload(stage3D.context3D);
			scene.addChild(_sphere);
			
			var ground:Ground = new Ground();
			ground.uploadContext3D(stage3D.context3D);
			scene.addChild(ground);
			
			//			sphere1.mouseEnabled = false;
			//			sphere1.x = -100;
			//			sphere1.y = 100;
			//			sphere1.geometry.upload(stage3D.context3D);
			//			scene.addChild(sphere1);
			//			
			//			
			//			sphere2.mouseEnabled = false;
			//			sphere2.x = 100;
			//			sphere2.y = -500;
			//			sphere2.z = 1000;
			//			sphere2.geometry.upload(stage3D.context3D);
			//			scene.addChild(sphere2);
			
			
			
			
			trace("sphere(x,y,z)"+"x = "+_sphere.x+" y = "+_sphere.y+" z = "+_sphere.z);
			
			
			//			加载外部资源相关
			
			
			//			 Parser of level
			//			var levelParser:ParserCollada = new ParserCollada();
			//			levelParser.parse(XML(new LevelModel()));
			//			level = levelParser.getObjectByName("level") as Mesh;
			//			var levelResource:BitmapTextureResource = new BitmapTextureResource(new LevelTexture().bitmapData);
			//			var levelMaterial:TextureMaterial = new TextureMaterial(levelResource);
			//			level.setMaterialToAllSurfaces(levelMaterial);
			//			scene.addChild(level);
			//			
			//			
			//			// Upload   设置为可见
			//			levelResource.upload(stage3D.context3D);
			//			level.geometry.upload(stage3D.context3D);
			//			
			//			// Adding double click listener
			//			level.useHandCursor = true;
			//			level.doubleClickEnabled = true;
			////			
			//			
			//			
			//			// Frames
			//			// Создание кадров
			//			var phases:BitmapData = new EmbedTexture().bitmapData;
			//			var materials:Vector.<Material> = new Vector.<Material>();
			//			for (var i:int = 0; i < phases.width; i += 128) {
			//				var bmp:BitmapData = new BitmapData(128, 128, true, 0);
			//				bmp.copyPixels(phases, new Rectangle(i, 0, 128, 128), new Point());
			//				materials.push(new TextureMaterial(new BitmapTextureResource(bmp)));
			//			}
			//			
			//			// Creation of sprite
			//			// Создание спрайта
			//			sprite = new AnimSprite(100, 100, materials, true);
			//			scene.addChild(sprite);
			//			level.addEventListener(MouseEvent3D.DOUBLE_CLICK, onDoubleClick);
			
			//			add code
			//			level.addEventListener(MouseEvent3D.DOUBLE_CLICK, onDoubleClick);
			
			
			// Parser of character
			//			var characterParser:ParserCollada = new ParserCollada();
			//			characterParser.parse(XML(new CharacterModel()));
			//			character = characterParser.getObjectByName("character") as Skin;
			//			var characterResource:BitmapTextureResource = new BitmapTextureResource(new CharacterTexture().bitmapData);
			//			var characterMaterial:TextureMaterial = new TextureMaterial(characterResource);
			//			character.setMaterialToAllSurfaces(characterMaterial);
			//			scene.addChild(character);
			//			trace("character,y,z)"+"x = "+character.x+" y = "+character.y+" z = "+character.z);			
			
			
			//			// Upload  设置为可见
			//			characterResource.upload(stage3D.context3D);
			//			character.geometry.upload(stage3D.context3D);
			//			
			//			character.mouseEnabled = false;
			//			
			
			
			
			//			动画相关
			
			// Character animation
			//			var animation:AnimationClip = characterParser.getAnimationByObject(character);
			//			
			//			// Slice of animation
			//			idle = animation.slice(0, 40/30);
			//			run = animation.slice(41/30, 61/30);
			//			
			//			// Adding 
			//			animationSwitcher.addAnimation(idle);
			//			animationSwitcher.addAnimation(run);
			//			
			//			// Running
			//			animationSwitcher.activate(idle, 0.1);
			//			animationSwitcher.speed = timeScale;
			//			
			//			animationController.root = animationSwitcher;
			//			
			
			//			事件侦听相关
			// Listeners
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.RESIZE, onResize);
			
			
			
			//			添加键盘控制
			//			stage.addEventListener(KeyboardEvent.KEY_DOWN, on_Key_Down);
			//			stage.addEventListener(KeyboardEvent.KEY_UP, on_Key_Up);
			
			//			lastTime = getTimer();
		}
		private var _speed:Number = 10;
		private var _keyDic:Dictionary = new Dictionary();
		
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
						trace("球的位置",_sphere.x,_sphere.y);
					}
					else
					{
						_sphere.x -= _speed;
					}
					break;
				case Keyboard.S:
					_sphere.y -= _speed;
					break;
				case Keyboard.D:
					_sphere.x += _speed;
					break;
				case Keyboard.W:
					_sphere.y += _speed;
					break;
				default:
					break;
			}
			
		}
		
		//		private function onDoubleClick(e:MouseEvent3D):void {
		//			
		//			trace("double click sphere(x,y,z)"+"x = "+sphere.x+" y = "+sphere.y+" z = "+sphere.z);
		//			target = (e.target as Object3D).localToGlobal(new Vector3D(e.localX, e.localY, e.localZ));
		//		}
		
		
		
		//		private function on_Key_Down(e:KeyboardEvent):void {
		//			//target = (e.target as Object3D).localToGlobal(new Vector3D(e.localX, e.localY, e.localZ));
		//		}
		
		
		
		
		
		
		
		private function onEnterFrame(e:Event):void {
			
			//			var dis:Number = 
			//			_sphere.
			
			
			// Time of frame
			var time:int = getTimer();
			var deltaTime:Number = timeScale*(time - lastTime)/1000;
			lastTime = time;
			
			var displacement:Vector3D = new Vector3D();
			//			if (target != null) {
			//				// Sphere moving
			//				// Перемещение сферы
			//				sphere.x += (target.x - sphere.x)*0.3;
			//				sphere.y += (target.y - sphere.y)*0.3;
			//				sphere.z += (target.z - sphere.z)*0.3;
			//				// Direction of character
			//				// Расчёт направления движения персонажа
			//				displacement.x = target.x - character.x;
			//				displacement.y = target.y - character.y;
			//				if (displacement.length > 15) {
			//					character.rotationZ = Math.atan2(displacement.x, -displacement.y);
			//					displacement.scaleBy(deltaTime*600/displacement.length);
			//					animationSwitcher.activate(run, 0.1);
			//				} else {
			//					target = null;
			//					animationSwitcher.activate(idle, 0.1);
			//				}
			//			}
			//			
			// Fall speed
			fallSpeed -= 0.5*gravity*deltaTime*deltaTime;
			//			
			var characterCoords:Vector3D = new Vector3D(_sphere.x, _sphere.y, _sphere.z+90);
			
			// Checking of surface under character
			var collisionPoint:Vector3D = new Vector3D();
			var collisionPlane:Vector3D = new Vector3D();
			camera.startTimer();
			//			var onGround:Boolean = collider.getCollision(characterCoords, new Vector3D(0.1,0.1, 0.1), collisionPoint, collisionPlane, level);
			//			if (onGround) {
			//				trace("发生碰撞 \n");
			//				
			//				
			//				collider.threshold = 0;
			////				sphere.x = characterCoords.x;
			////				sphere.y = characterCoords.y;
			////				sphere.z = characterCoords.z;
			//				
			//				
			//			} else {
			//				_sphere.z = fallSpeed;
			//				trace("没发生碰撞    \n");
			//			}
			//			
			//			// Collision detection
			//			var destination:Vector3D = collider.calculateDestination(characterCoords, displacement, level);
			////			var bound:Boolean = collider.calculateDestination(characterCoords, displacement, level);
			//			
			//			
			////			打印调试信息
			//			trace("destination = "+ destination.x+"   "+destination.y+"         " +
			//				"           "+destination.z+" destination length = "+destination.length);
			//			
			//			
			//			
			//			
			//			
			//			camera.stopTimer();
			////			
			////			
			//			_sphere.x = destination.x;
			//			_sphere.y = destination.y;
			//			_sphere.z = destination.z - 90;
			//			
			//			trace("after moving character(x,y,z)"+"x = "+character.x+" y = "+character.y+" z = "+character.z);
			//			
			//			animationController.update();
			
			controller.update();
			//			character_controller.update();
			
			camera.render(stage3D);
			
		}
		
		
		
		//		重绘窗口相关
		private function onResize(e:Event = null):void {
			// Width and height of view
			// Установка ширины и высоты вьюпорта
			camera.view.width = stage.stageWidth;
			camera.view.height = stage.stageHeight;
		}
		
	}
}











