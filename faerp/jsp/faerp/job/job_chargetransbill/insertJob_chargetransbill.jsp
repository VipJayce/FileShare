<%@ page contentType="text/html; charset=UTF-8" %>

<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	boolean isModify = "true".equals(request.getParameter("isModify")) ? true : false;//定义变量,标识本页面是否修改(或者新增)
	System.out.print("isModify:"+isModify);
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增费用划转单</title>
<script language="javascript">

 function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }


    //数据校验
    function validateData(){
        var transcode = jQuery("#transcode").val();//划转单编号
        var transtype = jQuery("#transtype").val();//划转单类型
        //var contract_id = jQuery("#contract_id").val();//关联合同
        //var cust_id = jQuery("#cust_id").val();//客户
        //var bill_id = jQuery("#bill_id").val();//账单ID
        var outdept_id = $id("outdept_id").getValue();//划出部门
        var transyearmonth = jQuery("#transyearmonth").val();//划转年月
        if(!transcode){
            alert("划转单编号不能为空！");
            return false;
        }
        if(!transtype){
            alert("划转单类型不能为空！");
            return false;
        }
        /*
        if(!contract_id){
            alert("关联合同不能为空！");
            return false;
        }
        if(!cust_id){
            alert("客户不能为空！");
            return false;
        }
        if(!bill_id){
            alert("账单不能为空！");
            return false;
        }
        */
        if(!outdept_id){
            alert("费用划出部门不能为空！");
            return false;
        }
        if(!transyearmonth){
            alert("划转年月不能为空！");
            return false;
        }
    //datacell数据校验
	   var datacell = $id("datacell1");
	   if(!datacell.validateAll())
            return ;
	   var uEntities = datacell.dataset.getAlltEntities();
	   if(uEntities.length==0){
	       alert("请添加划转单明细数据！");
	       return false;
	   }
	   var rowCount = 0;
	   for(i=0;i<uEntities.length;i++){
	       var datarow = datacell.dataset.get(i);
	       if(datarow.status == "3" || datarow.status == "4" )
	           continue;
	        rowCount++;
	        var entity = uEntities[i];
	        var cutindept_id = entity.getProperty("cutindept_id");//划入部门
	        var expenseitem = entity.getProperty("expenseitem");//费用项目
	        var expenseamount = entity.getProperty("expenseamount");//划转金额
	        if(!cutindept_id){
	          alert("第"+(i+1)+"行划入部门不能为空！");
	          return false;
	        }
	        if(!expenseitem){
	            alert("第"+(i+1)+"行费用项目不能为空！");
	            return false;
	        }
	        if(!expenseamount){
	            alert("第"+(i+1)+"行划转金额不能为空！");
	            return false;
	        }else{
	            if(isNaN(expenseamount)){
	                alert("第"+(i+1)+"行划转金额不是有效数字！");
	                return false;
	            }   
	        }
	     }
	     if(rowCount == 0){
	       alert("请添加划转单明细数据！");
	       return;
	     }
	     return true;
	  }


	function insert_onClick(){  //插入单条数据
	        if(!validateData()){
	           return ;
	        }
            var datacell = $id("datacell1");
	        var dataset1 = datacell.dataset;//取得页面的dataset
	        if(dataset1 == null || dataset1.getLength() == 0){
	          alert("请添加划转单明细数据！");
	          return ;
	        }
	        
	        var datacell2 = $id("datacell2");
	         var dataset2 = datacell2.dataset;//取得页面的dataset
	         if(dataset2 == null || dataset2.getLength() == 0){
	            alert("请添加合同及客户明细数据！");
	            return ;
	         }
	         
	         var datacell3 = $id("datacell3");
	         var dataset3 = datacell3.dataset;//取得页面的dataset
	         if(dataset3 == null || dataset3.getLength() == 0){
	            alert("请添加账单明细数据！");
	            return ;
	         }
	        
	        /****
	        if(datacell.isModefied){
                if(form){
                     for(var i=0;i<form.elements.length;i++){
                     var elem = form.elements[i];
                     if(elem.name){
                         $id("datacell1").addParam(elem.name,getElementValue(elem));
                     }
                }
             }
             if($id("datacell1").submit()){
                alert("保存成功！");
             }
            }else{
                alert("数据未修改！");
            }
	       **/
	    
		var action = "/FAERP/Job_chargetransbillAction.do?cmd=insertAll";
        
		for(var i=0; i<dataset1.getLength(); i++){
                var datarow =  dataset1.get(i);
                datarow.setProperty("datarowstate",datarow.status);
        }
        for(var i=0; i<dataset2.getLength(); i++){
                var datarow =  dataset2.get(i);
                datarow.setProperty("datarowstate",datarow.status);
        }
        for(var i=0; i<dataset3.getLength(); i++){
                var datarow =  dataset3.get(i);
                datarow.setProperty("datarowstate",datarow.status);
        }
        
		var xmlSubmit =  dataset1.toString();
		xmlSubmit+=  dataset2.toString();
		xmlSubmit+=  dataset3.toString();
		var myAjax = new Ajax(action);
		if(form){
		  for(var i=0;i<form.elements.length;i++){
		      var elem = form.elements[i];
		      if(elem.name){
		          myAjax.addParam(elem.name,getElementValue(elem));
		      }
		  }
		}
		myAjax.submitXML(xmlSubmit,"UTF-8");
		var returnNode = myAjax.getValue("root/data/returnValue") ;
		  if(returnNode== "ok"){
		      alert("保存成功！");
		       cancel_onClick();
		      //window.close();
		      //window.opener.insertcallback("ok");
		  }else{
		      alert("保存失败！");
		  }
		
	}

  	function update_onClick(id){  //保存修改后的单条数据
  	  
  	   /*
  	      if(jQuery("#transtype").val() ==  jQuery("#o_transtype").val() 
            && jQuery("#contract_id").val() ==  jQuery("#o_contract_id").val() 
            &&$id("outdept_id").getValue() ==  jQuery("#o_outdept_id").val() 
            && jQuery("#transyearmonth").val() ==  jQuery("#o_transyearmonth").val() 
            && jQuery("#bill_id").val() ==  jQuery("#o_bill_id").val() 
            && jQuery("#bill_amount").val() ==  jQuery("#o_bill_amount").val() 
            && jQuery("#description").val() ==  jQuery("#o_description").val() && !datacell.isModefied ){
                alert("数据没有发生变化！");
                return ;
        } 
        */
        
    	 if(!validateData()){
               return ;
         }
         
         var datacell = $id("datacell1");
         var dataset1 = datacell.dataset;//取得页面的dataset
         if(dataset1 == null || dataset1.getLength() == 0){
            alert("请添加划转单转入明细数据！");
            return ;
         }
         
         var datacell2 = $id("datacell2");
         var dataset2 = datacell2.dataset;//取得页面的dataset
         if(dataset2 == null || dataset2.getLength() == 0){
            alert("请添加合同及客户明细数据！");
            return ;
         }
         
         var datacell3 = $id("datacell3");
         var dataset3 = datacell3.dataset;//取得页面的dataset
         if(dataset3 == null || dataset3.getLength() == 0){
            alert("请添加账单明细数据！");
            return ;
         }
       
        var action = "/FAERP/Job_chargetransbillAction.do?cmd=updateAll";
        
        for(var i=0; i<dataset1.getLength(); i++){
                var datarow =  dataset1.get(i);
                datarow.setProperty("datarowstate",datarow.status);
        }
        for(var i=0; i<dataset2.getLength(); i++){
                var datarow =  dataset2.get(i);
                datarow.setProperty("datarowstate",datarow.status);
        }
        for(var i=0; i<dataset3.getLength(); i++){
                var datarow =  dataset3.get(i);
                datarow.setProperty("datarowstate",datarow.status);
        }
        var xmlSubmit =  dataset1.toString();
        xmlSubmit+=  dataset2.toString();
        xmlSubmit+=  dataset3.toString();
        var myAjax = new Ajax(action);
        if(form){
          for(var i=0;i<form.elements.length;i++){
              var elem = form.elements[i];
              if(elem.name){
                  myAjax.addParam(elem.name,getElementValue(elem));
              }
          }
        }
        myAjax.addParam("id","${bean.id}");
        myAjax.submitXML(xmlSubmit,"UTF-8");
        var returnNode = myAjax.getValue("root/data/returnValue") ;
          if(returnNode== "ok"){
              alert("保存成功！");
               cancel_onClick();
              //window.close();
              //window.opener.insertcallback("ok");
          }else{
              alert("保存失败！");
          }
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/Job_chargetransbillAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
     //合同参照
    function toFindContract(arg){
        var dc = $id("datacell2");
        var entity = dc.getActiveEntity();
        
        var lookup = $id("lk_contract");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        entity.setProperty("contract_id",arg[0]);
        entity.setProperty("cust_id",arg[2]);
        entity.setProperty("cust_name",arg[3]);
        return false;
    }
    
   //客户参照
    function rtnCustFunc(arg){
    var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);       
        return false;
    }
    
    //账单参照
    function toFindBill(arg){
        var dc = $id("datacell3");
        var entity = dc.getActiveEntity();
        
        var lookup = $id("lk_bill");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        entity.setProperty("bill_id",arg[0]);
        //entity.setProperty("bill_code",arg[1]);
        entity.setProperty("bill_amount",arg[2]);
        entity.setProperty("bill_year_month",arg[3]);
        entity.setProperty("cust_id",arg[4]);
        entity.setProperty("cust_name",arg[5]);
        return false;
    }
    
    //生成复选框
     function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    //增行
    function toAddSub_onClick(){
        $id("datacell1").insertEmptyRow() ;
        var dept_id = jQuery("#dept_id").val();
        var dept_name = jQuery("#dept_name").val();
        $id("datacell1").getActiveEntity().setProperty("cutindept_id",dept_id);
        $id("datacell1").getActiveEntity().setProperty("dept_name",dept_name);
        $id("datacell1").getActiveEntity().setProperty("serialno",$id("datacell1").dataset.getLength());
    }
    
    //删行
    function deleteMulti_onClick(){
       var ids = findSelections("checkbox_template");  //取得多选框的选择项      
       if(ids == null) {  //如果ids为空
            alert('请选择需要删除的数据行！');
            return;
       }
       if(confirm('确定要删除所选行吗？')) {  //如果用户在确认对话框按"确定"
            var datacell = $id("datacell1");
            var elementCheckbox = document.getElementsByName("checkbox_template");
            for (var i = elementCheckbox.length - 1; i >= 0; i--) {          
                if (elementCheckbox[i].checked) { // 如果被选中   
		            datacell.deleteRow(i);    
                }
            }
       }
    }
    
