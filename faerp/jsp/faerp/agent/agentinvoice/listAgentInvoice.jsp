<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
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
          var url="<%=request.getContextPath()%>/AgentInvoiceAction.do?cmd=UpdateInvoicePage&id="+ids;
             showModalCenter(url, window, callBack, 750, 230, "修改页面");    
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
      
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
                 var url="<%=request.getContextPath()%>/AgentInvoiceAction.do?cmd=deleteMulti&ids=" +ids;
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
      var url="<%=request.getContextPath()%>/jsp/faerp/agent/agentinvoice/insertAgentInvoice.jsp";
             showModalCenter(url, window, callBack, 750, 260, "增加页面");       
    }
    function callBack(reg){ 
            $id("datacell1").loadData();  
            $id("datacell1").refresh();
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
        form.action="<%=request.getContextPath()%>/AgentInvoiceAction.do?id=" + ids;
        form.cmd.value = "detail";
        form.submit();
    }

     function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('发票返回管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
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
         <td align="right">票据号</td>
            <td align="left">
                <input type="text" class="text_field" name="invoice_code" inputName="invoice_code" maxLength="64"/>
            </td>
            <td align="right">供应商名称</td>
            <td align="left">
                <input type="text" class="text_field" name="agent_name" inputName="agent_name" maxLength="64"/>
            </td>
              <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
           
                <input class="c" type="button"   value="新增"    onClick="toAdd_onClick();">
             <input class="b" type="button"   value="修改"    onClick="findCheckbox_onClick();">
            <input class="d" type="button"   value="删除"    onClick="deleteMulti_onClick();">
         </div>
           <div class="clear"></div>            
</div>
</div>
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/AgentInvoiceAction.do?cmd=queryInvoiceData" width="99%" height="305px" xpath="AgentInvoiceVo" paramFormId="datacell_formid" readonly="true">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="35px"
            onRefreshFunc="setCheckboxStatus" align="center">
        </r:field>
      <r:field fieldName="agent_code" label="供应商编号" width="80px"></r:field>   
 <r:field fieldName="agent_name" label="供应商名称" width="250px"></r:field>
 <r:field fieldName="invoice_code" label="票据号"  width="90px"></r:field>
   <r:field fieldName="invoice_amount" label="票据金额" width="90px"></r:field>
    <r:field fieldName="bill_date" label="票据日期"  width="85px">
        <w:date format="yyyy-MM-dd"/>
      </r:field>     
          <r:field fieldName="invoice_date" label="开票日期" width="85px">
        <w:date format="yyyy-MM-dd"/>
      </r:field>
       <r:field fieldName="payment_purpose" label="支付用途" width="300px"></r:field>
       <r:field fieldName="inv_desc" label="备注" width="300px">
      </r:field>

 </r:datacell>

</div>

</form>
</fmt:bundle>

</body>
</html>
