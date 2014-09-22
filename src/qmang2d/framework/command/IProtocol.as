package qmang2d.framework.command 
{

	/**
	 *前后台协议接口 
	 * @author panhao
	 * 
	 */	
    public interface IProtocol
	{

		/**
		 *获取前后台每一条信息的id 
		 * @return 
		 * 
		 */		
        function get commandId():uint;

    }
}
