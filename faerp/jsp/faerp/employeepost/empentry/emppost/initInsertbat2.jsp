<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<h:script src="/js/thread/Concurrent.Thread.js"/>
<script type="text/javascript">
jQuery.noConflict();
jQuery(function(){
        $id("com1").isQueryFirst = false;
        $id("com2").isQueryFirst = false;
        $id("com3").isQueryFirst = false;
        $id("firsttbody").isQueryFirst = false;
        $id("grdCityEnsureTbody").isQueryFirst = false;
        $id("fulitbody").isQueryFirst = false;
        $id("secondtbody").isQueryFirst = false;
    });
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="java.util.*" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostsendVo" %>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants" %>
<%@ page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo" %>
<%@ page import="rayoo.employeepost.empentry.emppost.bs.IEmppostBs" %>
<%@ page import="venus.frames.mainframe.util.Helper" %>
<%@ page import="rayoo.system.securitygroup.vo.SecuritygroupShortcutVo" %>

<%  

String id = (String)session.getAttribute("id");
String is_preget = (String)session.getAttribute("is_preget");
String city_id = (String)session.getAttribute("city_id");
IEmppostBs empPostBs = (IEmppostBs)Helper.getBean("IEmppostBs");//获取入离职业务逻辑层对象
List<SecuritygroupShortcutVo> listgscVoList = empPostBs.findShortcutGroupForQuanGou(city_id);
String isLimitUpperAndLower = request.getParameter("isLimitUpperAndLower").toString();
System.out.println(isLimitUpperAndLower);
request.setAttribute("isLimitUpperAndLower",isLimitUpperAndLower);   
String is_phoenix = (String)session.getAttribute("IS_PHOENIX");//2015-3-23 yangyuting
String is_Offpost_phoenix = (String)session.getAttribute("IS_OFFPOST_PHOENIX");//2015-3-23 yangyuting
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title></title>
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
. {LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
tr.hover1 {background:#c4e7f8;}
.fex_row {LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
</style>
<script type="text/javascript">
    var vpath = "<%=request.getContextPath()%>";

    function setTabBatSyn ( i )
    {
        selectTabBatSyn(i);
    }
    
    function selectTabBatSyn ( i )
    {
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            $id("grdCityEnsureTbody").containerTable.style.display="block";
            $id("fulitbody").containerTable.style.display="block";
            $id("secondtbody").endEdit();
            break;
            case 2:
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            $id("grdCityEnsureTbody").containerTable.style.display="none";
            $id("fulitbody").containerTable.style.display="none";
            $id("firsttbody").endEdit();
            $id("grdCityEnsureTbody").endEdit();
            $id("fulitbody").endEdit();            
            break;
        }
    }

    
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       if($id("firsttbody").firstCheckBox == null){
        $id("firsttbody").firstCheckBox = true;
        return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id") + " checked onclick=''>";
       }else{
        return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id") + " checked>";       
       }
       
    }
    
    function findSelections() {  //从列表中找出选中的id值列表
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
            var is_check = dataset.get(i).getProperty("is_check");
            if(is_check=='1'){
                
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(dataset.get(i).getProperty("id")); //加入选中的checkbox对应的行id
            }
            
        }
        
        return ids;
    }
    
    function submitAll(){//表单提交
        var idarray = findSelections();  //取得多选框的选择项
        //var ids='';
        if(idarray == null) {  //如果ids为空
            alert("<fmt:message key="choose_emp_on_post_info"/>");
            return;
        }else{
	        if(checkAllCont()){
	        /*
	           for(var i=0;i<idarray.length;i++){
	               
                   if(i==0){
                       ids=idarray[0];
                   }else{
                       ids = ids+','+idarray[i];
                   }
               }
               alert(ids);
               */
               
               jQuery("input[name='button_reset1']").attr('disabled','disabled');
               
	            var dc1 = $id("grdCityEnsureTbody");
	            var dc2 = $id("fulitbody");
	            var dc3 = $id("firsttbody");
	            var dc4 = $id("secondtbody");
	            var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=savePostBat";
	            //将两个datacell的xml内容合并
	            var xmlSubmit = dc1.dataset.toString();
	            xmlSubmit +=  dc2.dataset.toString();
	            xmlSubmit +=  dc3.dataset.toString();
	            xmlSubmit +=  dc4.dataset.toString();
	            //alert(xmlSubmit);
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
	             myAjax.submitXML(xmlSubmit, 'UTF-8');
	             var returnNode = myAjax.getResponseXMLDom();
	             if( returnNode ) {
	                 if( myAjax.getValue("root/data/returnValue") == 1 ) {
	                      alert("<fmt:message key='batch_declare_on_post_succese'/>"+"<fmt:message key='confirmTax'/>" );
	                      window.location.href="<%=request.getContextPath()%>/EmppostAction.do?cmd=queryAll&backFlag=true";
	                  } else if( myAjax.getValue("root/data/returnValue")== -2 ) {
	                      alert("该员工已经在职，不能再次申报入职！"); 
	                  } else if( myAjax.getValue("root/data/returnValue")== -3 ) {
                          alert("该批员工申报入职正在处理，不能重复提交！"); 
                      } else if( myAjax.getValue("root/data/returnValue") == -4 ) {
	                      alert("该员工的福利办理方和客户对应的社保账号不存在或社保账号未配置新的工伤保险比例！"); 
	                  }else if( myAjax.getValue("root/data/returnValue").split(",")[0] == -5 ) {
	                      alert( myAjax.getValue("root/data/returnValue").split(",")[1] ); 
	                  } else {
	                      alert( "<fmt:message key="batch_declare_on_post_error"/>" ); 
	                  }
	                  
	                  jQuery("input[name='button_reset1']").removeAttr("disabled");
	             }
	            
	        }
	    }
    }
    
     function checkAllCont(ids){//页面提交验证
        var ali = true;
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        var empids = null;  //定义emp_id值的数组
        
        
        for(var i=0; i<dataset.getLength(); i++){
            var is_check = dataset.get(i).getProperty("is_check");
            //只有勾选的才判断
            if(is_check=='1'){
                //var datasettr = dataset.findEntity("id",ids[j]);
                var datasettr = dataset.get(i);
                if(empids == null) {
                    empids = new Array(0);
                }
                empids.push(datasettr.getProperty("emp_id"));  //加入选中的数组
		        if(datasettr.getProperty("apply_on_post_date")==null || datasettr.getProperty("apply_on_post_date")==''){
		            alert("<fmt:message key="emp_on_post_date"/>");
		            ali = false;
		            return ali;
		        }
		        if(datasettr.getProperty("charge_start_date")==null || datasettr.getProperty("charge_start_date")==''){
		            alert("<fmt:message key="emp_fee_begin_date"/>");
		            ali = false;
		            return ali;
		        }
		        if(datasettr.getProperty("charge_end_date")==null || datasettr.getProperty("charge_end_date")==''){
		            alert("<fmt:message key="emp_fee_end_date"/>");
		            ali = false;
		            return ali;
		        }
		        if(datasettr.getProperty("charge_end_date")<datasettr.getProperty("charge_start_date")){
		            alert("<fmt:message key="emp_fee_b_gt_e"/>");
		            return;
		        }
		        if(datasettr.getProperty("contract_type_bd")==null || datasettr.getProperty("contract_type_bd")==''){
		            alert("<fmt:message key="emp_on_post_type_not_null"/>");
		            return ali;
		        }
		        if(datasettr.getProperty("allmoney")==null || datasettr.getProperty("allmoney")==''){
                    alert("<fmt:message key="emp_contract_allmoney_not_null"/>");
                    return ali;
                }
                
                /*
                //魏佳新增，验证如果报税属性为“FA客户报税”则必须填写“税局（tax_bureau）”
                if(datasettr.getProperty("is_tax")=="2" && (datasettr.getProperty("tax_bureau")=="" || datasettr.getProperty("tax_bureau") == null)){
                    alert("报税属性为FA客户报税，必须填写报税税局!");
                    ali = false;
                    return ali;
                }
		        */
		        //2015-3-23 yangyuting add 
                if(datasettr.getProperty("is_phoenix")=="" || datasettr.getProperty("is_phoenix") == null){
                    alert("是否走E化入职选项为空，必须选择是否走E化入职选项!");
                    ali = false;
                    return ali;
                }
                     var is_phoenix_select= <%=is_phoenix%>;
			        if(is_phoenix_select==null||is_phoenix_select=="0"){
			            if(datasettr.getProperty("is_phoenix")=="1"){
			              alert("非E化客户不得选择‘是否走E化入职’选项为是！");
			                    ali = false;
			                    return;
			            }
			        }
                  
		        //2015-3-23 yangyuting add 
                if(datasettr.getProperty("is_Offpost_phoenix")=="" || datasettr.getProperty("is_Offpost_phoenix") == null){
                    alert("是否走E化离职选项为空，必须选择是否走E化离职选项!");
                    ali = false;
                    return ali;
                }
                var is_Offpost_phoenix_select= <%=is_Offpost_phoenix%>;
                    if(is_Offpost_phoenix_select==null||is_Offpost_phoenix_select=="0"){
                        if(datasettr.getProperty("is_Offpost_phoenix")=="1"){
                          alert("非E化客户不得选择‘是否走E化离职’选项为是！");
                                ali = false;
                                return;
                        }
                    }
		        //魏佳新增，验证如果报税属性为“FA客户报税”则必须填写“税局（tax_bureau）”
                if(datasettr.getProperty("isonline")=="" || datasettr.getProperty("isonline") == null){
                    alert("是否线上选项为空，必须选择是否线上选项!");
                    ali = false;
                    return ali;
                }
                //2014年12月2日 新增，入职属性不能为空
		        if(datasettr.getProperty("emp_entry_bd")=="" || datasettr.getProperty("emp_entry_bd") == null){
                    alert("请选择入职属性！");
                    ali = false;
                    return ali;
                }
		        
		        var fields = datacell.fields;//获得页面所有的列
	            //列循环，使用页面field名称设值
	            for(var j=0; j<fields.length; j++){
	                var field = fields[j];
	                var fieldName = field.fieldName;
	                if(fieldName.indexOf("sf_start_date") == 0){
	                    if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
	                        alert("<fmt:message key="ss_product_fee_begin_date_not_null"/>");
		                    ali = false;
		                    return ali;
	                    }
	                }
	                if(fieldName.indexOf("base") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="ss_product_cardinal_num_not_null"/>");
                            ali = false;
                            return ali;
                        }
                    }
                    if(fieldName.indexOf("e_ratio") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="ss_product_enterprise_pro_not_null"/>");
                            ali = false;
                            return ali;
                        }
                    }
                    if(fieldName.indexOf("p_ratio") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="ss_product_peson_pro_not_null"/>");
                            ali = false;
                            return ali;
                        }
                    }
                    if(fieldName.indexOf("money") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="ss_product_money_not_null"/>");
                            ali = false;
                            return ali;
                        }
                    }
                    if(fieldName.indexOf("e_money") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="ss_product_enterprise_money_not_null"/>");
                            ali = false;
                            return ali;
                        }
                    }
                    if(fieldName.indexOf("p_money") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="ss_product_peson_money_not_null"/>");
                            ali = false;
                            return ali;
                        }
                    }
                    if(fieldName.indexOf("fl_sf_start_date") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="fl_sf_start_date_not_null"/>");
                            ali = false;
                            return ali;
                        }
                    }
                    if(fieldName.indexOf("fl_money") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="fl_money_not_null"/>");
                            ali = false;
                            return ali;
                        }
                    }
                    if(fieldName.indexOf("allmoney") == 0){
                        if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                            alert("<fmt:message key="emp_contract_allmoney_not_null"/>");
                            ali = false;
                            return ali;
                        }
                    }
	            }
	        }
       
        }
        
        //批量判断福利产品收费频率不能为空
        var datacell1 = $id("fulitbody");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
               var datasettr = dataset1.get(i);
                
               if(datasettr.getProperty("charge_frequency_bd")==null || datasettr.getProperty("charge_frequency_bd")==''){
                    alert("<fmt:message key="fl_pay_frequency_not_null"/>");
                    ali = false;
                    return ali;
               }
           
       }
        //批量判断员工信息电话或手机不能为空
        var datacell2 = $id("secondtbody");
        var dataset2 = datacell2.dataset;//取得页面的datacell
       
            for(var j=0;j<empids.length;j++){
               
                //只有勾选的才判断
                var datasettr2 = dataset2.findEntity("id",empids[j]);
            
	            if((datasettr2.getProperty("tel")==null || datasettr2.getProperty("tel")=='') && (datasettr2.getProperty("mobile")==null || datasettr2.getProperty("mobile")=='')){
	                    alert("<fmt:message key="emp_mobile_or_tel_not_null"/>");
	                    ali = false;
	                    return ali;
	             }
	             
	              var is_phoenix_select= <%=is_phoenix%>;
			        if(is_phoenix_select==null||is_phoenix_select=="0"){
			            
			        }else{//E化员工手机号必填 add by yiwenbin
			        	var sMobile = datasettr2.getProperty("mobile");
			       		if(sMobile==""||sMobile==null){
			       			alert('E化员工手机号必填！');
			       			ali = false;
				            return;
			       		} 
			        }
	             
	             
	             var datasettr = dataset.findEntity("emp_id",datasettr2.getProperty("id"));
	             var emp_post_type_bd = datasettr.getProperty("contract_type_bd")
	             if(emp_post_type_bd=='1' || emp_post_type_bd=='3'){
	                 var start_date = datasettr2.getProperty("start_date");
	                 var end_date = datasettr2.getProperty("end_date");
	                 if(start_date==null || start_date==''){
	                      alert("<fmt:message key="contract_begin_date_not_null"/>");
	                      ali = false;
	                      return ali;
	                 }
	                 if(end_date==null || end_date==''){
	                      alert("<fmt:message key="contract_end_date_not_null"/>");
	                      ali = false;
	                      return ali;
	                 }
	                 if(end_date<start_date){
	                    alert("<fmt:message key="contract_date_b_gt_e"/>");
	                    return;
	                }
	             }
	         }
            
        
        
        return ali;
        
    }
    
    //魏佳新增，批量修改选中行的“是否线上一列”
    function onchangeBat(obj,num,name){
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
            var entity = datacell.getEntity(i);
            var is_check = dataset.get(i).getProperty("is_check");
            if(is_check=='1'){
                datacell.selectRow(i);//只有选中改行后才可以对该行的数据进行赋值操作
                entity.setProperty(name,obj.value);//设置状态
            }
        }
    }
    //yangyuting，批量修改选中行的“是否E化一列”
    function onchangeBatE(obj,num,name){
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
            var entity = datacell.getEntity(i);
            var is_check = dataset.get(i).getProperty("is_check");
            if(is_check=='1'){
                datacell.selectRow(i);//只有选中改行后才可以对该行的数据进行赋值操作
                entity.setProperty(name,obj.value);//设置状态
            }
        }
    }
    
     function checkMobile(obj){ 
    var sMobile = obj.value;    //document.datacell_formid.mobile.value ;
    var ds1 = $id("secondtbody").dataset;
    if( null != sMobile && "" != sMobile){
        var mobileValue = sMobile.replace(/\s/g, "")+"";
        if(mobileValue.length!=11){ 
            alert("不是完整的11位手机号"); 
            //document.datacell_formid.mobile.focus(); 
            ds1.get(ds1.getLength()-1).setProperty("mobile", "");
            return false; 
        } else{
            ds1.get(ds1.getLength()-1).setProperty("mobile", mobileValue);
        }
     }
} 
</script>

