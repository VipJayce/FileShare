<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.File"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="rayoo.system.product.vo.ProductVo"%>
<%@ page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo"%>
<%@ page import="rayoo.system.productscheme.vo.ProductschemeVo"%>
<%@ page import="rayoo.system.product.util.IProductConstants"%>
<%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<%@ page import="gap.rm.tools.helper.RmUploadHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js" />
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<%
	    AttachmentfileVo avo = null;//附件VO
	    if (request.getAttribute("AttachmentfileVo") != null) { //如果request中取出的bean不为空
	        avo = (AttachmentfileVo) request
	                .getAttribute("AttachmentfileVo"); //从request中取出vo, 赋值给resultVo
	    }
	    String attachName = avo == null ? "" : avo
	            .getAttachment_file_name().toString();
	    String attachAddress = avo == null ? "" : avo
	            .getAttachment_file_path().toString();
	%>
	<script language="javascript">
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
    }
   function Insert(){
   var title=document.getElementById("announce_title").value;
   var content=document.getElementById("announce_content").value;
   var readid=document.getElementById("read_man_id").value;
   if((title!=null&&title!="")&&(content!=null&&content!="")&&(readid!=null&&readid!="")){
   form.action="<%=request.getContextPath() %>/PbannounceinfoAction.do?cmd=insert";
   form.submit();
   }else{
   alert("请填写完必填项（*标记为必填）!");
   return false;
   }
   }
   //接收人树
   function getQueryTree(outputArray, basePath, inputType, rootCode, isSubmitAll, returnValueType, treeLevel, dataLimit){
        //回填的表单项名称
        if(outputArray==null) {
            alert("<fmt:message key='gap.authority.Set_the_single_name_of_the_table_filling' bundle='${applicationAuResources}' />");
            return false;
        }
        //树结点的类型，分radio和checkbox两种，默认radio
        if(inputType==null || inputType=="")
            inputType = "radio";

        //控制树的节点是否全带checkbox（radio），yes全带，no只有树的最末尾一层带
        if(isSubmitAll==null || isSubmitAll=="")
            isSubmitAll = "no";

        //返回值是哪个字段，可以选择partyrelation表的id、party_id和code三者之一，默认为code
        if(returnValueType==null || returnValueType=="")
            returnValueType = "party_id";
            
        //参数：控制树能展示到的层次，0 全部，1 公司，2 部门，3 岗位，-3 去除岗位，默认为0
        if(treeLevel == null || treeLevel=="") {
            treeLevel = "0";
        }
        
        //参数：是否控制数据权限,0 否，1 是
        if(dataLimit == null || dataLimit=="") {
            dataLimit = "0";
        }

        var treePath = basePath+"/jsp/authority/tree/treeQueryRef.jsp?inputType="+inputType+"&nodeRelationType=noRelation&basePath="+basePath+"&parent_code="+rootCode+"&submit_all="+isSubmitAll+"&return_type="+returnValueType+"&tree_level="+treeLevel+"&data_limit="+dataLimit;
        
        var rtObj = window.showModalDialog(treePath, new Object(),'dialogHeight=600px;dialogWidth=350px;resizable:yes;status:no;scroll:auto;');
        if(rtObj != undefined && rtObj.length > 0){
            var allTextValue = "";
            var allTextName = "";
            var allParentName = "";
            var detailedType = "";
            for(var i=0; i<rtObj.length-1; i++) {
                allTextValue += rtObj[i]['returnValue'] + ",";
                allTextName += rtObj[i]['childName'] + ",";
                allParentName += rtObj[i]["parentName"] + ",";
                detailedType += rtObj[i]["detailedType"] + ",";
            }
            allTextValue += rtObj[rtObj.length-1]['returnValue'];
            allTextName += rtObj[rtObj.length-1]['childName'];
            allParentName += rtObj[rtObj.length-1]['parentName'];
            detailedType += rtObj[rtObj.length-1]['detailedType'];
            var textValue = outputArray[0];
            var textName = outputArray[1];
            
            jQuery("#"+textValue).val(allTextValue);
            jQuery("#"+textValue).trigger("change");  
            
            jQuery("#"+textName).val(allTextName);
            jQuery("#"+textName).trigger("change");  
            
            if(outputArray.length>=3) {
                var textParentName = outputArray[2];
                jQuery("#"+textParentName).val(allParentName);
                jQuery("#"+textParentName).trigger("change");                
            }
            if(outputArray.length==4) {
                var nodeType = outputArray[3];
                jQuery("#"+nodeType).val(detailedType);
                jQuery("#"+nodeType).trigger("change");
            }
        } 
    }
   function Batch(){
     var url="<venus:base/>/jsp/faerp/system/announceinfo/pbannounceinfo/batchsend.jsp";
     showModalCenter(url, window,backvalue,640,540,"批量选择接收人");
   }
   function backvalue(obj)
   {
          document.all.form.batchids.value=obj;
   }
