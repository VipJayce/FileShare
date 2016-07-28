<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.pps.ppssasalarydata.vo.PpssasalarydataVo" %>
<%@ page import="rayoo.pps.ppssasalarydata.util.IPpssasalarydataConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	PpssasalarydataVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IPpssasalarydataConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (PpssasalarydataVo)request.getAttribute(IPpssasalarydataConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/PpssasalarydataAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/PpssasalarydataAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/PpssasalarydataAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>


 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
		<tr>
			<td class="td_1" >company_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="company_id" inputName="company_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >department_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="department_id" inputName="department_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >pay_year_month</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pay_year_month" inputName="pay_year_month" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >stop_flag</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="stop_flag" inputName="stop_flag" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_verify</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_verify" inputName="is_verify" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_del</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_del" inputName="is_del" value="'0'" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_postpone</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_postpone" inputName="is_postpone" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_email</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_email" inputName="is_email" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >email_time</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="email_time" id="email_time" inputName="email_time" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('email_time','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >email_user</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="email_user" inputName="email_user" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">email_remarks</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="email_remarks" inputName="email_remarks" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >def1</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def1" inputName="def1" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def2</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def2" inputName="def2" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def3</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def3" inputName="def3" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def4</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def4" inputName="def4" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def5</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def5" inputName="def5" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_valid</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_valid" inputName="is_valid" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">note</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="note" inputName="note" maxLength="2000" ></textarea>
			</td>
		</tr>
		<tr>
			<td  class="td_1" >old_id</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="old_id" inputName="old_id" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >pps_sa_batch_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pps_sa_batch_id" inputName="pps_sa_batch_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >pps_user_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="pps_user_id" inputName="pps_user_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def6</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def6" inputName="def6" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def7</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def7" inputName="def7" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def8</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def8" inputName="def8" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def9</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def9" inputName="def9" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def10</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def10" inputName="def10" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def11</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def11" inputName="def11" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def12</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def12" inputName="def12" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def13</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def13" inputName="def13" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def14</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def14" inputName="def14" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def15</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def15" inputName="def15" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def16</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def16" inputName="def16" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def17</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def17" inputName="def17" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def18</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def18" inputName="def18" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def19</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def19" inputName="def19" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def20</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def20" inputName="def20" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def21</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def21" inputName="def21" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def22</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def22" inputName="def22" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def23</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def23" inputName="def23" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def24</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def24" inputName="def24" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def25</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def25" inputName="def25" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def26</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def26" inputName="def26" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def27</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def27" inputName="def27" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def28</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def28" inputName="def28" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def29</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def29" inputName="def29" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def30</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def30" inputName="def30" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def31</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def31" inputName="def31" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def32</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def32" inputName="def32" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def33</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def33" inputName="def33" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def34</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def34" inputName="def34" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def35</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def35" inputName="def35" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def36</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def36" inputName="def36" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def37</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def37" inputName="def37" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def38</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def38" inputName="def38" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def39</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def39" inputName="def39" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def40</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def40" inputName="def40" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def41</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def41" inputName="def41" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def42</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def42" inputName="def42" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def43</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def43" inputName="def43" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def44</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def44" inputName="def44" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def45</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def45" inputName="def45" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def46</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def46" inputName="def46" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def47</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def47" inputName="def47" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def48</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def48" inputName="def48" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def49</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def49" inputName="def49" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def50</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def50" inputName="def50" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def51</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def51" inputName="def51" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def52</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def52" inputName="def52" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def53</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def53" inputName="def53" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def54</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def54" inputName="def54" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def55</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def55" inputName="def55" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def56</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def56" inputName="def56" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def57</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def57" inputName="def57" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def58</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def58" inputName="def58" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >def59</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="def59" inputName="def59" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
		</tr>
	</table>
 

            
   
   
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
