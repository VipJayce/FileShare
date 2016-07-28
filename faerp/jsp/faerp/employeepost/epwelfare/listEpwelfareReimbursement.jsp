<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/> 
<%@ page import="java.util.*"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@ page import="rayoo.employeepost.epwelfare.vo.EpwelfareVo"%>
<%@ page import="rayoo.employeepost.epwelfare.util.IEpwelfareConstants"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%
    //取出List
    List lResult = null; //定义结果列表的List变量
    if (request.getAttribute(IEpwelfareConstants.REQUEST_BEANS) != null) { //如果request中的beans不为空
        lResult = (List) request
                .getAttribute(IEpwelfareConstants.REQUEST_BEANS); //赋值给resultList
    }
    Iterator itLResult = null; //定义访问List变量的迭代器
    if (lResult != null) { //如果List变量不为空
        itLResult = lResult.iterator(); //赋值迭代器
    }
    EpwelfareVo resultVo = null; //定义一个临时的vo变量
%>
<html>
<fmt:bundle basename="rayoo.employeepost.epwelfare.epwelfare_resource" prefix="rayoo.employeepost.epwelfare.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
<script>		  

    function init(){
        var day = new Date(); 
        var year=day.getFullYear();
        var month=day.getMonth()+1; 
        if(month<=9){
            month="0"+month;
        }
        var yearmonth=year+""+month;
       //  alert(yearmonth);
   //      document.form.enjoy_month.value=yearmonth;
    jQuery("#enjoy_month").val(yearmonth);
    }
    
    
     
 function deleteDataInterface(){ 
     $id("dc_inter").deleteRow();
 }

			   
 function checkMonth(mm){
      if((mm+'').length!=6){
      return false;
      }
      if(((mm+'').substr(0,4))<2000 || ((mm+'').substr(0,4))>2030){
        return false;
      }
      if(((mm+'').substr(4,2))<01 || ((mm+'').substr(4,2))>12){
        return false;
      }
      return true;
  }
			   
