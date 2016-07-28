/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.testinstance.bs.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import org.apache.commons.lang.StringUtils;

import gap.warning.util.WarningConstants;
import test.gap.warning.testinstance.bs.ITestInstanceBs;
import test.gap.warning.testinstance.dao.ITestInstanceDao;
import test.gap.warning.testinstance.vo.WarningTestVo;
import venus.frames.base.bs.BaseBusinessService;
import venus.frames.base.exception.BaseApplicationException;
/**
 * @author guopeng2
 *
 */
public class TestInstanceBs extends BaseBusinessService implements ITestInstanceBs{
    
    private ITestInstanceDao dao;
    private WarningTestVo getWarningTest(){
        List list = dao.getWarningTestVo();
        if(list==null||list.size()>1)
            throw new BaseApplicationException("测试表里记录数不对，只能有一条记录");
        return (WarningTestVo)list.get(0);
    }
    
    public String getString() {
        return getWarningTest().getStringCol().trim();
    }

    public Integer getInteger() {
         String integer = getWarningTest().getIntegerCol();
         if(StringUtils.isEmpty(integer))
             throw new BaseApplicationException("INTEGER字段没有值");
        return new  Integer(integer);
    }
    public Date getDate(){
        String date = getWarningTest().getDateCol();
        if(StringUtils.isEmpty(date))
            throw new BaseApplicationException("DATE字段没有值");
        try {
            return WarningConstants.DATE_FORMAT.parse(date);
        } catch (ParseException e) {
            throw new BaseApplicationException("格式化日期出错");
        }
    }

    /* (non-Javadoc)
     * @see test.gap.warning.bs.ITestInstanceBs#geBigDecimal()
     */
    public BigDecimal getBigDecimal() {
        String big = getWarningTest().getBigdecimalCol();
        if(StringUtils.isEmpty(big))
            throw new BaseApplicationException("BIGDECIMAL字段没有值");
        return new BigDecimal(big);
    }
    public Boolean getBoolean() {
        String bool = getWarningTest().getBoolCol();
        if(StringUtils.isEmpty(bool))
            throw new BaseApplicationException("BOOL字段没有值");
        return new Boolean(bool);
    }

    /**
     * @return the dao
     */
    public ITestInstanceDao getDao() {
        return dao;
    }

    /**
     * @param dao the dao to set
     */
    public void setDao(ITestInstanceDao dao) {
        this.dao = dao;
    }

    
}
