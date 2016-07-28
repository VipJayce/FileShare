<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@ page import="java.util.*" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" /> 

<title></title>
</head>
<script>
    function leading_in()
    {
       var radios = document.getElementsByName("Settlementclaim");
        var attachName = document.getElementById("attachNameInput").value;
        if(attachName==null||attachName=="")
        {
            alert("上传文件不能为空，请选择上传的附件！");
            return ;
        }
        else
        {
            var  length = attachName.lastIndexOf(".");
            var postfix = attachName.substring(length+1,attachName.length);
            if(postfix!="xls")
            {
                alert("上传的文件不是Excel，请重新选择！");
                document.getElementById("attachNameInput").value="";
                return ;
            }
        else
        {
           for(var i=0;i<radios.length;i++){             
             if(radios[i].checked){
                document.getElementById("type").value=radios[i].value;
             }
           }
            var type= document.getElementById("type").value;

            form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=importToExcel&type="+type;
            form.submit();
        }
        }
    }
    
    function openError_onClick()
    {
         var url = "<%=request.getContextPath()%>/jsp/faerp/insurance/settlementclaim/errorDesc.jsp";
         showModalCenter(url, window,null,750,400,"查看错误信息");
    }
</script>
<body>
 
<form name="form" method="post" enctype="multipart/form-data">

    	<div class="ringht_s">
 

<div id="ccParent0" class="box_3"> 

</div>

<div id="ccChild0" class="box_3">
    <%
    System.out.println(request.getAttribute("Settlementclaimerror"));
    if(request.getAttribute("Settlementclaimerror") != null){
        List settlementclaimerrorList = (List)request.getAttribute("Settlementclaimerror");
        if(settlementclaimerrorList.size()>0){
        %>
        <center><a style="color: red;" href="#" onClick="javascript:openError_onClick();">导入<%=settlementclaimerrorList.size() %>处错误，点击查看！</a></center>
        <%
    }}
    %>
	<table width="100%" height="30" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	   <tr>
	   <td class="td_1"  style="width: 200px;">Excel：</td> 
            <td class="td_2">   
                <input type="radio" name="Settlementclaim" checked="checked" value="1"/>导入理赔申请单 &nbsp;&nbsp;&nbsp;   <input type="radio" name="Settlementclaim"  value="2"/>导入理赔结果
            </td>
	   </tr>
		<tr>
			<td class="td_1"  style="width: 200px;"> 附件上传：</td>
			<td class="td_2">
	             <input type="file"  id="attachNameInput" name="attachNameInput"/>
	             <input type="hidden" id="type" name="type" >
	             <a onclick="toDownLoad_onclick()" href="#" style="color: blue;">点击下载模板</a>
			</td>
		</tr>
	</table>
</div>


  	
<div class="foot_button">
<input type="button" class="foot_icon_1" value='上传'  onclick="javascript:leading_in();" />
<input type="button" class="foot_icon_1" value='关闭'  onclick="javascript:window.close();" />
</div>


</div>


	 </div>

</form>

</body>
</html>
<script type="text/javascript">
//var msg = '${msg}';
//if(msg!=null&&msg!="")
//{
  //  alert('');
//}
function toDownLoad_onclick(){
      window.location="<%=request.getContextPath()%>/SettlementclaimAction.do?cmd=downLoad&inputtype=1" ;
}
if (${msg != null && msg != '' }){
    alert('${msg }');
}
</script>
