/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.testinstance.vo;

import venus.frames.base.vo.BaseValueObject;

/**
 * @author guopeng2
 *
 */
public class WarningTestVo extends BaseValueObject {
    private String id;
    private String integerCol;
    private String stringCol;
    private String dateCol;
    private String bigdecimalCol;
    private String boolCol;
    /**
     * @return the id
     */
    public String getId() {
        return id;
    }
    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }
    /**
     * @return the integerCol
     */
    public String getIntegerCol() {
        return integerCol;
    }
    /**
     * @param integerCol the integerCol to set
     */
    public void setIntegerCol(String integerCol) {
        this.integerCol = integerCol;
    }
    /**
     * @return the stringCol
     */
    public String getStringCol() {
        return stringCol;
    }
    /**
     * @param stringCol the stringCol to set
     */
    public void setStringCol(String stringCol) {
        this.stringCol = stringCol;
    }
    /**
     * @return the dateCol
     */
    public String getDateCol() {
        return dateCol;
    }
    /**
     * @param dateCol the dateCol to set
     */
    public void setDateCol(String dateCol) {
        this.dateCol = dateCol;
    }
    /**
     * @return the bigdecimalCol
     */
    public String getBigdecimalCol() {
        return bigdecimalCol;
    }
    /**
     * @param bigdecimalCol the bigdecimalCol to set
     */
    public void setBigdecimalCol(String bigdecimalCol) {
        this.bigdecimalCol = bigdecimalCol;
    }
    /**
     * @return the boolCol
     */
    public String getBoolCol() {
        return boolCol;
    }
    /**
     * @param boolCol the boolCol to set
     */
    public void setBoolCol(String boolCol) {
        this.boolCol = boolCol;
    }
    
}
