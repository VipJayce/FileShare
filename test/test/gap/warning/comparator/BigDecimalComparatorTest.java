/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.comparator;

import java.math.BigDecimal;

import gap.warning.comparator.impl.BigDecimalComparator;
import gap.warning.util.WarningConstants;
import junit.framework.TestCase;

/**
 * @author maxiao
 *
 */
public class BigDecimalComparatorTest extends TestCase {
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
        BigDecimal dataValue=new BigDecimal("1");
        String threshold="1";
        
        BigDecimalComparator comparator=new BigDecimalComparator();
        boolean result=comparator.compare(WarningConstants.EQUAL, dataValue, threshold);
        assertTrue(result);
        

        dataValue=new BigDecimal("1.072");
        threshold="1.072";
        result=comparator.compare(WarningConstants.EQUAL, dataValue, threshold);
        assertTrue(result);
        
    }
    
    
    public void testIsUnEquivalent(){
        BigDecimal dataValue=new BigDecimal("1.07");
        String threshold="1";
        
        BigDecimalComparator comparator=new BigDecimalComparator();
        boolean result=comparator.compare(WarningConstants.UNEQUAL, dataValue, threshold);
        assertTrue(result);
    }
    
    public void testIsGreaterThan(){
        BigDecimal dataValue=new BigDecimal("1.07");
        String threshold="1";
        
        BigDecimalComparator comparator=new BigDecimalComparator();
        boolean result=comparator.compare(WarningConstants.GREATER, dataValue, threshold);
        assertTrue(result);
    }
    
    public void testIsGreaterThanOrEqual(){
        BigDecimal dataValue=new BigDecimal("1.07");
        String threshold="1.07";
        
        BigDecimalComparator comparator=new BigDecimalComparator();
        boolean result=comparator.compare(WarningConstants.GREATER_OR_EQUAL, dataValue, threshold);
        assertTrue(result);
    }
    
    public void testIsLessThan(){
        BigDecimal dataValue=new BigDecimal("1.01");
        String threshold="1.07";
        
        BigDecimalComparator comparator=new BigDecimalComparator();
        boolean result=comparator.compare(WarningConstants.LESS_THEN, dataValue, threshold);
        assertTrue(result);
    }
    
    public void testIsLessThanOrEqual(){
        BigDecimal dataValue=new BigDecimal("1.07");
        String threshold="1.07";
        
        BigDecimalComparator comparator=new BigDecimalComparator();
        boolean result=comparator.compare(WarningConstants.LESS_OR_EQUAL, dataValue, threshold);
        assertTrue(result);
    }
    
    public void testIsBetween(){
        BigDecimal dataValue=new BigDecimal("1.16");
    String threshold="1.03#3.02";
    
    BigDecimalComparator comparator=new BigDecimalComparator();
    boolean result=comparator.compare(WarningConstants.BETWEEN, dataValue, threshold);
    assertEquals(true, result);
    }

}
