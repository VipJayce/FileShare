<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.insurance.welfareproduct.util.IWelfareProductConstants"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>FESCO Adecco ERP系统</title>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
    <script language="javascript">
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    function findCheckbox_onClick() {  //从多选框到修改页面
        var Id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<Id_check.length;i++){  //循环checkbox组
            if(Id_check[i].checked){
                ids.push(Id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/WelfareProductAction.do?cmd=find&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 900, 350, "修改福利产品");  
    }  
    
    function callBack(reg){
        if(reg!=""&&reg!=null){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }
    }
    
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/WelfareProductAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
    var product_name=document.form.product_name.value;
        form.action="<%=request.getContextPath()%>/WelfareProductAction.do?cmd=simpleQuery&product_name="+product_name;
        form.submit();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/insurance/welfareproduct/insertWelfareProduct.jsp";
        form.submit();
    }
    function detail_onClick(){  //实现转到详细页面
        var Id_check = document.getElementsByName("temp");
        var ids = null;  //定义id值的数组
        if(ids == null) {
            ids = new Array(0);
        }
        for(var i=0;i<Id_check.length;i++){  //循环checkbox组
            if(Id_check[i].checked){
                ids.push(Id_check[i].value);  //加入选中的checkbox
            }
        }
        if(ids==null||ids==""){
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/WelfareProductAction.do?cmd=detail&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, callBack, 900, 350, "查看福利产品");  
        //form.action="<%=request.getContextPath()%>/WelfareProductAction.do?id=" + ids;
        //form.cmd.value = "detail";
        //form.submit();
    }

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='temp' value=" + entity.getProperty("id") + " >";
    }
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    /**
	 * 功能描述：动态生成产品大类下拉菜单的内容
	 * 参数：  selectId --下拉框id;
	 *              key -- 填充时作为option value的对象属性
	 *              value -- 填充时作为option展示的对象属性
	 */    
	function getAllBigType(selectObject,key,value,selectvalue){
        AjaxControl.getBigTypeId("big_type_id",{callback:function(data){
                if (data != null && typeof data == 'object') 
                {
                    setSelectForBean(selectObject.id,data,key,value,selectvalue);
                    getAllSmallType(document.form.big_type_id,'small_type_id','code','name','');
                }
            }
        });
	}
	
	/**
	 * 功能描述：动态生成产品小类下拉菜单的内容
	 * 参数：selectObject --下拉框对象;
	                targetId         -- 下拉框目标对象;
	 *              key -- 填充时作为option value的对象属性
	 *              value -- 填充时作为option展示的对象属性
	 */    
	function getAllSmallType(selectObject,targetId,key,value,selectvalue){
	    AjaxControl.getSmallTypeId(selectObject.value,{callback:function(data){
	            if (data != null && typeof data == 'object') 
	            {
	                DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
	                DWRUtil.addOptions(targetId,{'':'--请选择--'});
	                setSelectForBean(targetId,data,key,value,selectvalue);
                    getAllThreeType(document.form.small_type_id,'three_type_id','code','name','');
	            }
	        }
	    });
	}
	
	/**
	 * 功能描述：动态生成产品三级分类下拉菜单的内容
	 * 参数：selectObject --下拉框对象;
	                targetId         -- 下拉框目标对象;
	 *              key -- 填充时作为option value的对象属性
	 *              value -- 填充时作为option展示的对象属性
	 */    
	function getAllThreeType(selectObject,targetId,key,value,selectvalue){
	    AjaxControl.getThreeTypeId(selectObject.value,{callback:function(data){
	            if (data != null && typeof data == 'object') 
	            {
	                DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
	                DWRUtil.addOptions(targetId,{'':'--请选择--'});
	                setSelectForBean(targetId,data,key,value,selectvalue);
	            }
	        }
	    });
	}
</script>
    </head>
