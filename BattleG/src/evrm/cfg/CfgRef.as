package evrm.cfg
{
	import flash.utils.getTimer;

	public class CfgRef
	{
		private var _gravity:Number;
		private var _fallSpeed:Number;
		
		private var _time:Number;
		private var _lastTime:Number;
		private var _timeScale:Number;
		private var _detelTime:Number;
		public function CfgRef()
		{
			_gravity = 9800;
			_timeScale = 0.7;
			
			//getDetelTime();
			
		}
		
		public function getDetelTime():Number
		{
			_time = getTimer();
			
			_detelTime = _timeScale* (_time - _lastTime)/1000;			
			_lastTime = _time;

			return _detelTime;
		}
		
		public function getFallSpeed():Number
		{
			getDetelTime();
			//trace("t"+_time+"dt"+_detelTime+"lt"+_lastTime+"ts"+_timeScale);
			 _fallSpeed = 0.5 * _gravity * _detelTime *_detelTime;
			 trace("fallsp="+_fallSpeed,"gravity="+_gravity,"delt="+_detelTime);
			 return _fallSpeed;
		}
		
		public function speed():Number
		{
			return _timeScale;
		}
	}
}