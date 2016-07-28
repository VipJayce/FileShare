<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.contract.vo.ContractVo" %>
<%@ page import="rayoo.sales.contract.util.IContractConstants" %>
<%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<%@ page import="gap.rm.tools.helper.RmUploadHelper" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script src="<%=request.getContextPath()%>/dwr/interface/TreeAjax.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/engine.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/util.js" type="text/javascript"></script> 
 <script language="javascript" src="<venus:base/>/js/ajax/gap-ajax-tree.js"></script>
 <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<%  //判断是否为修改页面
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
    }
    System.out.println(isModify);
%>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
    var contract_template_name = document.getElementById("contract_template_name").value;
    var contract_template_version = document.getElementById("contract_template_version").value;
    var effect_date = document.getElementById("effect_date").value;
    var lapse_date = document.getElementById("lapse_date").value;
         if(contract_template_name==""||contract_template_name.trim().length==0){
           alert("合同模板名称不能为空！");
           return ;
        }
        if(effect_date==""||lapse_date==""){
        alert("合同日期不能为空！");
        return;
        }
          if(effect_date!=""||effect_date.trim().length!=0&&lapse_date!=""||lapse_date.trim().length!=0){
              var beginTime = effect_date;
                            var endTime = lapse_date;
                            var beginTimes=beginTime.substring(0,10).split('-');
                            var endTimes=endTime.substring(0,10).split('-');
                            beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
                            endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
                            if(beginTime>endTime){
                                alert("合同失效日期早于合同生效日期！");
                                return ;
        }
       var param = jQuery("#tempcontractform").serialize();
        var url="<%=request.getContextPath()%>/Ibd_contract_serviceAction.do?cmd=insert_tempIbdcontract&"+param;
        jQuery.post(url,function(data){
        if(data){
              alert("新增合同模版成功!");
                    window.close();
                    window.opener.showListData();    
                     }
                     else {
                     alert("新增合同模版失败!");
                     window.close();
                     window.opener.showListData();    
                     }
            });
    }
    }

    function update_onClick(){  //保存修改后的单条数据
     var contract_template_name = document.getElementById("contract_template_name").value;
    var contract_template_version = document.getElementById("contract_template_version").value;
    var effect_date = document.getElementById("effect_date").value;
    var lapse_date = document.getElementById("lapse_date").value;
        if(contract_template_name==""||contract_template_name.trim().length==0){
           alert("合同模板名称不能为空！");
           return ;
        }
       if(effect_date!=""||effect_date.trim().length!=0&&lapse_date!=""||lapse_date.trim().length!=0){
              var beginTime = effect_date;
                            var endTime = lapse_date;
                            var beginTimes=beginTime.substring(0,10).split('-');
                            var endTimes=endTime.substring(0,10).split('-');
                            beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
                            endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
                            if(beginTime>endTime){
                                alert("合同失效日期早于合同生效日期！");
                                return ;
        }
        var param = jQuery("#tempcontractform").serialize();
        var url="<%=request.getContextPath()%>/Ibd_contract_serviceAction.do?cmd=update_tempIbdcontract&"+param;
        jQuery.post(url,function(data){
        if(data){
              alert("更新合同模版成功!");
                    window.close();
                    window.opener.showListData();    
                     }
                     else{
                    alert("更新合同模版失败!");
                     }
            });
    }
    }

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>
<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('修改IBD合同模板','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('新增IBD合同模板','<%=request.getContextPath()%>/');
</script>
 <div class="ringht_x">
<form name="form" method="post"  id="tempcontractform">
<input id="id" name="id" type="hidden" class="text_field" inputName="id" value="${bean.id}"   readonly="true">
<div id="ccChild1"     class="box_xinzeng" style="height:400px; "> 
                    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                            <tr>
                                <td class="td_1" ><span class="style_required_red">* </span>合同模板名称</td>
                                <td class="td_2 ">
                                    <input type="text" class="text_field"  id = "contract_template_name" name="contract_template_name" inputName="合同模板名称" value="${bean.contract_template_name}" maxLength="50" />
                                </td>
                                 <td class="td_1" >合同模板版本号</td>
                                <td class="td_2 ">
                                    <input type="text" class="text_field" id="contract_template_version"    name="contract_template_version" inputName="合同模板版本号" value="${bean.contract_template_version}" maxLength="64" />
                                </td>
                            </tr>                   
                            <tr>
                                <td class="td_1" ><span class="style_required_red">* </span>合同生效日期</td>                                                                                                             
                                <td class="td_2">
                                    <w:date format="yyyy-MM-dd" id="effect_date" name="effect_date" property="bean/effect_date" width="189px" readonly="true"/>
                                </td>
                                 <td class="td_1" ><span class="style_required_red">* </span>合同失效日期</td>
                                <td class="td_2">
                                    <w:date format="yyyy-MM-dd" id="lapse_date" name="lapse_date" property="bean/lapse_date" width="189px" readonly="true"/>
                                </td>
                            </tr>    
                            <tr>
                             <td class="td_1" >合同模板类型</td>                                                                
                                <td class="td_2">
                                    <d:select dictTypeId="CONTRACT_TYPE_BD" name="contract_type_bd" id="contract_type_bd" property="bean/contract_type_bd" style="width:208px" value="8" disabled="true"/>
                                </td>
                                <td class="td_1" >合同业务类型</td>                                                                
                                <td class="td_2">
                                    <d:select dictTypeId="IBD_BUSINESS_TYPE_BD" name="business_type_bd" id="business_type_bd" property="bean/business_type_bd" style="width:208px"/>
                                </td>
                            </tr> 
                              <tr>
                                <td class="td_1" >合同内容</td>                                                                
                                <td class="td_2" colspan="3">
                                <textarea name="contract_content" rows="8" 
                style="width: 500px" class="textarea_limit_words" id="contract_content" maxLength="2000">${bean.contract_content }</textarea>
                                </td>
                                </tr>
                    </table>
        </div>  
         <div class="mx_button"  align="center">
                                <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
                                <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>      
     </form> 
</div>
</div>
<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
