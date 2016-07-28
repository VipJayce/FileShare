<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script src="<%=request.getContextPath()%>/dwr/interface/TreeAjax.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/engine.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/util.js" type="text/javascript"></script> 
 <script language="javascript" src="<venus:base/>/js/ajax/gap-ajax-tree.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript" >
    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>
<div id="right">
<script language="javascript">
    writeTableTopFesco('查看IBD合同模板','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
 <div class="ringht_x">
<form name="form" method="post"  id="tempcontractform">
<input id="ids" name="ids" type="hidden" class="text_field" inputName="id" value="${bean.id}"   readonly="true">
 
<div id="ccChild1"     class="box_xinzeng" style="height:400px; "> 
                    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                            <tr>
                                <td class="td_1" ><span class="style_required_red">* </span>合同模板名称</td>
                                <td class="td_2 ">
                                    <input type="text" class="text_field"  id = "contract_template_name" name="contract_template_name" inputName="合同模板名称" value="${bean.contract_template_name}" maxLength="50" readonly="readonly" />
                                </td>
                                 <td class="td_1" >合同模板版本号</td>
                                <td class="td_2 ">
                                    <input type="text" class="text_field" id="contract_template_version"    name="contract_template_version" inputName="合同模板版本号" value="${bean.contract_template_version}" maxLength="64" readonly="readonly"/>
                                </td>
                            </tr>                   
                            <tr>
                                <td class="td_1" >合同生效日期</td>                                                                                                             
                                <td class="td_2">
                                    <w:date format="yyyy-MM-dd" id="effect_date" name="effect_date" property="bean/effect_date" width="189px" readOnly="true"/>
                                </td>
                                 <td class="td_1" >合同失效日期</td>
                                <td class="td_2">
                                    <w:date format="yyyy-MM-dd" id="lapse_date" name="lapse_date" property="bean/lapse_date" width="189px" readOnly="true"/>
                                </td>
                            </tr>    
                            <tr>
                             <td class="td_1" >合同模板类型</td>                                                                
                                <td class="td_2">
                                    <d:select dictTypeId="CONTRACT_TYPE_BD" name="contract_type_bd" id="contract_type_bd" property="bean/contract_type_bd" style="width:208px" value="10" disabled="true"/>
                                </td>
                                <td class="td_1" >合同业务类型</td>                                                                
                                <td class="td_2">
                                    <d:select dictTypeId="FINOUT_TYPE_BD" name="business_type_bd" id="business_type_bd" property="bean/business_type_bd" style="width:208px" disabled="true"/>
                                </td>
                            </tr> 
                              <tr>
                                <td class="td_1" >合同内容</td>                                                                
                                <td class="td_2" colspan="3">
                                <textarea name="contract_content" rows="8" 
                style="width: 500px" class="textarea_limit_words" id="contract_content" maxLength="2000" readonly="readonly">${bean.contract_content }</textarea>
                                </td>
                                </tr>
                    </table>
        </div>  
         <div class="mx_button"  align="center">
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
