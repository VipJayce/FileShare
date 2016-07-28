<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page
    import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%
      String loadData = request.getParameter("loadData");
      request.setAttribute("loadData",loadData);
%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>


<html>
<fmt:bundle basename="rayoo.customerservice.security.securitymanger.listSecurityManager_resource" prefix="auto.">
    <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>codegen</title>
    <script language="javascript">
    
    //判断是否加载数据，如果是从首页提醒点击过来要加载数据，并且直接定位到公积金进账审核标签
	jQuery(document).ready(function(){
	    if("${loadData}" == "" || "${loadData}" == false){
            $id("datacell1").isQueryFirst=false;
        }else{
            document.getElementById('bg').className='social_xixi2';
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabConInner1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("TabConInner2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
        }
	});
	
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
    function findCheckbox_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","cust_id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
      // form.action="<%=request.getContextPath()%>/jsp/faerp/insurance/settlementclaim/insertSettlementclaim.jsp?id="+ids;
      //  form.submit();
    }  

    function simpleQuery_onClick(){  //简单的模糊查询

       $id("datacell").addParam("query_security_group_id",$id("query_security_group_id").value); 
       $id("datacell").addParam("cs_social_unit_id",$name("social_unit_id").value); 
       $id("datacell").addParam("query_cust_code",$id("query_cust_code").value); 
       $id("datacell").addParam("query_cust_name",$id("query_cust_name").value); 
       $id("datacell").addParam("query_name",$id("query_name").getValue()); 
       $id("datacell").loadData();
       $id("datacell").refresh();
    }

    function detail_onClick(){  //实现转到详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/SettlementclaimAction.do?id=" + ids;
        form.cmd.value = "detail";
        form.submit();
    }
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio' value='"+ value+"' name='checkbox_template' >";
    }
   function checkAll(){
   var element = document.getElementsByTagName("input");
   for(var i=0;i<element.length;i++){
           if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
               element[i].checked= !element[i].checked ? true : false;
           }
   } 
 }

//取得选中行
    function checkSelections() {  
        var dc = $id("datacell");
        var enCur = dc.getActiveEntity();
        if(enCur){
            var ids = null;
            if(ids == null) {
                ids = new Array(0);
            }
            ids.push(enCur.getProperty("group_name"));  //加入选中的checkbox
            ids.push(enCur.getProperty("hire_unit_short_name"));
            ids.push(enCur.getProperty("customer_name"));
            ids.push(enCur.getProperty("customer_code"));
            ids.push(enCur.getProperty("cust_id"));
            return ids;
        }
        return null;
    }
