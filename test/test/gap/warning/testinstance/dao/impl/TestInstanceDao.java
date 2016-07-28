/**
 * Copyright 2003-2010 UFIDA Software Engineering Co., Ltd. 
 */
package test.gap.warning.testinstance.dao.impl;

import java.util.List;

import test.gap.warning.testinstance.dao.ITestInstanceDao;
import test.gap.warning.testinstance.vo.WarningTestVo;
import venus.frames.base.dao.BaseHibernateDao;

/**
 * @author guopeng2
 *
 */
public class TestInstanceDao extends BaseHibernateDao implements
        ITestInstanceDao {
    public List getWarningTestVo() {
        return loadAll(WarningTestVo.class);
    }

}
