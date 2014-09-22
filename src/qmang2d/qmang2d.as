
package qmang2d
{
	/**
	 * The namespace used to enclose properties and methods that should only be available within the qmang2d library.
	 * This keeps the public API clean and prevents the calling of methods that should never be called manually.
	 * @author panhao 
	 *<p>version=1.5 final
	 */	
	public namespace qmang2d;
	
	//1.1 增加新功能：(1)基于帧标签的渲染优化;(2)类反射后将mc转换为bitmapMovie渲染
	//1.2 增加新功能：(1)引用deng包压缩，解压包。将自己封装的内库还回引擎;(2)引擎完全不对外部产生任何依赖;(3)渲染支持逆向从后往前渲染播放
	//修正问题：          (1)修正渲染不平稳跳动现象;(2)修正渲染后bitmap位置未知与原生mc不一致问题;
	//1.3 增加新功能: (1)循环播放进行回调函数;(2)循环播放事件派发，不怎么常用，在其它游戏可以关闭此功能;(3)在IPool接口中设置sleep()和wakeUp()方法
	//				 (4)音效管理功能增加@author lql
	//1.4欲增加功能:  (1)基于air环境下了，sqlite数据库数据存储，在cookie里面实现。
	//1.5增加功能         (1)framework引入，通信框架制定，为外部提供优雅的框架编程
	
}