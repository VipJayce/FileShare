/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd.
 */
package jsonpost;

import java.util.HashMap;
import java.util.Map;

import junit.framework.TestCase;
import net.sf.json.JSONObject;
import rayoo.common.httpclient.HttpUtil;
import rayoo.employeepost.empinfo.employee.action.EmployeeAction;

/**
 * @author maxiao
 *
 */
public class EmployeeActionTest extends TestCase {

    /* (non-Javadoc)
     * @see junit.framework.TestCase#setUp()
     */
    protected void setUp() throws Exception {
	super.setUp();
    }

    /* (non-Javadoc)
     * @see junit.framework.TestCase#tearDown()
     */
    protected void tearDown() throws Exception {
	super.tearDown();
    }

   public void testGetUpdateEmpcode(){
		EmployeeAction employeeAction=new EmployeeAction();
		Map<String,String> postMap = new HashMap<String,String>();
		Map<String,String> result = new HashMap<String,String>();

		postMap.put("number", "5203978");
		postMap.put("emp_name", "赵立测试");
		//postMap.put("id_card_type", arg1);
		//postMap.put("id_card", arg1);
		postMap.put("new_number", "7203978");
		result=employeeAction.getUpdateEmpcode(postMap);
		assertEquals("ok", result.get("reFlag"));
    }

    public void testOutSyncEmpCode(){
    	HttpUtil http = new HttpUtil();
    	String url = "http://10.11.8.25:9999/FAERP/FaerpEmployeeAction.do?cmd=outSyncEmpCode";
    	Map<String,Object> postMap = new HashMap<String,Object>();
    	//postMap.put("cmd", "outSyncEmpCode");
    	postMap.put("post_data", "{\"number\":\"123456\", \"emp_name\":\"yiwenbin\"}");
    	String retjson = HttpUtil.sendSimplePostRequest(url, postMap);
    	JSONObject result = JSONObject.fromObject(retjson);
    	assertEquals("ok", result.getString("success"));

    /*	IntegerComparator comparator=new IntegerComparator();
    	boolean result=comparator.compare("!=", dataValue, threshold);
    	assertEquals(true, result);*/
    }


}
