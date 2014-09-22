package  qmang2d.utils {
    import flash.net.*;

	/**
	 *调用虚拟机的垃圾清理，当然只有在必要的 时候使用，比如切换场景，地图等。这个只是人为控制gc，跟其能不能回收没有关系
	 */	
    public function gc():void{
        try {
            new LocalConnection().connect("gc");
            new LocalConnection().connect("gc");
        } catch(e:Error) {
			
        }
		
    }
} 
