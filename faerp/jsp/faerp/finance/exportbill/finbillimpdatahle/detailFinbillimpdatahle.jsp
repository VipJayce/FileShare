<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.finance.exportbill.finbillimpdatahle.vo.FinbillimpdatahleVo" %>
<%@ page import="rayoo.finance.exportbill.finbillimpdatahle.util.IFinbillimpdatahleConstants" %>
<%  //取出本条记录
	FinbillimpdatahleVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (FinbillimpdatahleVo)request.getAttribute(IFinbillimpdatahleConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/FinbillimpdatahleAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >cust_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >cust_name：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCust_name())%></td>
		</tr>
		<tr>
			<td class="td_1" >d：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getD())%></td>
		</tr>
		<tr>
			<td class="td_1" >e：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getE())%></td>
		</tr>
		<tr>
			<td class="td_1" >f：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getF())%></td>
		</tr>
		<tr>
			<td class="td_1" >g：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getG())%></td>
		</tr>
		<tr>
			<td class="td_1" >h：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getH())%></td>
		</tr>
		<tr>
			<td class="td_1" >i：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getI())%></td>
		</tr>
		<tr>
			<td class="td_1" >j：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getJ())%></td>
		</tr>
		<tr>
			<td class="td_1" >k：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getK())%></td>
		</tr>
		<tr>
			<td class="td_1" >l：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getL())%></td>
		</tr>
		<tr>
			<td class="td_1" >m：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getM())%></td>
		</tr>
		<tr>
			<td class="td_1" >n：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getN())%></td>
		</tr>
		<tr>
			<td class="td_1" >o：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getO())%></td>
		</tr>
		<tr>
			<td class="td_1" >p：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getP())%></td>
		</tr>
		<tr>
			<td class="td_1" >q：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getQ())%></td>
		</tr>
		<tr>
			<td class="td_1" >r：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getR())%></td>
		</tr>
		<tr>
			<td class="td_1" >s：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getS())%></td>
		</tr>
		<tr>
			<td class="td_1" >t：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getT())%></td>
		</tr>
		<tr>
			<td class="td_1" >u：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getU())%></td>
		</tr>
		<tr>
			<td class="td_1" >v：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getV())%></td>
		</tr>
		<tr>
			<td class="td_1" >w：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getW())%></td>
		</tr>
		<tr>
			<td class="td_1" >x：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getX())%></td>
		</tr>
		<tr>
			<td class="td_1" >y：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getY())%></td>
		</tr>
		<tr>
			<td class="td_1" >z：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getZ())%></td>
		</tr>
		<tr>
			<td class="td_1" >aa：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAa())%></td>
		</tr>
		<tr>
			<td class="td_1" >ab：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAb())%></td>
		</tr>
		<tr>
			<td class="td_1" >ac：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAc())%></td>
		</tr>
		<tr>
			<td class="td_1" >ad：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAd())%></td>
		</tr>
		<tr>
			<td class="td_1" >ae：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAe())%></td>
		</tr>
		<tr>
			<td class="td_1" >af：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAf())%></td>
		</tr>
		<tr>
			<td class="td_1" >ag：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAg())%></td>
		</tr>
		<tr>
			<td class="td_1" >ah：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAh())%></td>
		</tr>
		<tr>
			<td class="td_1" >ai：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAi())%></td>
		</tr>
		<tr>
			<td class="td_1" >aj：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAj())%></td>
		</tr>
		<tr>
			<td class="td_1" >ak：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAk())%></td>
		</tr>
		<tr>
			<td class="td_1" >al：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAl())%></td>
		</tr>
		<tr>
			<td class="td_1" >am：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAm())%></td>
		</tr>
		<tr>
			<td class="td_1" >an：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAn())%></td>
		</tr>
		<tr>
			<td class="td_1" >ao：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAo())%></td>
		</tr>
		<tr>
			<td class="td_1" >ap：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAp())%></td>
		</tr>
		<tr>
			<td class="td_1" >aq：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAq())%></td>
		</tr>
		<tr>
			<td class="td_1" >ar：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAr())%></td>
		</tr>
		<tr>
			<td class="td_1" >as1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAs1())%></td>
		</tr>
		<tr>
			<td class="td_1" >at：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAt())%></td>
		</tr>
		<tr>
			<td class="td_1" >au：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAu())%></td>
		</tr>
		<tr>
			<td class="td_1" >av：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAv())%></td>
		</tr>
		<tr>
			<td class="td_1" >aw：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAw())%></td>
		</tr>
		<tr>
			<td class="td_1" >ax：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAx())%></td>
		</tr>
		<tr>
			<td class="td_1" >ay：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAy())%></td>
		</tr>
		<tr>
			<td class="td_1" >az：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAz())%></td>
		</tr>
		<tr>
			<td class="td_1" >ba：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBa())%></td>
		</tr>
		<tr>
			<td class="td_1" >bb：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBb())%></td>
		</tr>
		<tr>
			<td class="td_1" >bc：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBc())%></td>
		</tr>
		<tr>
			<td class="td_1" >bd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBd())%></td>
		</tr>
		<tr>
			<td class="td_1" >be：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBe())%></td>
		</tr>
		<tr>
			<td class="td_1" >bf：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBf())%></td>
		</tr>
		<tr>
			<td class="td_1" >bg：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBg())%></td>
		</tr>
		<tr>
			<td class="td_1" >bh：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBh())%></td>
		</tr>
		<tr>
			<td class="td_1" >bi：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBi())%></td>
		</tr>
		<tr>
			<td class="td_1" >bj：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBj())%></td>
		</tr>
		<tr>
			<td class="td_1" >bk：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBk())%></td>
		</tr>
		<tr>
			<td class="td_1" >bl：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBl())%></td>
		</tr>
		<tr>
			<td class="td_1" >bm：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBm())%></td>
		</tr>
		<tr>
			<td class="td_1" >bn：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBn())%></td>
		</tr>
		<tr>
			<td class="td_1" >bo：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBo())%></td>
		</tr>
		<tr>
			<td class="td_1" >bp：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBp())%></td>
		</tr>
		<tr>
			<td class="td_1" >bq：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBq())%></td>
		</tr>
		<tr>
			<td class="td_1" >br：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBr())%></td>
		</tr>
		<tr>
			<td class="td_1" >bs：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBs())%></td>
		</tr>
		<tr>
			<td class="td_1" >bt：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBt())%></td>
		</tr>
		<tr>
			<td class="td_1" >bu：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBu())%></td>
		</tr>
		<tr>
			<td class="td_1" >bv：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBv())%></td>
		</tr>
		<tr>
			<td class="td_1" >bw：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBw())%></td>
		</tr>
		<tr>
			<td class="td_1" >bx：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBx())%></td>
		</tr>
		<tr>
			<td class="td_1" >by1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBy1())%></td>
		</tr>
		<tr>
			<td class="td_1" >bz：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBz())%></td>
		</tr>
		<tr>
			<td class="td_1" >ca：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCa())%></td>
		</tr>
		<tr>
			<td class="td_1" >cb：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCb())%></td>
		</tr>
		<tr>
			<td class="td_1" >cc：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCc())%></td>
		</tr>
		<tr>
			<td class="td_1" >cd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCd())%></td>
		</tr>
		<tr>
			<td class="td_1" >ce：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCe())%></td>
		</tr>
		<tr>
			<td class="td_1" >cf：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCf())%></td>
		</tr>
		<tr>
			<td class="td_1" >cg：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCg())%></td>
		</tr>
		<tr>
			<td class="td_1" >ch：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCh())%></td>
		</tr>
		<tr>
			<td class="td_1" >ci：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCi())%></td>
		</tr>
		<tr>
			<td class="td_1" >cj：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCj())%></td>
		</tr>
		<tr>
			<td class="td_1" >ck：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCk())%></td>
		</tr>
		<tr>
			<td class="td_1" >cl：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCl())%></td>
		</tr>
		<tr>
			<td class="td_1" >cm：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCm())%></td>
		</tr>
		<tr>
			<td class="td_1" >cn：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCn())%></td>
		</tr>
		<tr>
			<td class="td_1" >co：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCo())%></td>
		</tr>
		<tr>
			<td class="td_1" >cp：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCp())%></td>
		</tr>
		<tr>
			<td class="td_1" >cq：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCq())%></td>
		</tr>
		<tr>
			<td class="td_1" >cr：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCr())%></td>
		</tr>
		<tr>
			<td class="td_1" >cs：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCs())%></td>
		</tr>
		<tr>
			<td class="td_1" >ct：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCt())%></td>
		</tr>
		<tr>
			<td class="td_1" >cu：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCu())%></td>
		</tr>
		<tr>
			<td class="td_1" >cv：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCv())%></td>
		</tr>
		<tr>
			<td class="td_1" >cw：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCw())%></td>
		</tr>
		<tr>
			<td class="td_1" >cx：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCx())%></td>
		</tr>
		<tr>
			<td class="td_1" >cy：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCy())%></td>
		</tr>
		<tr>
			<td class="td_1" >cz：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCz())%></td>
		</tr>
		<tr>
			<td class="td_1" >da：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDa())%></td>
		</tr>
		<tr>
			<td class="td_1" >db：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDb())%></td>
		</tr>
		<tr>
			<td class="td_1" >dc：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDc())%></td>
		</tr>
		<tr>
			<td class="td_1" >dd：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDd())%></td>
		</tr>
		<tr>
			<td class="td_1" >de：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDe())%></td>
		</tr>
		<tr>
			<td class="td_1" >df：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDf())%></td>
		</tr>
		<tr>
			<td class="td_1" >dg：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDg())%></td>
		</tr>
		<tr>
			<td class="td_1" >dh：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDh())%></td>
		</tr>
		<tr>
			<td class="td_1" >di：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDi())%></td>
		</tr>
		<tr>
			<td class="td_1" >dj：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDj())%></td>
		</tr>
		<tr>
			<td class="td_1" >dk：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDk())%></td>
		</tr>
		<tr>
			<td class="td_1" >dl：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDl())%></td>
		</tr>
		<tr>
			<td class="td_1" >dm：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDm())%></td>
		</tr>
		<tr>
			<td class="td_1" >dn：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDn())%></td>
		</tr>
		<tr>
			<td class="td_1" >do1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDo1())%></td>
		</tr>
		<tr>
			<td class="td_1" >dp：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDp())%></td>
		</tr>
		<tr>
			<td class="td_1" >dq：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDq())%></td>
		</tr>
		<tr>
			<td class="td_1" >dr：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDr())%></td>
		</tr>
		<tr>
			<td class="td_1" >ds：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDs())%></td>
		</tr>
		<tr>
			<td class="td_1" >dt：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDt())%></td>
		</tr>
		<tr>
			<td class="td_1" >du：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDu())%></td>
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
