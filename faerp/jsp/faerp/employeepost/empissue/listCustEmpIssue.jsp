<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
     //简单的模糊查询
    function simpleQuery_onClick(){ 
       var classify_date_from =document.getElementById("classify_date_from").value;
       var idCard = document.getElementById("idCard").value;//身份证号码
       var cust_id = document.getElementById("cust_id").value;//客户id
       var customer_email = document.getElementById("customer_email").value;
       var classify_date_to = document.getElementById("classify_date_to").value;
  
       if(idCard==""&&cust_id==""&&customer_email==""&&classify_date_from==""&&classify_date_to==""){
          alert("请必须输入一个条件查询！");
          return;
       }
       if(classify_date_from!=""){
                if(classify_date_to==""){
                  alert("结束时间不能为空！");
                  return;
                  }
       }
       if(classify_date_to!=""){
                if(classify_date_from==""){
                  alert("开始时间不能为空！");
                  return;
                  }
       }
           $id("datacell1").queryAction = "<%=request.getContextPath()%>/EmpIssueAction.do?cmd=getEmpIssueByAll&idCard="+idCard+"&cust_id="+cust_id+"&customer_email="+customer_email+"&classify_date_from="+classify_date_from+"&classify_date_to="+classify_date_to;
           $id("datacell1").loadData();
           $id("datacell1").refresh();
           if( $id("datacell1").getActiveEntity()==null)
           {
            alert("该用户无工单记录！");
           }
    }

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
       function rtnFuncCustomer(arg){
            var lookup = $id("cust_name");
            lookup.value = arg[2];
            lookup.displayValue = arg[2];
            document.getElementById("cust_id").value=arg[1];
            return false;
        }
</script>
 

</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<div id="right">
	<script language="javascript">
	       writeTableTopFesco('呼叫记录查询','<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
    <div class="ringht_s">
        <div id="ccChild0" class="search">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="174" rowspan="10" style="padding-top: 0;" colspan="6">
					   <div class="search_title">查询条件</div>
					</td>
				</tr>
				<tr>
					<td align="left">客服:</td>
					<td align="left"><!--
					   <input type="text" class="text_field" id="customer_email" name="customer_email" value="" />
					       -->
					   <r:comboSelect id="customer_email" name="customer_email"
                       queryAction="EmpIssueAction.do?cmd=getAllCustomer"
                       textField="username"
                       valueField="email"
                       xpath="UserDeptVo"
                       width="200px"
                       messagekey="please_select" />
					   </td>
					<td align="left">查询日期:</td>
					<td>
					    <w:date format="yyyy-MM-dd" id="classify_date_from" name="classify_date_from" width="80px"/>&nbsp;到&nbsp;<w:date format="yyyy-MM-dd" id="classify_date_to" name="classify_date_to" width="80px"/>  
					</td>
					<td align="left">身份证号码:</td>
					<td>
					   <input type="text" class="text_field" id="idCard" name="idCard" value="" />
					</td>
				</tr>
				<tr>
					<td align="left">客户名称:</td>
					   <input type="hidden" class="text_field" id="cust_id" name="cust_id" value="" />
			<td align="left">
              <w:lookup onReturnFunc="rtnFuncCustomer" id="cust_name" name="cust_name"  lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                            messagekey="choose_customer" height="440" width="600"  style="width:170px"/>
                  </td>
					<td align="left" colspan="3">
					   <input name="button_ok" class="icon_1" type="button" value='查询' onClick="javascript:simpleQuery_onClick()">
                       <input type="reset" class="icon_1" />
                    </td>
				</tr>
			</table>
		</div>
    
    
        <!--  div ccChild0 end -->
        <div style="margin-top: 5px;">
            <div class="xz_title" style="width:45%;float: left;">工单信息</div>
            <div class="xz_title" style="width:48%;float: right;">呼叫记录信息</div>
        </div>
        
        <!--  div ccParent1 start -->
	   <div id="ccParent1" class="button" style="float: left;width:100%;overflow: visible;"> 
	           <div class="clear"></div>            
	    </div>
	    <!--  div ccParent1 end -->
        <!--  div start -->
        <div style="padding: 8 10 8 8;">
            <div style="float: left;">
				 <r:datacell id="datacell1"  queryAction=""  pageSize="10000"
				 width="530px" height="300px" xpath="EmpIssue"   >
					 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
					  <r:field fieldName="id" label="工单号" width="50px"></r:field>
					  <r:field fieldName="type" label="工单类型" width="60px"></r:field>
					 <r:field fieldName="status" label="状态" width="40px"  allowModify="false">
                            <select onchange="selectIsReceive(this.value)">
                                <option value="0">待处理</option>
                                <option value="1">未完成</option>
                                <option value="2">已完成</option>
                            </select>
                        </r:field>    
					 <r:field fieldName="name" label="请 求 人" width="50px"></r:field>
                     <r:field fieldName="realName" label="跟进人" width="50px"></r:field>
					 <r:field fieldName="createTime" label="开始时间" width="140px"></r:field>
					 <r:field fieldName="endTime" label="结束时间" width="140px"></r:field>
					 
				  </r:datacell>
		    </div>
			 <div style="float: right;margin-right:11px;">
			 
		             <r:datacell id="datacell2" queryAction="" 
		            pageSize="100"
		             width="550px" height="300px" xpath="EmpCallHistory" >
		             <r:toolbar location="bottom" tools="nav,pagesize,info"/>
		                 <r:field fieldName="callNum" label="呼叫次数" width="110px"  allowModify="false"></r:field>    
		                 <r:field fieldName="callTime" label="呼叫时间" width="180px"  allowModify="false" ></r:field>    
		                 <r:field fieldName="callResult" label="呼叫状态" width="80px"  allowModify="false">
		                    <select onchange="selectIsReceive(this.value)">
		                        <option value="false">失败</option>
		                        <option value="true">成功</option>
		                    </select>
		                </r:field>    
		                 <r:field fieldName="otherRemark" label="备注" width="80px"  allowModify="false"></r:field>
		             </r:datacell>
             </div>
             
        </div>
        <!--  div end -->
        
        
</div>
</div>
</form>
</body>
</html>

<script language="javascript">
//初始化不加载页面信息<siqp添加>
jQuery(function(){
	    $id("datacell1").isQueryFirst = false;
	    $id("datacell2").isQueryFirst = false;
        $id("datacell1").afterSelectRow  = function(row){
                     var value= $id("datacell1").getActiveEntity().getValue("id"); 
                    $id("datacell2").queryAction = "/FAERP/EmpIssueAction.do?cmd=getCallHistoryQuery&issueId="+value;
                   $id("datacell2").loadData();
                   $id("datacell2").refresh();
                   
    }
});


</script>   
