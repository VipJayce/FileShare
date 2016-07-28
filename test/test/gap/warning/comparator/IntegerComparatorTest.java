/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.comparator;

import gap.warning.comparator.impl.IntegerComparator;
import junit.framework.TestCase;

/**
 * @author maxiao
 *
 */
public class IntegerComparatorTest extends TestCase {

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
	Integer dataValue=new Integer("1");
	String threshold="1";
	
	IntegerComparator comparator=new IntegerComparator();
	boolean result=comparator.compare("==", dataValue, threshold);
	assertEquals(true, result);
    }
    
    public void testIsUnEquivalent(){
	Integer dataValue=new Integer("1");
	String threshold="2";
	
	IntegerComparator comparator=new IntegerComparator();
	boolean result=comparator.compare("!=", dataValue, threshold);
	assertEquals(true, result);
    }
    
    public void testIsGreaterThan(){
	Integer dataValue=new Integer("3");
	String threshold="1";
	
	IntegerComparator comparator=new IntegerComparator();
	boolean result=comparator.compare(">", dataValue, threshold);
	assertEquals(true, result);
    }
    
    public void testIsGreaterThanOrEqual(){
	Integer dataValue=new Integer("3");
	String threshold="1";
	
	IntegerComparator comparator=new IntegerComparator();
	boolean result=comparator.compare(">=", dataValue, threshold);
	assertEquals(true, result);
    }
    
    public void testIsLessThan(){
	Integer dataValue=new Integer("1");
	String threshold="3";
	
	IntegerComparator comparator=new IntegerComparator();
	boolean result=comparator.compare("<", dataValue, threshold);
	assertEquals(true, result);
    }
    
    public void testIsLessThanOrEqual(){
	Integer dataValue=new Integer("1");
	String threshold="3";
	
	IntegerComparator comparator=new IntegerComparator();
	boolean result=comparator.compare("<=", dataValue, threshold);
	assertEquals(true, result);
    }
    
    public void testIsBetween(){
	Integer dataValue=new Integer("1");
	String threshold="1#3";
	
	IntegerComparator comparator=new IntegerComparator();
	boolean result=comparator.compare("<>", dataValue, threshold);
	assertEquals(true, result);
    }
    
}
