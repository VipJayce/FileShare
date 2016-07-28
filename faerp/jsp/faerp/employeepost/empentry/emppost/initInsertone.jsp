<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="java.util.*" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostsendVo" %>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants" %>
<%@ page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo" %>
<%  
    //派出信息
    EmppostsendVo postsendVo = null;  //定义一个临时的vo变量
    postsendVo = (EmppostsendVo)request.getAttribute(IEmppostConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
    if(postsendVo==null)
        postsendVo= new EmppostsendVo();
    
    String city_id = (String)request.getAttribute("city_id");
    String is_phoenix = (String)request.getAttribute("IS_PHOENIX");//2015-3-23 yangyuting
    String is_Offpost_phoenix = (String)request.getAttribute("IS_OFFPOST_PHOENIX");//2015-3-23 yangyuting
    System.out.println(city_id);
    //人员基本信息
    EmployeeVo empVo = null;  //定义一个临时的vo变量
    empVo = (EmployeeVo)request.getAttribute("empbean");  //从request中取出vo, 赋值给resultVo
    if(empVo==null)
        empVo = new EmployeeVo();
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
   var ruleBD = "${supp_medicare_start_rule}";//获取当前办理申报入职的委派单中【补医保开始日期】的规则属性值
   
    var vpath = "<%=request.getContextPath()%>";
        
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    function submitAll(){//表单提交\
      var frm = $id("datacell_formid");
  
      //表单验证
      if( !checkForm(frm) ) {
          
          return;
      }    
        if(checkAllCont()){
        
            jQuery("input[name='button_reset1']").attr('disabled','disabled');
            
            var dc1 = $id("grdCityEnsureTbody");
            var dc2 = $id("fulitbody");
            var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=savePostOne";
            //将两个datacell的xml内容合并
            var xmlSubmit = dc1.dataset.toString();
            xmlSubmit +=  dc2.dataset.toString();
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
                      alert("<fmt:message key='entry_declare_success'/>"+"<fmt:message key='confirmTax'/>");
                      window.location.href="<%=request.getContextPath()%>/EmppostAction.do?cmd=queryAll&backFlag=true";
                  } else if( myAjax.getValue("root/data/returnValue") == -1 ) {
                      alert("<fmt:message key="entry_agent_error"/>"); 
                  } else if( myAjax.getValue("root/data/returnValue") == -2 ) {
                      alert("该员工已经在职，不能再次申报入职！"); 
                  } else if( myAjax.getValue("root/data/returnValue") == -3 ) {
                      alert("该员工申报入职正在处理，不能重复提交！"); 
                  } else if( myAjax.getValue("root/data/returnValue") == -4 ) {
                      alert("该员工的福利办理方和客户对应的社保账号不存在或社保账号未配置新的工伤保险比例！"); 
                  } else if( myAjax.getValue("root/data/returnValue").split(",")[0] == -5 ) {
                      alert( myAjax.getValue("root/data/returnValue").split(",")[1] ); 
                  }else {
                      alert("<fmt:message key="entry_declare_error"/>"); 
                  }
                  
                  jQuery("input[name='button_reset1']").removeAttr("disabled");
             }
            
        }

    }
    
     function checkAllCont(){//页面提交验证
        var ali = true;
        var applydate = $id("apply_on_post_date").getValue();
        if(applydate==null || applydate==''){
            alert("<fmt:message key="emp_on_post_date"/>");
            ali = false;
            return ali;
        }
        var charge_start_date = $id("charge_start_date").getValue();
        if(charge_start_date==null || charge_start_date==''){
            alert("<fmt:message key="emp_fee_begin_date"/>");
            ali = false;
            return ali;
        }
        var charge_end_date = $id("charge_end_date").getValue();
        if(charge_end_date==null || charge_end_date==''){
            alert("<fmt:message key="emp_fee_end_date"/>");
            ali = false;
            return ali;
        }
        if(charge_end_date<charge_start_date){
            alert("<fmt:message key="emp_fee_b_gt_e"/>");
            ali = false;
            return ali;
        }
        var emp_post_type_bd = jQuery("select[name='emp_post_type_bd']").val();
        if(emp_post_type_bd==null || emp_post_type_bd==''){
            alert("<fmt:message key="emp_on_post_type_not_null"/>");
            ali = false;
            return ali;
        }else{
            if(emp_post_type_bd=='1' || emp_post_type_bd=='3'){
                var start_date = $id("start_date").getValue();
                var end_date = $id("end_date").getValue();
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
                    ali = false;
                    return ali;
                }
            }
        
        }
        var tel = jQuery("#tel").val();
        var mobile = jQuery("#mobile").val();
        if((tel==null || tel=='') && (mobile==null || mobile=='')){
            alert("<fmt:message key="emp_mobile_or_tel_not_null"/>");
            ali = false;
            return ali;
        }
        //批量判断起始年月、基数不能为空
        var datacell = $id("grdCityEnsureTbody");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
                var datasettr = dataset.get(i);
                if(datasettr.getProperty("sf_start_date")==null || datasettr.getProperty("sf_start_date")==''){
                    alert("<fmt:message key="ss_product_fee_begin_date_not_null"/>");
                    ali = false;
                    return ali;
                }
                if(datasettr.getProperty("base")==null || datasettr.getProperty("base")==''){
                    alert("<fmt:message key="ss_product_cardinal_num_not_null"/>");
                    ali = false;
                    return ali;
                }
                if(datasettr.getProperty("e_ratio")==null || datasettr.getProperty("e_ratio")==''){
                    alert("<fmt:message key="ss_product_enterprise_pro_not_null"/>");
                    ali = false;
                    return ali;
                }
                if(datasettr.getProperty("p_ratio")==null || datasettr.getProperty("p_ratio")==''){
                    alert("<fmt:message key="ss_product_peson_pro_not_null"/>");
                    ali = false;
                    return ali;
                }
                if(datasettr.getProperty("money")==null || datasettr.getProperty("money")==''){
                    alert("<fmt:message key="ss_product_money_not_null"/>");
                    ali = false;
                    return ali;
                }
                if(datasettr.getProperty("e_money")==null || datasettr.getProperty("e_money")==''){
                    alert("<fmt:message key="ss_product_enterprise_money_not_null"/>");
                    ali = false;
                    return ali;
                }
                if(datasettr.getProperty("p_money")==null || datasettr.getProperty("p_money")==''){
                    alert("<fmt:message key="ss_product_peson_money_not_null"/>");
                    ali = false;
                    return ali;
                }
       }
       
       //批量判断福利产品收费起始日期、金额、收费频率不能为空
       var datacell1 = $id("fulitbody");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
                var datasettr = dataset1.get(i);
                if(datasettr.getProperty("money")==null || datasettr.getProperty("money")==''){
                    alert("<fmt:message key="fl_money_not_null"/>");
                    ali = false;
                    return ali;
               }
               if(datasettr.getProperty("sf_start_date")==null || datasettr.getProperty("sf_start_date")==''){
                    alert("<fmt:message key="fl_sf_start_date_not_null"/>");
                    ali = false;
                    return ali;
               }
               if(datasettr.getProperty("charge_frequency_bd")==null || datasettr.getProperty("charge_frequency_bd")==''){
                    alert("<fmt:message key="fl_pay_frequency_not_null"/>");
                    ali = false;
                    return ali;
               }
               
       }
        
       
        var allmoney = jQuery("#allmoney").val();
        if(allmoney==null || allmoney==''){
            alert("<fmt:message key="emp_contract_allmoney_not_null"/>");
            ali = false;
            return;
        }
        
        /*
        //魏佳新增，验证如果报税属性为“FA客户报税”则必须填写“税局（tax_bureau）”
        var is_tax = jQuery("#is_tax").val();
        var tax_bureau = jQuery("#tax_bureau").val();
        if(is_tax==2 && (tax_bureau == "" || tax_bureau == null)){
            alert("报税属性为FA客户报税，必须填写报税税局!");
            ali = false;
            return;
        }
        */
        //魏佳新增，验证是否线上是否为空
        var isonline = jQuery("#isonline").val();
        if(isonline == "" || isonline == null){
            alert("是否线上选项为空，必须选择是否线上选项!");
            ali = false;
            return;
        }
        //2015-3-23 yangyuting新增，验证是否E化入职是否为空
        var is_phoenix = jQuery("#is_phoenix").val();
         var is_phoenix_select= <%=is_phoenix%>;
        if(is_phoenix_select==""||is_phoenix_select=="0"){
            if(is_phoenix=="1"){
              alert("非E化客户不得选择‘是否走E化入职’选项为是！");
		            ali = false;
		            return;
            }
        }else{//E化员工手机号必填 add by yiwenbin
        	var sMobile = jQuery("#mobile").val();
       		if(sMobile==""||sMobile==null){
       			alert('E化员工手机号必填！');
       			ali = false;
	            return;
       		} 
        }
        
        if(is_phoenix == "" || is_phoenix == null){
            alert("是否走E化入职选项为空，必须选择是否走E化入职选项!");
            ali = false;
            return;
        }
        
        //2015-3-23 yangyuting新增，验证是否E化离职职是否为空
        var is_Offpost_phoenix = jQuery("#is_Offpost_phoenix").val();
           var is_Offpost_phoenix_select= <%=is_Offpost_phoenix%>;
        if(is_Offpost_phoenix_select==""||is_Offpost_phoenix_select=="0"){
            if(is_Offpost_phoenix=="1"){
              alert("非E化客户不得选择‘是否走E化离职’选项为是！");
                    ali = false;
                    return;
            }
        }
        if(is_Offpost_phoenix == "" || is_Offpost_phoenix == null){
            alert("是否走E化离职选项为空，必须选择是否走E化离职选项!");
            ali = false;
            return;
        }
        
        return ali;
        
    }
    
    
    function openSelectPro(){
        window.open("jsp/faerp/employeepost/empentry/emppost/selectPro.jsp","newwindow","width=900px,height=600px,location=no,scroll=yes");
    }
    
    
