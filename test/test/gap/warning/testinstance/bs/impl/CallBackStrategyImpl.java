/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.testinstance.bs.impl;

import java.util.Map;

import gap.warning.instance.callback.IWarningCallBackStrategy;
import gap.warning.util.WarningUtils;

/**
 * @author maxiao
 *
 */
public class CallBackStrategyImpl implements IWarningCallBackStrategy {

    /* (non-Javadoc)
     * @see gap.warning.instance.callback.IWarningCallBackStrategy#callback()
     */
    public void callback() {
        // TODO Auto-generated method stub
        
        Map map=(Map)WarningUtils.getParam();
        if(map!=null){
        System.out.println("AAAAname====="+map.get("name"));
        System.out.println("AAAAIdentifier====="+map.get("Identifier"));
        }
    }

    /* (non-Javadoc)
     * @see gap.warning.instance.callback.IWarningCallBackStrategy#getMessage()
     */
    public String getMessage() {
        // TODO Auto-generated method stub
        StringBuffer str=new StringBuffer();
        
        Map map=(Map)WarningUtils.getParam();
        if(map!=null){
        str.append("用户："+map.get("name"));
        str.append("即时预警标识："+map.get("Identifier"));
        }
        
        return str.toString();
    }

}