</head>
<body>
<form name="form" method="post" id="datacell_formid"> 
<input name="rel_id" type="hidden" value="<%=id%>"/>
<input name="is_preget" type="hidden" value="<%=is_preget%>"/>
<input name="isLimitUpperAndLower" type="hidden" value="${isLimitUpperAndLower }"/>
<div id="right">
    <div class="tab">
        <div id="bg" class="xixi3">
            <div id="font1" class="tab3" onMouseDown="setTabBatSyn(1);document.getElementById('bg').className='xixi3';"><fmt:message key="peson_order_info"/></div>
            <div id="font2" class="tab4" onMouseDown="setTabBatSyn(2);document.getElementById('bg').className='xixi4';"><fmt:message key="basic_info_and_lobar_contract"/></div>
        </div>
        <div id="TabCon1">
            <!--表格1-->
              <div class="ringht_s" style=" border:1px solid #bfd8e0;">
                  
                        <div class="box_3">
        <div class="xz_title"><fmt:message key="overall_set"/></div>
        <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key="batch_on_post_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="pl_apply_on_post_date" name="pl_apply_on_post_date" onchange="toAllInputDate();"/>
            </td>
            
            <td class="td_1"><fmt:message key="batch_fee_begin_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="pl_charge_start_date" name="pl_charge_start_date" onchange="toAllChargeDate();"/>
            </td>
            <td class="td_1"><fmt:message key="batch_fee_end_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="pl_charge_end_date" name="pl_charge_end_date"/>
            </td>
          </tr>
          
          <tr>
            <td class="td_1">户籍类型</td>
            <td class="td_2">
                <!-- RmStringHelper.prt(empVo.getResident_type_bd()) -->
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("resident_type_bd", -1, "RESIDENT_TYPE_BD","" , "inputName='户籍类别' ", false) %>
            </td>
            <td class="td_1">社保标准</td>
            <td class="td_2">
                 <select name="sbbz" id="sbbz">
                    <option value="">--请选择--</option>
                    <%
                    for(SecuritygroupShortcutVo vo : listgscVoList){
                    %>
                    <option value="<%=vo.getId() %>"><%=vo.getGroup_shortcut_name() %></option>
                    <%
                    }
                    %>
                </select>
            </td>
            <td class="td_1"></td>
            <td class="td_2"></td>
          </tr>
        </table>
    </div>
            <!--表格 -->
            <div id="values_div">
                    <r:datacell 
                         id="firsttbody"
                         queryAction="/FAERP/EmppostAction.do?cmd=initInsertBat2"
                         submitAction="/FAERP/EmppostAction.do?cmd=savePostBat"
                         width="100%"
                         xpath="EmppostsendVo"
                         submitXpath="EmppostsendVo"
                         paramFormId="datacell_formid"
                         pageSize="-1" readonly="false"
                         freezeNumber="3"
                         >

                         <r:field fieldName="is_check" messagekey="choose" width="50px" align="center" sortAt="none" onRefreshFunc="setCheckboxStatus">
                         </r:field>                   
                         <r:field fieldName="emp_code" messagekey="emp_code">
                         </r:field>
                         <r:field fieldName="emp_name" messagekey="emp_name">
                         </r:field>
                         <r:field fieldName="id_card_type_bd" messagekey="id_card_type" allowModify="false">
                             <d:select dictTypeId="ID_CARD_TYPE_BD"/>
                         </r:field>
                         <r:field fieldName="id_card" messagekey="emp_card_no1">
                         </r:field>
                         <r:field fieldName="isonline" label="是否线上">
                             <d:select dictTypeId="TrueOrFalse" nullLabel="--请选择--" onchange="onchangeBat(this,6,'isonline');"/>
                         </r:field>
                         <r:field fieldName="is_phoenix" label="是否E化入职">
                             <d:select dictTypeId="TrueOrFalse" nullLabel="--请选择--" onchange="onchangeBatE(this,7,'is_phoenix');"/>
                         </r:field>
                         <r:field fieldName="is_Offpost_phoenix" label="是否E化离职">
                             <d:select dictTypeId="IS_FOREIGNER" nullLabel="--请选择--" onchange="onchangeBatE(this,8,'is_Offpost_phoenix');"/>
                         </r:field>
                         <r:field fieldName="internal_code" messagekey="internal_code">
                            <h:text/>
                         </r:field>
                         <r:field fieldName="contract_type_bd" messagekey="emp_on_post_type">
                             <d:select dictTypeId="EMP_POST_TYPE_BD" nullLabel="--请选择--"/>
                         </r:field>
                         <r:field fieldName="emp_entry_bd" messagekey="emp_entry">
                             <d:select dictTypeId="EMP_ENTRY_BD" nullLabel="--请选择--"/>
                         </r:field>
                         <r:field fieldName="apply_on_post_date" messagekey="apply_on_post_date">
                             <w:date format="yyyy-MM-dd" name="apply_on_post_date"/>
                         </r:field>
                         <r:field fieldName="is_import_client" messagekey="is_import_client">
                            <h:switchCheckbox id="is_import_client" value="0"  checkedValue="1" uncheckedValue="0"/>
                         </r:field>
                         <r:field fieldName="is_employ_notice" messagekey="is_employ_notice">
                            <h:switchCheckbox id="is_employ_notice" value="0"  checkedValue="1" uncheckedValue="0"/>
                         </r:field>
                         <r:field fieldName="is_physical_examination" messagekey="is_physical_examination">
                            <h:switchCheckbox id="is_physical_examination" value="0"  checkedValue="1" uncheckedValue="0"/>
                         </r:field>
                         <r:field fieldName="security_unit_id" label="社保福利办理方">
                            <r:comboSelect id="com1" 
                                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                                textField="hire_unit_short_name" 
                                valueField="id" 
                                xpath="SocialunitVo"
                                messagekey="please_choose" >
                            </r:comboSelect>                          
                         </r:field>
                         <r:field fieldName="fund_security_unit_id" label="公积金福利办理方">
                            <r:comboSelect id="com2" 
                                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                                textField="hire_unit_short_name" 
                                valueField="id" 
                                xpath="SocialunitVo"
                                messagekey="please_choose" >
                            </r:comboSelect>                          
                         </r:field>
                         <r:field fieldName="hire_security_unit_id" label="用退工福利办理方">
                            <r:comboSelect id="com3" 
                                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                                textField="hire_unit_short_name" 
                                valueField="id" 
                                xpath="SocialunitVo"
                                messagekey="please_choose" >
                            </r:comboSelect>                          
                         </r:field>
                         <r:field fieldName="is_tax" label="报税属性">
                             <d:select dictTypeId="TAX_FLAG"/>
                         </r:field>
                         <r:field fieldName="tax_bureau" label="报税税局">
                             <h:text/>
                         </r:field>
                         <r:field fieldName="job_num" label="工号">
                             <h:text/>
                         </r:field>
                         <r:field fieldName="hro" label="HRO">
                             <h:text/>
                         </r:field>
                         <r:field fieldName="business" label="业务部门">
                             <h:text/>
                         </r:field>
                         <r:field fieldName="ee_status" label="员工状态">
                             <d:select dictTypeId="EMP_POSITION" nullLabel="--请选择--"/>
                         </r:field>
                         <r:field fieldName="salary" messagekey="pay" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text onchange="anySecury();"/>
                         </r:field>
                         <r:field fieldName="charge_start_date" messagekey="pay_begin">
                            <w:date format="yyyy-MM-dd" name="charge_start_date"/>
                         </r:field>
                         <r:field fieldName="charge_end_date" messagekey="pay_end">
                            <w:date format="yyyy-MM-dd" name="charge_end_date"/>
                         </r:field>
                         <r:field fieldName="on_post_desc" messagekey="on_post_desc">
                            <h:text/>
                         </r:field>
                         <r:field fieldName="allmoney" messagekey="contract_all_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text onchange="checkallmoney();"/>
                         </r:field>
                         <!-- 社保产品循环，行转为列 -->
                         <script>
                            var start5Index = 28;
                            var array5Index = start5Index;
                            var array5 = [];
                           
                         </script>
                         <logic:iterate   name="productbeans"  id="data1" scope="session" indexId="indexs">
                             <bean:define id="security_product_id" name="data1" property="id" type="java.lang.String"/>
                             <bean:define id="product_name" name="data1" property="product_name" type="java.lang.String"/>
                             
                             <r:field fieldName="sf_start_date_${security_product_id}" messagekey="pay_begin_month">
	                            <h:text  onchange="anyStartDate('${security_product_id}')"/>
	                         </r:field>
	                         <script>array5Index++;array5[array5Index-start5Index-1]="${product_name}";</script>
	                         <r:field fieldName="base_${security_product_id}" messagekey="cardinal_num" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                                <h:text  onchange="anyAmount('${security_product_id}');"/>
                             </r:field>
                             <r:field fieldName="money_${security_product_id}" messagekey="money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                                <h:text  onchange="anyMoney('${security_product_id}');"/>
                             </r:field>
                             <r:field fieldName="e_money_${security_product_id}" messagekey="enterprise_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return  formatNumber(cellText,'#,###.##');})">
                                <h:text  onchange="countMoney('${security_product_id}');"/>
                             </r:field>
                             <r:field fieldName="p_money_${security_product_id}" messagekey="person_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                                <h:text  onchange="countMoney('${security_product_id}');"/>
                             </r:field>
                         </logic:iterate>
                         <script>
                            //alert(array5.length);
                            var array2Index = 0;                            
                            var array2 = [];
                            // alert('社保产品循环，行转为列');
                         </script>                         
                         <logic:iterate name="fulibeans"  id="data2" scope="session" indexId="indexid">
                             <bean:define id="product_id" name="data2" property="id" type="java.lang.String"/>
                             <bean:define id="money_dd" name="data2" property="money" type="java.math.BigDecimal"/>
                             
                            <r:field fieldName="fl_sf_start_date_${product_id}" messagekey="pay_begin_day" >
                                <w:date format="yyyy-MM-dd" name="fl_sf_start_date"/>
                             </r:field>
                             <logic:equal name="data2" property="onpost_input" value="1">
	                             <r:field allowModify="true" fieldName="fl_money_${product_id}" messagekey="money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){if(cur.isFirstTimeRefresh==true ){ entity.setProperty('fl_money_${product_id}','${money_dd }');};if(cur.isFirstTimeRefresh ===false){return formatNumber(entity.getProperty('fl_money_${product_id}'),'#,###.##');}else{return formatNumber('${money_dd }','#,###.##');}})">
	                                <h:text  onchange="anyFlMoney('${product_id}');"/>
	                             </r:field>
                             </logic:equal>
                             <logic:equal name="data2" property="onpost_input" value="0">
                                 <r:field allowModify="false"  fieldName="fl_money_${product_id}" messagekey="money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){if(cur.isFirstTimeRefresh==true ){ entity.setProperty('fl_money_${product_id}','${money_dd }');};if(cur.isFirstTimeRefresh ===false){return formatNumber(entity.getProperty('fl_money_${product_id}'),'#,###.##');}else{return formatNumber('${money_dd }','#,###.##');}})">
                                    <h:text  onchange="anyFlMoney('${product_id}');"/>
                                 </r:field>
                             </logic:equal>
                             
                             <bean:define id="product_name2" name="data2" property="product_name" type="java.lang.String"/>
                             <script>array2Index++;array2[array2Index-1]="${product_name2}";</script>
                         </logic:iterate>
                      </r:datacell>
           
                </div>      
                  
                  
                  
                <div style="overflow:hidden;">
                    <div id="values_div2" style="width:60%; float:left;">
                      <r:datacell 
                         id="grdCityEnsureTbody"
                         queryAction="/FAERP/EmppostAction.do?cmd=initInsertBat1"
                         submitAction="/FAERP/EmppostAction.do?cmd=savePostBat"
                         width="100%"
                         xpath="SecurityAllVo"
                         submitXpath="SecurityAllVo"
                         paramFormId="datacell_formid"
                         pageSize="-1" readonly="false"
                         >
                         <r:field  fieldName="product_name" messagekey="product">
                         </r:field>
                         <r:field fieldName="group_name" messagekey="ss_fund">
                         </r:field>
                         <r:field fieldName="e_ratio" messagekey="enterprise_pro" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.####');})">
                         </r:field>
                         <r:field fieldName="p_ratio" messagekey="person_pro" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.####');})">
                         </r:field>
                         <r:field width="80" fieldName="is_prepay" label="是否预收<input type='checkbox' name='prepayall' value='' onclick='prepayAll_onClick(this);' />" sortAt="none">
                            <h:switchCheckbox id="is_prepay" value="0"  checkedValue="1" uncheckedValue="0"/>
                         </r:field>
                         <r:field width="80" fieldName="charge_frequency_bd" messagekey="pay_frequency" defaultValue="1">
                            <d:select id="dselect1" dictTypeId="FREQUENCY_BD" nullLabel="--请选择--" onchange="javascript:checkprepay();"/>
                         </r:field>
                         <r:field width="120" fieldName="is_charge_on_security" label="福利办理好收费<input type='checkbox' name='chargeall' value='' checked onclick='chargeAll_onClick(this);' />" sortAt="none" onRefreshFunc="setCheckboxStatus1_1">
                         </r:field>
                         <r:field fieldName="is_preget" messagekey="is_preget">
				            <d:select id="dselect2" dictTypeId="ISPREGET" nullLabel="--请选择--"/>
				         </r:field>
                         <r:field fieldName="e_add_ratio" messagekey="enterprise_add_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                         </r:field>
                         <r:field fieldName="p_add_ratio" messagekey="person_add_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                         </r:field>
                         
                       </r:datacell>
                    </div>
                    <div id="values_div3" style="width:35%; float:right;">
                      <r:datacell 
                         id="fulitbody"
                         queryAction="/FAERP/EmppostAction.do?cmd=initInsertBat3"
                         submitAction="/FAERP/EmppostAction.do?cmd=savePostOne"
                         width="100%"
                         xpath="ProductVo"
                         submitXpath="ProductVo"
                         paramFormId="datacell_formid"
                         pageSize="-1"
                         >
                        
                         <r:field  fieldName="product_name" messagekey="product">
                         </r:field>
                         <r:field fieldName="is_prepay" label="是否预收<input type='checkbox' name='prepayall1' value='' onclick='prepayAll_onClick1(this);' />" sortAt="none">
                            <h:switchCheckbox id="is_prepay" value="0"  checkedValue="1" uncheckedValue="0"/>
                         </r:field>
                         <r:field fieldName="charge_frequency_bd" messagekey="pay_frequency" defaultValue="1">
                            <d:select id="dselect2" dictTypeId="FREQUENCY_BD" nullLabel="--请选择--" onchange="javascript:checkprepay1();"/>
                         </r:field>
                         <r:field width="120" fieldName="is_charge_on_security" messagekey="is_charge_on_security" sortAt="none" onRefreshFunc="setCheckboxStatus2_1">
                         </r:field>
                         <r:field fieldName="is_preget" messagekey="is_preget">
				            <d:select id="dselect2" dictTypeId="ISPREGET" nullLabel="--请选择--"/>
				         </r:field>
				         <r:field fieldName="is_foreign_welfare" label="是否做外地福利">
				            <h:switchCheckbox id="is_foreign_welfare" value="0"  checkedValue="1" uncheckedValue="0"/>
				         </r:field>
                       </r:datacell>
                    </div>
                  </div>
                  <!--表格 end-->
                  <p></p>
                  
                <div class="foot_button">
                      <input type="button" class="foot_icon_1" value="<fmt:message key="go_one"/>" onClick="location.href='<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/emppost/initInsertbat1.jsp'"/>
                      <input type="button" class="foot_icon_1" value="<fmt:message key="generate_order"/>" onClick="javascript:submitAll();"/>
                </div>
          </div>
             <!--表格1 end-->
        </div>
        <div id="TabCon2" >
            <div class="ringht_s" style=" border:1px solid #bfd8e0;">
	            <!--表格2-->
	            <div id="values_div4">
                    <r:datacell 
                         id="secondtbody"
                         queryAction="/FAERP/EmppostAction.do?cmd=initInsertBat4"
                         submitAction="/FAERP/EmppostAction.do?cmd=savePostBat"
                         width="100%" 
                         xpath="EmployeeVo"
                         submitXpath="EmployeeVo"
                         paramFormId="datacell_formid"
                         pageSize="-1" readonly="false"
                         freezeNumber="2"
                         >
                         <r:field  fieldName="emp_code" messagekey="emp_code">
                         </r:field>
                         <r:field fieldName="emp_name" messagekey="emp_name">
                         </r:field>
                         <r:field fieldName="tel" messagekey="tel1">
                            <h:text/>
                         </r:field>
                         <r:field fieldName="mobile" messagekey="mobile1">
                             <!-- validateAttr="type=number;allowNull=true;maxLength=11;minLength=11;message=不是完整的11位手机号"  -->
                               <h:text  onkeydown="value=value.replace(/[^\d{11}]/g,'') " onblur="checkMobile(this);" />
                         </r:field>
                         <r:field fieldName="address" messagekey="address">
                            <h:text/>
                         </r:field>
                         <r:field fieldName="postal_code" messagekey="postal_code">
                            <h:text/>
                         </r:field>
                         <r:field fieldName="resident_addresss" messagekey="resident_addresss">
                            <h:text/>
                         </r:field>
                         <r:field fieldName="email" messagekey="email">
                            <h:text/>
                         </r:field>
                         <r:field fieldName="language_type_bd" messagekey="language_type_bd">
                            <d:select dictTypeId="LANGUAGE_TYPE_BD" nullLabel="--请选择--"/>
                         </r:field>
                         <r:field fieldName="language_level_bd" messagekey="language_level_bd">
                            <d:select dictTypeId="LANGUAGE_LEVEL_BD" nullLabel="--请选择--"/>
                         </r:field>
                         <r:field fieldName="education_bd" messagekey="education_bd">
                            <d:select dictTypeId="EDUCATION_BD" nullLabel="--请选择--"/>
                         </r:field>
                         <r:field fieldName="gzjl" messagekey="gzjl">
                            <h:text/>
                         </r:field>
                         <r:field fieldName="start_date" messagekey="start_date">
                            <w:date format="yyyy-MM-dd" name="start_date"/>
                         </r:field>
                         <r:field fieldName="end_date" messagekey="end_date">
                            <w:date format="yyyy-MM-dd" name="end_date"/>
                         </r:field>
                         <r:field fieldName="try_start_date" messagekey="try_start_date">
                            <w:date format="yyyy-MM-dd" name="try_start_date"/>
                         </r:field>
                         <r:field fieldName="try_end_date" messagekey="try_end_date">
                            <w:date format="yyyy-MM-dd" name="try_end_date"/>
                         </r:field>
                         <r:field fieldName="send_start_date" messagekey="send_start_date">
                            <w:date format="yyyy-MM-dd" name="send_start_date"/>
                         </r:field>
                         <r:field fieldName="send_end_date" messagekey="send_end_date">
                            <w:date format="yyyy-MM-dd" name="send_end_date"/>
                         </r:field>
                         <r:field fieldName="salary" messagekey="pay" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                           <h:text onchange="salaryNoNum2('salary')"/>
                         </r:field>
                         <r:field fieldName="try_salary" messagekey="try_salary" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text onchange="salaryNoNum2('try_salary')"/>
                         </r:field>
                         <r:field fieldName="position" messagekey="post">
                            <h:text/>
                         </r:field>
                          <r:field fieldName="working_bd" label="工作制">
                            <d:select dictTypeId="WORKING_BD" nullLabel="--请选择--"/>
                         </r:field>
                       </r:datacell>
                   </div>
                <!--表格2 end-->        
                <p></p>
                </div>
            <div class="foot_button">
                <input type="button" class="foot_icon_1" value="<fmt:message key="go_one"/>" onClick="location.href='<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/emppost/initInsertbat1.jsp'"/>
                <input type="button" name="button_reset1" class="foot_icon_1" value="<fmt:message key="generate_order"/>" onClick="javascript:submitAll();"/>
           </div>
        </div>
    </div>