//获取划转单编号
function gentranscode(){
var flags=true;
        jQuery.ajax({
        url: '<%=request.getContextPath()%>/Job_chargetransbillAction.do?cmd=getTransCode',
        type: 'POST',
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
        success: function(code){
            document.getElementById("transcode").value=code;
            document.getElementById("gencodebtn").disabled="disabled";
        }
        });
        return flags;
} 

//上移
 function moveUp() {  //上移
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var big_status=datasettr.status;
        if(big_status!=1&&big_status!=2){
        alert("请选保存数据再上移");
            return;
        }
        var order_col = datasettr.getProperty("serialno");
        var pre = activeRow.previousSibling;
        if(pre == null){
            alert("已经到达顶端");
            return;
        }else {
            datacell.isModefied = true;
            var datasettr_pre = datacell.getEntity(pre);
            var order_col2 = datasettr_pre.getProperty("serialno");
            datasettr.setProperty("serialno", order_col2);
            datasettr_pre.setProperty("serialno", order_col);
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_pre.status = Entity.STATUS_MODIFIED;
            
            datacell.rowMoveUp(activeRow);
        }
    }
    
    //下移
    function moveDown() {  //下移
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var order_col = datasettr.getProperty("serialno");
        var big_status=datasettr.status;
        if(big_status!=1&&big_status!=2){
        alert("请先保存数据再下移");
            return;
        }
        var next = activeRow.nextSibling;
        if(next == null){
            alert("已经到达最下端");
            return;
        }else {
            datacell.isModefied = true;
            var datasettr_next = datacell.getEntity(next);
            var order_col2 = datasettr_next.getProperty("serialno");
            var bignex_status=datasettr_next.status;
            if(bignex_status!=1&&bignex_status!=2){
                alert("请先保存数据再下移");
                return;
             }
            datasettr.setProperty("serialno", order_col2);
            datasettr_next.setProperty("serialno", order_col);
            datasettr.status = Entity.STATUS_MODIFIED;
            datasettr_next.status = Entity.STATUS_MODIFIED;
            
            datacell.rowMoveDown(activeRow);
        }
        
        
     }

