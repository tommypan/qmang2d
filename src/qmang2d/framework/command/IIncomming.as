package  qmang2d.framework.command
{
    import flash.utils.*;

    public interface IIncomming
	{

		/**
		 *填充数据 
		 * @param obj从服务器传来数据被解析后的对象
		 * 
		 */		
        function fill(obj:Object):void;
		
		/**
		 *判断两vo对象是否相等（与java类似） 
		 * @param obj对象
		 * @return 返回true，则相等状态；返回false，则不等状态
		 * 
		 */		
        function equals(obj:Object):Boolean;

    }
}
