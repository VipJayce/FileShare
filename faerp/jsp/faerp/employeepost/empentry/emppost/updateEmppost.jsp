<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
    jQuery(function(){
        $id("emppost_init").isQueryFirst = false;
    });
    var vpath = "<%=request.getContextPath()%>";

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' id='temp_"+rowNo+"'  value=" + entity.getProperty("id") + ">";
    }
    
    //员工列表，点击全选按钮
    function emp_onClick(obj){
        var datacell = $id("emppost_init");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
            //针对第一行有问题，其他行可行
            if(obj.checked){//勾选上
                $id("temp_"+i).checked=true;
            }else{//勾选去掉
                $id("temp_"+i).checked=false;
            }
        }
       
    }
    
    //选择客服
	function rtnFuncCS(arg){
	    var lookup = $id("lk_cs");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[1];
	    jQuery("#h_submit_user_id").val(arg[0]);        
	    return false;
	}

    //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        //jQuery("#h_customer_id").val(arg[0]);        
        return false;
    }
    
    function rtnFunSend(arg){
        var lookup = $id("lk_wpd");
        lookup.value = arg[1];
        lookup.displayValue = arg[1];
        //jQuery("#h_send_name").val(arg[1]);
        return false;
    }
    
    function findSelections(checkboxName) {  //从列表中找出选中的id值列表
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
    function simpleQuery_onClick(){  //简单的模糊查询
        $id("emppost_init").loadData();
        $id("emppost_init").refresh();
    }

    //查看个人订单信息 参数为PB_EMP_POST表中的主键id
    function detail_onClick(){
        var ids = findSelections("checkbox_template");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert("<fmt:message key="please_choose_on_post_record"/>");
            return false;
        }else{
            if(ids.length>1){
                alert("<fmt:message key="selected_on_post_record_query"/>");
                return false;
            }
        }
        
        if(ids[0]!=null && ids[0]!=""){
            //window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrder&id='+ids[0],'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
            window.open('<%=request.getContextPath()%>/EmppostAction.do?cmd=detailPerOrderBack&id='+ids[0],'','height=600px,width=1024px,top=100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=no');
        }
    }
    
    
    function toUpdateAll_onClick(type) {  //到订单变更全部记录页面
        var idarray = findSelections("checkbox_template");  //取得多选框的选择项
        var ids ='';
        if(idarray == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }else{
             var send_id='';
             var cust_id='';
             var datacell = $id("emppost_init");
             var dataset = datacell.dataset;
             for(var i=0;i<idarray.length;i++){
                 var datatr = dataset.findEntity("id",idarray[i]);
                 if(i==0){
                     send_id = datatr.getProperty("send_id");
                     cust_id = datatr.getProperty("cust_id");
                     ids=idarray[0];
                 }else{
                     if(type=='1' || type=='3'){//变更所有或只变更社保公积金必须是同一委派单
	                     if(send_id!=datatr.getProperty("send_id")){
	                          alert("<fmt:message key="selected_on_post_record_must_by_send"/>");
	                          return;
	                     }
	                 }
	                 if(type=='2'){//变更报价单
                         if(cust_id!=datatr.getProperty("cust_id")){
                              alert("<fmt:message key="selected_on_post_record_must_by_cust"/>");
                              return;
                         }
                     }
                     ids = ids+','+idarray[i];
                 }
            }
            //检查所选员工在福利办理表中是否有待办记录
            //var action_check="<%=request.getContextPath()%>/EmpwelfarerecordAction.do?cmd=checkEmpWelfareInfo4All";
            //var myAjax_check = new Ajax(action_check);
            //myAjax_check.addParam("ids", ids);
            //myAjax_check.submit();
           // var returnNode_check = myAjax_check.getResponseXMLDom();
            //if( returnNode_check) {
            //var  flag=myAjax_check.getProperty("returnValue");
            //if(flag==0){
            //判断订单表中有没有该入离职ID有没有对应的订单
            jQuery.getJSON(vpath+"/EmppostAction.do?cmd=checkorderbypostid&date="+new Date()+"",{"ids":ids},  function(json){
                 if(json.saia!=null && json.saia.length>0){
	                 for(var i = 0; i < json.saia.length; i++){
		                alert("<fmt:message key="emp"/><fmt:message key="emp_code"/>："+json.saia[i].emp_code+",<fmt:message key="emp_name"/>："+json.saia[i].emp_name+","+json.saia[i].message);
		             }
		         }else{
		            var quotation_id = $id("quotation_id").value;
		            var custId = $id("cust_id").value;
		            var methed = "";
		            if(type=='1'){//变更所有
		                methed= "initUpdateAll";
		                if(quotation_id==null || quotation_id==''){
		                    alert("<fmt:message key="please_choose_send"/>");
		                    return;
		                }
		                if(custId!=cust_id){
		                    alert("<fmt:message key="selected_on_post_record_and_send_must_by_cust"/>");
		                    return;
		                }
		            }
		            if(type=='2'){//只变更福利
		                methed= "initUpdateFuli";
		                if(quotation_id==null || quotation_id==''){
		                    alert("<fmt:message key="please_choose_send"/>");
		                    return;
		                }
		                if(custId!=cust_id){
		                    alert("<fmt:message key="selected_on_post_record_and_send_must_by_cust"/>");
		                    return;
		                }
		            }
		            if(type=='3'){//只变更社保公积金
		                methed= "initUpdateAll";
		            }
		            form.action="<%=request.getContextPath()%>/EmppostAction.do?ids=" + ids+"&quotation_id="+quotation_id+"&type="+type;
			        form.cmd.value = methed;
			        form.submit();
		            
		         }
             });
               // }else{
                // alert("所选员工存在待确认的GE福利记录，请办理完成后再做变更！");
                // return;
                // }
             //}else{
             //alert("系统异常，请稍后再试！");
            // return;
           // }
	    }
	    
        
    }

