package game.model
{
	import flash.geom.Point;
	
	import game.model.vo.PointVo;
	
	import org.robotlegs.mvcs.Actor;
	
	import qmang2d.loader.LoaderManager;
	
	public class LineModel extends Actor
	{
		public var line1 :Vector.<Vector.<PointVo>>; 
		
		public var line2 :Vector.<Vector.<PointVo>>;
		
		public var line3 :Vector.<Vector.<PointVo>>;
		
		public var line4 :Vector.<Vector.<PointVo>>;
		
		public var line5 :Vector.<Vector.<PointVo>>;
		
		public var line6 :Vector.<Vector.<PointVo>>;
		
		public var line7 :Vector.<Vector.<PointVo>>;
		
		public var line8 :Vector.<Vector.<PointVo>>;
		
		public var line9 :Vector.<Vector.<PointVo>>;
		
		public var line10 :Vector.<Vector.<PointVo>>;
		
		public var line11 :Vector.<Vector.<PointVo>>;
		
		public var line12 :Vector.<Vector.<PointVo>>;
		
		public function LineModel()
		{
			//todo 可以适当考虑将读取配置信息提前
			LoaderManager.getInstance().getXml("res/chapterConfig/chapterLine.xml",initModel);
		}
		
		private function initModel(xml:XML):void
		{
			
			line1 = new Vector.<Vector.<PointVo>>();
			line2 = new Vector.<Vector.<PointVo>>();
			line3 = new Vector.<Vector.<PointVo>>();
			line4 = new Vector.<Vector.<PointVo>>();
			line5 = new Vector.<Vector.<PointVo>>();
			line6 = new Vector.<Vector.<PointVo>>();
			line7 = new Vector.<Vector.<PointVo>>();
			line8 = new Vector.<Vector.<PointVo>>();
			line9 = new Vector.<Vector.<PointVo>>();
			line10 = new Vector.<Vector.<PointVo>>();
			line11 = new Vector.<Vector.<PointVo>>();
			line12 = new Vector.<Vector.<PointVo>>();
			
			line1.push(new Vector.<PointVo>());
			line1.push(new Vector.<PointVo>());
			
			line2.push(new Vector.<PointVo>());
			line2.push(new Vector.<PointVo>());
			
			line3.push(new Vector.<PointVo>());
			line3.push(new Vector.<PointVo>());
			line3.push(new Vector.<PointVo>());
			line3.push(new Vector.<PointVo>());
			
			line4.push(new Vector.<PointVo>());
			line4.push(new Vector.<PointVo>());
			line4.push(new Vector.<PointVo>());
			line4.push(new Vector.<PointVo>());
			
			line5.push(new Vector.<PointVo>());
			line5.push(new Vector.<PointVo>());
			line5.push(new Vector.<PointVo>());
			line5.push(new Vector.<PointVo>());
			line5.push(new Vector.<PointVo>());
			line5.push(new Vector.<PointVo>());
			
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			line6.push(new Vector.<PointVo>());
			
			line7.push(new Vector.<PointVo>());
			line7.push(new Vector.<PointVo>());
			line7.push(new Vector.<PointVo>());
			line7.push(new Vector.<PointVo>());
			line7.push(new Vector.<PointVo>());
			line7.push(new Vector.<PointVo>());
			
			line8.push(new Vector.<PointVo>());
			line8.push(new Vector.<PointVo>());
			line8.push(new Vector.<PointVo>());
			line8.push(new Vector.<PointVo>());
			line8.push(new Vector.<PointVo>());
			line8.push(new Vector.<PointVo>());
			
			line9.push(new Vector.<PointVo>());
			line9.push(new Vector.<PointVo>());
			line9.push(new Vector.<PointVo>());
			line9.push(new Vector.<PointVo>());
			line9.push(new Vector.<PointVo>());
			line9.push(new Vector.<PointVo>());
			
			line10.push(new Vector.<PointVo>());
			line10.push(new Vector.<PointVo>());
			line10.push(new Vector.<PointVo>());
			line10.push(new Vector.<PointVo>());
			line10.push(new Vector.<PointVo>());
			line10.push(new Vector.<PointVo>());
			
			line11.push(new Vector.<PointVo>());
			line11.push(new Vector.<PointVo>());
			line11.push(new Vector.<PointVo>());
			line11.push(new Vector.<PointVo>());
			line11.push(new Vector.<PointVo>());
			line11.push(new Vector.<PointVo>());
			line11.push(new Vector.<PointVo>());
			line11.push(new Vector.<PointVo>());
			
			line12.push(new Vector.<PointVo>());
			line12.push(new Vector.<PointVo>());
			line12.push(new Vector.<PointVo>());
			line12.push(new Vector.<PointVo>());
			line12.push(new Vector.<PointVo>());
			line12.push(new Vector.<PointVo>());
			
			for each (var i:XML in xml.chapter) 
			{
				switch(int(i.@id))//记住一定要int转型，除非在if语句中==比较时，会默认转型。swich，case不支持
				{
					case 1:
					{
						commom(line1,i);
						
						break;
					}
					case 2:
					{
						commom(line2,i);
						break;
					}
					case 3:
					{
						commom(line3,i);
						break;
					}
					case 4:
					{
						commom(line4,i);
						break;
					}
					case 5:
					{
						commom(line5,i);
						break;
					}
					case 6:
					{
						commom(line6,i);
						break;
					}
					case 7:
					{
						commom(line7,i);
						break;
					}
					case 8:
					{
						commom(line8,i);
						break;
					}
					case 9:
					{
						commom(line9,i);
						break;
					}
					case 10:
					{
						commom(line10,i);
						break;
					}
					case 11:
					{
						commom(line11,i);
						break;
					}
					case 12:
					{
						commom(line12,i);
						break;
					}
						
				}
			}
			
		}
		
		private function commom(lines:Vector.<Vector.<PointVo>>, i:XML):void
		{
			var pointVo :PointVo; 
			var id :int;
			for each (var j:XML in i.line) 
			{
				for each (var k:XML in j.point) 
				{
					pointVo = new PointVo(k.@x,k.@y);
					id = j.@id;
					lines[id].push(pointVo);
				}
				
				
			}
			
			
		}
		
		public function changeLine():void
		{
			
		}
		
		
	}
}