function toAdd_onClick()
{
   var ids = checkSelections();
   if(ids==null){
       alert("<fmt:message key="select_one_record"/>");
       return ;
   }
    var datacell = $id("datacell");
    var activeRow = datacell.activeRow;
    var enCurEntity = datacell.getEntity(activeRow);//得到当前操作的行dataset
    //var security_group_id=enCurEntity.getProperty('security_group_id');
    var social_unit_id = enCurEntity.getProperty('social_unit_id');
   var report_month = enCurEntity.getProperty('report_month');
   if(report_month==null || report_month=="null" || report_month=="undefined"){
       report_month = "";
   }
   var customer_name  =ids[2]=="无客户名称"?"":ids[2];
   var customer_code = ids[3]=="无客户编号"?"":ids[3];
   var  url = "<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/listTransactionHousingEmpsecurity.jsp?report_month="+report_month+"&social_unit_id="+social_unit_id+"&customer_name="+encodeURIComponent(customer_name)+"&customer_code="+customer_code+"&isQuery=true";
  window.open(url,'','height=600px,width=1200px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=公积金办理');
    //showModalCenter(url, window,"",1200,600,"公积金办理");
}
function toStopAdd_onClick()
{
   var ids = checkSelections();
   if(ids==null){
       alert("<fmt:message key="select_one_record"/>");
       return ;
   }
    var datacell = $id("datacell");
    var activeRow = datacell.activeRow;
    var enCurEntity = datacell.getEntity(activeRow);//得到当前操作的行dataset
    //var security_group_id=enCurEntity.getProperty('security_group_id');
    var social_unit_id = enCurEntity.getProperty('social_unit_id');
    var report_month = enCurEntity.getProperty('report_month');
   var customer_name  =ids[2]=="无客户名称"?"":ids[2];
   var customer_code = ids[3]=="无客户编号"?"":ids[3];
   var  url = "<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/listStopHousingEmpsecurity.jsp?social_unit_id="+social_unit_id+"&report_month="+report_month+"&customer_name="+encodeURIComponent(customer_name)+"&customer_code="+customer_code+"&isQuery=true";
    window.open(url,'','height=600px,width=1200px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=公积金停办');
    //showModalCenter(url, window,"",1050,600,"公积金停办");
}
function toReport_onClick()
{
    var ids = checkSelections();
    if(ids==null){
       alert("<fmt:message key="select_one_record"/>");
       return ;
   }
    var datacell = $id("datacell");
    var activeRow = datacell.activeRow;
    var enCurEntity = datacell.getEntity(activeRow);//得到当前操作的行dataset
    var security_group_id=enCurEntity.getProperty('security_group_id');
    var social_unit_id = enCurEntity.getProperty('social_unit_id');
    var report_month = enCurEntity.getProperty('report_month');
   if(report_month==null || report_month=="null" || report_month=="undefined"){
       report_month = "";
   }
   var customer_name  =ids[2]=="无客户名称"?"":ids[2];
   var cust_id = ids[4]==""?"":ids[4];
   var  url = "<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/listSocialSecurityStatementsGongJin.jsp?security_group_id="+security_group_id+"&report_month="+report_month+"&social_unit_id="+social_unit_id+"&customer_name="+encodeURIComponent(customer_name)+"&cust_id="+cust_id+"&isQuery=true";
   window.open(url,'','height=600px,width=1200px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=公积金报表');
   //showModalCenter(url, window,"",1050,400,"公积金报表");
}
function toPay_onClick()
{
  var ids = checkSelections();
  if(ids==null){
       alert("<fmt:message key="select_one_record"/>");
       return ;
   }
    var datacell = $id("datacell");
    var activeRow = datacell.activeRow;
    var enCurEntity = datacell.getEntity(activeRow);//得到当前操作的行dataset
    var security_group_id=enCurEntity.getProperty('security_group_id');
    var social_unit_id = enCurEntity.getProperty('social_unit_id');
    var report_month = enCurEntity.getProperty('report_month');
   if(report_month==null || report_month=="null" || report_month=="undefined"){
       report_month = "";
   }
   var customer_name  =ids[2]=="无客户名称"?"":ids[2];
   var customer_code = ids[3]=="无客户编号"?"":ids[3];
   var cust_id = ids[4]==""?"":ids[4];
   if(social_unit_id==null || social_unit_id=="" ){
    alert("<fmt:message key="listSecurityManager0000"/>");
    return;
   }
  var  url= "<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/listSecurityPay.jsp?security_group_id="+security_group_id+"&report_month="+report_month+"&social_unit_id="+social_unit_id+"&customer_name="+encodeURIComponent(customer_name)+"&customer_code="+customer_code+"&isQuery=true&security_type=2&cust_id="+cust_id;
   window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=公积金支付');
   //showModalCenter(url, window,"",1050,400,"公积金支付");
}
function chanage()
{
    alert(document.getElementById("query_security_group_id").selectedIndex);
}



    //tab切换
    function selectTab03Syn ( i )
    {
        switch(i){
            case 1:
            document.getElementById('bg').className='social_xixi1';
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabConInner1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("TabConInner2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
            document.getElementById('bg').className='social_xixi2';
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabConInner1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("TabConInner2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            
            break;
        }
    }
    
    function setRadioStatus(value,entity,rowNo,cellNo){
        return "<input type='radio' name='radio_template' value='"+value+"' >";
    }
    
    //打开文件上传对话框
    function UploadFileWindow(){
        var paymentID = "";
        var creditDate = "";
        var remittedPic = "";
        var dc = $id("datacell1");
        var radioObj = jQuery('input[type="radio"]');
        jQuery(radioObj).each(function(i){
                if (radioObj[i].checked) {
                    var row = dc.table.tBodies[0].rows[i];
                    var entity = dc.getEntity(row);
                    paymentID = entity.getValue("payment_id");
                    creditDate = entity.getValue("credit_date");
                    remittedPic = entity.getValue("remitted_pic");
                }
            });
        
        
        var childWin = "";
        if(paymentID == "" || paymentID=="null" || paymentID == null) {
            alert('请选择一条记录。');
            return;
        }else{
            //w为窗口宽度，h为高度
            var w = 500;
            var h = 300;
            var l = (screen.width - w) / 2; 
            var t = (screen.height - h) / 2; 
            var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
            s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
            //childWin = window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp?uploadDir=upload/fin_payment_pic&paymentID='+paymentID,'newwindow', s);
            childWin = window.open('<%=request.getContextPath() %>/jsp/faerp/customerservice/security/SecurityManger/securityAttachUploadFrame.jsp?uploadDir=upload/fin_payment_pic&firsttime=first&paymentID='+paymentID+'&creditDate='+creditDate+'&remittedPic='+remittedPic,'newwindow', s);
            
        }
    }
    
    //获取选中的节点
    function getCheckItem(){
       var id = "";
        var dc = $id("datacell1");
        var radioObj = jQuery('input[type="radio"]');
        jQuery(radioObj).each(function(i){
            if (radioObj[i].checked) {
                var row = dc.table.tBodies[0].rows[i];
                var entity = dc.getEntity(row);
                id = entity.getValue("payment_id");
            }
        });
        return id;
    }
    
    
    //审核确认
    function confirmSec(){
        var paymentID = getCheckItem();
        if(paymentID == "" || paymentID=="null" || paymentID == null) {
            alert('请选择一条记录。');
            return;
        }else{
           var csName = "";
           var csEmail = "";
           var custName = "";
           var confirmStatus = "";
           var paymentMonth = "";
           var creditDate = "";
           
           var dc = $id("datacell1");
           var radioObj = jQuery('input[type="radio"]');
           jQuery(radioObj).each(function(i){
               if (radioObj[i].checked) {
                   var row = dc.table.tBodies[0].rows[i];
                   var entity = dc.getEntity(row);
                   confirmStatus = entity.getValue("confirm_status");
                   csName = entity.getValue("user_name");
                   csEmail = entity.getValue("user_email");
                   custName = entity.getValue("customer_name");
                   paymentMonth = entity.getValue("payment_month");
                   creditDate = entity.getValue("credit_date");
               }
           });
           if(creditDate == "" || creditDate == "null"||creditDate == null){
                alert("请选择公积金进账时间！");
                return;
           }else{
                if(confirmStatus == "已确认"){
		              alert("请勿重复确认！");
		              return;
		           }else{
		                if(confirm("进账审核确认，是否继续！")){
		                   //编码
		                    csName = encodeURI(encodeURI(csName));
		                    custName = encodeURI(encodeURI(custName));
		                    var urlStr = "<%=request.getContextPath()%>/SecurityManagerAction.do?cmd=sendEmailToServicer&paymentID="+paymentID+"&csName="+csName+"&csEmail="+csEmail+"&custName="+custName+"&paymentMonth="+paymentMonth+"&creditDate="+creditDate;
		                    
		                    jQuery.ajax({
		                        type : "post",
		                        url : urlStr,
		                        dataType : "html",
		                        error: function(){
		                             alert('Ajax Error!');
		                             return;
		                         },success : function(data) {
		                           if(data != "null"){
		                               alert(data);
		                           }
		                        }
		                    });
		                    $id("datacell1").loadData();
		                    $id("datacell1").refresh();
		                }
		            }
           }
        }
    }
    
    function simpleQueryDataCell1_onClick(){  //简单的模糊查询
       $id("datacell1").addParam("query_security_group_id_for_confirm",$id("query_security_group_id_for_confirm").value); 
       $id("datacell1").addParam("cs_social_unit_id_for_confirm",$name("social_unit_id_for_confirm").value); 
       $id("datacell1").addParam("query_cust_code_for_confirm",$id("query_cust_code_for_confirm").value); 
       $id("datacell1").addParam("query_cust_name_for_confirm",$id("query_cust_name_for_confirm").value); 
       $id("datacell1").addParam("query_name_for_confirm",$id("query_name_for_confirm").getValue()); 
       $id("datacell1").addParam("apply_date_search_for_confirm",$id("apply_date_search_for_confirm").value);
       $id("datacell1").addParam("sec_check_type_bd",$id("sec_check_type_bd").value);
       $id("datacell1").addParam("sync_status",$id("sync_status").value);
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
    //显示一般的链接
    function showLink(value,entity,rowNo,cellNo){
    //onClick='javascript:window.open(this.href,\"_blank\",\"width=800,height=600,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes\");return false;'
        if(value){
            return "<a target='_blank' href='<%=request.getContextPath()%>/"+entity.getProperty("remitted_pic")+"'  style='color: #0033CC; font-weight: bold; text-decoration: underline;' onClick='javascript:window.open(this.href,\"_blank\",\"width=800,height=600,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes\");return false;'>预览</a>";
        }
    }
    
    //供上传截图，子窗口调用刷新数据
    function reloadDataCell1(){
        $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
    function exportExcel(){
       var query_security_group_id_for_confirm = $id("query_security_group_id_for_confirm").value; 
       var cs_social_unit_id_for_confirm = $name("social_unit_id_for_confirm").value; 
       var query_cust_code_for_confirm = $id("query_cust_code_for_confirm").value; 
       var query_cust_name_for_confirm = $id("query_cust_name_for_confirm").value; 
       var query_name_for_confirm = $id("query_name_for_confirm").getValue(); 
       var apply_date_search_for_confirm = $id("apply_date_search_for_confirm").value;
       var sec_check_type_bd = $id("sec_check_type_bd").value;
       var url = "<%=request.getContextPath()%>/SecurityManagerAction.do?cmd=exportExcel&query_security_group_id_for_confirm="+query_security_group_id_for_confirm+"&cs_social_unit_id_for_confirm="
                    +cs_social_unit_id_for_confirm+"&query_cust_code_for_confirm="+query_cust_code_for_confirm+"&query_cust_name_for_confirm="+query_cust_name_for_confirm+"&query_name_for_confirm="+query_name_for_confirm+"&apply_date_search_for_confirm="+apply_date_search_for_confirm+"&sec_check_type_bd="+sec_check_type_bd;
        form.action=url;
        form.submit();
    }
</script>
    </head>
    <body>

    <form id="datacell_formid" name="form" method="post" action="">
    <div id="right">
    <div class="ringht_s">
    <!--<div id="bg" class="reserve_xixi1">
        <div id="font1" class="reserve_tab1"
            onMouseDown="selectTab03Syn(1);document.getElementById('bg').className='reserve_xixi1'"><fmt:message
            key="listSecurityManager0028" /></div>
        <div id="font2" class="reserve_tab2"
            onMouseDown="selectTab03Syn(2);document.getElementById('bg').className='reserve_xixi2'">公积金办理2</div>
    </div>-->
    
        <div id="bg" class="social_xixi1">
          <div id="font1" class="social_tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='social_xixi1'"><fmt:message
            key="listSecurityManager0028" /></div>
          <div id="font2" class="social_tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='social_xixi2'">公积金进账审核</div>
        </div>
    
        <div id="TabCon1" style="display:block;">
                <div id="ccChild0" class="search">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="174" rowspan="10" style="padding-top: 0;">
                                    <div class="search_title"><fmt:message key="listSecurityManager0047" /></div>
                                </td>
                                <td />
                                <td />
                                <td></td>
                                <td />
                            </tr>
                            <tr>
                                <td align="right"><fmt:message key="listSecurityManager0046" /></td>
                                <td align="left">
                                    <select id="query_security_group_id" name="query_security_group_id" style="width: 185px">
                                        <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID5 %>"><fmt:message
                                            key="listSecurityManager0055" /></option>
                                        <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>"><fmt:message
                                            key="listSecurityManager0078" /></option>
                                        <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>"><fmt:message
                                            key="listSecurityManager0012" /></option>
                                    </select>
                                </td>
                                <td align="right"><fmt:message key="listSecurityManager0070" /></td>
                                <td align="left">
                                        <r:comboSelect id="social_unit_id" name="social_unit_id"
                                            queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                                            textField="hire_unit_short_name" valueField="id"
                                            xpath="SocialunitVo" messagekey="listSecurityManager0055"
                                            width="185px">
                                        </r:comboSelect>
                                </td>
                                <td align="right"><fmt:message key="listSecurityManager0041" /></td>
                                <td align="left">
                                    <input type="text" class="text_field" id="query_cust_code" name="query_cust_code"
                                       inputName="<fmt:message key="listSecurityManager0041"/>" maxLength="50" />
                                 </td>
                            </tr>
                            <tr>
                                <td align="right"><fmt:message key="listSecurityManager0072" /></td>
                                <td align="left">
                                    <input type="text" class="text_field" id="query_cust_name" name="query_cust_name"
                                        inputName="<fmt:message key="listSecurityManager0072"/>" maxLength="64" style="width: 185px;" />
                                </td>
                                <td align="right"><fmt:message key="listSecurityManager0011" /></td>
                                <!-- siqp添加接单客服 -->
                                <td align="left">
                                    <r:comboSelect id="query_name" name="query_name"
                                        queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=1"
                                        textField="name" valueField="partyid" xpath="Partyrelation"
                                        width="185" messagekey="listSecurityManager0055">
                                    <!-- 客服下拉注释 onChangeFunc="pushSelectName" -->
                                    </r:comboSelect>
                                 </td>
                            </tr>
                            <tr>
                                <td />
                                <td />
                                <td />
                                <td />
                                <td />
                                <td><input name="button_ok" class="icon_1" type="button"
                                    value='<fmt:message key="query"/>'
                                    onClick="javascript:simpleQuery_onClick()"></td>
                            </tr>
                        </table>
                </div>
        </div>      
        <div id="TabConInner1"  style="display:block;">
              <div id="ccParent1" class="button">
                   <div class="button_right"><!--<ul>
                                   <li class="bl">     <a onClick="javascript:toAdd_onClick();">办理 </a></li>
                                   <li class="tb">     <a  onClick="javascript:toStopAdd_onClick();">停办</a> </li>
                                   <li class="bb">     <a  onClick="javascript:toReport_onClick();">报表</a> </li>
                                   <li class="zf">     <a  onClick="javascript:toPay_onClick();">支付</a> </li>
                               </ul>
                        -->
                        <input class="bl" type="button" value="<fmt:message key="listSecurityManager0010"/>" <au:authorityBtn code="gjjgl_bl" type="1"/> onClick="toAdd_onClick();">
                       <input class="tb" type="button" value="<fmt:message key="listSecurityManager0073"/>" <au:authorityBtn code="gjjgl_tb" type="1"/> onClick="toStopAdd_onClick();">
                       <input class="bb" type="button" value="<fmt:message key="listSecurityManager0040"/>" <au:authorityBtn code="gjjgl_bb" type="1"/> onClick="toReport_onClick();">
                       <input class="zf" type="button" value="<fmt:message key="listSecurityManager0071"/>" <au:authorityBtn code="gjjgl_zf" type="1"/> onClick="toPay_onClick();">
                   </div>
                   <div class="clear"></div>
                  </div>
                  <r:datacell id="datacell" queryAction="/FAERP/SecurityManagerAction.do?cmd=queryAll&forCheck=false"
                      isCount="false" width="100%" xpath="SecurityManagerVo" height="319"
                      submitXpath="SecurityManagerVo" paramFormId="datacell_formid">
                      <r:toolbar location="bottom" tools="nav,pagesize,info" />
              
                      <r:field fieldName="group_name" width="100px"  messagekey="listSecurityManager0046">
                      </r:field>
                      <r:field fieldName="hire_unit_short_name" width="150px" messagekey="listSecurityManager0070">
                      </r:field>
                      <r:field fieldName="customer_code" width="100px" messagekey="listSecurityManager0041">
                      </r:field>
                      <r:field fieldName="customer_name" width="150px" messagekey="listSecurityManager0072">
                      </r:field>
                      <r:field fieldName="user_name" width="100px" messagekey="listSecurityManager0011">
                      </r:field>
                      <r:field fieldName="report_month" width="100px" messagekey="listSecurityManager0024">
                          <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;" />
                      </r:field>
                      <r:field fieldName="is_fesco_pay" width="120px" messagekey="listSecurityManager0009">
                      </r:field>
                      <r:field fieldName="open_unit" width="150px" messagekey="listSecurityManager0069">
                      </r:field>
                      <r:field fieldName="open_unit" width="200px" messagekey="listSecurityManager0067">
                      </r:field>
                      <r:field fieldName="open_unit_accounts" width="200px" messagekey="listSecurityManager0035">
                      </r:field>
                      <r:field fieldName="end_date" width="100px" messagekey="listSecurityManager0034">
                      </r:field>
                      <r:field fieldName="get_day" width="100px"  messagekey="listSecurityManager0065">
                      </r:field>
                      <r:field fieldName="seal_party" width="100px" messagekey="listSecurityManager0001">
                      </r:field>
              
                      <r:field fieldName="remarks" width="100px"  messagekey="listSecurityManager0033">
                      </r:field>
                  </r:datacell>
            </div>
        </div>
    
        <div id="TabCon2" style="display:none;">
               <div id="ccChild1" class="search">
                     <table width="100%" border="0" cellspacing="0" cellpadding="0">
                         <tr>
                             <td width="174" rowspan="10" style="padding-top: 0;">
                             <div class="search_title"><fmt:message
                                 key="listSecurityManager0047" /></div>
                             </td>
                 
                             <td />
                             <td />
                             <td></td>
                             <td />
                         </tr>
                         <tr>
                             <td align="right"><fmt:message key="listSecurityManager0046" /></td>
                             <td align="left">
                                 <select id="query_security_group_id_for_confirm"
                                     name="query_security_group_id_for_confirm" style="width: 185px">
                                     <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID5 %>"><fmt:message
                                         key="listSecurityManager0055" /></option>
                                     <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID1 %>"><fmt:message
                                         key="listSecurityManager0078" /></option>
                                     <option value="<%=IEmpsecurityConstants.SECURITY_GROUP_ID2 %>"><fmt:message
                                         key="listSecurityManager0012" /></option>
                                 </select>
                             </td>
                             <td align="right"><fmt:message key="listSecurityManager0070" /></td>
                             <td align="left">
                                 <r:comboSelect id="social_unit_id_for_confirm" name="social_unit_id_for_confirm"
                                     queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                                     textField="hire_unit_short_name" valueField="id"
                                     xpath="SocialunitVo" messagekey="listSecurityManager0055"
                                     width="185px">
                                 </r:comboSelect>
                             </td>
                             <td align="right"><fmt:message key="listSecurityManager0041" /></td>
                             <td align="left">
                                 <input type="text" class="text_field" id="query_cust_code_for_confirm" name="query_cust_code_for_confirm"
                                     inputName="<fmt:message key="listSecurityManager0041"/>" maxLength="50" />
                             </td>
                         </tr>
                         <tr>
                             <td align="right"><fmt:message key="listSecurityManager0072" /></td>
                             <td align="left">
                                 <input type="text" class="text_field" id="query_cust_name_for_confirm" name="query_cust_name_for_confirm"
                                     inputName="<fmt:message key="listSecurityManager0072"/>" maxLength="64" style="width: 185px;" />
                             </td>
                             <td align="right"><fmt:message key="listSecurityManager0011" /></td>
                             <!-- siqp添加接单客服 -->
                             <td align="left">
                                 <r:comboSelect id="query_name_for_confirm"
                                     name="query_name_for_confirm"
                                     queryAction="/FAERP/PbcustomerserviceAction.do?cmd=getEmp&jibangren=1"
                                     textField="name" valueField="partyid" xpath="Partyrelation"
                                     width="185" messagekey="listSecurityManager0055">
                                     <!-- 客服下拉注释 onChangeFunc="pushSelectName" -->
                                 </r:comboSelect>
                             </td>
                             <td align="right">支付年月</td>
                             <td align="left">
                                    <input type="text" class="text_field" id="apply_date_search_for_confirm" name="apply_date_search_for_confirm"
                                     inputName="支付年月" maxLength="6" value="" />
                             </td>
                         </tr>
                         <tr>
                             <td align="right">审核确认状态</td>
                             <td align="left">
                                    <d:select name="sec_check_type_bd" id="sec_check_type_bd" dictTypeId="SEC_CHECK_TYPE_BD" filterOp="in" filterStr="0,1,2" nullLabel="--请选择--" style="width:185px;"/>       
                             </td>
                             <td align="right">同步状态</td>
					            <td align="left">
					                <d:select name="sync_status" id="sync_status" dictTypeId="SYNC_STATUS" nullLabel="--请选择--" style="width:170px;"/>
					            </td>
                             <td>
		                             <input name="button_ok" class="icon_1" type="button"
		                                 value='<fmt:message key="query"/>' onClick="javascript:simpleQueryDataCell1_onClick()">
		                             <input name="button_reset" class="icon_1" type="button" value="重置" onClick="javascript:this.form.reset()">
		                      </td>
                         </tr>
                     </table>
             </div>
        </div>
        <div id="TabConInner2"  style="display:none;">
             <div id="ccParent2" class="button">
                   <div class="button_right">
                        <input class="p_1" type="button" value="上传截图" <au:authorityBtn code="gjjgl_upload" type="1"/> onClick="javascript:UploadFileWindow();">
                        <input class="p_1" type="button" value="审核确认" <au:authorityBtn code="gjjgl_check" type="1"/> onClick="javascript:confirmSec();">
                        <input class="e" type="button" value="导出" <au:authorityBtn code="gjjgl_export" type="1"/> onClick="javascript:exportExcel();">
                   </div>
                   <div class="clear"></div>
                  </div>
                  <r:datacell id="datacell1" 
                        queryAction="/FAERP/SecurityManagerAction.do?cmd=queryAll&forCheck=true&loadData=${loadData}"
                        submitAction=""
                        isCount="false" width="100%" xpath="SecurityManagerVo" height="319"
                      submitXpath="SecurityManagerVo" paramFormId="datacell_formid"
                      >
                      <r:toolbar location="bottom" tools="nav,pagesize,info" />
                      <r:field fieldName="payment_id" label="" width="30px" sortAt="none" onRefreshFunc="setRadioStatus"  align="center"></r:field>
                      <r:field fieldName="user_email" width="0px"  messagekey="">
                      </r:field>
                      <r:field fieldName="customer_code" width="100px" messagekey="listSecurityManager0041">
                      </r:field>
                      <r:field fieldName="customer_name" width="150px" messagekey="listSecurityManager0072">
                      </r:field>
                      <r:field fieldName="group_name" width="100px"  messagekey="listSecurityManager0046">
                      </r:field>
                      <r:field fieldName="hire_unit_short_name" width="150px" messagekey="listSecurityManager0070">
                      </r:field>
                      <r:field fieldName="user_name" width="100px" messagekey="listSecurityManager0011">
                      </r:field>
                      <r:field fieldName="payment_month" width="100px" label="支付年月">
                      </r:field>
                      <r:field fieldName="apply_date" width="100px" label="请款时间" allowModify="false">
                            <w:date allowInput="true" id="apply_date" name="apply_date" format="YYYY-MM-DD" property="bean/apply_date" width="100px" />
                      </r:field>
                      <r:field fieldName="audit_status" width="100px" label="支付审批状态" allowModify="false">
                            <d:select dictTypeId="FIN_PAY_AUDIT_STATUS"></d:select>
                      </r:field>
                      <r:field fieldName="cashier_operate_date" width="100px" label="财务打款时间" allowModify="false">
                            <w:date allowInput="true" id="cashier_operate_date" name="cashier_operate_date" format="YYYY-MM-DD" property="bean/cashier_operate_date" width="100px" />
                      </r:field>
                      <r:field fieldName="credit_date" width="100px" label="公积金进账时间" allowModify="false">
                            <w:date allowInput="true" id="credit_date" name="credit_date" format="yyyy-MM-dd" property="bean/credit_date" width="100px" />
                      </r:field>
                      <r:field fieldName="confirm_status" width="100px" label="审核确认状态">
                      </r:field>
                      <r:field fieldName="confirm_date" width="100px" label="确认时间" allowModify="false">
                            <w:date allowInput="true" id="confirm_date" name="confirm_date" format="YYYY-MM-DD" property="bean/confirm_date" width="100px" />
                      </r:field>
                      <r:field fieldName="confirm_user" width="100px" label="审核确认人">
                      </r:field>
                      <r:field fieldName="is_fesco_pay" width="120px" messagekey="listSecurityManager0009">
                      </r:field>
                      <r:field fieldName="open_unit" width="150px" messagekey="listSecurityManager0069">
                      </r:field>
                      <r:field fieldName="open_unit_accounts" width="200px" messagekey="listSecurityManager0035">
                      </r:field>
                      <r:field fieldName="end_date" width="100px" messagekey="listSecurityManager0034">
                      </r:field>
                      <r:field fieldName="get_day" width="100px"  messagekey="listSecurityManager0065">
                      </r:field>
                      <r:field fieldName="remitted_pic" width="100px" label="汇缴截图" onRefreshFunc="showLink" allowModify="false">
                      </r:field>
                      
                       <r:field fieldName="sync_status" label="同步状态" width="150px" allowModify="false">
				            <d:select dictTypeId="SYNC_STATUS" disabled="true"/>
				      </r:field>
				      
				      <r:field fieldName="sync_remark" label="同步备注" width="150px" allowModify="false">
				           <d:select dictTypeId="SYNC_REMARK" disabled="true"/>  
				      </r:field> 
				      <r:field fieldName="sync_date" label="同步时间" width="130px" allowModify="false">
                                <w:date format="yyyy-MM-dd HH:mm:ss" />
         			  </r:field>
         			  <r:field fieldName="remark" label="同步历史" width="350px" allowModify="false">
				           <h:text/>
				      </r:field>
                  </r:datacell>
            </div>
        </div>            
    
    </div>
    </form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
<script type="text/javascript">
jQuery(function(){
    $id("datacell").isQueryFirst = false;
    });
</script>
