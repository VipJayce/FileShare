<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache" /> 
<script language="javascript">
    var venusbase = "<%=request.getContextPath()%>";
</script>
<title>uploadExcel</title>
</head>
<body style="overflow: auto;">
<div class="box_xinzeng">
<form name="upform" action="<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=uploadExcelForBatchInsertFinincoming" method="post">
<table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">
    <tr>
         <td class="td_1">附件上传:</td>
          <td td_2>
               <input type="text" id="attachNameInput" class="xText" name="attach_name" inputName="附件地址" value="" hiddenInputId="attach_name"/>
               <img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
              <input type="hidden" id="attackAddressInput" name="attach_address" value="">
          </td>
    </tr>
      <tr>
        <td class="td_1">是否有表头</td>
        <td class="td_2">
            <input type="radio" value="1" name="startrow">无表头
            <input type="radio" value="2" name="startrow" checked="checked">有表头
        </td>
        <input type="hidden" value="" name="fileID"/>
    </tr>
    <tr>
        <td align="right">希望导入的行数</td>
        <td align="left"><input type="text" name="maxNum" id="maxNum" value="" style="border: 1px solid #90B3CF">输入0或大于最大行数时，导入全部</td>
    </tr>
     <tr>
        <td class="td_1">银行</td>
        <td class="td_2">
             <d:select id="inc_bank" name="inc_bank" dictTypeId="BANK"></d:select>
        </td>
    </tr>
    <tr>
        <td class="td_1"><button id="sub" value="上传" >上传</button></td>
        <td class="td_2"><button onclick="javascript:window.close();">取消</button></td>
    </tr>
</table>
</form>
<div style="padding-left:10px; padding-top:20px;">excel格式：到款编号&nbsp;&nbsp;到款日期&nbsp;&nbsp;到款公司名称&nbsp;&nbsp;到款额</div>
</div>
</body>
<script type="text/javascript">

    _$(document).ready(function(){
        _$(_$("button")[0]).bind("click", function(){
            if(_$("#attachNameInput").val() == '') {
                alert('上传文件不能为空。');
                return false;
            }
            /*
            if($("#maxNum").val() == '') {
                alert('导入行数不能为空。');
                return false;
            }
            */
            var inc_back = document.getElementsByName('inc_bank');
            if(inc_back[0].value < 1) {
                alert('银行必须选择。');
                return false;
            }
            
            _$.ajax({
	            type : "post",
	            url : venusbase + "/FININCOMINGAction.do?cmd=uploadExcelForBatchInsertFinincoming",
	            data : _$("form").serialize(),
	            dataType : "html",
	            success : function(data) {
	                if (data && data.length < 4000) {
	                    if(data == '上传成功。') {
	                       alert(data);
	                       window.close();
	                    } else {
	                       alert(data);
	                       window.close();
	                    }
                    } else {
                        alert("上传失败。");
                    }
	            }
	        });
        });
    });
    
        //打开文件上传对话框
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2;
        var t = (screen.height - h) / 2;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
       
        //window.showModalDialog('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', "dialogWidth=600px; dialogHeight=400px");
    }
    
</script>
</html>