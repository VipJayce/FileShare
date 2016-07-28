/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.comparator;

import gap.warning.comparator.impl.DateComparator;
import gap.warning.util.WarningConstants;

import java.text.ParseException;
import java.util.Date;

import junit.framework.TestCase;

/**
 * @author maxiao
 *
 */
public class DateComparatorTestCase extends TestCase {

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
        Date dataValue=null;
        try {
            dataValue = WarningConstants.DATE_FORMAT.parse("2008-6-29");
        } catch (ParseException e) {
            e.printStackTrace();
            fail();
        }
        String threshold="2008-6-29";
        
        DateComparator comparator=new DateComparator();
        boolean result=comparator.compare(WarningConstants.EQUAL, dataValue, threshold);
        assertTrue(result);

    }
    
    public void testIsGreaterThanOrEqual(){
        Date dataValue=null;
        try {
            dataValue = WarningConstants.DATE_FORMAT.parse("2008-6-29");
        } catch (ParseException e) {
            e.printStackTrace();
            fail();
        }
        String threshold="2008-6-29";
        
        DateComparator comparator=new DateComparator();
        boolean result=comparator.compare(WarningConstants.BEGIN, dataValue, threshold);
        assertTrue(result);

    }
    
    
    public void testIsLessThanOrEqual(){
        Date dataValue=null;
        try {
            dataValue = WarningConstants.DATE_FORMAT.parse("2008-6-29");
        } catch (ParseException e) {
            e.printStackTrace();
            fail();
        }
        String threshold="2008-6-29";
        
        DateComparator comparator=new DateComparator();
        boolean result=comparator.compare(WarningConstants.END, dataValue, threshold);
        assertTrue(result);

    }
    
    public void testIsBetween(){
        Date dataValue=null;
        try {
            dataValue = WarningConstants.DATE_FORMAT.parse("2008-6-29");
        } catch (ParseException e) {
            e.printStackTrace();
            fail();
        }
        String threshold="2008-6-29#2008-7-1";
        
        DateComparator comparator=new DateComparator();
        boolean result=comparator.compare(WarningConstants.BETWEEN, dataValue, threshold);
        assertTrue(result);

    }
    

}
