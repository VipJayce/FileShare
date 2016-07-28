<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />

<%
    String uploadDir = request.getParameter("uploadDir");
    String paymentID = request.getParameter("paymentID");
    String creditDate = request.getParameter("creditDate");
    String firsttime = request.getParameter("firsttime");
    String remittedPic = request.getParameter("remittedPic");
    if(!"".equals(creditDate)&&!"null".equals(creditDate)&&creditDate !=null){
        if(creditDate.length() > 9){
            creditDate = creditDate.substring(0,10);
        }
    }else{
        creditDate = "";
    }
%>
<html>
<head>
<script language="javascript"
	src="<%=request.getContextPath()%>/js/common/fesco.js"></script>
<script language="javascript"
	src="<%=request.getContextPath()%>/js/dd/jquery/jquery.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传截图</title>

</head>
<body class="uploadPage" onload="javascript:test();">
	<center>
		<form name="form" method="post" enctype="multipart/form-data">
		    <table style="width: 100%;margin-top: 30px;margin-left: 30px;">
		          <tr>
		              <td>
              文件：
		              </td>
		              <td>
		                  <input type="file" id="fileInput" name="file1">
		              </td>
		          </tr>
		          <tr>
                      <td align="left">
              公积金进账时间：
                      </td>
                      <td align="left">
                            <w:date allowInput="true" id="creditDate" name="creditDate" format="YYYY-MM-DD" value="<%=creditDate%>"/>
                            <input style="margin-left: 15px;"  type="button" value="确定" onclick="javascript:upload_onClick();">
                      </td>
                  </tr>
            </table>
            <%
                  if(!"".equals(remittedPic) && !"null".equals(remittedPic)&&remittedPic!=null){
            %>
                    <div style="margin-top:  100px;">
		                <a style="color:red;font-weight:bold;">注：此操作将替换掉原有图片信息！</a>
		                <a style="color:blue;font-weight:bold;" href="<%=request.getContextPath()%>/<%=remittedPic %>" onClick="javascript:window.open(this.href,'_blank','width=800,height=600,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;">原图预览</a>
		            </div>
            <%         
                  }
            %>
            
	    </form>
	</center>
	<script language="javascript">
	   <%
	          if(!"first".equals(firsttime)){
	    %>
	               $(document).ready(function (){ 
		              if("${uploadResult}" == "1" || "${uploadResult}" == "2"){
		                  window.parent.window.close();
		                  window.parent.opener.reloadDataCell1();
		              }else{
		                  if(window.confirm("上传失败，原因是：${uploadResult}，是否重新上传? ")){
		                        form.action = "<%=request.getContextPath() %>/jsp/faerp/customerservice/security/SecurityManger/securityAttachUploadFrame.jsp?uploadDir=${uploadDir}&firsttime=first&paymentID=${paymentID}&creditDate=${creditDate}&remittedPic=${remittedPic}";
                                form.submit();
		                  }else{
		                        window.parent.window.close();
		                  }
		              }
		         }); 
	    <%          
	          }
	   %>
        

	
	
	   function upload_onClick() {
	        var creditDateVal = document.getElementById("creditDate").value;
	        var ss = document.getElementById("fileInput").value;
	        if(creditDateVal == ""){
	           alert("请填写公积金进账时间！");
	           return;
	        }
	        
	        if(ss==""){
	            form.action = "<%=request.getContextPath()%>/SecurityManagerAction.do?cmd=uploadPic&paymentID=<%=paymentID%>&creditDateVal="+creditDateVal;
                form.submit();
	        }else{
	            if(ss.indexOf(".jpg")<0){
	               alert("文件只能为jpg类型！");
	               return;
	            }else{
	               form.action = "<%=request.getContextPath()%>/SecurityManagerAction.do?cmd=uploadPic&paymentID=<%=paymentID%>&picPath=<%=uploadDir%>&creditDateVal="+creditDateVal;
	               form.submit();
	            }
	        }
	    }
	</script>
</body>
</html>
