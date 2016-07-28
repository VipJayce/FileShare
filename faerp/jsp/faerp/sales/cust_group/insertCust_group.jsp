<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.sales.customer.vo.CustomerVo" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.cust_group.vo.Cust_groupVo" %>
<%@ page import="rayoo.sales.cust_group.util.ICust_groupConstants" %>
<%  //判断是否为修改页面
	Cust_groupVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(ICust_groupConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (Cust_groupVo)request.getAttribute(ICust_groupConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		    System.out.println(resultVo.getCust_group_name());
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增客户组</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	var  cust_group_name = document.getElementById("cust_group_name").value;
        if(cust_group_name==null || cust_group_name==""){
            alert("请输入客户组名称！");
            return false;
        }
      var action="<%=request.getContextPath()%>/Cust_groupAction.do?cmd=insert";
      var myAjax = new Ajax(action);
       myAjax.addParam("cust_group_name", cust_group_name);
	  myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
             if( myAjax.getValue("root/data/returnValue") == 1 ) {
                   alert('保存成功');
                  returnValue = '1';
                  window.close();
                  window.opener.simpleQuery_onClick();
             } else {
                    alert('保存失败！'); 
                  returnValue = '0';
                  window.close();
                  window.opener.simpleQuery_onClick();
             }
        }
	
	
	}

  	function update_onClick(id){  //保存修改后的单条数据
  	 var  cust_group_name = document.getElementById("cust_group_name").value;
        if(cust_group_name==null || cust_group_name==""){
            alert("请输入客户组名称！");
            return false;
        }
        var  id = document.getElementById("id").value;
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		
	  var action="<%=request.getContextPath()%>/Cust_groupAction.do?cmd=update";
      var myAjax = new Ajax(action);
       myAjax.addParam("cust_group_name", cust_group_name);
       myAjax.addParam("id",id);
       myAjax.submit();
        var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
             if( myAjax.getValue("root/data/returnValue") == 1 ) {
                   alert('保存成功');
                  returnValue = '1';
                  window.close();
                  window.opener.simpleQuery_onClick();
             } else {
                    alert('保存失败！'); 
                  returnValue = '0';
                  window.close();
                  window.opener.simpleQuery_onClick();
             }
        }
		
	}

    function cancel_onClick(){  //取消后返回列表页面
    window.close();
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('修改页面','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('新增页面','<%=request.getContextPath()%>/');
</script>


 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
		<tr>
			<td class="td_2" >客户组名称&nbsp;&nbsp;</td>
			<td class="td_2 ">
			<%if (isModify) {%>
				<input type="text" class="text_field" name="cust_group_name" id="cust_group_name"  inputName="cust_group_name" value="<%=resultVo.getCust_group_name() %>" maxLength="100" />
				<input type="hidden" id="id" value="<%=resultVo.getId() %>"/>
				<%}else{ %>
				<input type="text" class="text_field" name="cust_group_name" id="cust_group_name" inputName="cust_group_name" value="" maxLength="100" />
				<%} %>
			</td>
		<td class="td_2"  colspan="2">
		 <input type="button" class="icon_2" value='保存' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='返回'  onClick="javascript:cancel_onClick()"/>
        </td>
		</tr>
	</table>
   
   
   
</div>         
            

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