</script>
</head>
<body>

<form checkType="blur" name="form" method="post" id="datacell_formid">
    <input type="hidden" name="dept_id" id="dept_id" value="${dep_id}"/>
    <input type="hidden" name="dept_name" id="dept_name" value="${dep_name}"/>
<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>
 
 <div class="ringht_s">
<div id="ccChild1"     class="box_3"> 

<div class="xz_title">基本信息</div>
<table  width="100%" height="50" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>划转单编号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="transcode" id="transcode"  inputName="划转单编号" readonly="readonly" value="${bean.transcode }"  maxLength="50" /> 
                <%if(!isModify){ %>
                <span class="mx_button" style="margin-left:5px;"><input type="button" id="gencodebtn" class="icon_2" value="获取编号" onClick="javascript:gentranscode();" /></span>
                <%} %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>划转单类型</td>
            <td class="td_2 ">
                <d:select id="transtype" name="transtype" dictTypeId="JOB_TRANSTYPE_BD" value="${bean.transtype==null?1:bean.transtype }" nullLabel="请选择"></d:select>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>划出部门</td>
            <td class="td_2 ">
                <r:comboSelect id="outdept_id" name="outdept_id"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                       readonly="false"
                       property="bean/outdept_id"
                       xpath="DepartmentVo"
                       nullText="请选择" width="205" value="${bean.outdept_id }" ></r:comboSelect>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>划转年月</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="transyearmonth" id="transyearmonth" inputName="划转年月" value="${bean.transyearmonth }" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >备注</td>
            <td class="td_2 " colspan="3">
                <textarea rows="5" cols="50" name="description" id="description">${bean.description }</textarea>
            </td>
        </tr>
    </table>
    </div>
	
           <div class="clear"></div>
           <div class="button">
            <div class="button_right">
                <ul>
                  <li class="c"><a onClick="javascript:toAddSub_onClick();">增行 </a></li>
                  <!-- <li class="b"><a onClick="javascript:toModifySub_onClick();"><fmt:message key="modify" /> </a></li> -->
                  <li class="e"><a onClick="moveUp();">上移 </a></li>
                   <li class="e"><a onClick="moveDown();">下移 </a></li>
                  <li class="d"><a onClick="javascript:deleteMulti_onClick();">删行</a></li> 
                </ul>
            </div>
          </div>
        <div class="clear"></div>

        <div style="padding: 8 8 8 8;">
               <r:datacell id="datacell1" 
                queryAction="/FAERP/Job_chargetransbillAction.do?cmd=queryChargeDetailDataForUpdate&chargetransferbill_id=${bean.id }"
                xpath="Job_chargetransdetailVo" 
                submitAction="/FAERP/Job_chargetransbillAction.do?cmd=insertAll"
                submitXpath="Job_chargetransdetailVo"
                width="98%" height="220px" pageSize="-1">
                    <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
                    <r:field fieldName="cutindept_id" label="划入部门" width="0px">
                    </r:field>
                    <r:field fieldName="dept_name" label="划入部门" width="150px">
                    </r:field>
                    <r:field fieldName="expenseitem" label="费用项目" width="180px">
                        <h:text validateAttr="allowNull=false;" />
                    </r:field>
                    <r:field fieldName="expenseamount" label="划转金额" width="150px">
                        <h:text validateAttr="type=number;allowNull=false;"/>
                    </r:field>  
                    <!-- 
			        <r:field fieldName="showed" label="是否显示" width="100px">
			            <d:select dictTypeId="TrueOrFalse" />
			        </r:field>
			        <r:field fieldName="serialno" label="显示序号" width="100px">
			            <h:text />
			        </r:field> -->
			        <l:equal value="${bean.transtype}" targetValue="1">
			        <r:field fieldName="position_name" label="职位" width="100px"></r:field>
			        <r:field fieldName="pmteam" label="团队" width="100px">
			         <r:comboSelect id="cutindept_id" name="cutindept_id"
                           queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                           textField="dept_name"
                           valueField="id"
                           readonly="false"
                          property="bean/outdept_id"
                         xpath="DepartmentVo"
                        nullText="" width="205" validateAttr="allowNull=false;" >
                        </r:comboSelect>
			        </r:field>
                    <r:field fieldName="pm_name" label="项目经理" width="100px"></r:field>
			        <r:field fieldName="counselor_name" label="顾问" width="100px"> </r:field>
			        <r:field fieldName="emp_name" label="员工" width="100px"></r:field>
			        <r:field fieldName="sendstartdate" label="外派起始日期" width="100px">
			          <w:date format="yyyy-MM-dd"/>
			        </r:field>
			        <r:field fieldName="sendenddate" label="外派截止日期" width="100px">
			          <w:date format="yyyy-MM-dd"/>
			        </r:field>
			        <r:field fieldName="sendperiod" label="外派期限" width="100px"> </r:field>
			        </l:equal>
                    <r:field fieldName="description" label="备注" width="200px" >
                        <h:textarea rows="5" cols="35"/>
                    </r:field>  
         </r:datacell>
        </div>
            
            <div class="clear"></div>
        <div style="padding: 8 8 8 8;">
           <div id="values_div1" style="width:43%; float:left;">
               <r:datacell id="datacell2" 
                queryAction="/FAERP/Job_chargetransbillAction.do?cmd=queryChargeContractForUpdate&chargetransferbill_id=${bean.id }"
                xpath="Job_chargecontractVo" 
                submitAction="/FAERP/Job_chargetransbillAction.do?cmd=insertAll"
                submitXpath="Job_chargecontractVo"
                width="98%" height="200px" pageSize="-1">
                <r:toolbar location="bottom" tools="edit:add del"/>
                    
                    <r:field fieldName="contract_name" label="合同" width="180px">
                        <w:lookup onReturnFunc="toFindContract" readonly="true" id="lk_contract"
                        lookupUrl="faerp/common/sales/RefJobContract.jsp" dialogTitle="选择合同" height="444" width="764" style="width:188px"/>
                    </r:field>
                    <r:field fieldName="contract_id" label="合同ID" width="0px">
                    </r:field>
                    <r:field fieldName="cust_id" label="客户ID" width="0px">
                    </r:field>
                    <r:field fieldName="cust_name" label="客户名称" width="200px">
                    </r:field>
         </r:datacell>
        </div>
        <div id="values_div2" style="width:55%; float:left;">
               <r:datacell id="datacell3" 
                queryAction="/FAERP/Job_chargetransbillAction.do?cmd=queryChargeFinbillForUpdate&chargetransferbill_id=${bean.id }"
                xpath="Job_chargefinbillVo" 
                submitAction="/FAERP/Job_chargetransbillAction.do?cmd=insertAll"
                submitXpath="Job_chargefinbillVo"
                width="98%" height="200px" pageSize="-1">
                <r:toolbar location="bottom" tools="edit:add del"/>
                   
                    <r:field fieldName="bill_code" label="账单编号" width="150px">
                        <w:lookup onReturnFunc="toFindBill" readonly="true" id="lk_bill" 
                    lookupUrl="/FinbillAction.do?cmd=toSelectBillByCust"  dialogTitle="选择账单" height="444" width="764" style="width:188px"/>
                    </r:field>
                    <r:field fieldName="bill_id" label="账单ID" width="0px">
                    </r:field>
                    <r:field fieldName="bill_year_month" label="账单年月" width="80px">
                    </r:field>
                    <r:field fieldName="bill_amount" label="账单金额" width="80px">
                    </r:field>
                    <r:field fieldName="cust_id" label="客户ID" width="0px">
                    </r:field>
                    <r:field fieldName="cust_name" label="客户名称" width="200px">
                    </r:field>
         </r:datacell>
        </div>
    </div>
   
   
    <div class="foot_button" style="text-align: center; margin-left: 0px;">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()" : "insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
    </div>