</script>
	</head>
	<body>

	<form name="form" method="post">

    <div id="right">
    <div class="right_title_bg">
    <div class=" right_title">发布信息</div>
    </div>
    <div class="ringht_s">
    <div class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript:Insert()">发送</a></li>
        <li class="pl"><a href="##" onClick="javascript:Batch();">批量设置接收人</a><input
            type="hidden" id="batchids" name="batchids" /></li>
        <li class="m"><a href="##" onClick="location.href='javascript:history.go(-1);'">返回</a></li> 
    </ul>
    </div>
    <div class="clear"></div>
    </div>

    <div id="ccParent0" class="box_3">
    <table class="table_div_control">
    </table>
    </div>
    <div id="ccChild0" class="box_3">
    <table width="100%" height="40" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1"><span class="style_required_red">* </span>信息类别</td>
            <td class="td_2 "><d:select dictTypeId="ANNOUNCE_TYPE"
                id="announce_type" name="announce_type" /></td>
        </tr>
        <tr>
            <td class="td_1"><span class="style_required_red">* </span>标题</td>
            <td class="td_2"><input name="announce_title" type="text"
                style="width: 200px;" class="sText" id="announce_title" value="" /></td>
        </tr>
        <tr>
            <td width="12%" align="right" class="td_1">附件上传:</td>
            <td width="20%" align="left" class="td_2"><input type="text"
                id="attachNameInput" class="text_field_reference_readonly"
                name="attach_name" inputName="附件地址"
                value="<%=gap.rm.tools.helper.RmStringHelper.prt(attachName)%>"
                hiddenInputId="attach_name" readonly="readonly"/><img class="refButtonClass"
                src="<%=request.getContextPath()%>/images/icon/reference.gif"
                onClick="javascript:UploadFileWindow();" /> <input type="hidden"
                id="attackAddressInput" name="attach_address"
                value="<%=gap.rm.tools.helper.RmStringHelper.prt(attachAddress)%>" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><span class="style_required_red">* </span>接收人</td>
            <td width="30%" align="left" class="td_2"><input type="text"
                class="" validators="isSearch" id="name14" name="name14"
                inputName="接收人" size="108" maxlength="700"
                hiddenInputId="read_man_id" readonly="readonly"/><input type="hidden" id="read_man_id"
                name="read_man_id" /><img class="refButtonClass"
                src="<venus:base/>/images/au/09.gif"
                onClick="javascript:getQueryTree(new Array('read_man_id', 'name14', 'parentName', 'textType'),'<venus:base/>','checkbox','','','','','1');" />
            </td>
        </tr>
        <tr>
            <td class="td_1"><span class="style_required_red">* </span>发布内容编辑</td>
            <td class="td_2"><textarea name="announce_content" rows="8"
                style="width: 700px" class="xText_d" id="announce_content"></textarea>
            </td>
        </tr>
    </table>
    </div>

    </div>

    </div>

    </form>
	<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
	</body>
</fmt:bundle>
</html>
