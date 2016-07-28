/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.testinstance.bs.impl;

import test.gap.warning.testinstance.bs.ITestInstanceBs;
import venus.frames.mainframe.util.Helper;
import gap.commons.testcase.BaseGapTest;

/**
 * @author maxiao
 *
 */
public class TestInstance extends BaseGapTest {
    ITestInstanceBs bs=null;
    
    /* (non-Javadoc)
     * @see junit.framework.TestCase#setUp()
     */
    protected void setUp() throws Exception {
        super.setUp();
        bs=(ITestInstanceBs) Helper.getBean("testBS");
        
    }

    /* (non-Javadoc)
     * @see junit.framework.TestCase#tearDown()
     */
    protected void tearDown() throws Exception {
        super.tearDown();
    }

    
    public void testaaaa(){
        bs.getString();
    }
}
