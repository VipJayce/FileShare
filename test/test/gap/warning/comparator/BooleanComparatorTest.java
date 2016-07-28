/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.comparator;

import gap.warning.comparator.impl.BooleanComparator;
import gap.warning.util.WarningConstants;
import junit.framework.TestCase;

/**
 * @author guopeng2
 *
 */
public class BooleanComparatorTest extends TestCase {
    BooleanComparator comparator = null;
    protected void setUp() throws Exception {
        super.setUp();
        comparator = new BooleanComparator();
    }

    protected void tearDown() throws Exception {
        comparator = null;
        super.tearDown();
    }
    
    public void testIsTrue1(){
        Boolean bool = new Boolean(true);
        boolean reruslt = comparator.compare(WarningConstants.TRUE, bool, "");
        assertTrue(reruslt);
    }
    public void testIsTrue2(){
        Boolean bool = new Boolean(false);
        boolean reruslt = comparator.compare(WarningConstants.TRUE, bool, "");
        assertFalse(reruslt);
    }
    public void testIsFalse1(){
        Boolean bool = new Boolean(false);
        boolean reruslt = comparator.compare(WarningConstants.FALSE, bool, "");
        assertTrue(reruslt);
    }
    public void testIsFalse2(){
        Boolean bool = new Boolean(true);
        boolean reruslt = comparator.compare(WarningConstants.FALSE, bool, "");
        assertFalse(reruslt);
    }
}
