package view.map
{
	import flash.display3D.Context3D;
	
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.primitives.Plane;
	
	/**
	 *场景地面 
	 * @author zhanxuegui
	 * 
	 */
	public class Ground extends Object3D
	{
		private var _plane:Plane;
		public function Ground()
		{
			init();
		}
		
		private function init():void
		{
			
			_plane = new Plane(100000,100000,10,10,true,true,new FillMaterial(0xff0000),new FillMaterial(0xff0000));
			addChild(_plane);
		}
		public function uploadContext3D(context3D:Context3D):void
		{
			_plane.geometry.upload(context3D);
		}
		
	}
}
import view.map;

