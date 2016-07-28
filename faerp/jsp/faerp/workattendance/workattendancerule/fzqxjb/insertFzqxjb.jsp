<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
	function vailform(){
        var  cust_id = jQuery("#cust_id").val();
        if(!cust_id){
            alert("请选择客户");
            return false;
        }
        return true;
    }
	
	function save_onClick(){  //保存
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            var datacell = $id("datacell1");
            datacell.submitAllByHidden();
            if (code){
                form.action="<%=request.getContextPath()%>/FzqxjbAction.do?cmd=update&id="+code;
            }else{
	            form.action="<%=request.getContextPath()%>/FzqxjbAction.do?cmd=insert&id="+code;
            }
            form.submit();
       }
    }
    
    function save_onClick1(){
    	   	var datacell1 = $id("datacell1");
    	   	var action = "<%=request.getContextPath()%>/FzqxjbAction.do?cmd=updateAll";
            var dataset1 = datacell1.dataset;//取得页面的dataset
            for(var i=0; i<dataset1.getLength(); i++){
             	var datarow =  dataset1.get(i);
             	datarow.setProperty("status",datarow.status);
            }
       		var xmlSubmit = datacell1.dataset.toString();
            var myAjax = new Ajax(action);
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }
            myAjax.submitXML(xmlSubmit, 'UTF-8');
            var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == "ok" ) {
                      alert( '保存成功！' );
                      window.location.href="<%=request.getContextPath()%>/FzqxjbAction.do?cmd=queryAll";
                  } 
                  else {
                      alert( '保存失败！' ); 
                  }
             }
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/FzqxjbAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    function rtnFunc(arg){
	    var lookup = $id("lk_cust");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[2];
	    jQuery("#cust_id").val(arg[0]);       
	    return false;
	}
	
	function toAddSub_onClick(){
		$id("datacell1").addRow();
	}
	
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3">
<div class="xz_title">公休假日信息</div> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1"  width="23%" ><span class="style_required_red">* </span>客户名称</td>
            
            <td class="td_2 " width="28%">
                <input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id}">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="false" displayValue="${bean.customer_name}" id="lk_cust" 
                                   lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false"/>
        </tr>
		<tr>
			</td>
            <td class="td_1" width="23%"><span class="style_required_red">* </span>假日名称</td>
            <td class="td_2"  width="28%">
           	    <input type="text" class="text_field" id="holidayname" name="holidayname" inputName="假日名称" value="${bean.holidayname}" maxLength="20" />
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>假日年度</td>
			<td  class="td_2" width="28%">
			    <input type="text" class="text_field" id="holidayyear" name="holidayyear" inputName="假日年度" value="${bean.holidayyear}" maxLength="4" />
			</td>
		</tr>
		<tr>
			<td  class="td_1"  width="23%" ><span class="style_required_red">* </span>开始时间</td>
            <td  class="td_2 " width="28%" >
            	<w:date  allowInput="true" name="starttime"  id="starttime"  property="bean/starttime" format="YYYY-MM-DD" />
            </td>
			<td  class="td_1" width="23%" ><span class="style_required_red">* </span>结束时间</td>
			<td  class="td_2" width="28%">
				<w:date  allowInput="true" name="endtime"  id="endtime"  property="bean/endtime"  format="YYYY-MM-DD"/>
			</td>
		</tr>
		<tr>
			<td  class="td_1"  width="23%" ><span class="style_required_red">* </span>是否适用全部人员</td>
            <td  class="td_2 " width="28%" >
            	<d:select dictTypeId="TrueOrFalse" property="bean/allflag"  id="allflag"  name="allflag"  style="width:207px;"  nullLabel="--请选择--"/>
            </td>
		</tr>
    </table>
	<p></p>
</div>
		<div class="button">
            <div class="button_right">
                <ul>
                  <li class="c"><a onClick="javascript:toAddSub_onClick();"><fmt:message key="insert" /> </a></li>
		          <li class="b"><a onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify" /> </a></li>
		          <li class="d"><a onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete" /> </a></li>                     
                </ul>
            </div>
            <div class="clear"></div>
		</div>
		<div style="padding: 15 8 8 8;">
		 <r:datacell 
		        id="datacell1"
		        paramFormId="datacell_formid"
		        queryAction="/FAERP/FzqxjbAction.do?cmd=querySubData&fzqxjb_id=${bean.id}"
		        submitAction="/FAERP/FzqxjbAction.do?cmd=insertSubData&fzqxjb_id=${bean.id}"
		        width="99%"
		        height="318px"
		        xpath="HolidayleaveVo"
		        submitXpath="HolidayleaveVo"
		        pageSize="-1"
		        >
		        	<r:toolbar tools="nav,pagesize,custom,edit:add del reload,info"></r:toolbar>
		            <r:field fieldName="transdate" label="调班日期" width="100px">
		                <w:date format="YYYY-MM-DD"/>
		            </r:field>
		            <r:field fieldName="remark" label="备注" width="200px">
		            	<h:text/> 
		            </r:field>
		    </r:datacell>
		</div>
		<p></p>
		<div class="foot_button" style="text-align: center; margin-left: 0px;">
		        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick1()"/>
		        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
		</div>

<input type="hidden" name="id" id="edit_id" value="${bean.id}">
<input type="hidden" name="create_date" id="create_date" value="${bean.create_date}">
<input type="hidden" name="create_user_id" id="create_user_id" value="${bean.create_user_id}">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">
<input type="hidden" name="create_date" />
</form> 
</fmt:bundle>
</body>
</html>
