<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<title></title>
<script language="javascript">
    var vpath = "<%=request.getContextPath()%>";
        
    function findSelections(checkboxName) {  //从列表中找出选中的id值列表
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
      
    
    function emp_onClick(obj){
        var datacell = $id("emppost_init");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
            //针对第一行有问题，其他行可行
            if(obj.checked){//勾选上
                $id("temp_"+i).checked=true;
            }else{//勾选去掉
                $id("temp_"+i).checked=false;
            }
        }
       
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function toAdd_onClick() {  //到新增页面
        window.open("jsp/faerp/pps/pps_erp_salary_relation/addErpSalary_relation.jsp","newwindow","width=800px,height=600px,location=no,scroll=yes");
    }
    
    function findCheckbox_onClick(){
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
        var rel_id = datasettr.getProperty('id');
        window.open("<%=request.getContextPath()%>/Pps_erp_salary_relationAction.do?cmd=tosearchRelation&rel_id="+rel_id,"newwindow","width=800px,height=600px,location=no,scroll=yes");
    }
    
    function findItemRelation_onClick(){
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
        var rel_id = datasettr.getProperty('id');
        window.open("<%=request.getContextPath()%>/Pps_erp_saitem_relationAction.do?cmd=tosearchRelation&rel_id="+rel_id,"newwindow","width=800px,height=600px,location=no,scroll=yes");
    }
    
    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        jQuery("#customer_code").val(arg[1]);   
        $id("pps_bas_id").addParam("cust_id", arg[0]);   
        $id("pps_bas_id").loadData();
        $id("pps_bas_id").refresh();
        return false;
    }
    
</script>
</head>
<body>
 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco("PPS账套与ERP薪资类别关联列表",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<form name="form" method="post" id="simpleQuery">
<input type="hidden" name="cmd" value="queryAll">
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="174" rowspan="4" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
            <td/>
            <td/>
              <td>    </td>
                <td/>
        </tr>
                <tr>
            <td align="right">PPS客户</td>
            <td align="left">
                <w:lookup name="customer_name" onReturnFunc="rtnFuncCustomer" id="lk_clz" lookupUrl="/Pps_au_party_check_relationAction.do?cmd=getCheckCustomerByCondition" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
            </td>
            <td align="right">PPS客户编号</td>
            <td align="left">
                <input type="text" class="text_field" id="customer_code" name="customer_code" inputName="客户编号" maxLength="25"/>
            </td>
            <td align="right">PPS账套</td>
            <td align="left">
                <r:comboSelect id="pps_bas_id"
                    name="pps_bas_id"
                    queryAction="/FAERP/PpssasalarytempletAction.do?cmd=getPpsTempletByCustomerID"
                    textField="salary_templet_name" valueField="id" xpath="PpssasalarytempletVo"
                 width="190" messagekey="please_select"/>
            </td>
        </tr>
        
        <tr>
            
            <td align="center"></td>
            <td colsapn="4">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
                <td/>
        </tr>
    
</table>

</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
         <input class="c" type="button" value="<fmt:message key="insert"/>" onClick="toAdd_onClick();">
         <input class="b" type="button" value="<fmt:message key="modify"/>" onClick="findCheckbox_onClick();">
         <input class="m_2" type="button" value="账套项与薪资项匹配" onClick="findItemRelation_onClick();">
         <!--  
         <input class="d" type="button" value="<fmt:message key="delete"/>" onClick="deleteMulti_onClick();">
         -->
         
         </div>
           <div class="clear"></div>            
</div>
      <div style="padding: 5 0 0 8;">
                    <r:datacell 
                         id="datacell1"
                         queryAction="/FAERP/Pps_erp_salary_relationAction.do?cmd=simpleQuery"
                         width="99%"
                         height="320px"
                         xpath="Pps_erp_salary_relationVo"
                         submitXpath="Pps_erp_salary_relationVo"
                         paramFormId="simpleQuery"
                         >
                         <r:toolbar  tools="nav,pagesize,info"/>
                         
                         <r:field fieldName="pps_customer_name" label="PPS客户" width="250px">
                         </r:field>
                         <r:field fieldName="erp_customer_name" label="ERP客户" width="250px">
                         </r:field>
                         <r:field fieldName="salary_templet_name" label="PPS帐套" allowModify="false" width="200px">
                         </r:field>
                         <r:field fieldName="sa_class_name" label="ERP薪资类别" width="200px">
                         </r:field>
                       </r:datacell>
                       </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