</div>
</form>
</body>
</fmt:bundle>
<script>


    $id("firsttbody").headHeight = 23+23;
    $id("firsttbody").headTextAlign = "center";

</script>

<script language="javascript" src="<venus:base/>/jsp/faerp/employeepost/empentry/emppost/initProductbat.js"></script>
</html>
<script>
//解决修改行数据，多选框勾选消失BUG
    $id("grdCityEnsureTbody").beforeRefreshCell = function(cell,field){
        if(field && field.fieldName && field.fieldName.indexOf("is_charge_on_security") >= 0){
            return false;
        }
        return true;
    }
    
    $id("fulitbody").beforeRefreshCell = function(cell,field){
        if(field && field.fieldId && field.fieldId.indexOf("is_charge_on_security") >= 0){
            return false;
        }
        return true;
    } 
    

    $id("firsttbody").beforeRefreshCell = function(cell,field){
        if(field && field.fieldId && field.fieldId.indexOf("emp") >= 0){
            return false;
        }
        return true;
    } 

    var aa = 0;
    //初始化加载时，显示福利产品金额
    $id("fulitbody").afterRefresh = function(){
        aa++;
        var allmoney=0;
           
        //获得该福利产品的各项属性
        var datacell1 = $id("fulitbody");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        var svalue = "";
        if (aa ==2 ){
            var is_preget =  jQuery("input[name='is_preget']").val();
            
            for(var k=0; k<dataset1.getLength(); k++){
                dataset1.get(k).setProperty("is_preget",is_preget);
                
                datacell1.refreshRow(datacell1.getRow(k));
                
                svalue = dataset1.get(k).getProperty("money");
                if(checkFloat(svalue)){
                    allmoney+= getNumber(svalue);
                }
           }
            
        }else{
            for(var k=0; k<dataset1.getLength(); k++){
                svalue = dataset1.get(k).getProperty("money");
                if(checkFloat(svalue)){
                    allmoney+= getNumber(svalue);
                }
            }
        }
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
             dataset.get(i).setProperty("allmoney",allmoney.toFixed(2));
        }
        datacell.refresh();
        
    }
    var bb = 0;
    $id("grdCityEnsureTbody").afterRefresh = function(){
        bb++;
        if (bb ==2 ){
            
            var datacell = $id("grdCityEnsureTbody");
            var is_preget =  jQuery("input[name='is_preget']").val();
            var dataset2 = datacell.dataset;
            for(var i=0; i<dataset2.getLength(); i++){
                dataset2.get(i).setProperty("is_preget",is_preget);
                datacell.refreshRow(datacell.getRow(i));
           }
        }
        
        return true;
    }

    
