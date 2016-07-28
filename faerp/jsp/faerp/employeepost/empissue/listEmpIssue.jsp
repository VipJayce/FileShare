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
       var emp_code = document.getElementById("emp_code").value;
       if(emp_code==""){
        alert("请先选择一个员工！");
        return;
       }
        
       var obj = document.getElementsByName("bm");
       var idCard = document.getElementById("idCard").value;
       var cust_name = document.getElementById("cust_name").value;
        //idCard='362525197412011532';
       cust_name=""; 
       
    //   for(var i=0; i<obj.length; i ++){
    //    if(obj[i].checked){
    //        if (obj[i].value=="issue"){ 
                 $id("datacell1").queryAction = "<%=request.getContextPath()%>/EmpIssueAction.do?cmd=getEmpIssueByIdcard&idCard="+idCard;
                 $id("datacell1").loadData();
                 $id("datacell1").refresh();
                 if( $id("datacell1").getActiveEntity()==null)
                 {
                  alert("该用户无工单记录！");
                 }
               
                  
     //       }
     //       else if(obj[i].value=="callHistory"){
	           
	 //               $id("datacell2").queryAction = "<%=request.getContextPath()%>/EmpIssueAction.do?cmd=getCallHistoryQuery&idCard="+idCard+"&cust_name="+cust_name;
	 //               $id("datacell2").loadData();
	  //              $id("datacell2").refresh();
                 
	               
        //    }
            
      //  }
   // }

    }
     //选择员工
    function toAdd_onClick(type) { 
       //     showModalCenter("<%=request.getContextPath()%>/EmpMaterialAction.do?cmd=selectPage&type=" + type,null,empReturn,850,600,"选择员工");
            showModalCenter("<%=request.getContextPath()%>/EmpIssueAction.do?cmd=selectPage&type=" + type,null,empReturn,850,600,"选择员工");
        
    }
    
    //选择员工 返回方法
	function empReturn(retVal){
	 //value 为新选择的empid
     //   $id("datacell1").queryAction = "<%=request.getContextPath()%>/EmpIssueAction.do?cmd=getEmpIssueByIdcard&idCard="+retVal[0];
     //   $id("datacell1").loadData();
      //  $id("datacell1").refresh();
     document.getElementById("emp_code").value=retVal[0];
      document.getElementById("emp_name").value=retVal[1];
      document.getElementById("idCard").value=retVal[2];
      document.getElementById("cust_code").value=retVal[3];
      document.getElementById("cust_name").value=retVal[4];
     
	}
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
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
					<td align="left"><font color="red">*</font>选择员工</td>
					<td align="left" colspan="5">
						<div id="ccParent1" class="button"
							style="float: left; width: 100%; overflow: visible;"><input
							class="icon_1" type="button" value="查找员工" onClick="toAdd_onClick(1);">
						</div>
					</td>
				</tr>
			
				<tr>
					<td align="left">员工编号:</td>
					<td align="left">
					   <input type="text" class="text_field" id="emp_code" name="emp_code" value="" readOnly="readonly" /></td>
					<td align="left">员工姓名:</td>
					<td>
					   <input type="text" class="text_field" id="emp_name" name="emp_name" value="" readOnly="readonly" /></td>
					<td align="left">身份证号码:</td>
					<td>
					   <input type="text" class="text_field" id="idCard" name="idCard" value="" readOnly="readonly" />
					</td>
				</tr>
				<tr>
					<td align="left">客服编号:</td>
					<td align="left">
					   <input type="text" class="text_field" id="cust_code" name="cust_code" value="" readOnly="readonly" />
					</td>
			
					<td align="left">客户名称:</td>
					<td align="left">
					   <input type="text" class="text_field" id="cust_name" name="cust_name" value="" readOnly="readonly" />
					</td>
					<td align="left" colspan="2">
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
				 <r:datacell id="datacell1"  queryAction=""  pageSize="100"
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
