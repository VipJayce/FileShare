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
<title>工作日历新增</title>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
	
	function vailform(){
        var  custId = jQuery("#cust_id").val();
        if(!custId){
            alert("请选择客户");
            return false;
        }
        return true;
    }
	
	function save_onClick(){  //保存
       var dataset1 = $id("datacell1").dataset;//取得页面的dataset
       alert($id("datacell1").isModefied);
       var datarow =  dataset1.get(7);
       alert(datarow.status);
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                form.action="<%=request.getContextPath()%>/PSNCALENDARAction.do?cmd=update&id="+code;
            }else{
	            form.action="<%=request.getContextPath()%>/PSNCALENDARAction.do?cmd=insert&id="+code;
            }
            form.submit();
            $id("datacell1").submit();
       }
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/PSNCALENDARAction.do?cmd=queryAll&backFlag=true";
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
	
	function gen_onClick(){
       		var datacell1 = $id("datacell1");
       		var action = "<%=request.getContextPath()%>/PSNCALENDARAction.do?cmd=genSubData";
            var myAjax = new Ajax(action);
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }
            myAjax.submit();
            //var returnNode = myAjax.getResponseXMLDom();
            //var returnXml = myAjax.getDataset("root/data");
            //alert(returnXml);	
            var xmlDom = myAjax.retDom;
			var dataset =  Dataset.create(xmlDom,"root/data/PsncalendarsubVo","PsncalendarsubVo");
			for(var i=0;i<dataset.values.length;i++){
				var entity = dataset.values[i];
				entity.status = 0;
				datacell1.insertRow(entity);
			}
            
	}
	
	 function save_onClick1(){
    	   	var datacell1 = $id("datacell1");
    	   	var action = "<%=request.getContextPath()%>/PSNCALENDARAction.do?cmd=updateAll";
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
                      window.location.href="<%=request.getContextPath()%>/PSNCALENDARAction.do?cmd=queryAll";
                  } 
                  else {
                      alert( '保存失败！' ); 
                  }
             }
    }
	
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<div id="right">
<div class="ringht_s">
<div id="ccChild1"     class="box_3"> 
<div class="xz_title">基本信息</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1"  width="23%" >客户名称</td>
            <td class="td_2 " width="28%">
                <input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id}">
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px" readonly="false" displayValue="${bean.customer_name}" id="lk_cust" 
                                   lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false"/>
            </td>
            <td class="td_1" width="23%">出差数据是否汇总</td>
            <td class="td_2"  width="28%">
            	<d:select dictTypeId="TrueOrFalse" property="awaydatacostatus"  id="awaydatacostatus"  value="${bean.awaydatacostatus}"  style="width:207px;"  nullLabel="--请选择--"/>
            </td>
        </tr>
		<tr>
			<td  class="td_1" width="23%" >休假数据是否汇总</td>
			<td  class="td_2" width="28%">
				<d:select dictTypeId="TrueOrFalse" property="leavedatacostatus"  id="leavedatacostatus"  value="${bean.leavedatacostatus}"  style="width:207px;"  nullLabel="--请选择--"/>
			</td>
			<td  class="td_1"  width="23%" >加班数据是否汇总</td>
            <td  class="td_2 " width="28%" >
            	<d:select dictTypeId="TrueOrFalse" property="overtimedatacostatus"  id="overtimedatacostatus"  value="${bean.overtimedatacostatus}"  style="width:207px;"  nullLabel="--请选择--"/>
            </td>
		</tr>
		<tr>
			<td  class="td_1" width="23%" >考勤数据是否汇总</td>
			<td  class="td_2" width="28%">
				<d:select dictTypeId="TrueOrFalse" property="kqdatacostatus"  id="kqdatacostatus"  value="${bean.kqdatacostatus}"  style="width:207px;"  nullLabel="--请选择--"/>
			</td>
			<td  class="td_1"  width="23%" >考勤数据是否导入</td>
            <td  class="td_2 " width="28%" >
            	<d:select dictTypeId="TrueOrFalse" property="dataimportstatus"  id="dataimportstatus"  value="${bean.dataimportstatus}"  style="width:207px;"  nullLabel="--请选择--"/>
            </td>
		</tr>
		<tr>
			<td  class="td_1" width="23%" >考勤数据是否生成</td>
			<td  class="td_2" width="28%">
				<d:select dictTypeId="TrueOrFalse" property="datacreatestatus"  id="datacreatestatus"  value="${bean.datacreatestatus}"  style="width:207px;"  nullLabel="--请选择--"/>
			</td>
			<td  class="td_1"  width="23%" >工作时长</td>
            <td  class="td_2 " width="28%" >
                <input type="text" class="text_field" name="gzsj" id="gzsj" inputName="工作时长" maxLength="23" integerDigits="22" decimalDigits="0"  value="${bean.gzsj}"/>
            </td>
		</tr>
		<tr>
			<td  class="td_1" width="23%" >开始日期</td>
			<td  class="td_2" width="28%">
				<w:date  allowInput="true" name="begin_date"  id="begin_date"  property="bean/begin_date"  format="YYYY-MM-DD"/>
			</td>
			<td  class="td_1" width="23%" >结束日期</td>
			<td  class="td_2" width="28%">
				<w:date  allowInput="true" name="end_date"  id="end_date"  property="bean/end_date"  format="YYYY-MM-DD"/>
			</td>
			
		</tr>
		<tr>
			<td  class="td_1"  width="23%" >是否休假</td>
            <td  class="td_2 " width="28%" >
               <d:select dictTypeId="TrueOrFalse" property="if_rest"  id="if_rest"  value="${bean.if_rest}"  style="width:207px;"  nullLabel="--请选择--"/>
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
		          <li class="p_1"><a onClick="javascript:gen_onClick();">生成工作日历</a></li>                     
                </ul>
            </div>
            <div class="clear"></div>
		</div>
		<div style="padding: 15 8 8 8;">
		       <r:datacell 
		        id="datacell1"
		        paramFormId="datacell_formid"
		        queryAction="/FAERP/PSNCALENDARAction.do?cmd=querySubData&pk_job_order=${bean.id}"
		        submitAction="/FAERP/PSNCALENDARAction.do?cmd=insertSubData&pk_psncalendar=${bean.id}"
		        width="99%"
		        height="318px"
		        xpath="PsncalendarsubVo"
		        submitXpath="PsncalendarsubVo"
		        pageSize="-1"
		        >
		            <r:field fieldName="timeid" label="日期" width="150px">
		                <h:text/>
		            </r:field>
		            <r:field fieldName="kssj" label="开始时间" width="100px">
		            	<w:time/> 
		            </r:field>
		            <r:field fieldName="ksto" label="开始截止时间" width="150px">
		            	<w:time/> 
		            </r:field>  
		            <r:field fieldName="jssj" label="结束时间" width="100px">
		            	<w:time/> 
		            </r:field>              
		            <r:field fieldName="jsto" label="结束截止时间" width="150px">
		            	<w:time/> 
		            </r:field>        
		            <r:field fieldName="checkinflag" label="上班是否打卡" width="150px">
		            	<d:select dictTypeId="TrueOrFalse"></d:select>
		            </r:field>      
		            <r:field fieldName="checkoutflag" label="下班是否打卡" width="150px">
		            	<d:select dictTypeId="TrueOrFalse"></d:select>
		            </r:field>      
		            <r:field fieldName="sfkt" label="是否跨天" width="100px">
		                <d:select dictTypeId="TrueOrFalse"></d:select>
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
</body>
</fmt:bundle>
</html>