</script>
</head>
<body>


<div id="right">
<script language="javascript">
    writeTableTopFesco("<fmt:message key="reporte_change"/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<form name="form" method="post" id="simpleQuery">
<input type="hidden" name="cmd" value="queryAllpost">
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
          
            <td/>
            <td/>
              <td>    </td>
                <td/>
        </tr>

        <tr>
            <td align="right"><fmt:message key="emp_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="25"/>
            </td>
            <td align="right"><fmt:message key="emp_name"/></td>
            <td align="left">
                <input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="50"/>
            </td>
            <td align="right"><fmt:message key="emp_card_no1"/></td>
            <td align="left"><input type="text" class="text_field" name="id_card" inputName="证件号码" maxLength="64"/></td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="internal_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="internal_code" inputName="客户方编号" maxLength="25"/>
            </td>
            <td align="right"><fmt:message key="cust_code"/></td>
            <td align="left">
                <input type="text" class="text_field" name="cust_code" inputName="客户编号" maxLength="50"/>
            </td>
            <td align="right"><fmt:message key="cust_name"/></td>
            <td align="left">
                <w:lookup name="cust_name" onReturnFunc="rtnFuncCustomer" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="post_status"/></td>
            <td align="left">
                <select name="post_status_bd" class="sSelect" id="post_status_bd">
                    <option value=""><fmt:message key="please_choose"/></option>
                    <option value="1"><fmt:message key="on_post_not_effective"/></option>
                    <option value="2"><fmt:message key="on_post"/></option>
                    <option value="3"><fmt:message key="off_post"/></option>
                </select>
            </td>
            <td align="right"><fmt:message key="user_name"/></td>
            <td>
                <r:comboSelect id="combo_cs" name="submit_user_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=${requestScope.kefuid }"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_choose" />
            </td>
            <td align="right"><fmt:message key="send_name"/></td>
            <td>
                <w:lookup name="send_name" onReturnFunc="rtnFunSend" id="lk_wpd" lookupUrl="/SendAction.do?cmd=queryAllSend" messagekey="choose_send" height="440" width="800"  style="width:195px"/>
                
            </td>
            
        </tr>
        <tr>
            <td/>
            <td/>
            <td align="right"></td>
            <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
                <td/>
                <td/>
        </tr>
    
</table>

</div>


 


<div id="ccParent1" class="button"> 
 <div class="button_right"><!--
                <ul>
                    <li class="a_2"><a onClick="javascript:detail_onClick()">查看个人订单</a></li>
                      
                      
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="b">      <a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
                </ul>
         -->
         <input type="button" class="a_2" value="<fmt:message key="look_person_order"/>" <au:authorityBtn code="view_orderItem4" type="1"/> onClick="detail_onClick();" />
         </div>
           <div class="clear"></div>            
</div>
                    <r:datacell 
                         id="emppost_init"
                         queryAction="/FAERP/EmppostAction.do?cmd=toUpdateQuery"
                         width="98%"
                         height="320px"
                         xpath="EmppostVo"
                         submitXpath="EmppostVo"
                         paramFormId="simpleQuery"
                         pageSize="50"
                         >
                         <r:toolbar  tools="nav,pagesize,info"/>
                         <r:field fieldName="emp" label="操作<input type='checkbox' name='empselect' onclick='emp_onClick(this);' />" width="50px" onRefreshFunc="setCheckboxStatus" sortAt="none" align="center">
                         </r:field>   
                         <r:field fieldName="emp_name" messagekey="emp_name">
                         </r:field>
                          <r:field fieldName="emp_code" messagekey="emp_code">
                         </r:field>
                         <r:field width="200" fieldName="id_card" messagekey="emp_card_no1">
                         </r:field>
                         <r:field fieldName="cust_code" messagekey="cust_code">
                         </r:field>
                         <r:field width="300" fieldName="cust_name" messagekey="cust_name">
                         </r:field>
                         <r:field width="300" fieldName="send_name" messagekey="send_name">
                         </r:field>
                         <r:field width="100" fieldName="user_name" messagekey="user_name">
                         </r:field>
                       </r:datacell>
    </br>
	<div class="xz_title"><fmt:message key="selected_new_quotation"/></div>
        <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1">&nbsp;</td>
            <td class="td_1"><fmt:message key="choose_quotation"/></td>
            <td class="td_2">
                <input type="hidden" name="cust_id" id="cust_id"/>
                <w:lookup onReturnFunc="rtnFuncquotation" readonly="false" id="quotation_id" name="quotation_id" lookupUrl="/EmppostAction.do?cmd=toQuotationByCust" messagekey="choose_quotation" height="440" width="800"  style="width:170px"/>
            </td>
          </tr>
        </table>
        <br>
        <div class="foot_button">
        <input name="submit3" type="button" class="foot_icon_2" value="<fmt:message key="change_all"/>" <au:authorityBtn code="sbbg_all" type="1"/>  onclick="toUpdateAll_onClick('1');" />
        <input name="submit2" type="button" class="foot_icon_2" value="<fmt:message key="change_quotation"/>"  <au:authorityBtn code="sbbg_bgbj" type="1"/> onclick="toUpdateAll_onClick('2');"/>
        <input name="submit2" type="button" class="foot_icon_3" value="<fmt:message key="change_ss_fund"/>"  <au:authorityBtn code="sbbg_bggjj" type="1"/> onclick="toUpdateAll_onClick('3');"/>
    </div>
</div>
</div>
</form>
</body>
</html>
<script language="javascript">

     function rtnFuncquotation(arg){
        var lookup = $id("quotation_id");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[1];
	    return false;
     }


    $id("quotation_id").beforeOpenDialog = function(lookup1){
        lookup1.params = [];
        var ids = findSelections("checkbox_template");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert("<fmt:message key="please_choose_on_post_record"/>");
            return false;
        }else{
                var cust_id='';
                var datacell = $id("emppost_init");
                var dataset = datacell.dataset;
                for(var i=0;i<ids.length;i++){
                    var datatr = dataset.findEntity("id",ids[i]);
                    if(i==0){
                        cust_id = datatr.getProperty("cust_id");
                    }else{
                        if(cust_id!=datatr.getProperty("cust_id")){
                            alert("<fmt:message key="selected_on_post_record_must_by_cust"/>");
                            return false;
                        }
                    }
                }
                jQuery("#cust_id").val(cust_id);
                
                lookup1.addParam("cust_id",cust_id);
        }
        
        return true;
    }
    
</script>
</fmt:bundle>