</script>
</head>
<body onclick="hideDiv()">
 
<form name="form" method="post" id="datacell_formid">
<input name="isLimitUpperAndLower" type="hidden" value="${isLimitUpperAndLower }"/>
<div id="right">
    <div class="right_title_bg">
        <div class=" right_title"><fmt:message key="entry_declare"/></div>
    </div>

    <div class="ringht_s">
    
    <!--表格2-->
    <div class="box_3">
        <div class="xz_title"><fmt:message key="person_order_info"/></div>
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <input name="rel_id" type="hidden" value="<%=RmStringHelper.prt(postsendVo.getId())%>"/>
            <input id="cust_id" name="cust_id" type="hidden" value="<%=RmStringHelper.prt(postsendVo.getCust_id())%>"/>
            <input name="send_id" type="hidden" value="<%=RmStringHelper.prt(postsendVo.getSend_id())%>"/>
            <input name="is_preget" type="hidden" value="<%=RmStringHelper.prt(postsendVo.getIs_preget())%>"/>
            <input name="quotation_id" type="hidden" value="<%=RmStringHelper.prt(postsendVo.getQuo_id())%>"/>
            <input id="city_id" name="city_id" type="hidden" value="<%=city_id %>"/>
            <td class="td_1"><fmt:message key="cust_code"/></td>
            <td class="td_2"><input name="cust_code" type="text" class="sText" id="cust_code" readonly value="<%=RmStringHelper.prt(postsendVo.getCust_code())%>"/></td>
            <td class="td_1"><fmt:message key="cust_name"/></td>
            <td class="td_2"><input name="cust_name" type="text" class="sText" id="cust_name" readonly value="<%=RmStringHelper.prt(postsendVo.getCust_name())%>"/></td>
            <td class="td_1"><fmt:message key="emp_name"/></td>
            <td class="td_2"><input name="emp_name" type="text" class="sText" id="emp_name" readonly value="<%=RmStringHelper.prt(postsendVo.getEmp_name())%>"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key="emp_code"/></td>
            <td class="td_2"><input name="emp_code" type="text" class="sText" id="emp_code" readonly value="<%=RmStringHelper.prt(postsendVo.getEmp_code())%>"/></td>
            <td class="td_1"><fmt:message key="id_card_type"/></td>
            <td class="td_2">
                <input name="id_card_type_bd" id="id_card_type_bd" type="hidden" value="<%=RmStringHelper.prt(postsendVo.getId_card_type_bd())%>"/>
                <input name="id_card_type_name" type="text" class="sText" readonly value="<%=BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",String.valueOf(postsendVo.getId_card_type_bd()))%>"/>
            </td>
            <td class="td_1"><fmt:message key="emp_card_no1"/></td>
            <td class="td_2"><input name="id_card" type="text" class="sText" id="id_card" readonly value="<%=RmStringHelper.prt(postsendVo.getId_card())%>"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key="internal_code"/></td>
            <td class="td_2"><input name="internal_code" type="text" class="sText" id="internal_code" value="<%=RmStringHelper.prt(postsendVo.getInternal_code())%>"/></td>
            <td class="td_1"><font color="red">*</font>&nbsp;<fmt:message key="entry_declare_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="apply_on_post_date" name="apply_on_post_date" style="width:172px" onchange="toInputDate();"/>
            </td>
            <td class="td_1"><font color="red">*</font>&nbsp;<fmt:message key="charge_start_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="charge_start_date" name="charge_start_date" style="width:172px" onchange="javascript:changeStartDate();"/>
            
            </td>
          </tr>
          <tr>
            <td class="td_1"><font color="red">*</font>&nbsp;<fmt:message key="charge_end_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="charge_end_date" name="charge_end_date" style="width:172px"/>
            </td>
            <td class="td_1"><font color="red">*</font>&nbsp;<fmt:message key="emp_on_post_type"/></td>
            <td class="td_2">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_post_type_bd", -1, "EMP_POST_TYPE_BD", RmStringHelper.prt(postsendVo.getContract_type_bd()), "inputName='员工入职类型' ", false) %>
            </td>
            <td class="td_1"><fmt:message key="is_import_client"/></td>
            <td class="td_2">
                <select name="is_import_client" class="sSelect" id="is_import_client">
                  <option value=""><fmt:message key="please_choose"/></option>
                  <option value="1" <%if(RmStringHelper.prt(postsendVo.getIs_import_client()).equals("1")){ %>selected<%} %>><fmt:message key="yes"/></option>
                  <option value="0" <%if(RmStringHelper.prt(postsendVo.getIs_import_client()).equals("0")){ %>selected<%} %>><fmt:message key="no"/></option>
                </select>
            </td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key="is_employ_notice"/></td>
            <td class="td_2"><input type="checkbox" name="is_employ_notice" id="is_employ_notice" value="1" <%if(RmStringHelper.prt(postsendVo.getIs_employ_notice()).equals("1")){ %>checked<%} %> />
            <label for="checkbox"></label></td>
            <td class="td_1"><fmt:message key="is_physical_examination"/></td>
            <td class="td_2"><input type="checkbox" name="is_physical_examination" id="is_physical_examination" value="1" <%if(RmStringHelper.prt(postsendVo.getIs_physical_examination()).equals("1")){ %>checked<%} %> />
                <label for="checkbox2"></label></td>
            <td class="td_1"><fmt:message key="emp_entry"/></td>
            <td class="td_2"><d:select name="emp_entry_bd" id="emp_entry_bd" dictTypeId="EMP_ENTRY_BD" style="width: 205px"/></td>
          <tr>
          <% 
            String security_unit_id=   RmStringHelper.prt(postsendVo.getSecurity_unit_id());
            String fund_security_unit_id=   RmStringHelper.prt(postsendVo.getFund_security_unit_id());
            String hire_security_unit_id=   RmStringHelper.prt(postsendVo.getHire_security_unit_id());
            request.setAttribute("security_unit_id",security_unit_id);
            request.setAttribute("fund_security_unit_id",fund_security_unit_id);
            request.setAttribute("hire_security_unit_id",hire_security_unit_id);
            %>
            <td class="td_1">社保福利办理方</td>
            <td class="td_2">
            <!-- 2015-2-11 yangyuting add  -->
            <select id='security_unit_id' name='security_unit_id' onchange="toChangeSecurityUnitId();">
               <option value="1099141600000000108" <%if(RmStringHelper.prt(postsendVo.getSecurity_unit_id()).equals("1099141600000000108")){ %>selected<%} %>>上海公司大库</option>
                <option value="1099141600000000105" <%if(RmStringHelper.prt(postsendVo.getSecurity_unit_id()).equals("1099141600000000105")){ %>selected<%} %>>财务外包公司大库</option>
                <option value="1099141600000000107" <%if(RmStringHelper.prt(postsendVo.getSecurity_unit_id()).equals("1099141600000000107")){ %>selected<%} %>>诺华贸易单立户</option>
                <option value="1099141600000000111" <%if(RmStringHelper.prt(postsendVo.getSecurity_unit_id()).equals("1099141600000000111")){ %>selected<%} %>>单立户</option>
                <option value="2013300100000000015" <%if(RmStringHelper.prt(postsendVo.getSecurity_unit_id()).equals("2013300100000000015")){ %>selected<%} %>>外地大库</option>
            </select>   
                <!--<faerp:SoialunitSelectTag  tagname="security_unit_id"  beanname="security_unit_id" />
            --></td>
            <td class="td_1">公积金福利办理方</td>
            <td class="td_2"><!--
                <faerp:SoialunitSelectTag  tagname="fund_security_unit_id"  beanname="fund_security_unit_id" />
            -->
             <!-- 2015-2-11 yangyuting add  -->
            <select name='fund_security_unit_id'>
               <option value="1099141600000000108" <%if(RmStringHelper.prt(postsendVo.getFund_security_unit_id()).equals("1099141600000000108")){ %>selected<%} %>>上海公司大库</option>
                <option value="1099141600000000105" <%if(RmStringHelper.prt(postsendVo.getFund_security_unit_id()).equals("1099141600000000105")){ %>selected<%} %>>财务外包公司大库</option>
                <option value="1099141600000000107" <%if(RmStringHelper.prt(postsendVo.getFund_security_unit_id()).equals("1099141600000000107")){ %>selected<%} %>>诺华贸易单立户</option>
                <option value="1099141600000000111" <%if(RmStringHelper.prt(postsendVo.getFund_security_unit_id()).equals("1099141600000000111")){ %>selected<%} %>>单立户</option>
                <option value="2013300100000000015" <%if(RmStringHelper.prt(postsendVo.getFund_security_unit_id()).equals("2013300100000000015")){ %>selected<%} %>>外地大库</option>
            </select>   
            </td>
            <td class="td_1">用退工福利办理方</td>
            <td class="td_2">
                <!--<faerp:SoialunitSelectTag  tagname="hire_security_unit_id"  beanname="hire_security_unit_id" />
            -->
             <!-- 2015-2-11 yangyuting add  -->
                    <select name='hire_security_unit_id'>
               <option value="1099141600000000108" <%if(RmStringHelper.prt(postsendVo.getHire_security_unit_id()).equals("1099141600000000108")){ %>selected<%} %>>上海公司大库</option>
                <option value="1099141600000000105" <%if(RmStringHelper.prt(postsendVo.getHire_security_unit_id()).equals("1099141600000000105")){ %>selected<%} %>>财务外包公司大库</option>
                <option value="1099141600000000107" <%if(RmStringHelper.prt(postsendVo.getHire_security_unit_id()).equals("1099141600000000107")){ %>selected<%} %>>诺华贸易单立户</option>
                <option value="1099141600000000111" <%if(RmStringHelper.prt(postsendVo.getHire_security_unit_id()).equals("1099141600000000111")){ %>selected<%} %>>单立户</option>
                <option value="2013300100000000015" <%if(RmStringHelper.prt(postsendVo.getHire_security_unit_id()).equals("2013300100000000015")){ %>selected<%} %>>外地大库</option>
            </select>  
            </td>
          </tr>
          <tr>
            <td class="td_1" rowspan="2"><fmt:message key="on_post_desc"/></td>
            <td colspan="3" class="td_2" rowspan="2"><textarea name="on_post_desc" rows="3" class="xText_d" id="on_post_desc"></textarea></td>
            <td class="td_1" ><font color="red">*</font>&nbsp;报税属性</td>
            <td class="td_2 ">
                <d:select id="is_tax" name="is_tax" dictTypeId="TAX_FLAG" value="${bean.is_tax}"></d:select>
            </td>
          </tr>
          <tr>
            <td class="td_1" >报税税局</td>
            <td class="td_2" ><input type="text" class="text_field" name="tax_bureau" id="tax_bureau" value=""></td>
        </tr>
        <tr>
            <td class="td_1" >工号</td>
            <td class="td_2" ><input type="text" class="text_field" name="job_num" id="job_num"  value=""></td>
            <td class="td_1" >HRO</td>
            <td class="td_2" ><input type="text" class="text_field" name="hro" id="hro" value=""></td>
            <td class="td_1" >业务部门</td>
            <td class="td_2" ><input type="text" class="text_field" name="business" id="business" value=""></td>
        </tr>
        
        <tr>
            <td class="td_1" >员工状态</td>
            <td class="td_2" ><d:select id="emp_status" name="emp_status" dictTypeId="EMP_POSITION"  nullLabel="--请选择--"></d:select></td>
            <td class="td_1" >户籍类型</td>
            <td class="td_2" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("resident_type_bd", -1, "RESIDENT_TYPE_BD", RmStringHelper.prt(empVo.getResident_type_bd()), "inputName='户籍类别' ", false) %>
            </td>
            <td class="td_1" >社保标准</td>
            <td class="td_2" >
                <select name="sbbz" id="sbbz">
                    <option value="">--请选择--</option>
                    <logic:iterate name="listgscVoList"  id="data" scope="request" indexId="indexs">
                       <option value="<bean:write name='data' property='id'/>">
                         <bean:write name="data" property="group_shortcut_name"/>
                       </option>
                    </logic:iterate>
                </select>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><font color="red">*</font>&nbsp;是否线上</td>
            <td class="td_2" ><d:select id="isonline" name="isonline" dictTypeId="TrueOrFalse"  nullLabel="--请选择--"></d:select></td>
            <td class="td_1" ><font color="red">*</font>&nbsp;是否走入职E化</td>
            <td class="td_2" ><!--<d:select id="is_phoenix" name="is_phoenix" dictTypeId="TrueOrFalse"  nullLabel="--请选择--"></d:select>-->
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_phoenix", -1, "IS_FOREIGNER", is_phoenix, "inputName='是否走入职E化' ", false) %></td>
            <td class="td_1" ><font color="red">*</font>&nbsp;是否走离职E化</td>
            <td class="td_2" ><%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_Offpost_phoenix", -1, "IS_FOREIGNER", is_Offpost_phoenix, "inputName='是否离职职E化' ", false) %></td>
        </tr>
        </table>
        <p></p>
        <div class="xz_title"><fmt:message key="emp_info"/></div>
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <input name="emp_id" id="emp_id" type="hidden" value="<%=RmStringHelper.prt(empVo.getId())%>"/>
            <td class="td_1"><fmt:message key="tel1"/></td>
            <td class="td_2"><input name="tel" type="text" class="sText" id="tel" value="<%=RmStringHelper.prt(empVo.getTel())%>"/></td>
            <td class="td_1"><fmt:message key="mobile1"/></td>
            <td class="td_2"><input name="mobile " type="text" class="sText" id="mobile"
                    onkeyup="value=value.replace(/[^\d{11}]/g,'') " onblur="checkMobile();" 
                 value="<%=RmStringHelper.prt(empVo.getMobile())%>"/></td>
            <td class="td_1"><fmt:message key="email"/></td>
            <td class="td_2"><input name="email" type="text" class="sText" id="email" value="<%=RmStringHelper.prt(empVo.getEmail())%>"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key="address"/></td>
            <td class="td_2"><input name="address" type="text" class="sText" id="address" value="<%=RmStringHelper.prt(empVo.getAddress())%>"/></td>
            <td class="td_1"><fmt:message key="postal_code"/></td>
            <td class="td_2"><input name="postal_code" type="text" class="sText" id="postal_code" value="<%=RmStringHelper.prt(empVo.getPostal_code())%>"/></td>
            <td class="td_1"><fmt:message key="resident_addresss"/></td>
            <td class="td_2"><input name="resident_address" type="text" class="sText" id="resident_address" value="<%=RmStringHelper.prt(empVo.getResident_addresss())%>"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key="language_type_bd"/></td>
            <td class="td_2">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("language_type_bd", -1, "LANGUAGE_TYPE_BD", RmStringHelper.prt(empVo.getLanguage_type_bd()), "inputName='外语语种' ", false) %>
            </td>
            <td class="td_1"><fmt:message key="language_level_bd"/></td>
            <td class="td_2">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("language_level_bd", -1, "LANGUAGE_LEVEL_BD", RmStringHelper.prt(empVo.getLanguage_level_bd()), "inputName='外语等级' ", false) %>
            
            </td>
            <td class="td_1"><fmt:message key="education_bd"/></td>
            <td class="td_2">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("education_bd", -1, "EDUCATION_BD", RmStringHelper.prt(empVo.getEducation_bd()), "inputName='学历' ", false) %>
            
            </td>
          </tr>
          <!--<tr>
            <td class="td_1">工作经历</td>
            <td colspan="5" class="td_2"><textarea name="text7" rows="3" class="xText_d" id="text7"></textarea></td>
          </tr>-->
        </table>
        <p></p>
        <div class="xz_title"><fmt:message key="labor_contract"/></div>
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key="start_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="start_date" name="start_date" style="width:172px"/>
            </td>
            <td class="td_1"><fmt:message key="end_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="end_date" name="end_date" style="width:172px"/>
            </td>
            <td class="td_1"><fmt:message key="try_salary"/></td>
            <td class="td_2"><input name="try_salary" type="text" class="sText" id="try_salary" value="" onkeyup="checkNoNum(this);"/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key="try_start_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="try_start_date" name="try_start_date" style="width:172px"/>
            </td>
            <td class="td_1"><fmt:message key="try_end_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="try_end_date" name="try_end_date" style="width:172px"/>
            </td>
            <td class="td_1"><fmt:message key="post"/></td>
            <td class="td_2"><input name="position" type="text" class="sText" id="position" value=""/></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key="send_start_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="send_start_date" name="send_start_date" style="width:172px"/>
            </td>
            <td class="td_1"><fmt:message key="send_end_date"/></td>
            <td class="td_2">
                <w:date format="yyyy-MM-dd" id="send_end_date" name="send_end_date" style="width:172px"/>
            </td>
            <td class="td_1"><fmt:message key="pay"/></td>
            <td class="td_2"><input name="salary" type="text" class="sText" id="salary" value="" onchange="anySecury();"/></td>
          </tr>
          <tr>
            <td class="td_1">工作制</td>
            <td class="td_2">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("working_bd", -1, "WORKING_BD", RmStringHelper.prt(""), "", false) %>
            <td class="td_1"></td>
            <td class="td_2"></td>
            <td class="td_1"></td>
            <td class="td_2"></td>
          </tr>
        </table>
    </div>
    </div>
    <!--表格2 end-->
    <!--社保公积金-->
    <div class="zbox">
        <div class="xz_title"><fmt:message key="ss_fund"/></div>
        <!-- 已选社保公积金组end-->
        <div>
             <table width="100%">
                <tr>
                    <td width="120">
                        &nbsp;&nbsp;<fmt:message key="selected_ss_fund_group"/>：
                    </td>
                    <td id="selectgroups">
                    <logic:iterate   name="groupbeans"  id="data" scope="request" indexId="indexs">
                        <div style="display:inline" id="<bean:write name="data" property="id"/>" align="left">
                            <input type="hidden" name="select_group_id" value="<bean:write name="data" property="id"/>" />
                            <input type="hidden" name="select_city_id" value="<bean:write name="data" property="city_id"/>" />
                            <input type="hidden" name="select_group_name" value="<bean:write name="data" property="group_name"/>" />
                            <bean:write name="data" property="group_name"/>
                        </div>
                    </logic:iterate>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 已选社保公积金组end-->
        
        <!--按钮-->
    <div class="button">
            <div class="button_right">
                <ul>
                  <li class="c"><a onClick="javascript:openSelectPro();"><fmt:message key="insert"/></a></li>
                  <li class="d"><a onClick="javascript:DelSite();"><fmt:message key="deleted"/></a></li>
                </ul>
                <div class="clear"></div>
            </div>
            
        </div>
    <!--按钮 end-->
    <!--社保公积金产品列表 -->
    <div id="values_div">
                    <r:datacell 
                         id="grdCityEnsureTbody"
                         queryAction="/FAERP/EmppostAction.do?cmd=initInsertOneSecurity"
                         submitAction="/FAERP/EmppostAction.do?cmd=savePostOne"
                         width="100%"
                         xpath="SecurityAllVo"
                         submitXpath="SecurityAllVo"
                         paramFormId="datacell_formid"
                         pageSize="-1" readonly="false"
                         >
                         <r:field  fieldName="id_index" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="50px" onRefreshFunc="setCheckboxStatus" sortAt="none">
                         </r:field>
                         <r:field  fieldName="group_product" messagekey="ss_group_and_product_order" width="0">
                         </r:field>
                         <r:field  fieldName="product_name" messagekey="product">
                         </r:field>
                         <r:field fieldName="group_name" messagekey="ss_fund">
                         </r:field>
                         <r:field fieldName="sf_start_date" messagekey="pay_begin_month" allowModify="true">
                             <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" onchange="javascript:anyStartDate();"/>
                         </r:field>
                         <r:field fieldName="base" messagekey="cardinal_num" >
                             <h:text onchange="javascript:anyAmount();"/>
                         </r:field>
                         <r:field fieldName="e_ratio" messagekey="enterprise_pro" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.####');})">
                             <h:text onclick="javascript:show(this);" onchange="javascript:anyAmount3();"/>
                         </r:field>
                         <r:field fieldName="p_ratio" messagekey="person_pro" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.####');})">
                             <h:text onclick="javascript:show(this);" onchange="javascript:anyAmount3();"/>
                         </r:field>
                         <r:field fieldName="money" messagekey="money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                             <h:text onchange="javascript:anyMoney('grdCityEnsureTbody');"/>
                         </r:field>
                         <r:field fieldName="e_money" messagekey="enterprise_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text onchange="javascript:countMoney();"/>
                         </r:field>
                         <r:field fieldName="p_money" messagekey="person_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text onchange="javascript:countMoney();"/>
                         </r:field>
                         <r:field fieldName="is_prepay" messagekey="is_prepay">
                            <h:switchCheckbox id="is_prepay" value="0" checkedValue="1" uncheckedValue="0"/>
                         </r:field>
                         <r:field fieldName="charge_frequency_bd" messagekey="pay_frequency" defaultValue="1">
                            <d:select id="dselect1" dictTypeId="FREQUENCY_BD" nullLabel="--请选择--" onchange="javascript:checkprepay()"/>
                         </r:field>
                         <r:field width="120" fieldName="is_charge_on_security" messagekey="is_charge_on_security" onRefreshFunc="setCheckboxStatus1">
                         </r:field>
                         <r:field fieldName="is_preget" messagekey="is_preget">
                            <d:select id="dselect2" dictTypeId="ISPREGET" nullLabel="--请选择--"/>
                         </r:field>
                         <r:field fieldName="e_add_ratio" messagekey="enterprise_add_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text onchange="javascript:checkaddoney('e_add_ratio','企业附加金额');"/>
                         </r:field>
                         <r:field fieldName="p_add_ratio" messagekey="person_add_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text onchange="javascript:checkaddoney('p_add_ratio','个人附加金额');"/>
                         </r:field>
                         
                       </r:datacell>
           
    </div>
    
    <!--社保公积金产品列表 end-->
    </div>
