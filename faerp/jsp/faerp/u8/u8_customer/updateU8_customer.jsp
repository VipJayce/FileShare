<%@ page contentType="text/html; charset=UTF-8" %>


<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
  

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
            if(checkAllForms()){

        var param=jQuery("#formId").serialize();
        var url="<%=request.getContextPath()%>/U8_customerAction.do?cmd=update&"+param;
        jQuery.post(url,function(data){
         if(data!=0){
           alert("修改成功！");
           window.close();
         }else{
               alert("修改失败！");
                window.close();
         }
        })
        }
    }

    function cancel_onClick(){  //取消后返回列表页面
    window.close();
    }
</script>
</head>
<body>

<form name="form" method="post" id="formId">

<div id="right">

 <div class="ringht_s">
<div id="ccChild1"     class="box_3" > 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>客户编码</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccuscode" inputName="客户编码" value="${bean.ccuscode }" maxLength="25" disabled="disabled" />
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>客户名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccusname" inputName="客户名称" value="${bean.ccusname }" maxLength="100" disabled="disabled"/>
            </td>
        </tr>
        
        <tr>
            <td class="td_1" >客户简称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccusabbname" inputName="客户简称" value="${bean.ccusabbname }" maxLength="100" />
            </td>
            <td class="td_1" >英文名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccusenname" inputName="英文名称" value="${bean.ccusenname }" maxLength="50" />
            </td>
        </tr>
      
        <tr>
            <td class="td_1" >客户分类编码</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccccode" inputName="客户分类编码" value="${bean.ccccode }" maxLength="10" />
            </td>
      <td class="td_1" >地区编码</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="cdccode" inputName="地区编码" value="${bean.cdccode }" maxLength="10" />
            </td>
        </tr>
      
        <tr>
            <td class="td_1" >地址</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccusaddress" inputName="地址" value="${bean.ccusaddress }" maxLength="25" />
            </td>
          <td class="td_1" >邮政编码</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccuspostcode" inputName="邮政编码" value="${bean.ccuspostcode }" maxLength="5" />
            </td>
        </tr>
       
        <tr>
            <td class="td_1" >纳税人登记号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccusregcode" inputName="纳税人登记号" value="${bean.ccusregcode }" maxLength="25" />
            </td>
           <td class="td_1" >开户银行</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccusbank" inputName="开户银行" value="${bean.ccusbank }" maxLength="50" />
            </td>
        </tr>
    
        <tr>
            <td class="td_1" >银行账号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccusaccount" inputName="银行账号" value="${bean.ccusaccount }" maxLength="50" />
            </td>
               <td class="td_1" >法人</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccuslperson" inputName="法人" value="${bean.ccuslperson }" maxLength="50" />
            </td>
        </tr>
 
        <tr>
            <td class="td_1" >联系人</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccusperson" inputName="联系人" value="${bean.ccusperson }" maxLength="50" />
            </td>
            <td class="td_1" >联系电话</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ccusphone" inputName="联系电话" value="${bean.ccusphone }" maxLength="50" />
            </td>
        </tr>
     
        <tr>
            <td class="td_1" >所属行业</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ctrade" inputName="所属行业" value="${bean.ctrade }" maxLength="25" />
            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
   
    </table>
    </div> 
    <div class="foot_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:update_onClick()" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
     <input type="hidden" name="id" value="${bean.id }">
<input type="hidden" name="create_date" />
        </div>
</div>         

 </div>    


</form>
</fmt:bundle>

</body>
</html>
