<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.security.socialaccountpvd.vo.SocialaccountpvdVo" %>
<%@ page import="rayoo.customerservice.security.socialaccountpvd.util.ISocialaccountpvdConstants" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>

<%  //判断是否为修改页面
    SocialaccountpvdVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ISocialaccountpvdConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (SocialaccountpvdVo)request.getAttribute(ISocialaccountpvdConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
    String group_type = request.getParameter("group_type");
    String security_type = request.getParameter("security_type");
    ///System.out.println("*****************"+group_type+"--"+security_type+"***********");
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>供应商账号新增</title>
<script language="javascript">

//城市社保组联动标签1099110100000000050
function citySecurityGroupchange(seletvalue){
    //alert(seletvalue);
      SecurityGroupAjax.getCitySecurityGroup(seletvalue,{callback:function(data){
                    setSelectForBean("social_group_id",data,"id","group_name","");
                    if(<%=isModify%>){
                         document.getElementById("social_group_id").value="<%=resultVo==null?"":resultVo.getSocial_group_id()%>";
                    }
                }
            });
    }
    

    function insert_onClick(){  //插入单条数据
        if(checkAll()){
              var action = "<%=request.getContextPath()%>/SocialaccountpvdAction.do?cmd=insert";
              var myAjax = new Ajax(action);
              var form = $id("datacell_formid");
                if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }       
             myAjax.submit();
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                  alert(""+myAjax.getProperty("returnValue"));
                  window['returnValue'] = ""+myAjax.getProperty("returnValue");
                  window.close();
                  //window.opener.callBack(myAjax.getProperty("returnValue"));
                  window.opener.$id("datacell1").loadData();
                  window.opener.$id("datacell1").refresh();
             }
        }
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
            if(checkAll()){

            var action ="<%=request.getContextPath()%>/SocialaccountpvdAction.do?cmd=update";
            var myAjax = new Ajax(action);
            var form = $id("datacell_formid");
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }       
             myAjax.submit();
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                  alert(""+myAjax.getProperty("returnValue"));
                  window['returnValue'] = ""+myAjax.getProperty("returnValue");
                  window.close();
                  window.opener.callBack(myAjax.getProperty("returnValue"));
             }
        }
    }
    
    function checkAll(){
        var social_unit_id = $name('social_unit_id').value;
        if(social_unit_id==null||social_unit_id==''){
            alert(" 福利办理方不能为空！");
            return false;
        }
        
        return true;
    }

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
</script>
</head>
<body>

<form name="form" id="datacell_formid" method="post">

<div id="right">
<!--<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('供应商账号修改','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('供应商账号新增','<%=request.getContextPath()%>/');
</script>


 

 
 --><div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
    <input type="hidden" name="group_type" value="${param.group_type}">
    <input type="hidden" name="security_type" value="${param.security_type}">
        <%
                   if(isModify){
                   }else{
                   
                  %>
        <tr>
            <td class="td_1" >城市</td>
            <td class="td_2" colspan="3">
                <r:comboSelect id="city_idList_search" name="city_id"
                           queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                           textField="city_name"
                           valueField="id"
                           xpath="PB_CITYVo"
                           width="200px"
                           value="1099110100000000357"
                           nullText="请选择" 
                           />
            </td>
        </tr>
        <%} %>
        <tr>
            <td class="td_1" >社保/公积金组</td>
            <td class="td_2 ">
                <r:comboSelect id="group_List" name="social_group_id"
                       queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=${param.group_type}"
                       valueField="id"
                       textField="group_name"
                       xpath="SecuritygroupVo"
                       width="200px"
                       linkId="city_idList_search"
                       nullText="请选择" />
            </td>
            <td class="td_1" >福利办理方</td>
            <td class="td_2 ">
                    <r:comboSelect id="com1"  name="social_unit_id" value="${bean.social_unit_id }"
                            queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                            textField="hire_unit_short_name" 
                            valueField="id" 
                            xpath="SocialunitVo"
                            nullText="--请选择--"
                            width="185px">
                        </r:comboSelect>
            </td>
        </tr>
        <tr>
            <td class="td_1" >账号</td>
            <td class="td_2 ">
                <input type="text" class="text_field"  name="accounts"  inputName="账号" value="${bean.accounts }" validate="isNum;"  maxLength="64" />
            </td>
            <td class="td_1" >开户单位</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="open_unit" inputName="开户单位" value="${bean.open_unit }" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >开户单位账号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="open_unit_accounts" inputName="开户单位账号" value="${bean.open_unit_accounts }" validate="isNum;" maxLength="64" />
            </td>
            <c:choose>
                <c:when test="${param.group_type=='2'}">
                    <td class="td_1" >截止日期</td>
                    <td class="td_2 ">
                        <input type="text" class="text_field" name="end_date" inputName="截止日期" value="${bean.end_date }" validate="isValidDay;" maxLength="64" />
                    </td>
                    </tr>
                    <tr>
                       <td class="td_1" >应进账日</td>
                    <td class="td_2 ">
                        <input type="text" class="text_field" name="get_day" inputName="应进账日" value="${bean.get_day }" validate="isValidDay;" maxLength="64" />
                    </td>
                    <td class="td_1" >盖章方</td>
                    <td class="td_2 ">
                        <input type="text" class="text_field" name="seal_party" inputName="盖章方" value="${bean.seal_party }" maxLength="64" />
                    </td>  
                    </tr>
                    <tr>
                        <td class="td_1" >备注</td>
                    <td class="td_2 ">
                        <input type="text" class="text_field" name="remarks" inputName="备注" value="${bean.remarks }" maxLength="64" />
                    </td>
                    <td class="td_1" >缴纳银行</td>
                    <td class="td_2" ><input type="text" class="text_field" name="paying_bank" inputName="缴纳银行" value="${bean.paying_bank }" maxLength="64" /></td>
                    </tr>
                </c:when>
                <c:otherwise>
                <td class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
                </c:otherwise>
            </c:choose>
            
    </table>
 

    <div align="center">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
            
<input type="hidden" name="pvd_id" value="${bean.id }">
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">

    //citySecurityGroupchange("1099110100000000050");
</script>
