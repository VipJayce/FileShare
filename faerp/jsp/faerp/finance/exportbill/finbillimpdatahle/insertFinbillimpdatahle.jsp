<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.exportbill.finbillimpdatahle.vo.FinbillimpdatahleVo" %>
<%@ page import="rayoo.finance.exportbill.finbillimpdatahle.util.IFinbillimpdatahleConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	FinbillimpdatahleVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IFinbillimpdatahleConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (FinbillimpdatahleVo)request.getAttribute(IFinbillimpdatahleConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/FinbillimpdatahleAction.do?cmd=insert";
		form.submit();
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
	    form.action="<%=request.getContextPath()%>/FinbillimpdatahleAction.do?cmd=update";
    	form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/FinbillimpdatahleAction.do?cmd=queryAll&backFlag=true";
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
				<input type="text" class="text_field" name="emp_code" inputName="emp_code" value="" maxLength="64" />
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
				<input type="text" class="text_field" name="emp_name" inputName="emp_name" value="" maxLength="64" />
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
			<td class="td_1" >cust_name</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cust_name" inputName="cust_name" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >d</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="d" inputName="d" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >e</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="e" inputName="e" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >f</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="f" inputName="f" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >g</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="g" inputName="g" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >h</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="h" inputName="h" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >i</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="i" inputName="i" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >j</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="j" inputName="j" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >k</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="k" inputName="k" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >l</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="l" inputName="l" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >m</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="m" inputName="m" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >n</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="n" inputName="n" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >o</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="o" inputName="o" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >p</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="p" inputName="p" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >q</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="q" inputName="q" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >r</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="r" inputName="r" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >s</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="s" inputName="s" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >t</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="t" inputName="t" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >u</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="u" inputName="u" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >v</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="v" inputName="v" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >w</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="w" inputName="w" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >x</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="x" inputName="x" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >y</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="y" inputName="y" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >z</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="z" inputName="z" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >aa</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="aa" inputName="aa" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ab</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ab" inputName="ab" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ac</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ac" inputName="ac" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ad</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ad" inputName="ad" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ae</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ae" inputName="ae" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >af</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="af" inputName="af" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ag</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ag" inputName="ag" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ah</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ah" inputName="ah" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ai</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ai" inputName="ai" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >aj</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="aj" inputName="aj" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ak</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ak" inputName="ak" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >al</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="al" inputName="al" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >am</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="am" inputName="am" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >an</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="an" inputName="an" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ao</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ao" inputName="ao" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ap</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ap" inputName="ap" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >aq</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="aq" inputName="aq" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ar</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ar" inputName="ar" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >as1</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="as1" inputName="as1" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >at</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="at" inputName="at" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >au</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="au" inputName="au" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >av</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="av" inputName="av" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >aw</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="aw" inputName="aw" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ax</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ax" inputName="ax" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ay</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ay" inputName="ay" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >az</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="az" inputName="az" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ba</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ba" inputName="ba" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bb</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bb" inputName="bb" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bc</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bc" inputName="bc" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bd" inputName="bd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >be</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="be" inputName="be" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bf</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bf" inputName="bf" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bg</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bg" inputName="bg" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bh</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bh" inputName="bh" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bi</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bi" inputName="bi" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bj</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bj" inputName="bj" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bk</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bk" inputName="bk" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bl</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bl" inputName="bl" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bm</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bm" inputName="bm" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bn</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bn" inputName="bn" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bo</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bo" inputName="bo" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bp</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bp" inputName="bp" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bq</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bq" inputName="bq" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >br</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="br" inputName="br" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bs</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bs" inputName="bs" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bt</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bt" inputName="bt" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bu</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bu" inputName="bu" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bv</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bv" inputName="bv" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bw</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bw" inputName="bw" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bx</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bx" inputName="bx" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >by1</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="by1" inputName="by1" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bz</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bz" inputName="bz" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ca</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ca" inputName="ca" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cb</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cb" inputName="cb" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cc</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cc" inputName="cc" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cd" inputName="cd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ce</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ce" inputName="ce" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cf</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cf" inputName="cf" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cg</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cg" inputName="cg" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ch</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ch" inputName="ch" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ci</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ci" inputName="ci" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cj</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cj" inputName="cj" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ck</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ck" inputName="ck" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cl</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cl" inputName="cl" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cm</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cm" inputName="cm" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cn</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cn" inputName="cn" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >co</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="co" inputName="co" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cp</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cp" inputName="cp" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cq</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cq" inputName="cq" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cr</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cr" inputName="cr" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cs</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cs" inputName="cs" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ct</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ct" inputName="ct" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cu</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cu" inputName="cu" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cv</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cv" inputName="cv" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cw</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cw" inputName="cw" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cx</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cx" inputName="cx" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cy</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cy" inputName="cy" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cz</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cz" inputName="cz" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >da</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="da" inputName="da" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >db</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="db" inputName="db" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dc</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dc" inputName="dc" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dd</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dd" inputName="dd" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >de</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="de" inputName="de" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">df</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="df" inputName="df" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >dg</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dg" inputName="dg" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dh</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dh" inputName="dh" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >di</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="di" inputName="di" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">dj</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="dj" inputName="dj" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >dk</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dk" inputName="dk" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dl</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dl" inputName="dl" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dm</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dm" inputName="dm" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dn</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dn" inputName="dn" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >do1</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="do1" inputName="do1" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dp</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dp" inputName="dp" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dq</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dq" inputName="dq" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dr</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dr" inputName="dr" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ds</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ds" inputName="ds" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dt</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dt" inputName="dt" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">du</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="du" inputName="du" maxLength="1000" ></textarea>
			</td>
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
