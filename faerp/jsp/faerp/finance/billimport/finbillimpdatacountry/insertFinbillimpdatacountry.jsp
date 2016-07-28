<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.billimport.finbillimpdatacountry.vo.FinbillimpdatacountryVo" %>
<%@ page import="rayoo.finance.billimport.finbillimpdatacountry.util.IFinbillimpdatacountryConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	FinbillimpdatacountryVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IFinbillimpdatacountryConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (FinbillimpdatacountryVo)request.getAttribute(IFinbillimpdatacountryConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >bill_imp_batch_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bill_imp_batch_id" inputName="bill_imp_batch_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_failure</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_failure" inputName="is_failure" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">failure_reason</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="failure_reason" inputName="failure_reason" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >emp_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_id" inputName="emp_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >emp_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_code" inputName="emp_code" value="" maxLength="5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >emp_id_card_no</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_id_card_no" inputName="emp_id_card_no" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >emp_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_name" inputName="emp_name" value="" maxLength="5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a1</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a1" inputName="a1" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a2</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a2" inputName="a2" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a3</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a3" inputName="a3" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a4</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a4" inputName="a4" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a5</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a5" inputName="a5" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a6</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a6" inputName="a6" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a7</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a7" inputName="a7" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a8</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a8" inputName="a8" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a9</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a9" inputName="a9" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a10</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a10" inputName="a10" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a11</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a11" inputName="a11" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a12</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a12" inputName="a12" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a13</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a13" inputName="a13" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a14</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a14" inputName="a14" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a15</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a15" inputName="a15" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a16</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a16" inputName="a16" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a17</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a17" inputName="a17" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a18</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a18" inputName="a18" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a19</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a19" inputName="a19" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a20</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a20" inputName="a20" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a21</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a21" inputName="a21" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a22</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a22" inputName="a22" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a23</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a23" inputName="a23" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a24</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a24" inputName="a24" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a25</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a25" inputName="a25" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a26</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a26" inputName="a26" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a27</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a27" inputName="a27" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a28</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a28" inputName="a28" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a29</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a29" inputName="a29" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a30</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a30" inputName="a30" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a31</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a31" inputName="a31" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a32</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a32" inputName="a32" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a33</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a33" inputName="a33" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a34</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a34" inputName="a34" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a35</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a35" inputName="a35" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a36</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a36" inputName="a36" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a37</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a37" inputName="a37" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a38</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a38" inputName="a38" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a39</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a39" inputName="a39" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a40</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a40" inputName="a40" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a41</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a41" inputName="a41" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a42</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a42" inputName="a42" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a43</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a43" inputName="a43" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a44</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a44" inputName="a44" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a45</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a45" inputName="a45" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a46</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a46" inputName="a46" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a47</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a47" inputName="a47" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a48</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a48" inputName="a48" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a49</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a49" inputName="a49" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a50</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a50" inputName="a50" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a51</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a51" inputName="a51" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a52</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a52" inputName="a52" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a53</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a53" inputName="a53" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a54</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a54" inputName="a54" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a55</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a55" inputName="a55" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a56</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a56" inputName="a56" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a57</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a57" inputName="a57" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a58</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a58" inputName="a58" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a59</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a59" inputName="a59" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a60</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a60" inputName="a60" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a61</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a61" inputName="a61" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a62</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a62" inputName="a62" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a63</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a63" inputName="a63" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a64</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a64" inputName="a64" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a65</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a65" inputName="a65" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a66</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a66" inputName="a66" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a67</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a67" inputName="a67" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a68</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a68" inputName="a68" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a69</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a69" inputName="a69" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a70</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a70" inputName="a70" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a71</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a71" inputName="a71" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a72</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a72" inputName="a72" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a73</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a73" inputName="a73" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a74</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a74" inputName="a74" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a75</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a75" inputName="a75" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a76</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a76" inputName="a76" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a77</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a77" inputName="a77" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a78</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a78" inputName="a78" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a79</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a79" inputName="a79" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a80</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a80" inputName="a80" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a81</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a81" inputName="a81" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a82</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a82" inputName="a82" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a83</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a83" inputName="a83" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a84</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a84" inputName="a84" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a85</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a85" inputName="a85" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a86</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a86" inputName="a86" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a87</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a87" inputName="a87" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a88</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a88" inputName="a88" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a89</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a89" inputName="a89" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a90</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a90" inputName="a90" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a91</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a91" inputName="a91" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a92</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a92" inputName="a92" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a93</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a93" inputName="a93" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a94</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a94" inputName="a94" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a95</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a95" inputName="a95" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a96</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a96" inputName="a96" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a97</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a97" inputName="a97" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a98</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a98" inputName="a98" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a99</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a99" inputName="a99" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a100</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a100" inputName="a100" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a101</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a101" inputName="a101" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a102</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a102" inputName="a102" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a103</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a103" inputName="a103" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a104</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a104" inputName="a104" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a105</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a105" inputName="a105" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a106</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a106" inputName="a106" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a107</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a107" inputName="a107" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a108</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a108" inputName="a108" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a109</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a109" inputName="a109" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a110</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a110" inputName="a110" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a111</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a111" inputName="a111" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a112</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a112" inputName="a112" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a113</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a113" inputName="a113" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a114</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a114" inputName="a114" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a115</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a115" inputName="a115" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a116</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a116" inputName="a116" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a117</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a117" inputName="a117" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a118</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a118" inputName="a118" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a119</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a119" inputName="a119" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a120</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a120" inputName="a120" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a121</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a121" inputName="a121" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a122</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a122" inputName="a122" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a123</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a123" inputName="a123" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a124</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a124" inputName="a124" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a125</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a125" inputName="a125" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a126</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a126" inputName="a126" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a127</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a127" inputName="a127" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a128</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a128" inputName="a128" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a129</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a129" inputName="a129" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a130</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a130" inputName="a130" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a131</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a131" inputName="a131" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a132</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a132" inputName="a132" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a133</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a133" inputName="a133" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a134</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a134" inputName="a134" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a135</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a135" inputName="a135" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a136</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a136" inputName="a136" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a137</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a137" inputName="a137" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a138</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a138" inputName="a138" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_del</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_del" inputName="is_del" value="0 " maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="last_update_user_id" inputName="last_update_user_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_date</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="last_update_date" id="last_update_date" inputName="last_update_date" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('last_update_date','<venus:base/>/');"/>
			</td>
			<td  class="td_1" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cust_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cust_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_id" inputName="cust_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cust_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_code" inputName="cust_code" value="" maxLength="64" />
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
