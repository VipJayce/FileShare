<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>



<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
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
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
            var url="<%=request.getContextPath()%>/Job_orderchargetransfersetAction.do?cmd=modifyData&id=" + ids;
            window.open(url,'','height=550px,width=1100px,top =100,left=100,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=招聘订单修改');
    }  
    
   
    
   
    
    
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
   
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
           var url="<%=request.getContextPath()%>/Job_orderchargetransfersetAction.do?cmd=deleteMulti&ids=" + ids;
              jQuery.post(url,function(data){
         if(data!=0){
                alert("删除成功！");
               $id("datacell1").loadData();
              $id("datacell1").refresh();
       
         }else{
               alert("删除失败！");
                
         }
        })
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
function toAdd_onClick() {  //到增加记录页面
        var url="<%=request.getContextPath()%>/jsp/faerp/job/job_orderchargetransferset/addorderchargetransferset.jsp?";
        url=url+'_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=550px,width=1100px,top =100,left=100,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=招聘订单费用转单');
        
        
    }
    function detail_onClick(){  //实现转到详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url="<%=request.getContextPath()%>/Job_orderchargetransfersetAction.do?cmd=detail&id=" + ids;
        window.open(url,'','height=550px,width=1100px,top =100,left=100,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=招聘订单查看');
        
    }
    
 
    
    //保存成功后回调
    function insertcallBack(reg){
        if(reg=="0"){
            alert("保存成功！");
        }else{
            alert("保存失败！");
        }
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
  

</script>
</head>
<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/Job_orderchargetransfersetAction.do">
<input type="hidden"  name="cmd" value="queryAll"/>
<input type="hidden" name="backFlag" id="backFlag" value="true">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<input type="hidden" name="user_id" id="user_id" value="<%=rayoo.common.filter.UserInfoFilter.getLoginUserId() %>">
<div id="right" >
<script language="javascript">
    writeTableTopFesco('招聘订单费用划转单设置','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>

 <div class="ringht_s" style="height: 400px">
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
            <td/>
            <td/>
              <td>    </td>
                <td/>
        </tr>
           <tr>
            <td align="left">模板名称</td>
            <td align="left">
                  <input type="text" class="text_field" id="template_name" name="template_name" inputName="模板名称" maxLength="100"/>
            </td>
                    <td align="left">订单编号</td>
            <td align="left">
                <input type="text" class="text_field" id="order_code" name="order_code" inputName="订单编号" maxLength="100"/>
            </td>
         
                        <td align="left">订单名称</td>
            <td align="left">
                <input type="text" class="text_field" id="order_name" name="order_name" inputName="订单编号" maxLength="100"/>
            </td>
       
        </tr>
                <tr>
                <td></td>
                 <td></td>
                  <td></td>
                   <td></td>
            <td align="left" colspan="2">                 
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input type="reset" class="icon_1"  />
                </td>
            <td align="left"></td>
        </tr>
</table>
</div>      
<div id="ccParent1" class="button"> 
 <div class="button_right">
        <ul>
            <li class="a"><a onClick="javascript:detail_onClick();"><fmt:message key="view" /> </a></li>
            <li class="c"><a onClick="javascript:toAdd_onClick();"><fmt:message key="insert" /> </a></li>
            <li class="b"><a onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify" /> </a></li>
            <li class="d"><a onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete" /> </a></li>
        </ul>
</div>
           <div class="clear"></div>            
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=simpleQuery" width="98%" height="318px" xpath="Job_orderchargetransfersetVo" paramFormId="datacell_formid" readonly="true">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
  <r:field fieldName="order_code" label="招聘订单编号" width="110px" ></r:field>    
 <r:field fieldName="order_name" label="招聘订单名称" width="250px" ></r:field>    
 <r:field fieldName="cust_name" label="客户名称" width="250px"></r:field>
 <r:field fieldName="template_name" label="费用划转单模板"  width="250px"></r:field>
 <r:field fieldName="create_date" label="创建时间"  width="110px">
    <w:date format="YYYY-MM-DD"/>
 </r:field>
 <r:field fieldName="create_user_name" label="创建人" width="110px"></r:field>

 </r:datacell>
</div>

</div>

</div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>


