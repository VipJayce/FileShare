<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.eppartyrelation.vo.EppartyrelationVo" %>
<%@ page import="rayoo.employeepost.eppartyrelation.util.IEppartyrelationConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	EppartyrelationVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEppartyrelationConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EppartyrelationVo)request.getAttribute(IEppartyrelationConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="rayoo.employeepost.eppartyrelation.eppartyrelation_resource" prefix="rayoo.employeepost.eppartyrelation.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
 function cancel_onClick()
 {
    window.close();
 }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<div id="ccParent0" class="box_3"> 
<div class="xz_title"><fmt:message key="party_info"/></div>

<table  width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td  style="background:#f1f7f9; text-align:right; width:200px;"><fmt:message key="to_party_date"/>            </td>
            <td style="background:#fff;width:200px;">  <fmt:formatDate value="${bean.in_date }" pattern="yyyy-MM-dd"/>               </td>
            <td style="background:#f1f7f9; text-align:right; width:200px;" ><fmt:message key="become_date1"/>            </td>
            <td style="background:#fff;width:200px;" >  <fmt:formatDate value="${bean.become_date }" pattern="yyyy-MM-dd"/>  </td>
        </tr>
        <tr>
            <td style="background:#f1f7f9; text-align:right; width:200px;" ><fmt:message key="relation_area1"/></td>
            <td style="background:#fff;width:200px;">${bean.relation_area }     </td>
            <td style="background:#f1f7f9; text-align:right; width:200px;" ><fmt:message key="inside_position"/></td>
            <td style="background:#fff;width:200px;" >${bean.inside_position }    </td>
        </tr>
        <tr>
            <td style="background:#f1f7f9; text-align:right; width:200px;"><fmt:message key="is_secretary"/></td>
            <td style="background:#fff;width:200px;">${bean.is_secretary }</td>
            <td style="background:#f1f7f9; text-align:right; width:200px;" ><fmt:message key="is_over_sea_in"/></td>
            <td style="background:#fff;width:200px;">${bean.is_over_sea_in}</td>
        </tr>
        <tr>
            <td style="background:#f1f7f9; text-align:right; width:200px;"><fmt:message key="is_prepare"/></td>
            <td style="background:#fff;width:200px;" colspan="3">${bean.is_prepare}</td>
        </tr>
        <tr>
            <td style="background:#f1f7f9; text-align:right; width:200px;"><fmt:message key="on_post_desc1"/></td>
            <td style="background:#fff;width:200px;" colspan="3">${bean.memberremarks }</td>

        </tr>
        
    </table>
<div id="move_in" style="display:none; ">

	<div class="xz_title"><fmt:message key="transfer_info"/></div>
	<table  width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	        <tr>
	            <td style="background:#f1f7f9; text-align:right; width:200px;"><fmt:message key="begin_transfer_info_where"/>            </td>
	            <td style="background:#fff;width:200px;">${bean.relation_area}                   </td>
	            <td  style="background:#f1f7f9; text-align:right; width:200px;" ><fmt:message key="transfer_partyCode1"/>         </td>
	            <td style="background:#fff;width:200px;" >${bean.relationship_to}      </td>
	        </tr>
	        <tr>
	            <td style="background:#f1f7f9; text-align:right; width:200px;" ><fmt:message key="transfer_date"/></td>
	            <td style="background:#fff;width:200px;"  colspan="3"> <fmt:formatDate value="${bean.create_date }" pattern="yyyy-MM-dd"/>  </td>
	            </tr>
	                 <tr>
                     <td style="background:#f1f7f9; text-align:right; width:200px;"><fmt:message key="on_post_desc1"/>            </td>
                    <td style="background:#fff;width:200px;"  colspan="3">  ${bean.remarks }             </td>
                   </tr>
	    </table>
    </div>
    <div id="move_out" style="display:none; ">
		<div class="xz_title"><fmt:message key="turn_to_info"/></div>
		<table  width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		        <tr>
		            <td style="background:#f1f7f9; text-align:right; width:200px;" ><fmt:message key="turn_out_date"/>            </td>
		            <td style="background:#fff;width:200px;"><fmt:formatDate value="${bean.move_out_date }" pattern="yyyy-MM-dd"/>                   </td>
		            <td  style="background:#f1f7f9; text-align:right; width:200px;" ><fmt:message key="relationship_to"/></td>
		            <td style="background:#fff;width:200px;" >${bean.relationship_to}      </td>
		        </tr>
		        <tr>
	            	 <td style="background:#f1f7f9; text-align:right; width:200px;"><fmt:message key="on_post_desc1"/>            </td>
                    <td style="background:#fff;width:200px;"  colspan="3">  ${bean.remarks }             </td>
		           </tr>
		    </table>
    </div>
        <div id="feeshow" style="display:none; ">
    <div class="xz_title"><fmt:message key="party_fee_in_info"/></div>
        <table  width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                    <td style="background:#f1f7f9; text-align:right; width:200px;" ><fmt:message key="party_fee_end_date1"/>            </td>
                    <td style="background:#fff;width:200px;">  ${bean.end_date }             </td>
                    <td  style="background:#f1f7f9; text-align:right; width:200px;" ><fmt:message key="in_money"/></td>
                    <td style="background:#fff;width:200px;" >     ${bean.in_money }</td>
                </tr>
                <tr>
                    <td style="background:#f1f7f9; text-align:right; width:200px;"><fmt:message key="don_money"/>            </td>
                    <td style="background:#fff;width:200px;"  colspan="3">  ${bean.don_money }             </td>
                   </tr>
            </table>
            </div>
    <div class="mx_button" style="text-align: center;">
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
     </div>       

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	var relationstatus='${bean.status}';
	if(relationstatus=='2'||relationstatus=='4')
	{
	        document.getElementById("move_in").style.display="block";
	        document.getElementById("move_out").style.display="none";
	        document.getElementById("feeshow").style.display="block";
	}
	else if(relationstatus=="3")
	{
	       document.getElementById("move_out").style.display="block";
	       document.getElementById("move_in").style.display="none";
	       document.getElementById("feeshow").style.display="block";
	}
	else
	{
	       document.getElementById("move_out").style.display="none";
           document.getElementById("move_in").style.display="none";
           document.getElementById("feeshow").style.display="none";
	}
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
