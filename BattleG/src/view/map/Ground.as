package view.map
{
	import flash.display3D.Context3D;
	
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.primitives.Plane;
	import alternativa.engine3d.primitives.Box;
	
	/**
	 *场景地面 
	 * @author zhanxuegui
	 * 
	 */
	public class Ground extends Object3D
	{
		private var _plane:Plane;
		
		private var _pillar1:Box;
		private var _pillar2:Box;
		private var _pillar3:Box;
		private var _pillar4:Box;
		private var _pillar5:Box;
		private var _pillar6:Box;
		
		
		public function Ground()
		{
			init();
		}
		
		private function init():void
		{
			
			_plane = new Plane(100000,100000,10,10,true,true,new FillMaterial(0x005600),new FillMaterial());
			
			_pillar1 = new Box(50,50,450,10,1,1,false, new FillMaterial());
			_pillar2 = new Box(100,100,350,10,1,1,false, new FillMaterial(0x0000ff));
			_pillar3 = new Box(100,100,350,10,1,1,false, new FillMaterial(0x00ff00));
			_pillar4 = new Box(100,100,350,10,1,1,false, new FillMaterial(0xff0000));
			_pillar5 = new Box(100,100,350,10,1,1,false, new FillMaterial(0x123456));
			_pillar6 = new Box(100,100,350,10,1,1,false, new FillMaterial(0x654321));
			
			_pillar1.x = 100;
			_pillar1.y = 100;
			
			_pillar2.x = 200;
			_pillar2.y = 3000;
			
			_pillar3.x = -500;
			_pillar3.y = -1000;
			
			_pillar4.x = -100;
			_pillar4.y = 1000;
			
			_pillar5.x = 1000;
			_pillar5.y = -100;
			
			_pillar6.x = -1000;
			_pillar6.y = -900;
			
			
			
			addChild(_pillar1);
			addChild(_pillar2);
			addChild(_pillar3);
			addChild(_pillar4);
			addChild(_pillar5);
			addChild(_pillar6);
			
			
			addChild(_plane);
		}
		public function uploadContext3D(context3D:Context3D):void
		{
			_plane.geometry.upload(context3D);
			_pillar1.geometry.upload(context3D);
			_pillar2.geometry.upload(context3D);
			_pillar3.geometry.upload(context3D);
			_pillar4.geometry.upload(context3D);
			_pillar5.geometry.upload(context3D);
			_pillar6.geometry.upload(context3D);
			
		}
	}
}
import view.map;
