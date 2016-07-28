<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.finance.received.finbillimpdata.vo.FinbillimpdataVo" %>
<%@ page import="rayoo.finance.received.finbillimpdata.util.IFinbillimpdataConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	FinbillimpdataVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IFinbillimpdataConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (FinbillimpdataVo)request.getAttribute(IFinbillimpdataConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/FinbillimpdataAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/FinbillimpdataAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/FinbillimpdataAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >是否错误</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_failure" inputName="是否错误" value="" maxLength="64" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">错误原因</td>
			<td colspan="3" class="td_2" >
				<textarea class="textarea_limit_words" cols="60" rows="5" name="failure_reason" inputName="错误原因" maxLength="1000" ></textarea>
			</td>
		</tr>
		<tr>
			<td class="td_1" >员工ID</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_id" inputName="员工ID" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >员工唯一号</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_code" inputName="员工唯一号" value="" maxLength="5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >身份证</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_id_card_no" inputName="身份证" value="" maxLength="5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >员工姓名</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="emp_name" inputName="员工姓名" value="" maxLength="5" />
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