<div id="div1" style="display: none; border: #000 1px solid; position: absolute;z-index:999;">
                <table  width="500" cellspacing="0"  class="datagrid1">
                    <tr>
                      <th width="9%"><fmt:message key="product"/></th>
                      <th width="10%"><fmt:message key="enterprise_pro"/></th>
                      <th width="10%"><fmt:message key="person_pro"/></th>
                      <th width="10%"><fmt:message key="pay_frequency"/></th>
                      <th width="10%"><fmt:message key="enterprise_add_money"/></th>
                      <th width="10%"><fmt:message key="person_add_money"/></th>
                      </tr>
                      <tbody id="showratio">
                      
                      
                      </tbody>
                </table>
            </div>
            
            
    <!--社保公积金 end-->
    <!--福利项目-->
    <div class="zbox">
        <div class="xz_title"><fmt:message key="fl_project"/></div>
        
    <!--表格 -->
    <div>
        <r:datacell 
         id="fulitbody"
         queryAction="/FAERP/EmppostAction.do?cmd=initInsertOneFuli"
         submitAction="/FAERP/EmppostAction.do?cmd=savePostOne"
         width="100%"
         xpath="ProductVo"
         submitXpath="ProductVo"
         paramFormId="datacell_formid"
         pageSize="-1"
         >
         <r:field  fieldName="big_type_id" messagekey="big_type_id" width="0">
         </r:field>
         <r:field  fieldName="product_name" messagekey="product">
         </r:field>
         <r:field fieldName="money" messagekey="money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
             <h:text onchange="javascript:anyMoney('fulitbody');"/>
         </r:field>
         <r:field fieldName="sf_start_date" messagekey="pay_begin_day">
            <w:date format="yyyy-MM-dd" name="sf_start_date"/>
         </r:field>
         <r:field fieldName="is_prepay" messagekey="is_prepay">
            <h:switchCheckbox id="is_prepay" value="0"  checkedValue="1" uncheckedValue="0"/>
         </r:field>
         <r:field fieldName="charge_frequency_bd" messagekey="pay_frequency" defaultValue="1">
            <d:select id="dselect2" dictTypeId="FREQUENCY_BD" nullLabel="--请选择--" onchange="javascript:checkprepay1();"/>
         </r:field>
         <r:field width="120" fieldName="is_charge_on_security" messagekey="is_charge_on_security" onRefreshFunc="setCheckboxStatus2">
         </r:field>
         <r:field fieldName="is_preget" messagekey="is_preget">
            <d:select id="dselect2" dictTypeId="ISPREGET" nullLabel="--请选择--"/>
         </r:field>
         <r:field fieldName="product_simple_desc" messagekey="description" width="350">
         </r:field>
         <r:field fieldName="is_foreign_welfare" label="是否做外地福利">
            <h:switchCheckbox id="is_foreign_welfare" value="0"  checkedValue="1" uncheckedValue="0"/>
         </r:field>
         
       </r:datacell>
       </div>
    <!--表格 end-->
    
    </div>
    <!--福利项目 end-->
    
     <div class="zbox">
        <table>
         <tr>
            <td class="td_1"><fmt:message key="contract_all_money"/></td>
            <td class="td_2"><input name="allmoney" type="text" class="sText" id="allmoney" onchange="checkallmoney();"/></td>
            <td colspan="5">&nbsp;</td>
          </tr>
        </table>
     </div>
     
     
    <div class="foot_button">
          <input type="button" class="foot_icon_1" value="<fmt:message key="generate_order"/>" onClick="javascript:submitAll();"/>
          <input type="button" name="button_reset1" class="foot_icon_1" value="<fmt:message key="go_back"/>" onClick="javascript:back_onClick();"/>
    </div>

    
