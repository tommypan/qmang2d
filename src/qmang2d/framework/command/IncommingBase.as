package  qmang2d.framework.command 
{
    import flash.utils.*;
    
    import qmang2d.framework.command.CommandBase;
    import qmang2d.framework.command.IIncomming;
    
    
	/**
	 *SCMD应被继承的父类，fill方法应被重写 
	 * @author panhao
	 * 
	 */
    public class IncommingBase extends CommandBase implements IIncomming
	{

        public function IncommingBase(id1:uint)
		{
            super(id1);
        }
		
		/**
		 *填充数据 
		 * @param obj从服务器传来数据被解析后的对象
		 * 
		 */	
        public function fill(obj:Object):void
		{
        }
		
		/**
		 *判断两vo对象是否相等（与java类似） 
		 * @param obj对象
		 * @return 返回true，则相等状态；返回false，则不等状态
		 * 
		 */	
        public function equals(obj:Object):Boolean
		{
			var type:*;
			
			if (!(obj is IncommingBase))
				return (false)
			
			var thisXml:XML = describeType(this);
			var objXml:XML = describeType(obj);
			
			if (thisXml.@name != objXml.@name)
				return (false);
			
			for each (type in thisXml.variable) 
			{
				
				
				if (this[type.@name.toString()] != obj[type.@name.toString()])
					return (false);
			}
			return (true);
        }

    }
}