jQuery(document).ready(function() {
 
        var Me=$id("firsttbody");
        
        Me.afterInit = function(){
        
            //社保产品列头设定
	       var getIndex = 28;
	        for (var i=0; i < array5.length; i++ ) {
	           var key_css=""; 

	           key_css= ".eos-hd-row td[class='eos-dc-col-firsttbody-" + (getIndex+i*5+1) + "']";

	           
	            var td = jQuery(key_css);
	            var a0 = td.clone();
	            var a1 = td.next().clone();
	            var a2 = td.next().next().clone();
	            var a3 = td.next().next().next().clone();
	            var a4 = td.next().next().next().next().clone();
	    
	            a0.css("height", "23");
	            a1.css("height", "23");
	            a2.css("height", "23");
	            a3.css("height", "23");
	            a4.css("height", "23");
	    
	            td.next().next().next().next().remove();
	            td.next().next().next().remove();
	            td.next().next().remove();
	            td.next().remove();
	            td.remove();

                var newTable = jQuery("<td class='eos-dc-col-firsttbody-new-" + (getIndex+5*i+5) + "' style='text-align: left; height: 46px;width:500'>" 
                + "<table border='0' cellpadding='0' cellspacing='0' style='border:0px;margin:0px;padding:0px'>"
                + "<tr><td colspan='" + "5" + "' style='text-align:center;height:23px;'>" 
                + " <span>" + array5[i] + "</span></td></tr>"
                + "<tr class='oldHeadTr'></tr></table></td>");
                
                newTable.find(".oldHeadTr").append(a0).append(a1).append(a2).append(a3).append(a4);
	            
	            if (i <= 0){    
	                //alert(newTable.html());
	                jQuery(".eos-hd-row td[class='eos-dc-col-firsttbody-" + (getIndex+i*5) + "']").after(newTable);
	               
	            }else{
	                //alert(newTable.html());
	                jQuery(".eos-hd-row td[class='eos-dc-col-firsttbody-new-" + (getIndex+i*5) + "']").after(newTable);
	            
	            }
	        }	       
	       //福利产品列头的设定
           var getIndex2 = 28 + array5.length*5;
           //alert(getIndex2);
            for (var i=0; i < array2.length; i++ ) {
               var key_css=""; 

               key_css= ".eos-hd-row td[class='eos-dc-col-firsttbody-" + (getIndex2+i*2+1) + "']";

               
                var td = jQuery(key_css);
                var a0 = td.clone();
                var a1 = td.next().clone();
        
                a0.css("height", "23");
                a1.css("height", "23");
        
                td.next().remove();
                td.remove();

                var newTable = jQuery("<td class='eos-dc-col-firsttbody-new-" + (getIndex2+2*i+2) + "' style='text-align: left; height: 46px;width:200'>" 
                + "<table border='0' cellpadding='0' cellspacing='0' style='border:0px;margin:0px;padding:0px'>"
                + "<tr><td colspan='" + "2" + "' style='text-align:center;height:23px;'>" 
                + " <span>" + array2[i] + "</span></td></tr>"
                + "<tr class='oldHeadTr'></tr></table></td>");
                
                newTable.find(".oldHeadTr").append(a0).append(a1);
                if(array5.length <= 0 && i<=0){
                    jQuery(".eos-hd-row td[class='eos-dc-col-firsttbody-" + (getIndex2+i*2) + "']").after(newTable);
                }else{
                    jQuery(".eos-hd-row td[class='eos-dc-col-firsttbody-new-" + (getIndex2+i*2) + "']").after(newTable);
                }

            }     	        
	        
      }
        Me.afterRefresh = function(){
            Me.isFirstTimeRefresh = false;
        }
        Me.beforeRefresh = function(){

            Me.isFirstTimeRefresh = true;
        }      
  
    //单行的日期变化了，本行的其他相关日期等也要跟着变化
    Me.afterEdit = function (newValue,oldValue){
        var activeFieldName = Me.activeField.fieldName;
        if (activeFieldName && activeFieldName != "apply_on_post_date" && activeFieldName != "charge_start_date") return true;
        
        //单行的入职日期变化了，改变收费起始日期、收费结束日期、社保产品的收费起始月、福利收费起始日期
        if(activeFieldName && activeFieldName == "apply_on_post_date"){
	        var datacell = $id("firsttbody");
	        var activeRow = datacell.activeRow;
	        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
	        
	        var input_date = newValue;
	        if(input_date==null || input_date==''){
                return;
	        }
	        var emp_id = datasettr.getProperty("emp_id");
            var emp_name = datasettr.getProperty("emp_name");
            //判断新输入的入职日期不能小于该员工的离职日期
            jQuery.ajax({
               url: vpath+'/EmppostAction.do?cmd=checkApplyDate&emp_id='+emp_id+'&apply_date='+input_date,
               type: 'GET',
               dataType: 'html',
               async: false,
               timeout: 10000,
               error: function(){
                   alert('Error loading XML document');
                       return  null;
                   },
               success: function(text){
                   if(text==1){       
                         alert("<fmt:message key="emp"/>"+emp_name+"<fmt:message key="choose1"/>");
                         datasettr.setProperty("apply_on_post_date",'');
                         return;
                   }else{
            
			            //var emp_id = datasettr.getProperty("emp_id");
			            var emp_post_type = datasettr.getProperty("contract_type_bd");
			            var start_date=tostartDate(input_date);
			            var end_date=toendDate(start_date);
			            var end_date1=addYear(input_date,2);
			            
			            var yearmonth = start_date.substring(0,4)+start_date.substring(5,7);
			            
			            datasettr.setProperty("charge_start_date",start_date);
			            datasettr.setProperty("charge_end_date",end_date);
			            
			            
			            var fields = datacell.fields;//获得页面所有的列
			            //列循环，使用页面field名称设值
			            for(var j=0; j<fields.length; j++){
			                var field = fields[j];
			                var fieldName = field.fieldName;
			                //更新福利收费起始日期
			                if (fieldName.indexOf("fl_sf_start_date") == 0){
			                    datasettr.setProperty(fieldName,start_date);
			                }
			                if(fieldName.indexOf("sf_start_date") == 0){
			                    datasettr.setProperty(fieldName,yearmonth);
			                }
			                if (fieldName.indexOf("base") == 0){
			                    //修改基数不为空的值
			                    if(datasettr.getProperty(fieldName)!=null || datasettr.getProperty(fieldName)!=''){
			                        //得到社保产品id
			                        var basename = fieldName.split('_');
			                        var security_product_id = basename[1];
			                        var base = datasettr.getProperty(fieldName);
			                        //根据新的起始收费日期重新判断基数范围，并计算金额
			                        anyAmount1(datasettr,security_product_id,base);
			                    }
			                        
			                }
			            }       
			            //同步更新该员工劳动合同起止日期
			            var datacell1 = $id("secondtbody");
			            var dataset1 = datacell1.dataset;//取得页面的datacell
			            
			            var datasettr1 = dataset1.findEntity("id",emp_id );
			            datasettr1.setProperty("start_date",input_date);
			            datasettr1.setProperty("end_date",end_date1);
			            
			            if(emp_post_type=='1' || emp_post_type=='3'){
			                datasettr1.setProperty("send_start_date",input_date);
			                datasettr1.setProperty("send_end_date",end_date1);
			            }
			            datacell1.refresh();
			            datacell1.endEdit();
			        }
                   
               }
           });
           
	    }
	    
	    //单行的收费起始日期变化了，改变社保产品的收费起始月、福利收费起始日期
	    if(activeFieldName && activeFieldName == "charge_start_date"){
            var datacell = $id("firsttbody");
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            
            var input_date = newValue;
            if(input_date==null || input_date==''){
                alert("<fmt:message key="please_check_in"/>");
                return;
            }
            var yearmonth = input_date.substring(0,4)+input_date.substring(5,7);
            
            var fields = datacell.fields;//获得页面所有的列
            //列循环，使用页面field名称设值
            for(var j=0; j<fields.length; j++){
                var field = fields[j];
                var fieldName = field.fieldName;
                //更新福利收费起始日期
                if (fieldName.indexOf("fl_sf_start_date") == 0){
                    datasettr.setProperty(fieldName,input_date);
                }
                if(fieldName.indexOf("sf_start_date") == 0){
	                datasettr.setProperty(fieldName,yearmonth);
	            }
                if (fieldName.indexOf("base") == 0){
                    //修改基数不为空的值
                    if(datasettr.getProperty(fieldName)!=null || datasettr.getProperty(fieldName)!=''){
                        //得到社保产品id
                        var basename = fieldName.split('_');
                        var security_product_id = basename[1];
                        var base = datasettr.getProperty(fieldName);
                        //根据新的起始收费日期重新判断基数范围，并计算金额
                        anyAmount1(datasettr,security_product_id,base);
                    }
                        
                }
            }       
	    }
	    
        return true;
    }      
    var isFirstLoad = true;
    $id("secondtbody").afterRefresh = function(){
        if (isFirstLoad) {
	        setTabBatSyn(1);
	        document.getElementById('bg').className='xixi3';
            isFirstLoad = false;
        }       
    }
});