</div>

</div>
</form>
</fmt:bundle>
<script>
 function checkMobile(){
    var sMobile = document.datacell_formid.mobile.value+"" ;
    if( null != sMobile && "" != sMobile){
	    if(sMobile.length!=11){ 
	        alert("不是完整的11位手机号"); 
	        document.datacell_formid.mobile.focus(); 
	        return false; 
	    } 
	 }
} 
    //列表数据有刷新，重新计算总额
    var initedDataCell = 0;
    $id("fulitbody").afterRefresh = function(){
        initedDataCell++;
        if (initedDataCell >=2 ){
            countAllMoney();
        }else{
            var datacell = $id("fulitbody");
            var is_preget =  jQuery("input[name='is_preget']").val();
            var dataset2 = datacell.dataset;
            for(var i=0; i<dataset2.getLength(); i++){
                dataset2.get(i).setProperty("is_preget",is_preget);
                datacell.refreshRow(datacell.getRow(i));
           }
        }
        return true;
    }
    
    $id("grdCityEnsureTbody").afterRefresh = function(){
        initedDataCell++;
        if (initedDataCell >=2 ){
            countAllMoney();
        }else{
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
    
    /*
    var firstTimeLoad = 0;
    $id("grdCityEnsureTbody").beforeLoadData = function(){
        if (firstTimeLoad <= 0){
            firstTimeLoad = firstTimeLoad　+ 1; 
            return true;
        }else{
            firstTimeLoad = firstTimeLoad + 1;
            return false;            
        }
    }
    */
    
    //解决修改行数据，多选框勾选消失BUG
    $id("grdCityEnsureTbody").beforeRefreshCell = function(cell,field){
        //alert(field.fieldName.indexOf("id_index"));
        if(field && field.fieldName && field.fieldName.indexOf("id_index") >= 0){
            return false;
        }
        if(field && field.fieldName && field.fieldName.indexOf("is_charge_on_security") >= 0){
            return false;
        }
        return true;
    }
    
    $id("fulitbody").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("is_charge_on_security") >= 0){
            return false;
        }
        return true;
    } 
    $id("fulitbody").beforeEdit = function(cell,colIndex,rowIndex){
        var cell1 = $id("fulitbody");
        var ent1 = cell1.getEntityByCell(cell);
        //alert(ent1.getProperty("onpost_input"));
        //alert(colIndex);
        if (ent1.getProperty("onpost_input") == '1' || colIndex != 1 ){
            return true;
        }else {
            return false;
        }
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
    
</script>
<script language="javascript" src="<venus:base/>/jsp/faerp/employeepost/empentry/emppost/initProduct.js"></script>
</body>
</html>