function setCheckbox(value,entity,rowNo,cellNo){
      return "<input type='checkbox'  name='temp1'   value=" + entity.getProperty("id") + ">";
   //   return "<input type='checkbox'  name='temp1'   onClick=\"ClickRow1(\'" + entity.getProperty("id") + "\')\";>";
   }
			    
 function ClickRow1(idVa){
     //alert(idVa);
     var curEn = $id("dc_inter").dataset.findEntity("id", idVa); 
     if (curEn && curEn.getProperty){
         //alert(curEn.status);
         curEn.status = Entity.STATUS_MODIFIED;
         $id("dc_inter").isModefied = true;
         //alert(curEn.status);
         if (curEn.getProperty("id_checked") && curEn.getProperty("id_checked")== "true"){
             curEn.setProperty("id_checked", "false");
         }else{
             curEn.setProperty("id_checked", "true");
         }       
     }
 }
  function deleteDataInterface(){
     //alert(rows.length);
     var isEnd = deleteRow();
     while (!isEnd){
         isEnd = deleteRow();
     }
}
  function deleteRow(){
      var dc1 = $id("dc_inter");
      var rows = $id("dc_inter").tbody.rows;
      for(var i=0; i< rows.length; i++){
          var row1 = rows[i];
          var curEn = dc1.getEntity(row1);
          //alert(curEn.getProperty("id") + "," + curEn.getProperty("id_checked"));
          if(curEn.getProperty("id_checked") && curEn.getProperty("id_checked")=="true"){
              dc1.deleteRow(row1);
              return false;
          }        
      }    
      return true;
  }
			       
    function qrySalarybatch(flag){			    
       var id_card=document.getElementById("id_card").value;
       var cust_name=document.getElementById("h_customer_name").value; 
       var wt= document.getElementById("enjoy_month").value; 
       var emp_code= document.getElementById("emp_code").value;                  
       var cust_id= jQuery("#h_customer_id").val();
       var pro=jQuery("#small_product_code").val();
       $id("dc_inter").addParam("flag",flag);
       if(flag!="onlyQuery"){//生成时要选择福利产品
          if(pro==""||pro==null){
             alert("<fmt:message key="fl_product_not_null"/>");
              return;r
             }
      }
      if(!checkMonth( wt)){
         alert('<fmt:message key="notice4"/>');
         return false;
      } 
      if(flag=="generateData"){//如果是生成，则员工或客户需要至少选择一个
        if(cust_name==""&&emp_code==""){
            alert("<fmt:message key="to_select_one"/>");
            return;
        }
      }
        $id("dc_inter").reload();
  }
  
   /*查询弹性福利没有数据时，提示要先生成才能查询！2014年4月15日 注释*/
    jQuery(document).ready(function () {
        var dc = $id("dc_inter");
        dc.afterRefresh = function() {
             var value=jQuery("#small_product_code").val();
              var rows = $id("dc_inter").tbody.rows;
             var finalflag="";
            if (value) {
              var rows = dc.table.tBodies[0].rows;
              var data=dc.dataset;
               for(var i=0;i<data.getLength();i++){
               var entity=data.get(i);
               var row1 = rows[i];
               var errorinfoflag=entity.getProperty("errorinfoflag");
               if(errorinfoflag!=0&&errorinfoflag!=null){
                    finalflag=errorinfoflag;
                    dc.deleteRow(row1);
                }
              }
              if(finalflag==2){
                alert("该员工已离职！");
              }else if(finalflag==3){
                alert("该员工没有购买有效的产品！");
              }else if(finalflag==4){
                alert("该员工入职超过报销期限");
              }else if(finalflag==5){
                alert("该员工已经报销过此产品！");
              }else if( rows.length == 0){
                alert('<fmt:message key="not_fh_condition_date"/>');
              }
            }
        }        
    });    
  
   //选择客户
	function rtnFunc(arg){
	    var lookup = $id("lk_clz");
	    lookup.value = arg[2];
	    lookup.displayValue = arg[2];
	   // jQuery("#h_customer_id").val(arg[0]);        
	    return false;
	}
	 //删除多条记录
	function deleteMulti_onClick()
	{  
	   //从多选框物理删除多条记录
	       var aegnt_check = document.getElementsByName("temp1");
	       var ids = null;  //定义id值的数组
	       if(ids == null) {
	           ids = new Array(0);
	       }
	       for(var i=0;i<aegnt_check.length;i++){  //循环checkbox组
	           if(aegnt_check[i].checked){
	               ids.push(aegnt_check[i].value);  //加入选中的checkbox
	           }
	       }
	       if(ids==null||ids==""){
	           alert('<fmt:message key="select_one_record"/>');
	           return;
	       }
	       var auditstatus=pickAuditstatus();
	       var issure=pickIsSure();
	        if( (auditstatus==9&&issure==1) || (auditstatus==null&&issure==0) || (auditstatus==9&&issure==0)){
	          if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
           var  form=document.getElementById("datacell_formid");
              form.action="<%=request.getContextPath()%>/EpwelfareAction.do?ids=" + ids+"&label=rei";
               form.cmd.value = "deleteMulti_1";
               form.submit();
	              }
	       }else{
                    alert("<fmt:message key="ture_date_not_delete"/>");
                    return;
                    }
	   }			     
	 //审核按钮
     function toSure_onClick(){  
      var aegnt_check = document.getElementsByName("temp1");
      var  custflag= isTheSameCust();//是否是同一个客户
      var ids = null;  //定义id值的数组
      if(ids == null) {
          ids = new Array(0);
      } 
	    for(var i=0;i<aegnt_check.length;i++){  //循环checkbox组
	        if(aegnt_check[i].checked){            
	            ids.push(aegnt_check[i].value);  //加入选中的checkbox
	        }
	    }
	    if(ids==null||ids==""){
	          alert('<fmt:message key="select_one_record"/>');
	         return;
	    }
	   if(custflag=="false"){
	       alert('<fmt:message key="please_choose_the_same_cust"/>');
	       return;
	   }
	    if(!isSure()){
                    alert("<fmt:message key="have_done"/>");
                    return;
                  }
	      var sum= moneyCount();
	      var emp_name=getemp_name();
	      var product_name=getProduct_name();
	      var cust_name=getCustomer_name();
	      var emp_code=getEmp_code();
	      var start_date=getStart_date();
	      var end_date=getEnd_date();
	      var cust_code=getCustomer_code();
	      var cust_id=getCustomer_ID();
	      
	    var action="<%=request.getContextPath()%>/EpwelfareAction.do?cmd=updateData";
        var myAjax = new Ajax(action);
        var data1=$id("dc_inter");
        var xmlSubmit=null;
        if(data1.dataset.toString()!=""){
        xmlSubmit=data1.dataset.toString();
          }
        myAjax.submitXML(xmlSubmit);
       var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
	     //if(confirm('<fmt:message key="to_make_sure_had_save"/>')){
	          var url="<%=request.getContextPath()%>/EpwelfareAction.do?cmd=toPayForward&sum="+sum+"&ids="+ids+"&emp_name="+emp_name+"&selproduct_name="+product_name+"&cust_name="+cust_name+"&emp_code="+emp_code+"&selstart_date="+start_date+"&selend_date="+end_date+"&cust_code="+cust_code+"&cust_id="+cust_id;//2014年4月21日 加入了cust_id
	          showModalCenter(url, window, returnFun, 800, 460, "福利报销审核");      
	            //}       
	            }      
	   }
                 //支付页面关闭后的回调函数              
       function returnFun(){
            qrySalarybatch("onlyQuery");
	       // $id("dc_inter").reload();
	   }
	  function checkAllList()
	   {
	    var element = document.getElementsByName("temp1"); 
	    for(var i=0;i<element.length;i++){
	       if(element[i].type=="checkbox" && element[i].name=="temp1") {
	         element[i].checked= !element[i].checked ? true : false;
	        }
	     } 
	  } 
    //导出
     function exportExcel_onClick()
     {
        var form= document.getElementById("datacell_formid");
        form.action="<%=request.getContextPath()%>/EpwelfareAction.do" ;
        form.cmd.value = "exportExcel";
        form.submit();
     }
	//合计所选择记录的金额总和			      	             
    function moneyCount() {			         
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var sum=0;
	   jQuery("input[name='temp1']").each(function (i){
          if(jQuery(this).attr("checked") == "checked") {
              var curEnt = ds1.get(i);
              var order_money= curEnt.getValue("money")==null?"0":curEnt.getValue("money");
              sum+=parseFloat(order_money);
          }
        });
       return sum;				  
    }
    
       function  getemp_name() {                   
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var emp_name =null;
       jQuery("input[name='temp1']").each(function (i){
          if(jQuery(this).attr("checked") == "checked") {
              var curEnt = ds1.get(i);
            emp_name=  curEnt.getValue("emp_name");
          }
        });
       return emp_name;                
    } 
    
    //获取产品名称2014年2月14日 (因为该页面查询到的都是同一个产品，所以可不用获取固定的)
     function  getProduct_name() {                   
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var product_name =null;
       jQuery("input[name='temp1']").each(function (i){
          if(jQuery(this).attr("checked") == "checked") {
              var curEnt = ds1.get(i);
            product_name=  curEnt.getValue("product_name");
          }
        });
       return product_name;                
    }
    
     //获取客户名称2014年2月17日
     function  getCustomer_name() {                   
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var cust_name =null;
       jQuery("input[name='temp1']").each(function (i){
          if(jQuery(this).attr("checked") == "checked") {
              var curEnt = ds1.get(i);
            cust_name=  curEnt.getValue("cust_name");
          }
        });
       return cust_name;                
    } 
    //获取客户编号
      function  getCustomer_code() {                   
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var cust_code =null;
       jQuery("input[name='temp1']").each(function (i){
          if(jQuery(this).attr("checked") == "checked") {
              var curEnt = ds1.get(i);
            cust_code=  curEnt.getValue("cust_code");
          }
        });
       return cust_code;                
    } 
   
    //检测是否是同一个客户 2014年5月7日 
      function  isTheSameCust() {                   
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var cust_code =null;
       var first_code="";
       var j=0;
       var flag="true";
       jQuery("input[name='temp1']").each(function (i){
          if(jQuery(this).attr("checked") == "checked") {
             var curEnt = ds1.get(i);
            cust_code=  curEnt.getValue("cust_code");
             if(j==0){//记录第一个选中的客户code
              first_code=cust_code;
              }
              if(first_code!=cust_code){//如果有不相同的则给错误标志
                flag="false";
              }
              j++;
          }
        });
       return flag;                
    } 
    
    
    //获取客户id
          function  getCustomer_ID() {                   
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var cust_id =null;
       jQuery("input[name='temp1']").each(function (i){
          if(jQuery(this).attr("checked") == "checked") {
              var curEnt = ds1.get(i);
            cust_id=  curEnt.getValue("cust_id");
          }
        });
       return cust_id;                
    } 
    
    
    
         //获取受款人唯一号2014年2月17日
     function  getEmp_code() {
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var emp_code =null;
       jQuery("input[name='temp1']").each(function (i){
          if(jQuery(this).attr("checked") == "checked") {
              var curEnt = ds1.get(i);
            emp_code=  curEnt.getValue("emp_code");
          }
        });
       return emp_code;                
    } 
    //福利开始时间 2014年2月18日
     function  getStart_date() {                   
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var start_month =null;
       jQuery("input[name='temp1']").each(function (i){
          if(jQuery(this).attr("checked") == "checked") {
              var curEnt = ds1.get(i);
            start_month=  curEnt.getValue("start_month");
          }
        });
       return start_month;                
    } 
        //福利结束时间 2014年2月18日
     function  getEnd_date() {                   
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var end_month =null;
       jQuery("input[name='temp1']").each(function (i){
          if(jQuery(this).attr("checked") == "checked") {
              var curEnt = ds1.get(i);
            end_month=  curEnt.getValue("end_month");
          }
        });
       return end_month;                
    } 
    
    
		//判断所选择的记录 是否是已确认的
		//修改：2014年5月6日  现在根据审批状态来判断，如果为空或者驳回的数据，则可以提交审核
     function isSure() { 
       var b=true;                    
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       jQuery("input[name='temp1']").each(function (i){
       if(jQuery(this).attr("checked") == "checked") {
           var curEnt = ds1.get(i);
           var audit_status= curEnt.getValue("audit_status");  
           if(audit_status=="1" || audit_status=="2" || audit_status=="3" || audit_status=="4"){
              b=false;                    
           }
         }              
     });
      return b;                  
    } 
        //add by sqp
     function pickAuditstatus() { 
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var audit_status;
       jQuery("input[name='temp1']").each(function (i){
       if(jQuery(this).attr("checked") == "checked") {
           var curEnt = ds1.get(i);
           audit_status= curEnt.getValue("audit_status");
         }              
     });
      return   audit_status;     
    } 
      function pickIsSure() { 
       var ds1 = $id("dc_inter").dataset;
       var fields = $id("dc_inter").fields;
       var is_sure;
       jQuery("input[name='temp1']").each(function (i){
       if(jQuery(this).attr("checked") == "checked") {
           var curEnt = ds1.get(i);
           is_sure= curEnt.getValue("is_sure");
         }
     });
       return   is_sure;    
    } 
     

    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#h_customer_name").val(arg[2]);
         jQuery("#h_customer_id").val(arg[0]);
        return false;
    }
    
     function rtnFuncEmployee(arg){
        var lookup = $id("emp_name");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
          jQuery("#emp_id").val(arg[0]);
        if(arg[2] == null || arg[2] == "" || arg[2] == "null"){
        }else{
               jQuery("#emp_code").val(arg[2]);
        }
        
       
      if(arg[3] == null || arg[3] == "" || arg[3] == "null"){
        }else{
             jQuery("#id_card").val(arg[3]);
        }
        
        return false;
    }
    
    /****************保存*****************/
      function to_saveData(){
         var action="<%=request.getContextPath()%>/EpwelfareAction.do?cmd=updateData";
        var myAjax = new Ajax(action);
        var data1=$id("dc_inter");
        var xmlSubmit=null;
        if(data1.dataset.toString()!=""){
        xmlSubmit=data1.dataset.toString();
        }else{
        alert("没有数据需要保存!");
        return;
        }
       myAjax.submitXML(xmlSubmit);
       var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
                      alert(""+myAjax.getProperty("returnValue"));
                      window['returnValue'] = ""+myAjax.getProperty("returnValue");
                      qrySalarybatch("onlyQuery");
                 }
    }
    
