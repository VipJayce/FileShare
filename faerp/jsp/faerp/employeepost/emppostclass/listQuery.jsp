<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>

<script type="text/javascript">
    jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="rayoo.employeepost.emppostclass.emppostclass_resource" prefix="rayoo.employeepost.emppostclass.">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Datacell</title>
    
    <script language="javascript">
    function toImport_onClick(){
    }
    
    function toConfi_onClick(){
        var id = document.getElementById("emp_service_id").value;
        if(null==id||id==""){
            alert("<fmt:message key="please_selecte"/>");
            return;
        }
        form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=updateEmpService&backFlag=true&id="+id;
        form.submit();
    }
    
    //客户名称查询条件
    function getbyid(){
        var data = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
        document.form.cust_name.value=data[2];
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("emp_service_id") + "\",\"" + entity.getProperty("city_id") + "\");>";//city_idList
    }
    
    function ClickRow(value,value1){
        $id("emp_service_id").value = value;
        $id("city_id1").value = value1;
        $id("celllist1").queryParam= "<param><key>emp_service_id</key><value>" + value +  "</value></param>"; 
        var combo1 =   $id("service_idList");
        combo1.addParam("city_id1",value1);
        $id("cust_receive_id").addParam("city_id",value1);         
          
        $id("cust_receive_id").loadData();
        $id("cust_receive_id").refresh();     
             
        $id("celllist1").loadData();
        $id("celllist1").refresh();
        
        $id("service_idList").loadData();
        $id("service_idList").refresh();

    }
    
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function toAdd_onClick() { 
         $id("celllist1").addRow(); 
    }
        
        function deleteMulti_onClick(){ 
                 var emp_service_id = document.getElementById("emp_service_id").value;
                if(null==emp_service_id||emp_service_id==""){
                        alert("<fmt:message key="selecte_emp"/>");
                        return ;
                }
        
                var bl = document.getElementsByName("temp1");
                var n=0;
                               for(var i=0;i<bl.length;i++){  //循环checkbox组
                                          if(bl[i].checked) {  //如果被选中
                                          n++;
                                                     var enCurEntity = $id("celllist1").dataset.get(i); 
                                                  var      id  = enCurEntity.getProperty("id"); 
                                                     
                                                      if(id==undefined||id==""||id=="null"||id=="undefined"){
                                                         $id("celllist1").deleteRow();
                                                      }else{
                                                         alert("<fmt:message key="can_not_delete"/>");
                                                      }
                                             }
                                   }
                if(n==0){
                  alert("<fmt:message key="please_selecte"/>");
                }                
        }
        
        function toSave_onClick() { 
            var emp_service_id = document.getElementById("emp_service_id").value;
            
            if(null==emp_service_id||emp_service_id==""){
                    alert("<fmt:message key="selecte_emp"/>");
                    return ;
        }
            
        var product_name = document.getElementsByName("temp1");
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<product_name.length;i++){  //循环checkbox组
                     var enCurEntity = $id("celllist1").dataset.get(i); 
                     $id("celllist1").isModefied = true;
                     
                     var cust_receive_id = enCurEntity.getProperty("cust_receive_id");
                      var service_id = enCurEntity.getProperty("service_id");
                      var service_status= enCurEntity.getProperty("service_status");
                     
                     if(cust_receive_id==null||cust_receive_id==""){
                             alert("<fmt:message key="agent_not_null"/>");
                     return;
                     }
                   if(service_id==null||service_id==""){
                             alert("<fmt:message key="emp_entry_not_null"/>");
                     return;
                     }
                     
                  if(service_status==null||service_status==""){
                             alert("<fmt:message key="service_status_not_null"/>");
                     return;
                     }
        }
          
            $id("celllist1").submit();
        }   
        function toReload_onClick() {
             $id("celllist1").reload();
        }
           
    function detail_onClick(){  //实现转到详细页面
        var curRowNum = $id("datacell1").activeRow.rowIndex;
          var entity=$id("datacell1").getEntity(curRowNum);
          if(entity!=undefined){
                var emp_post_id=entity.getProperty("id");
                window.showModalDialog('<venus:base/>/EmppostAction.do?cmd=detailPerOrder&id='+emp_post_id,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
                }else{
                    alert("<fmt:message key="select_records"/>");
                    return;
                }
    }
        
    function setCheckbox(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp1'   value="+entity.getProperty("id")+"   onClick=ClickRow1(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("city_id") + "\");>";
    }
    
    function ClickRow1(value,value1){
        $id("fwid").value = value;
    }
    
     function exportEmpSend(){ 
        form.cmd.value = "exportDaiXu";
        form.submit();
    }
    
   function rtnFuncCustomer(arg){
            var lookup = $id("lk_clz");
            lookup.value = arg[2];
            lookup.displayValue = arg[2];
            return false;
        }
</script>
</head>

<body>
<form name="form" method="post" id="datacell_formid"  action="<%=request.getContextPath()%>/EmppostAction.do">
<input id="emp_service_id" name="emp_service_id" type="hidden"  value="" />
<input id="fwid" name="fwid" type="hidden"  value="" />
<input id="city_id1" name="city_id1" type="hidden"  value="" />
<input type="hidden" name="cmd" />

<div id="right">
    <script language="javascript">
           writeTableTopFesco("<fmt:message key="on_post_continue"/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"  nowrap="nowrap"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
          
            <td width="85"/>
            <td width="196"/>
              <td width="143">    </td>
                <td width="240"/>
        </tr>
                <tr>
            <td align="right"><fmt:message key="private_id"/></td>
            <td align="left" nowrap="nowrap">
            <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       messagekey="please_choose"
                       value="${requestScope.city_id }"
                        />
            </td>
              <td align="right"><fmt:message key="cust_name"/></td>
            <td align="left">
                <w:lookup name="cust_id" onReturnFunc="rtnFuncCustomer" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
            </td>
            
            <td align="right"><fmt:message key="emp_name"/></td>
            <td align="left"><input type="text" class="text_field" name="emp_name" inputName="员工姓名" maxLength="50"/>            </td>
            
        </tr>
        <tr>
            <td align="right"><fmt:message key="emp_code"/></td>
            <td align="left"><input type="text" class="text_field" name="emp_code" inputName="唯一号" maxLength="25"/>          </td>
            
            <td align="right"><fmt:message key="sort_status"/></td>
            <td align="left"><%=gap.rm.tools.helper.RmJspHelper.getSelectField("service_status_bd ", -1,"SERVICE_STATUS_BD", "", "", false) %></td>
              <td align="right"><fmt:message key="is_current_effective"/></td>
            <td align="left">
            <select id="is_valid"  name="is_valid">
            <option value="1"><fmt:message key="yes"/></option>
             <option value="0"><fmt:message key="no"/></option>
            </select>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="emp_card_no1"/></td>
            <td align="left"><input type="text" class="text_field" name="id_card" inputName="证件号码" maxLength="64"/></td>
              <td align="right"><fmt:message key="user_name"/></td>
              <td>
                       <r:comboSelect id="combo_cs" name="cs_id"
                       queryAction="CustServiceAction.do?cmd=getListData&id=${requestScope.kefuid }"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_choose" />
              </td>
              <td><fmt:message key="post_status"/></td>
              <td><%=gap.rm.tools.helper.RmJspHelper.getSelectField("post_status_bd", -1,"POST_STATUS_BD", "", "style='width:210'", false) %> </td>
        </tr>
        <tr>
              <td colspan="6" align="center">
                 <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
              </td>
        </tr>
        
</table>
</div>


<div id="ccParent1" class="search"> 
     <div class="button_right">
                <ul>
                   <li class="e"><a  onclick="detail_onClick();"><fmt:message key="look_person_order"/></a> </li> 
                     <li class="e">      <a  onclick="exportEmpSend();"><fmt:message key="leading_out"/></a> </li>
                    <li class="a">      <a  onClick="javascript:toConfi_onClick();"><fmt:message key="sure_operation"/></a> </li>
                </ul>
     </div>
     <div class="clear"></div>     
</div>
<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=queryList"
        width="98%"
        height="190px"
        xpath="EmppostVo"
        submitXpath="EmppostVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="Operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>           
       <r:field fieldName="send_name" messagekey="send_name" width="100px">
                  
       </r:field>    
    
      <r:field fieldName="cust_name" width="140px" messagekey="cust_name">
      </r:field>
      <r:field fieldName="id_card" messagekey="id_card_num">
      </r:field>
      
      <r:field fieldName="emp_code" messagekey="emp_code">
      </r:field>
      
      <r:field fieldName="emp_name" messagekey="emp_name">
      </r:field>
      
      <r:field fieldName="post_status_bd" messagekey="emp_status"  allowModify="false">
           <d:select dictTypeId="POST_STATUS_BD" />
      </r:field>
      <r:field fieldName="user_name" messagekey="user_name">
      </r:field>
      <r:field fieldName="big_name" messagekey="big_name">
      </r:field>
      <r:field fieldName="small_name" messagekey="small_name">
      </r:field>
      
      <r:field fieldName="service_status_bd" messagekey="sort_status"  allowModify="false">
          <d:select dictTypeId="SERVICE_STATUS_BD" />
      </r:field>
      
      
      <r:field fieldName="classify_date" messagekey="sort_date"   allowModify="false">
           <w:date format="yyyy-MM-dd" />
      </r:field>
      
        <r:field fieldName="apply_on_post_date" messagekey="entry_declare_date"  allowModify="false">
          <w:date format="yyyy-MM-dd" />
      </r:field>
           <r:field fieldName="apply_off_post_date" messagekey="apply_off_post_date1"  allowModify="false">
         <w:date format="yyyy-MM-dd" />
      </r:field>
      
       <r:field fieldName="service_desc" messagekey="on_post_desc1">
      </r:field>
      
      <r:field fieldName="city_name" messagekey="city">
      </r:field>
      
    </r:datacell>
    </div>
    
     <div class="button_right">
                <ul>
                     <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="bc">      <a  onClick="javascript:toSave_onClick();"><fmt:message key="save"/></a> </li>
                </ul>
     </div>
     <div class="clear"></div>        
     
 <div style="display:" id="div1">
<table cellpadding="0" style="padding: 8 10 8 8;" border="0">
    <tr>
        <td valign="top" width="100%"> <br>
                <r:datacell 
                        id="celllist1"
                        isCount="false"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/EmppostAction.do?cmd=queryServiceItem"
                        submitAction="/FAERP/EmppostAction.do?cmd=insertServiceItemGroupData"
                        width="97%" height="200px"
                        xpath="EmpserviceitemVo"
                        submitXpath="EmpserviceitemVo"
                        pageSize="-1"
                        >
                <r:field fieldName="emp" messagekey="Operation" width="50px" onRefreshFunc="setCheckbox" align="center">
                </r:field>   
                      
                      <r:field fieldName="cust_receive_id" messagekey="agent" width="100px"  >
                              <r:comboSelect id="cust_receive_id" name="cust_receive_id"
                               queryAction="AgentAction.do?cmd=getListData"
                               textField="agent_name"
                               valueField="id"

                               xpath="AgentVo"
                               width="100px"
                                messagekey="please_choose"
                               validateAttr="message=供应商不能为空;allowNull=false"  />
                       </r:field>
                       
                       
                 <r:field fieldName="service_id" messagekey="on_post_servise_name"   >
                <r:comboSelect id="service_idList" name="service_id"
                               queryAction="PbserviceAction.do?cmd=getServiceListBycity"
                               valueField="id"
                               textField="service_name"
                               xpath="PbserviceVo"
                               width="150px"
                               messagekey="please_choose"
                               validateAttr="message=入职服务名称;allowNull=false"
                                   />
              </r:field>
                <r:field fieldName="service_status" messagekey="service_status"  >
               <d:select dictTypeId="SERVICE_STATUS"  />
              </r:field>
              <r:field fieldName="service_date" messagekey="service_date"  allowModify="false"  >
                 <w:date format="yyyy-MM-dd" disabled="true" />
             </r:field>
                 
                    
                    </r:datacell>
        </td>
     </tr>
     </table>
     </div>
     
     
     
     
         
</div>
    
    
<script>


        function initparam(){
        //alert("__________"+$id("countryList"));
        var dCell = $id("countryList");
        var dEn = dCell.getEntity();
            //alert(); 
            //var fieldV = dCell.getActiveCell() ;
            for(var pops in dCell){
                //alert(dCell[pops]);
            }
        }


</script>


   
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script>
$id("celllist1").beforeEdit= function(cell,colIndex,rowIndex){

    var celllist1 = $id("celllist1");
    if(colIndex==1||colIndex==2||colIndex==3){
        var id=celllist1.getEntityByCell(cell).getProperty("id");
        if(isNaN(id)){
              return   ;
        }else{
          return  false ;
        }
    }
}  


//$id("datacell1").afterSubmit= function(ajax){
           //alert("ajax="+ajax.getProperty("returnValue"));
//}
        
//$id("datacell1").beforeEdit= function(cell,colIndex,rowIndex){
//}


            $id("service_idList").beforeRefresh= function(){
                    var comS = $id("service_idList");
            }
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>
