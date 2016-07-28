<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.finance.billimport.finbillimpdatacountry.vo.FinbillimpdatacountryVo" %>
<%@ page import="rayoo.finance.billimport.finbillimpdatacountry.util.IFinbillimpdatacountryConstants" %>
<%  //取出本条记录
	FinbillimpdatacountryVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (FinbillimpdatacountryVo)request.getAttribute(IFinbillimpdatacountryConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/FinbillimpdatacountryAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
 
	
       <div id="right">
		<div class="right_title_bg">
	 <div class=" right_title">	<fmt:message key="detail_page"/>
	 </div>
	 </div>
    	<div class="ringht_s">
 

<div id="ccParent0" class="box_3"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="details"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" >company_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCompany_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >bill_imp_batch_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBill_imp_batch_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_failure：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_failure())%></td>
		</tr>
		<tr>
			<td class="td_1" >failure_reason：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFailure_reason())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_id_card_no：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_id_card_no())%></td>
		</tr>
		<tr>
			<td class="td_1" >emp_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEmp_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >a1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA1())%></td>
		</tr>
		<tr>
			<td class="td_1" >a2：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA2())%></td>
		</tr>
		<tr>
			<td class="td_1" >a3：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA3())%></td>
		</tr>
		<tr>
			<td class="td_1" >a4：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA4())%></td>
		</tr>
		<tr>
			<td class="td_1" >a5：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA5())%></td>
		</tr>
		<tr>
			<td class="td_1" >a6：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA6())%></td>
		</tr>
		<tr>
			<td class="td_1" >a7：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA7())%></td>
		</tr>
		<tr>
			<td class="td_1" >a8：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA8())%></td>
		</tr>
		<tr>
			<td class="td_1" >a9：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA9())%></td>
		</tr>
		<tr>
			<td class="td_1" >a10：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA10())%></td>
		</tr>
		<tr>
			<td class="td_1" >a11：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA11())%></td>
		</tr>
		<tr>
			<td class="td_1" >a12：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA12())%></td>
		</tr>
		<tr>
			<td class="td_1" >a13：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA13())%></td>
		</tr>
		<tr>
			<td class="td_1" >a14：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA14())%></td>
		</tr>
		<tr>
			<td class="td_1" >a15：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA15())%></td>
		</tr>
		<tr>
			<td class="td_1" >a16：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA16())%></td>
		</tr>
		<tr>
			<td class="td_1" >a17：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA17())%></td>
		</tr>
		<tr>
			<td class="td_1" >a18：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA18())%></td>
		</tr>
		<tr>
			<td class="td_1" >a19：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA19())%></td>
		</tr>
		<tr>
			<td class="td_1" >a20：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA20())%></td>
		</tr>
		<tr>
			<td class="td_1" >a21：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA21())%></td>
		</tr>
		<tr>
			<td class="td_1" >a22：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA22())%></td>
		</tr>
		<tr>
			<td class="td_1" >a23：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA23())%></td>
		</tr>
		<tr>
			<td class="td_1" >a24：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA24())%></td>
		</tr>
		<tr>
			<td class="td_1" >a25：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA25())%></td>
		</tr>
		<tr>
			<td class="td_1" >a26：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA26())%></td>
		</tr>
		<tr>
			<td class="td_1" >a27：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA27())%></td>
		</tr>
		<tr>
			<td class="td_1" >a28：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA28())%></td>
		</tr>
		<tr>
			<td class="td_1" >a29：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA29())%></td>
		</tr>
		<tr>
			<td class="td_1" >a30：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA30())%></td>
		</tr>
		<tr>
			<td class="td_1" >a31：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA31())%></td>
		</tr>
		<tr>
			<td class="td_1" >a32：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA32())%></td>
		</tr>
		<tr>
			<td class="td_1" >a33：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA33())%></td>
		</tr>
		<tr>
			<td class="td_1" >a34：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA34())%></td>
		</tr>
		<tr>
			<td class="td_1" >a35：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA35())%></td>
		</tr>
		<tr>
			<td class="td_1" >a36：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA36())%></td>
		</tr>
		<tr>
			<td class="td_1" >a37：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA37())%></td>
		</tr>
		<tr>
			<td class="td_1" >a38：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA38())%></td>
		</tr>
		<tr>
			<td class="td_1" >a39：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA39())%></td>
		</tr>
		<tr>
			<td class="td_1" >a40：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA40())%></td>
		</tr>
		<tr>
			<td class="td_1" >a41：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA41())%></td>
		</tr>
		<tr>
			<td class="td_1" >a42：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA42())%></td>
		</tr>
		<tr>
			<td class="td_1" >a43：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA43())%></td>
		</tr>
		<tr>
			<td class="td_1" >a44：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA44())%></td>
		</tr>
		<tr>
			<td class="td_1" >a45：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA45())%></td>
		</tr>
		<tr>
			<td class="td_1" >a46：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA46())%></td>
		</tr>
		<tr>
			<td class="td_1" >a47：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA47())%></td>
		</tr>
		<tr>
			<td class="td_1" >a48：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA48())%></td>
		</tr>
		<tr>
			<td class="td_1" >a49：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA49())%></td>
		</tr>
		<tr>
			<td class="td_1" >a50：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA50())%></td>
		</tr>
		<tr>
			<td class="td_1" >a51：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA51())%></td>
		</tr>
		<tr>
			<td class="td_1" >a52：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA52())%></td>
		</tr>
		<tr>
			<td class="td_1" >a53：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA53())%></td>
		</tr>
		<tr>
			<td class="td_1" >a54：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA54())%></td>
		</tr>
		<tr>
			<td class="td_1" >a55：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA55())%></td>
		</tr>
		<tr>
			<td class="td_1" >a56：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA56())%></td>
		</tr>
		<tr>
			<td class="td_1" >a57：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA57())%></td>
		</tr>
		<tr>
			<td class="td_1" >a58：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA58())%></td>
		</tr>
		<tr>
			<td class="td_1" >a59：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA59())%></td>
		</tr>
		<tr>
			<td class="td_1" >a60：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA60())%></td>
		</tr>
		<tr>
			<td class="td_1" >a61：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA61())%></td>
		</tr>
		<tr>
			<td class="td_1" >a62：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA62())%></td>
		</tr>
		<tr>
			<td class="td_1" >a63：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA63())%></td>
		</tr>
		<tr>
			<td class="td_1" >a64：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA64())%></td>
		</tr>
		<tr>
			<td class="td_1" >a65：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA65())%></td>
		</tr>
		<tr>
			<td class="td_1" >a66：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA66())%></td>
		</tr>
		<tr>
			<td class="td_1" >a67：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA67())%></td>
		</tr>
		<tr>
			<td class="td_1" >a68：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA68())%></td>
		</tr>
		<tr>
			<td class="td_1" >a69：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA69())%></td>
		</tr>
		<tr>
			<td class="td_1" >a70：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA70())%></td>
		</tr>
		<tr>
			<td class="td_1" >a71：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA71())%></td>
		</tr>
		<tr>
			<td class="td_1" >a72：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA72())%></td>
		</tr>
		<tr>
			<td class="td_1" >a73：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA73())%></td>
		</tr>
		<tr>
			<td class="td_1" >a74：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA74())%></td>
		</tr>
		<tr>
			<td class="td_1" >a75：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA75())%></td>
		</tr>
		<tr>
			<td class="td_1" >a76：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA76())%></td>
		</tr>
		<tr>
			<td class="td_1" >a77：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA77())%></td>
		</tr>
		<tr>
			<td class="td_1" >a78：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA78())%></td>
		</tr>
		<tr>
			<td class="td_1" >a79：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA79())%></td>
		</tr>
		<tr>
			<td class="td_1" >a80：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA80())%></td>
		</tr>
		<tr>
			<td class="td_1" >a81：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA81())%></td>
		</tr>
		<tr>
			<td class="td_1" >a82：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA82())%></td>
		</tr>
		<tr>
			<td class="td_1" >a83：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA83())%></td>
		</tr>
		<tr>
			<td class="td_1" >a84：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA84())%></td>
		</tr>
		<tr>
			<td class="td_1" >a85：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA85())%></td>
		</tr>
		<tr>
			<td class="td_1" >a86：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA86())%></td>
		</tr>
		<tr>
			<td class="td_1" >a87：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA87())%></td>
		</tr>
		<tr>
			<td class="td_1" >a88：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA88())%></td>
		</tr>
		<tr>
			<td class="td_1" >a89：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA89())%></td>
		</tr>
		<tr>
			<td class="td_1" >a90：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA90())%></td>
		</tr>
		<tr>
			<td class="td_1" >a91：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA91())%></td>
		</tr>
		<tr>
			<td class="td_1" >a92：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA92())%></td>
		</tr>
		<tr>
			<td class="td_1" >a93：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA93())%></td>
		</tr>
		<tr>
			<td class="td_1" >a94：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA94())%></td>
		</tr>
		<tr>
			<td class="td_1" >a95：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA95())%></td>
		</tr>
		<tr>
			<td class="td_1" >a96：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA96())%></td>
		</tr>
		<tr>
			<td class="td_1" >a97：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA97())%></td>
		</tr>
		<tr>
			<td class="td_1" >a98：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA98())%></td>
		</tr>
		<tr>
			<td class="td_1" >a99：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA99())%></td>
		</tr>
		<tr>
			<td class="td_1" >a100：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA100())%></td>
		</tr>
		<tr>
			<td class="td_1" >a101：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA101())%></td>
		</tr>
		<tr>
			<td class="td_1" >a102：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA102())%></td>
		</tr>
		<tr>
			<td class="td_1" >a103：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA103())%></td>
		</tr>
		<tr>
			<td class="td_1" >a104：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA104())%></td>
		</tr>
		<tr>
			<td class="td_1" >a105：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA105())%></td>
		</tr>
		<tr>
			<td class="td_1" >a106：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA106())%></td>
		</tr>
		<tr>
			<td class="td_1" >a107：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA107())%></td>
		</tr>
		<tr>
			<td class="td_1" >a108：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA108())%></td>
		</tr>
		<tr>
			<td class="td_1" >a109：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA109())%></td>
		</tr>
		<tr>
			<td class="td_1" >a110：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA110())%></td>
		</tr>
		<tr>
			<td class="td_1" >a111：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA111())%></td>
		</tr>
		<tr>
			<td class="td_1" >a112：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA112())%></td>
		</tr>
		<tr>
			<td class="td_1" >a113：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA113())%></td>
		</tr>
		<tr>
			<td class="td_1" >a114：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA114())%></td>
		</tr>
		<tr>
			<td class="td_1" >a115：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA115())%></td>
		</tr>
		<tr>
			<td class="td_1" >a116：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA116())%></td>
		</tr>
		<tr>
			<td class="td_1" >a117：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA117())%></td>
		</tr>
		<tr>
			<td class="td_1" >a118：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA118())%></td>
		</tr>
		<tr>
			<td class="td_1" >a119：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA119())%></td>
		</tr>
		<tr>
			<td class="td_1" >a120：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA120())%></td>
		</tr>
		<tr>
			<td class="td_1" >a121：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA121())%></td>
		</tr>
		<tr>
			<td class="td_1" >a122：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA122())%></td>
		</tr>
		<tr>
			<td class="td_1" >a123：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA123())%></td>
		</tr>
		<tr>
			<td class="td_1" >a124：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA124())%></td>
		</tr>
		<tr>
			<td class="td_1" >a125：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA125())%></td>
		</tr>
		<tr>
			<td class="td_1" >a126：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA126())%></td>
		</tr>
		<tr>
			<td class="td_1" >a127：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA127())%></td>
		</tr>
		<tr>
			<td class="td_1" >a128：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA128())%></td>
		</tr>
		<tr>
			<td class="td_1" >a129：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA129())%></td>
		</tr>
		<tr>
			<td class="td_1" >a130：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA130())%></td>
		</tr>
		<tr>
			<td class="td_1" >a131：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA131())%></td>
		</tr>
		<tr>
			<td class="td_1" >a132：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA132())%></td>
		</tr>
		<tr>
			<td class="td_1" >a133：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA133())%></td>
		</tr>
		<tr>
			<td class="td_1" >a134：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA134())%></td>
		</tr>
		<tr>
			<td class="td_1" >a135：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA135())%></td>
		</tr>
		<tr>
			<td class="td_1" >a136：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA136())%></td>
		</tr>
		<tr>
			<td class="td_1" >a137：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA137())%></td>
		</tr>
		<tr>
			<td class="td_1" >a138：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA138())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_del：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_del())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_user_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_user_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >last_update_date：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getLast_update_date(), 10)%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_code())%></td>
		</tr>
		<tr>
			<td class="td_1" align="right"></td>
			<td class="td_2" align="left"></td>
		</tr>
	</table>
</div>


  	
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>


</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