</div>
</div>
<input type="hidden" name="id" id="edit_id" value="${bean.id}">
<input type="hidden" name="create_date" id="create_date" value="${bean.create_date}">
<input type="hidden" name="create_user_id" id="create_user_id" value="${bean.create_user_id}">
<input type="hidden" name="create_user_name" id="create_user_name" value="${bean.create_user_name}">
<input type="hidden" name="company_id" id="company_id" value="<%=rayoo.common.filter.UserInfoFilter.geCompanyId() %>">

<input type="hidden" name="o_transtype" id="o_transtype" value="${bean.transtype}">
<input type="hidden" name="o_contract_id" id="o_contract_id" value="${bean.contract_id}">
<input type="hidden" name="o_outdept_id" id="o_outdept_id" value="${bean.outdept_id}">
<input type="hidden" name="o_transyearmonth" id="o_transyearmonth" value="${bean.transyearmonth}">
<input type="hidden" name="o_bill_id" id="o_bill_id" value="${bean.bill_id}">
<input type="hidden" name="o_bill_amount" id="o_bill_amount" value="${bean.bill_amount}">
<input type="hidden" name="o_transtype" id="o_transtype" value="${bean.transtype}">
<input type="hidden" name="o_description" id="o_description" value="${bean.description}">
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	
	//弹出编辑框之前，把客户id传到后台查询，根据默认客户
	//$id("lk_bill").beforeOpenDialog = function(lookup1){
    //    lookup1.params = [];
       
       //var cust_id = jQuery("#cust_id").val();
       //if(cust_id!=null && cust_id!=''){
       //     lookup1.addParam("cust_id",cust_id);
       //}
       
    //    return true;
    //}
</script>
</body>
</html>

<script language="javascript">
</script>