//员工勾选，需要设置dataset中的值
    $id("firsttbody").onClickCell = function(targetTD, colIdx, rowIdx, activeEntity, curfield, datacell){
       
        var datacell = $id("firsttbody");
        var activeFieldName = curfield.fieldName;
        if (activeFieldName && activeFieldName != "is_check") return true;
        
        if(activeFieldName && activeFieldName == "is_check"){
            var is_check = activeEntity.getProperty("is_check");
            if(is_check=='1'){
                activeEntity.setProperty("is_check",'0');
            }else{
                activeEntity.setProperty("is_check",'1');
            }
            return false;
        }
        
        datacell.endEdit();
        return true;
    }
    
//预收勾选，要判断收费频率是否为每月付
    $id("grdCityEnsureTbody").onClickCell = function(targetTD, colIdx, rowIdx, activeEntity, curfield, datacell){
       
        var datacell = $id("grdCityEnsureTbody");
        var activeFieldName = curfield.fieldName;
        if (activeFieldName && activeFieldName != "is_prepay") return true;
        
        if(activeFieldName && activeFieldName == "is_prepay"){
            var prepay = activeEntity.getProperty("is_prepay");
            var frequence = activeEntity.getProperty("charge_frequency_bd");
            if(prepay=='1' && frequence!='1'){
                alert("<fmt:message key="sorry"/>");
                activeEntity.setProperty("is_prepay",'0');
                return false;
            }
        }
        
        datacell.endEdit();
        return true;
    }
    
    //预收勾选，要判断收费频率是否为每月付
    $id("fulitbody").onClickCell = function(targetTD, colIdx, rowIdx, activeEntity, curfield, datacell){
       
        var datacell = $id("fulitbody");
        var activeFieldName = curfield.fieldName;
        if (activeFieldName && activeFieldName != "is_prepay") return true;
        
        if(activeFieldName && activeFieldName == "is_prepay"){
            var prepay = activeEntity.getProperty("is_prepay");
            var frequence = activeEntity.getProperty("charge_frequency_bd");
            if(prepay=='1' && frequence!='1'){
                alert("<fmt:message key="sorry"/>");
                activeEntity.setProperty("is_prepay",'0');
                return false;
            }
        }
        
        datacell.endEdit();
        return true;
    }
   
   // settimeout(a2,2);
    //  settimeout(a3,3);
     //   settimeout(a4,4);
</script>

<script > 
 function a1(){
          //   alert(' befor a1');
        var datacell = $id("firsttbody");
        datacell.loadData();
    datacell.refresh();
            // alert('a1');
        
    }
    
    function a2(){
            // alert(' befor a2');
        var datacel2 = $id("grdCityEnsureTbody");
        datacel2.loadData();
        datacel2.refresh();
            // alert('a2');
    }
  
  
      function a3(){
           // alert(' befor a3');
        var datacel3 = $id("fulitbody");
        datacel3.loadData();
        datacel3.refresh();
         //    alert('a3');
    }
  
    function a4(){
       //alert(' befor a4');
        var datacel4 = $id("secondtbody");
        datacel4.loadData();
       datacel4.refresh();
        //alert('a4');
        
    }
  Concurrent.Thread.create(a1);
  Concurrent.Thread.create(a2);
  Concurrent.Thread.create(a3);
  Concurrent.Thread.create(a4);
</script> 