//查看个人订单信息 参数为PB_EMP_POST表中的主键id
    function detail_update_onClick(){
        var dc = $id("dc_inter");
        var entity =dc.getActiveEntity();
        if(entity==null || entity==''){
            alert("<fmt:message key="select_one_record"/>");
            return ;
        }
        var emp_post_id = entity.getProperty("emp_post_id");
        if(emp_post_id==null || emp_post_id==''){
            alert("<fmt:message key="select_one_record"/>");
            return ;
        }
        window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrderBack&id='+emp_post_id,'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
    }

    
</script>
	</head>
	<body  onload="init();">
	<form method="post" id="myform" name="myform" >	   
	</form>
	<form method="post" id="datacell_formid" name="datacell_formid" action="<%=request.getContextPath()%>/EpwelfareAction.do">
		<input type="hidden" name="cmd" value="queryAll">
	    <input type="hidden" name="backFlag" id="backFlag" value="true"> 
	      <input type="hidden" name="c_name" id="h_customer_name" value=""/>
           <input type="hidden" name="c_id" id="h_customer_id" value=""/>    	        
	    <div id="right">
	        <script language="javascript">
	        writeTableTopFesco('<fmt:message key="benefits_reimbursement"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
	       </script>
	        <div class="ringht_s">
		        <div id="ccChild0" class="search">
			        <table width="100%" border="0" cellspacing="0" cellpadding="0">
			           <tr>
			                <td width="135" rowspan="3" style="padding-top:0;"><div class="search_title"><fmt:message key="query_conditions"/></div></td>
			                <td width="80"><span style="color:red">*</span><fmt:message key="fuli_product"/></td>
			                <td width="220">
			                   <select  id="small_product_code" name="product_id">
			                    <option value=""><fmt:message key="please_choose"/></option>
			                   <option value="1099110200000000114"><fmt:message key="home_equipment_fees"/></option>
			                   <option value="1099110200000000115"><fmt:message key="green_allowance"/></option>
			                   <option value="9099110200000000161"><fmt:message key="child"/></option><!-- 2013年9月12日 19:48:39 修改为 从产品1099110200000000161 到   9099110200000000161  -->
			                   <option value="2012800100000000001"><fmt:message key="preschools"/></option>
			                   <option value="1099800100000000041"><fmt:message key="movie_tickets"/></option>
			                   <option value="1099110200000000102"><fmt:message key="ndtj"/></option>
			                   <!-- 增加两个新的产品 供暖补贴和报刊费 2014年3月21日 sqp -->
			                   <option value="1099110200000000090"><fmt:message key="gnbt"/></option><!-- 1099110200000000090( 生产上该产品是有效的，但tr库里是无效的)  1099110200000000315 -->
			                   <option value="1099110200000000091"><fmt:message key="bkf"/></option>
			                   <!-- 新增产品 入职体检 2014年5月20日 1 -->
			                   <option value="2013800100000000188"><fmt:message key="rztj"/></option>
			                   
			                   </select>
			                </td>
			                <td width="80"><span style="color:red">*</span><fmt:message key="enjoy_benefits_month"/></td>
			                <td width="220"> <input type="text" class="text_field" name="enjoy_month"   id="enjoy_month"
			                    inputName="福利结束月" maxLength="64"   /></td>
			                <td width="80"><fmt:message key="emp_name"/></td>
			                <td width="220">
			                    <input type="hidden" class="text_field" name="emp_id" id="emp_id" inputName="员工唯一号" maxLength="64" />
			                      <input type="hidden" class="text_field" name="emp_code" id="emp_code" inputName="员工唯一号" maxLength="64" />
			                    <input type="hidden" name="is_call" id="is_call" value="false"/>
			                     <w:lookup onReturnFunc="rtnFuncEmployee" readonly="true" id="emp_name" name= "emp_name" lookupUrl="/EpempcardAction.do?cmd=searchEmployeeToList" messagekey="choose_emp" height="450" width="800"  style="width:195px"/>
			                </td>
			           </tr>
			           <tr>
		                    <td><fmt:message key="id_card_num"/></td>
		                    <td>
		                      <input type="text" class="text_field" name="id_card" id="id_card" inputName="证件号码" maxLength="64"  readonly="readonly">
		                    </td>
		                    <td><fmt:message key="cust_name"/></td>
		                    <td>
		                        <w:lookup onReturnFunc="rtnFuncCustomer" readonly="true" name='cust_id' id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_cust" height="440" width="600"  style="width:195px"/>
		                    </td>
		                      <td width="80"><fmt:message key="is_sure"/></td>
                                    <td>
                           <d:select name="is_sure" id="is_sure" dictTypeId="TrueOrFalse" nullLabel="--请选择--" style="width: 205px" />
                             </td>
                             </tr>
                           
                             <tr>
                            <td><fmt:message key="have_examine"/></td>
                             <td>
                           <d:select name="have_examine_s" id="have_examine_s" dictTypeId="TrueOrFalse" nullLabel="--请选择--" style="width: 205px" />
                             </td>
		                    <td><input name="button_ok" class="icon_1"   type="button" value='生成' onClick="javascript:qrySalarybatch('generateData')"></td>
		                    <td> <input name="button_ok" class="icon_1"   type="button" value='查询' onClick="javascript:qrySalarybatch('onlyQuery')">
		                    	<input type="reset" value="重置" class="icon_1">
		                    </td>
			           </tr>	                 
			        </table>
		        </div>    
		        <div id="ccParent1" class="button">
			        <div class="button_right">
			           <input type="button" class="a_2" value='查看个人订单'  onClick="detail_update_onClick();" />
			          <input type="button" class="d" value="<fmt:message key="delete"/>"  <au:authorityBtn code="flbx_del" type="1"/> onclick="deleteMulti_onClick();" />
			          <input type="button" class="r" value="<fmt:message key="approval"/>"  <au:authorityBtn code="flbx_approval" type="1"/> onclick="toSure_onClick();" />
			          <input type="button" class="e" value="<fmt:message key="export"/>" id="showErr"  <au:authorityBtn code="flbx_exp" type="1"/> onclick="exportExcel_onClick();" />
			          <input type="button" class="bc_1" value="<fmt:message key="save"/>" <au:authorityBtn code="flbx_bc" type="1"/> onclick="to_saveData();" />
			        </div>
		           <div class="clear"></div>
		        </div> 
		        <div style="padding: 8 10 8 8;">
			        <r:datacell id="dc_inter" 
			                queryAction="/FAERP/EpwelfareAction.do?cmd=simpleQueryRei"
			            width="98%" 
			            height="320px"  
			            pageSize="100"       
			            xpath="EpwelfareTempVo" submitXpath="EpwelfareTempVo"
			            paramFormId="datacell_formid">			    
			            <r:toolbar location="bottom" tools="nav,pagesize,info" />
			            <!--<r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckbox" align="center" >
			           </r:field> -->
			              <r:field allowModify="false" fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList();' />" width="40px" onRefreshFunc="setCheckbox" >
			               </r:field>  
			            <r:field fieldName="cust_name" messagekey="cust_name" width="150px">
			            </r:field>
			                <r:field fieldName="cust_code" messagekey="cust_code" width="100px">
                        </r:field>
                            <r:field fieldName="cust_id" messagekey="cust_id" width="0px">
                        </r:field>
			            <r:field fieldName="emp_name" messagekey="emp_name" width="150px">
			            </r:field>
			            <r:field fieldName="emp_code" messagekey="emp_code" width="150px">
			            </r:field>
			            <r:field fieldName="id_card" messagekey="id_card_num" width="150px">
			            </r:field>
			            <r:field fieldName="name" messagekey="fuli_product" width="150px">
			            </r:field>
			            <r:field fieldName="product_name" messagekey="emp_act" width="150px">
			            </r:field>			           
			            <r:field fieldName="remark" messagekey="remark" width="150px">
			            </r:field>
			            <r:field fieldName="is_sure" messagekey="is_sure" allowModify="false">
			            <d:select dictTypeId="TrueOrFalse"></d:select>
			            </r:field>
			            <r:field fieldName="start_month" messagekey="benefits_begin_month" width="150px"
			                allowModify="false">
			            </r:field>
			            <r:field fieldName="end_month" messagekey="benefits_end_month" width="150px" allowModify="false">
			            </r:field>
			            <!-- delete by sqp  2014年3月10日
			            <r:field fieldName="enjoy_month" messagekey="enjoy_month" width="150px" allowModify="false">
			            </r:field>
			            -->
			            <r:field fieldName="order_money" messagekey="order_money" width="150px">
			            </r:field>
			            <r:field fieldName="money" messagekey="enjoy_money" width="150px"   >
			            <h:text   validateAttr="allowNUll=false;type=float"/>
			            </r:field>
			              <r:field fieldName="bank_name" messagekey="bank_name" width="150px">
                        </r:field>
                         <r:field fieldName="account_num" messagekey="account_num" width="150px">
                        </r:field>
			            <r:field fieldName="user_name" messagekey="user_name" width="150px">
			            </r:field>
			            <r:field fieldName="user_pary" messagekey="party_name" width="150px">
			            </r:field>
			            <r:field fieldName="audit_status" messagekey="audit_status" width="150px"  allowModify="false"> 
			            <d:select dictTypeId="FIN_PAY_AUDIT_STATUS"></d:select>
			            </r:field>
			            <r:field fieldName="input_date" messagekey="input_date" width="150px"
			                allowModify="false">
			                <w:date format="yyyy-MM-dd"/>
			            </r:field>
			        </r:datacell>
		        </div>
	        </div>
	    </div>
	</form>

</body>
</fmt:bundle>
</html>
<script> 
$id("dc_inter").beforeRefreshCell = function(cell,field1){ 
    if (field1 && field1.fieldName && field1.fieldName=="emp"){
        return false;
    }
 }
 //初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("dc_inter").isQueryFirst = false;
});
 
 </script>
