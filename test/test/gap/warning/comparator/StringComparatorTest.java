/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.comparator;

import gap.warning.comparator.impl.StringComparator;
import junit.framework.TestCase;

/**
 * @author maxiao
 *
 */
public class StringComparatorTest extends TestCase {

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
    
    public void testIsEquivalent(){
	String dataValue="maxiao";
	String threshold="maxiao";
	
	StringComparator comparator=new StringComparator();
	boolean result=comparator.compare("=", dataValue, threshold);
	assertEquals(true, result);
	
	dataValue="xiajinxin";
	result=comparator.compare("==", dataValue, threshold);
	assertEquals(false, result);
	
    }
    
    public void testIsUnEquivalent(){
	String dataValue="maxiao";
	String threshold="maxiao";
	
	StringComparator comparator=new StringComparator();
	boolean result=comparator.compare("!=", dataValue, threshold);
	assertEquals(false, result);
	
	dataValue="xiajinxin";
	result=comparator.compare("!=", dataValue, threshold);
	assertEquals(true, result);
    }

}