<body>
    <form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/WelfareProductAction.do">
       <input type="hidden" name="cmd" value="queryAll"> 
       <input type="hidden" name="backFlag" id="backFlag" value="true">

       <div id="right">
           <script language="javascript">
                writeTableTopFesco('福利产品维护','<%=request.getContextPath()%>/');  //显示本页的页眉
           </script>
           <div class="ringht_s">
             <div id="ccChild0" class="search">
               <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                     <td width="140" rowspan="3" style="padding-top: 0;"><div class="search_title">查询条件</div>   </td>
                </tr>
                <tr>
		            <td align="right">产品大类</td>
		            <td align="left"><select id="big_type_id" name="big_type_id" onchange="javascript:getAllSmallType(this,'small_type_id','code','name')" disabled="disabled"></select></td>
		            <td align="right">产品小类</td>
		            <td align="left"><select id="small_type_id" name="small_type_id" onchange="javascript:getAllThreeType(this,'three_type_id','code','name')"><option value="">--请选择--</option></select> </td>
		            <td align="right">产品三级分类</td>
		            <td align="left"><select id="three_type_id" name="three_type_id"><option value="">--请选择--</option></select></td>
		        </tr>
                <tr>
                    <td align="right" width="80">产品名称</td>
                    <td align="left" width="140"><input type="text" class="text_field" name="product_name" inputName="产品名称" maxLength="50" /></td>
                    <td align="right">是否有效</td>
                    <td align="left"><d:select dictTypeId="INVALID_STATE" name="invalidstate" nullLabel="--请选择--" /></td>
                    <td align="right">
                       <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData();"> 
                    </td>
              </tr>
           </table>
       </div>

    <div id="ccParent1" class="button">
    <div class="button_right">
    <!--<ul>
        <li class="a"><a  onClick="javascript:detail_onClick();"><fmt:message key="view" /> </a> </li>
        <li class="b"><a onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify" /> </a></li>
    </ul>
    --><input class="a" type="button"   value="<fmt:message key="view"/>"  <au:authorityBtn code="flcpwh_view" type="1"/>  onClick="detail_onClick();">
    <input class="b" type="button"   value="<fmt:message key="modify"/>"  <au:authorityBtn code="flcpwh_xg" type="1"/>  onClick="findCheckbox_onClick();">
    </div>
    <div class="clear"></div>
    </div>
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/WelfareProductAction.do?cmd=searchWelfareProductAll"
        width="98%"
        height="303px"
        xpath="WelfareProductVo"
        paramFormId="datacell_formid"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作" width="50px" sortAt="none" onRefreshFunc="setCheckboxStatus"  align="center">
       </r:field>
       <r:field fieldName="product_name" label="产品名称" width="190px">
      </r:field>
      <r:field fieldName="scheme_type" label="方案类型" width="70px">
      </r:field>
      <r:field fieldName="big_type_id" label=" 产品大类" width="70px" allowModify="false">
      <d:select dictTypeId="big_type_id" />
      </r:field>
      <r:field fieldName="small_type_id" label="产品小类" width="110px" allowModify="false">
      <d:select dictTypeId="big_type_id" />
      </r:field>
       <r:field fieldName="three_type_id" label="产品三级分类" width="110px" allowModify="false">
      <d:select dictTypeId="big_type_id" />
      </r:field>
       <r:field fieldName="product_supplier" label="产品供应商名称" width="225px">
      </r:field>
      <r:field fieldName="product_dept" label="产品所属部门" width="100px">
      </r:field>
      <r:field fieldName="create_user" label="创建人" width="80px">
      </r:field>
      <r:field fieldName="create_date" label="创建时间" width="80px">
      <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="invalidstate" label="是否有效" width="60px" allowModify="false">
      <d:select dictTypeId="INVALID_STATE" />
      </r:field>
    </r:datacell>
    </div>
    </div>
    </form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
getAllBigType(document.form.big_type_id,'code','name','104')
<%  //表单回写
    if(request.getAttribute(IWelfareProductConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IWelfareProductConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>
