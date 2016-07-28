<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>发送在线人消息</title>
<link href="../../style/common.css" rel="stylesheet" type="text/css" />
<link href="../../style/index.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" src="../../scripts/common.js"></script>
<script langusge="javascript" >
 //datacell1 checkbox begin
     function setCheckboxStatus(value,entity,rowNo,cellNo){
        var returnStr = "";
       returnStr =  "<input   type='checkbox' onclick='changeCheck(" + rowNo + ",this);'  name='checkbox1' id='checkboxId' value='" + entity.getProperty("login_id")  + "@" +entity.getProperty("party_id")+ "'>";
       return returnStr;
    }
    function checkAllList(all){
    	if(all.checked){
	        var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
	                element[i].checked= true;
	            }
	        } 
	    }else{
	    	var element = document.getElementsByTagName("input");
	        for(var i=0;i<element.length;i++){
	            if(element[i].type=="checkbox" && element[i].name=="checkbox1") {
	                element[i].checked= false;
	            }
	        } 
	    }
    }
    
    function changeCheck(rowNo,box){
    	
    }
  	// end
  	
  	 function saveSms(){
  			var content = $id("content").value;
  			var ids = findSelections("checkbox1","id");

  	 		if(ids==null || ids== 'null'){
     			alert("请选择要要发送的人员！");
     			return;
     		}
     		if(!content){
     			alert("请输入消息内容！");
     			return;
     		}
  	 		$id("send").style.display="none";
  	 		$id("sending").style.display="block";
  	 		$id("sending").disabled="true";
     		
		    jQuery.getJSON("<venus:base/>/SmsSenderAction.do?cmd=send&ids=" + ids,{"content":content},function(json){
				alert(json.returnString);
				$id("send").style.display="block";
	  	 		$id("sending").style.display="none";
	  	 		
		        json = null;
	        });
     }
     
      function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
</script>
</head>
<body>
<form name="form" action="" method="post">
<div id="right">
<div class="right_title_bg">
<div class=" right_title">发送在线人消息</div>
</div>
<div class="ringht_s"><!--查询 -->
<div class="search"></div>
<!--查询 end--> <!--按钮-->
<div class="button">
<div class="button_right"></div>
</div>
<!--按钮 end--> <!--表格 -->
		<r:datacell id="celllist1"
			queryAction="/FAERP/SmsSenderAction.do?cmd=getOnlineUser"
			paramFormId="form" width="100%" height="350px" xpath="OnlineUserVo"
			readonly="true"  pageSize="100000">
			
			<r:field allowModify="false" fieldName="" sortAt="none"
				label="<input type='checkbox' name='checkall' value='' onclick='checkAllList(this);' />"
				width="70px" onRefreshFunc="setCheckboxStatus">
			</r:field>
			<r:field fieldName="login_id" label="登录账号" width="130px">
				<h:text />
			</r:field>
			<r:field fieldName="name" label="用户名" width="130px">
				<h:text />
			</r:field>
			<r:field fieldName="login_ip" label="IP地址" width="90px">
				<h:text />
			</r:field>
			<r:field fieldName="host" label="主机名" width="130px">
				<h:text />
			</r:field>
			<r:field fieldName="login_time" label="登录时间" width="130px">
				<h:text />
			</r:field>
		</r:datacell>
<!--表格 end--> <!--翻页 --> <!--表格2-->
<div class="box_2">
<div class="xz_title">消息信息</div>
<table width="100%" height="76" border="0" cellpadding="0"
	cellspacing="1" bgcolor="#c5dbe2">
	<tr>
		<td class="td_2" width="100%" height="76"><textarea
			name="content" rows="4" class="xText_d" id="content"
			style="width: 98%;" >您好！由于数据库数据整理，我们必须现在重启系统服务程序，将停止运行10分钟时间，请谅解！ 务必重新登入系统！</textarea></td>
	</tr>
	<tr>
		<td colspan="3" align="center" valign="middle" class="td_2">
			<span class="mx_button" > 
				<input id="send" name="send" type="button"	class="icon_4" value="向当前在线人发送短消息" onclick="saveSms()" />
				<input id="sending" name="sending"  type="button" class="icon_4" value="正在发送...." style="display:none" />
			</span>
		</td>
	</tr>
</table>
<br>
<div class="mx_button"></div>
</div>
<!--表格2 end--></div>
</div>
</form>
</body>
</html>
