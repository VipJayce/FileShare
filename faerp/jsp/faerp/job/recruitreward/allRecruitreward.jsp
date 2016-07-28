<%@ page contentType="text/html; charset=UTF-8"%>
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
 function save_onClick(){
   var orderid=document.getElementById("order_id").value;
  
                     var dataset1 = $id("datacell1").dataset;
              var len1 = dataset1.getLength();
              if(len1==0){
                alert("没有需要分配的业绩！");
                return ;
              }
                   for(var i =0 ; i < len1 ; i++){
                        var money = dataset1.get(i).getProperty("rewardamount");
                        if(money==""||money==null){
                        alert("业绩金额不能为空！");
                        return;
                        }    
                      if(money<0){
                        alert("分配金额不能为负数！");
                        return;
                        }  
              }
   jQuery("#save1").attr("disable",true);
      var action = "<%=request.getContextPath()%>/RecruitrewardAction.do?cmd=saveRward&orderid="+orderid;
    var pj1=$id("datacell1");
      var xmlSubmit = pj1.dataset.toString();
              var myAjax = new Ajax(action);
                 myAjax.submitXML(xmlSubmit, 'UTF-8');
                 var returnNode = myAjax.getResponseXMLDom();
                 if(returnNode) {
                 if( myAjax.getValue("root/data/returnValue")!=0 ) {
                       alert("分配成功")
                }
                  } else {
                      alert( '分配失败' ); 
                  }
                window.close();
                 window.opener.simpleQuery_onClick();   
             }
 function cancel_onClick(){
   window.close();
 }

</script>

	</head>
	<body>
	<h:form checkType="blur" name="form" method="post" id="datacell_formid">
		 <div id="right">
        <div class="right_title_bg">
       <div class=" right_title">业绩分配</div>
     </div>
    <div class="ringht_s">
		<input type="hidden" id="order_id" name="order_id" value="${bean.id }">
		<div id="ccChild0" class="box_3">
		<div class="xz_title" style="padding-top: 10px">基本信息</div>
		<table width="100%" height="20px" border="0" cellpadding="0"
			cellspacing="1" bgcolor="#c5dbe2">
			<tr>
				<td class="td_1">订单编号</td>
				<td class="td_2 "><input type="text" class="text_field"
					name="order_code" inputName="订单编号" value="${bean.order_code }"
					readonly="readonly" /></td>
				<td class="td_1">订单名称</td>
				<td class="td_2 "><input type="text" class="text_field"
					name="order_name" inputName="订单名称" value="${bean.order_name }"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="td_1">招聘合同</td>
				<td class="td_2 "><input type="text" class="text_field"
					name="contract_name" inputName="招聘合同"
					value="${bean.contract_name }" readonly="readonly" /></td>
				<td class="td_1">客户名称</td>
				<td class="td_2 "><input type="text" class="text_field"
					name="cust_name" inputName="客户名称" value="${bean.cust_name}"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="td_1">担保期</td>
				<td class="td_2 "><input type="text" class="text_field"
					name="warranty" inputName="担保期" value="${bean.warranty?"
					":bean.warranty }"
				readonly="readonly" /></td>
				<td class="td_1">订单日期</td>
				<td class="td_2 "><!-- <input type="text" class="text_field"
				name="create_date" inputName="订单日期" value="${bean.create_date }"
				readonly="readonly"  /> --> <w:date name="create_date"
					id="create_date" readonly="true" readOnly="true"
					format="yyyy-MM-dd" srcFormat="yyyy-MM-dd"
					value="${bean.create_date }" /></td>
			</tr>
			<tr>
				<td class="td_1" nowrap="nowrap">创建人</td>
				<td class="td_2 "><input type="text" class="text_field"
					name="name" inputName="创建人" value="${bean.name }"
					readonly="readonly" /></td>
				<td class="td_1">状态</td>
				<td class="td_2 "><d:select dictTypeId="ORDER_STATUS_BD"
					disabled="true" name="order_status" value="${bean.order_status }"></d:select></td>
			</tr>
		</table>
		</div>
		
		<div class="xz_title" style="padding-top: 10px">基本信息</div>
		<div style="padding: 8 8 8 8;">
		<r:datacell id="datacell1"
			queryAction="/FAERP/RecruitrewardAction.do?cmd=queryRecruitreward&position_id=${position_id }"
			width="98%" height="180px" xpath="RecruitrewardVo"
			paramFormId="datacell_formid" pageSize="100">
			<r:field fieldName="user_id" label="" width="0" allowModify="false"></r:field>
			<r:field fieldName="position_id" label="" width="0"
				allowModify="false"></r:field>
			<r:field fieldName="user_name" label="顾问姓名" width="150px"
				allowModify="false">
			</r:field>
			<r:field fieldName="deptname" label="部门" width="130px"
				allowModify="false">
			</r:field>
			<r:field fieldName="email" label="Email" width="200px"
				allowModify="false">
			</r:field>
			<r:field fieldName="position_name" label="招聘职位" width="150px"
				allowModify="false">
			</r:field>
			<r:field fieldName="rewardamount" label="业绩金额" width="100px"
				allowModify="true">
				<h:text validateAttr="allowNull=false;type=float;minValue=0;" />
			</r:field>
		</r:datacell>
		</div>
		</div>

		<div class="mx_button" align="center"><input type="button"
			class="icon_2" id="save1" value='确认分配'
			onClick="javascript:save_onClick()" /> <input type="button"
			class="icon_2" value="关闭" onClick="javascript:cancel_onClick()" />
	   </div>


		</div>
		</div>
	</h:form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>