<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.welfareproduct.vo.WelfareProductVo" %>
<%@ page import="rayoo.insurance.welfareproduct.util.IWelfareProductConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	WelfareProductVo resultVo = null;  //定义一个临时的vo变量
	if(request.getAttribute(IWelfareProductConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
	    resultVo = (WelfareProductVo)request.getAttribute(IWelfareProductConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/WelfareProductAction.do?cmd=queryAll&backFlag=false";
       //form.submit();
       window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<div id="right">
<!--<script language="javascript">
        writeTableTopFesco('查看福利产品','<%=request.getContextPath()%>/');
</script>
 --><div class="ringht_s">
<div id="ccChild0"     class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="10%">产品大类</td>
            <td class="td_2 " width="20%"><%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(resultVo.getBig_type_id()))%> </td>
            <td class="td_1" width="10%">产品小类</td>
            <td class="td_2 " width="20%"><%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(resultVo.getSmall_type_id()))%> </td>
            <td class="td_1" width="10%">三级分类</td>
            <td class="td_2 " width="30%"><%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(resultVo.getThree_type_id()))%></td>
        </tr>
         <tr>
            <td class="td_1" >产品名称</td>
            <td class="td_2 ">
                <%=resultVo.getProduct_name() %>
            </td>
            <td class="td_1" >是否定方案产品</td>
            <td class="td_2 "><%=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(resultVo.getIs_scheme()))%></td>
            <td class="td_1" >方案类型</td>
            <td class="td_2 "><%=BaseDataHelper.getNameByCode("scheme_type",String.valueOf(resultVo.getScheme_type()))%></td>
        </tr>
        <tr>
            <td class="td_1" >保额类型</td>
            <td class="td_2 "><%=(BaseDataHelper.getNameByCode("COVERAGE_TYPE",String.valueOf(resultVo.getCoverage_type())))==null?"":(BaseDataHelper.getNameByCode("COVERAGE_TYPE",String.valueOf(resultVo.getCoverage_type())))%></td>
            <!-- 最好是，保额类型选择“月薪倍数”时，“保额额度” 这里能动态变化为下拉选择框，选项值为：24倍月薪，36倍月薪，48倍月薪 -->
            <%if(resultVo.getCoverage_type()==null||!resultVo.getCoverage_type().equals("4")){ %>
                <td class="td_1">保额额度</td>
                <td class="td_2"><%=resultVo.getCoverage_limit()==null?"":resultVo.getCoverage_limit() %></td>
            <%}else{ %>
                <td class="td_1">月薪倍数</td>
                <td class="td_2"><%=BaseDataHelper.getNameByCode("M_SALARY_MULTIPLE",String.valueOf(resultVo.getM_salary_multiple()))%></td>
            <%} %>
            <td class="td_1" >免责期</td>
            <td class="td_2" ><%=resultVo.getRelief_limit()==null?"":resultVo.getRelief_limit() %></td>
        </tr>       
        <tr>
            <td class="td_1" >赔付比例</td>
            <td class="td_2 "><%=resultVo.getCompensation_proportion()==null?"":resultVo.getCompensation_proportion() %></td>
            <td class="td_1" >日免赔额</td>
            <td class="td_2" ><%=resultVo.getDay_franchise()==null?"":resultVo.getDay_franchise() %></td>
            <td class="td_1" >年免赔额</td>
            <td class="td_2" ><%=resultVo.getYear_franchise()==null?"":resultVo.getYear_franchise() %></td>
        </tr>       
        <tr>
            <td class="td_1" >次免赔额</td>
            <td class="td_2 "><%=resultVo.getSub_franchise()==null?"":resultVo.getSub_franchise() %></td>
            <td class="td_1" >日封顶额</td>
            <td class="td_2" ><%=resultVo.getDay_fde()==null?"":resultVo.getDay_fde() %></td>
            <td class="td_1" >年封顶额</td>
            <td class="td_2" ><%=resultVo.getYear_fde()==null?"":resultVo.getYear_fde() %></td>
        </tr>       
        <tr>
            <td class="td_1" >次封顶额</td>
            <td class="td_2 "><%=resultVo.getSub_fde()==null?"":resultVo.getSub_fde() %></td>
            <td class="td_1" >是否扣除生育津贴</td>
            <td class="td_2" ><%=resultVo.getSfkcsyjt()==null?"":resultVo.getSfkcsyjt() %></td>
            <td class="td_1" >疾病住院免责期</td>
            <td class="td_2" ><%=resultVo.getJbzymzq()==null?"":resultVo.getJbzymzq() %></td>
        </tr>       
        <tr>
            <td class="td_1" >意外住院免责期</td>
            <td class="td_2 "><%=resultVo.getYwzymzq()==null?"":resultVo.getYwzymzq() %></td>
            <td class="td_1" >是否有附险人</td>
            <td class="td_2" ><%=BaseDataHelper.getNameByCode("TrueOrFalse",String.valueOf(resultVo.getSfyfxr()))%></td>
            <td class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>       
        <tr>
            <td class="td_1" >简介</td>
            <td class="td_2 " colspan="5"><%=resultVo.getProduct_simple_desc()==null?"":resultVo.getProduct_simple_desc() %></td>
        </tr>       
        <tr>
            <td class="td_1" >详述</td>
            <td class="td_2 " colspan="5"><%=resultVo.getProduct_detail_desc()==null?"":resultVo.getProduct_detail_desc() %></td>
        </tr> 	
	</table>
   </div>
    <div class="mx_button" align="center">
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>  </div>       
            
<input type="hidden" name="id">
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
%>
</script>
