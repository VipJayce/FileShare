<%@ page import="rayoo.finance.receivable.MyUtils" %>
<%@ page contentType="text/html; charset=UTF-8"%>

<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<fmt:bundle basename="rayoo.finance.receivable.finincoming.finincoming_resource" prefix="rayoo.finance.receivable.finincoming.">
<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><fmt:message key='page_finincoming'/></title>
    <script type="text/javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
    <script language="javascript" src="<venus:base/>/jsp/faerp/finance/receivable/finincoming/listfincoming.js"></script>
    <style type="text/css">
        html body{
            margin:0px;
            padding:0px;
        }
        .text_field_half {
            background-color: #FFFFFF;
            border: 1px solid #90B3CF;
            color: #163752;
            font-size: 9pt;
            height: 20px;
            margin-right: 5px;
            vertical-align: middle;
            width: 102px;
        }
    </style>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
    <input type="hidden" id="batchType" />
<div id="right">
<script language="javascript">
	writeTableTopFesco("<fmt:message key='title_finincoming'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
        <td width="85"/>
        <td width="196"/>
        <td width="143"/>
        <td width="240"/>
    </tr>
        <tr>
            <td align="right"><fmt:message key='inc_cust_name'/></td>
            <td align="left">
                <input type="text" class="text_field" name="inc_cust_name" id="inc_cust_name"/><!-- 到款公司名称 -->
            </td>
            <td align="right"><fmt:message key='last_claim_user_name'/></td><!-- 客服到pb_customer_service 中取，根据CUSTOMER_ID，ROLE_TYPE_BD = 1来取数据 -->
            <td align="left">
                <input type="text" class="text_field" name="last_claim_user_name" id="last_claim_user_name"/>
            </td>
            <td align="right"><fmt:message key='inc_amout'/></td>
            <td align="left">
                <input type="text" class="text_field_half" name="inc_amout_from"   id="inc_amout_from" maxLength="15" onKeyUp="if(isNaN(value))execCommand('undo')" inputName="到款金额"  style="width: 80px"/>&nbsp;到&nbsp;<input type="text" class="text_field_half" maxLength="15"  onKeyUp="if(isNaN(value))execCommand('undo')" name="inc_amout_to" id="inc_amout_to" style="width: 80px"/>
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key='inc_date'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="inc_date_from"  id="inc_date_from" size="6"/>
                &nbsp;<fmt:message key='inc_date_to'/>&nbsp;<w:date format="yyyy-MM-dd" name="inc_date_to" id="inc_date_to" size="6"/>
            </td>
            <td align="right"><fmt:message key='claim_status_bd'/></td>
            <td align="left">
               <!-- CLAIM_STATUS_BD -->
               <d:select name="claim_status_bd" id="claim_status_bd" dictTypeId="CLAIM_STATUS_BD" nullLabel="-请选择-"></d:select>
            </td>
                <td align="right"><fmt:message key='voucher_status'/></td>
        <td align="left">
        	<d:select name="voucher_status" id="voucher_status" dictTypeId="VOUCHER_STATUS" nullLabel="--请选择--" style="width:190px"/>
        </td>
        </tr>
        <tr>
             <td align="center" colspan="6">
                <input name="button_ok" id="button_ok" class="icon_1"   type="button" value="<fmt:message key='button_query'/>" onClick="query();">
             </td>
        </tr>
</table>
<input type="hidden" name="ids" id="ids">
</div>

		
<div id="ccParent1" class="button" style="overflow: visible;"> 
 <div class="button_right">
	<!--<ul>
		<li class="d"><a  onClick="delIncom();">删除</a></li>
		<li class="b"><a  onClick="editIncom();">修改</a></li>
		<li class="xz"><a  onClick="downLoad_onClick();">下载模板</a></li>
		 上传<input type="button" class="foot_icon_1" value='模板下载' onClick="javascript:downLoad_onClick();"> 
		<li class="p_1">
         <a id="updateIncoming" href="###" onclick="showUploadincomPage();">上传到账信息</a>
        </li>
        <li class="p_1">
         <a id="showExc" href="###" onclick="showUploadException();">查看上传错误信息</a>
        </li>
	</ul>
	<input class="d" type="button" value="TEST" onclick="test4jdbcandproc();"/>
	-->
	<div style="width: 1050px;">
		<input class="c"  type="button"   value="<fmt:message key='button_insert'/>"   <au:authorityBtn code="dkfb_add" type="1"/> onClick="toAdd_onClick();">
		<input class="d" type="button"   value="<fmt:message key='button_delete'/>"  <au:authorityBtn code="dkfb_del" type="1"/>  onClick="delIncom();">
	    <input class="b" type="button"   value="<fmt:message key='button_update'/>"  <au:authorityBtn code="dkfb_xg" type="1"/>  onClick="editIncom();">
	    <input class="dj_3"  type="button"   value="导出"   <au:authorityBtn code="dkfb_export" type="1"/> onClick="exportIncomingToExcel();">
	    <input class="xz_1" type="button"   value="<fmt:message key='button_xzmb'/>"  <au:authorityBtn code="dkfb_xzmb" type="1"/>  onClick="downLoad_onClick();">
	    <!-- <input class="p_1" type="button"   value="上传招行到账信息"  <au:authorityBtn code="dkfb_ccdzxx" type="1"/>  onClick="showUploadincomPage();"> -->   
	    <input type="button" id="importZH"  class="p_1" value="<fmt:message key='button_ccdzxx'/>" <au:authorityBtn code="dkfb_ccdzxx" type="1"/>  />
	    
	    <input class="xz_1" type="button"   value="<fmt:message key='button_xzghmb'/>" <au:authorityBtn code="dkfb_xzghmb" type="1"/>  onClick="downLoad_onClick1();">
	    
	    <input type="button" id="importGHLS"  class="p_1" <au:authorityBtn code="dkfb_scghlsmx" type="1"/>  value="<fmt:message key='button_scghlsmx'/>"/>
	    
	    <input class="xz_1" type="button"   value="<fmt:message key='button_xzghjrmxmb'/>"  <au:authorityBtn code="dkfb_xzghjrmxmb" type="1"/> onClick="downLoad_onClick2();">
    </div>
    <div style="padding-top: 5px">
    <input type="button" id="importGHJR"  class="p_1" <au:authorityBtn code="dkfb_scghjrmx" type="1"/> value="<fmt:message key='button_scghjrmx'/>"/>&nbsp;
    
    <!-- 中信到款 -->
    <input class="xz_1" type="button"   value="<fmt:message key='button_xzzxdkmx'/>"  <au:authorityBtn code="dkfb_xzghjrmxmb" type="1"/> onClick="downLoad_onClick3();">
    <input type="button" id="importZX"  class="p_1" <au:authorityBtn code="dkfb_scghjrmx" type="1"/> value="<fmt:message key='button_sczxdkmx'/>"/>
    
    <!-- add by sqp   2013年11月6日 11:43:06 添加三个银行的明细（杭州用,需要按钮权限）-->
    <!-- 建行 -->
    <input class="xz_1" type="button"   value="<fmt:message key='button_xzjhdkmx'/>"  <au:authorityBtn code="dkfb_xzjhjrmxmb" type="1"/> onClick="downLoad_onClick4();">
    <input type="button" id="importJH"  class="p_1" <au:authorityBtn code="dkfb_scjhjrmx" type="1"/> value="<fmt:message key='button_scjhdkmx'/>"/>
    <!-- 浦发 -->
    <input class="xz_1" type="button"   value="<fmt:message key='button_xzpfdkmx'/>"  <au:authorityBtn code="dkfb_xzpfjrmxmb" type="1"/> onClick="downLoad_onClick5();">
    <input type="button" id="importPF"  class="p_1" <au:authorityBtn code="dkfb_scpfjrmx" type="1"/> value="<fmt:message key='button_scpfdkmx'/>"/>
    
    <!-- 农行 -->
    <input class="xz_1" type="button"   value="<fmt:message key='button_xznhdkmx'/>"  <au:authorityBtn code="dkfb_xznhjrmxmb" type="1"/> onClick="downLoad_onClick6();">
    <input type="button" id="importNH"  class="p_1" <au:authorityBtn code="dkfb_scnhjrmx" type="1"/> value="<fmt:message key='button_scnhdkmx'/>"/>
   <!-- end -->
   
    <input class="p_1" type="button"   value="<fmt:message key='button_errpr'/>"  <au:authorityBtn code="dkfb_errpr" type="1"/>  onClick="showUploadException();">
    <input class="b_1" type="button"   value="<fmt:message key='button_voucher'/>"  <au:authorityBtn code="dkfb_voucher" type="1"/>  onClick="showVoucher();">
    <input class="p_1" type="button"   value="<fmt:message key='button_veoucrh_zb'/>"  <au:authorityBtn code="batch_veoucrh_zb" type="1"/>  onClick="batchCreateVoucher();">
    
    
    </div>
 </div>
<div class="clear" onclick=""></div>			
</div>

 <div style="padding: 5 0 8 8;">
        <r:datacell
            id="dcListIncoming"
            paramFormId="datacell_formid"
            queryAction="/FAERP/FININCOMINGAction.do?cmd=queryAll"
            submitAction="#"
            width="98%"
            height="319px"
            xpath="FININCOMINGVo"
            submitXpath="FININCOMINGVo"
            pageSize="90"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
			<r:field allowModify="false" fieldName="chk"
                label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
                sortAt="none" width="30px">
                <h:switchCheckbox name="chk" id="chk" checkedValue="1" uncheckedValue="0"/>
            </r:field>
            <r:field fieldName="inc_code" messagekey="inc_code" width="120px;"/>
            <r:field fieldName="inc_date" messagekey="inc_date" allowModify="false">
                <w:date format="yyyy-MM-dd"/>
            </r:field>
            <r:field fieldName="inc_cust_name" messagekey="inc_cust_name" width="300px;"></r:field>
            <r:field fieldName="inc_amout" messagekey="inc_amout" allowModify="false">
            </r:field>
            <r:field fieldName="inc_bank" messagekey="inc_bank" allowModify="false">
                <d:select dictTypeId="BANK"></d:select>
            </r:field>
            <r:field fieldName="upload_desc" messagekey="abstract_demo" width="120px;"/>
            <r:field fieldName="last_claim_cust_name" messagekey="last_claim_cust_name" width="300px;"></r:field><!-- 最后认领的对应的客户名称 -->
            <r:field fieldName="user_name" messagekey="user_name"></r:field>
            <r:field fieldName="upload_date" messagekey="upload_date" width="150px;" allowModify="false">
                <w:date name="upload_date" />
            </r:field>
            <r:field fieldName="last_claim_date" messagekey="last_claim_date" width="150px;" allowModify="false">
                <w:date name="last_claim_date" />
            </r:field>
            <r:field fieldName="claim_status_bd" messagekey="claim_status_bd" allowModify="false">
                <d:select dictTypeId="CLAIM_STATUS_BD"></d:select>
            </r:field>
            <r:field fieldName="voucher_status" messagekey="voucher_status" width="90px">
				<d:select dictTypeId="VOUCHER_STATUS"></d:select>
			</r:field>
			<r:field fieldName="voucher_ym" messagekey="voucher_ym" width="90px">
			</r:field>
        </r:datacell>
    </div>
</div>
</div>
</form>
<div id="dialog" class="black_backgroud_div">
    <div class="dialog_div" style="width: 200px; height:100px;">
    <div class="dialog_div_title">选择日期</div>
    <div style=" text-align:center; vertical-align:middle;margin:15px 0px;">
        <span style="height:17px;vertical-align:middle;"> 请选择:</span>
        <%
            String CurrentTimestamp= MyUtils.Timestamp2String(MyUtils.getCurrentTimestamp(), MyUtils.DEFAULT_DATE);
            request.setAttribute("CurrentTimestamp", CurrentTimestamp);
        %>
        <w:date format="yyyy-MM-dd" id="create_date" name="create_date"  value="${requestScope.CurrentTimestamp}" width="70px"/>
    </div>
    <div>
        <input type="button" class="icon_1" value="确定" onclick="doSetDate()"/>
        <input type="button" class="icon_1" value="取消" onclick="hiddenBg()"/>
    </div>
    <br/>
</div>
</div>
</body>
</html>
<script language="javascript">
    /****下载模板***/
    function downLoad_onClick(){
        form.action=venusbase+"/FININCOMINGAction.do?cmd=downLoadExcel";
        form.submit();
    }
    function downLoad_onClick1(){
        form.action=venusbase+"/FININCOMINGAction.do?cmd=downLoadExcel1";
        form.submit();
    }
    function downLoad_onClick2(){
        form.action=venusbase+"/FININCOMINGAction.do?cmd=downLoadExcel2";
        form.submit();
    }
    
   function downLoad_onClick3(){
        form.action=venusbase+"/FININCOMINGAction.do?cmd=downLoadExcel3";
        form.submit();
    }
      function downLoad_onClick4(){
        form.action=venusbase+"/FININCOMINGAction.do?cmd=downLoadExcel4";
        form.submit();
    }
      function downLoad_onClick5(){
        form.action=venusbase+"/FININCOMINGAction.do?cmd=downLoadExcel5";
        form.submit();
    }
      function downLoad_onClick6(){
        form.action=venusbase+"/FININCOMINGAction.do?cmd=downLoadExcel6";
        form.submit();
    }
    
    jQuery(document).ready(function(){
        $id("dcListIncoming").isQueryFirst = false;
	    jQuery("#importZH").bind("click", function(){
	       vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finincoming/importZHExcel.jsp?type=1", "", "dialogWidth=600px; dialogHeight=250px");
	       if (vReturnValue == '1') {
	            jQuery("#button_ok").click();
	       }
	      }
	    );
	    
	    jQuery("#importGHLS").bind("click", function(){
	       vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finincoming/importZHExcel.jsp?type=2", "", "dialogWidth=600px; dialogHeight=250px");
	       if (vReturnValue == '1') {
	            jQuery("#button_ok").click();
	       }
	      }
	    );
	    
	    jQuery("#importGHJR").bind("click", function(){
	       vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finincoming/importZHExcel.jsp?type=3", "", "dialogWidth=600px; dialogHeight=250px");
	       if (vReturnValue == '1') {
	            jQuery("#button_ok").click();
	       }
	      }
	    );
	    
        jQuery("#importZX").bind("click", function(){
           vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finincoming/importZHExcel.jsp?type=4", "", "dialogWidth=600px; dialogHeight=250px");
           if (vReturnValue == '1') {
                jQuery("#button_ok").click();
           }
          }
        );
	/*******************5  建行 ，  6  浦发   ，7 农行 add by sqp******************/
	    jQuery("#importJH").bind("click", function(){
           vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finincoming/importZHExcel.jsp?type=5", "", "dialogWidth=600px; dialogHeight=250px");
           if (vReturnValue == '1') {
                jQuery("#button_ok").click();
           }
          }
        );
     jQuery("#importPF").bind("click", function(){
           vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finincoming/importZHExcel.jsp?type=6", "", "dialogWidth=600px; dialogHeight=250px");
           if (vReturnValue == '1') {
                jQuery("#button_ok").click();
           }
          }
        );
      jQuery("#importNH").bind("click", function(){
           vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/finance/receivable/finincoming/importZHExcel.jsp?type=7", "", "dialogWidth=600px; dialogHeight=250px");
           if (vReturnValue == '1') {
                jQuery("#button_ok").click();
           }
          }
        );
	
	   });

    //addd by yuanzhe 20160203
    function doSetDate() {
        hiddenBg();
        var ids = selectIds1();
        if(ids == null || ids == '') {
            alert("<fmt:message key='alert_select_one'/>");
            return;
        }
        var v_date = _$("#create_date_input").val();
        var openWindow = window.open(encodeURI('<%=request.getContextPath()%>/U8_voucher_remarkAction.do?cmd=batchCreateucherIncoming&incoming_id='+ids+'&vtype=收&vtitle=收款凭证&buztype=0&voucher_gs=002&date='+v_date),'选择制单日期','height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no','_blank');
        refreshTableWhenTheWindowClose(openWindow);
    }

    //add by yuanzhe 20160203
    function hiddenBg() {
        _$("select").show();
        document.getElementById("dialog").style.display="none";
    }

    //add by yuanzhe 20160203
    function showBg(){
        _$("select").hide();
        document.getElementById("dialog").style.display="block";
        document.getElementById("dialog").style.width = document.body.clientWidth;
        document.getElementById("dialog").style.height = document.body.clientHeight + document.body.offsetHeight;
    }

    //add by yuanzhe 20160203
    function refreshTableWhenTheWindowClose(w){
        var timer = setInterval(function(){
            if (w.closed) {
                clearInterval(timer);
                query();
            }
        },50);
    }
/**
 * 预览凭证
 */
function showVoucher(){
    var dc = $id("dcListIncoming");
    //var entity = dc.getActiveEntity();
    
    var ids = selectIds1();
    if(ids == null || ids == '') {
        alert("<fmt:message key='alert_select_one'/>");
        return;
    }
    
    if(ids.length>1){
        alert("<fmt:message key='alert_only_one'/>");
        return;
    }
    
    var incoming_id = ids[0] ;//entity.getValue("id");
   	if (incoming_id) {
        //w为窗口宽度，h为高度
        var w = 815;
        var h = 460;
        var l = 70;
        var t = 70;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
        var url = "/FAERP/U8_voucher_remarkAction.do?cmd=showVoucherIncoming&incoming_id=" + incoming_id +"&vtype=收"+"&vtitle=收款凭证"+"&buztype=0&voucher_gs=002";;
        url = encodeURI(url);
        var newWindow = window.open(url, 'newwindow', s);
        refreshTableWhenTheWindowClose(newWindow);
   }
}

     function retCallback() {
        query();
     }
     ////批量提交
     function batchCreateVoucher(){
        showBg();
     }




	function selectIds1() {
	    var myids = new Array(0);
	    var dc = $id("dcListIncoming");
	    var ds = dc.dataset;
	    _$("input[type='checkbox']").each(function(i) {
	        //第0个为全选按钮
	        if (i != 0 && _$(this).attr("checked")) {
	            var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
	            var entity = dc.getEntity(row);
	            //此id为post_id
	            //myids += entity.getValue("id") + ",";
	            myids.push(entity.getValue("id"));
	        }
	    });
	    return myids;
	}
	
	 //到款发布导出
      function exportIncomingToExcel(){
	         var inc_cust_name =  _$("#inc_cust_name").val(); //到款公司
	         var last_claim_user_name =  _$("#last_claim_user_name").val(); //客服
	         var inc_amout_from =  _$("#inc_amout_from").val(); //到款金额
	         var inc_amout_to =  _$("#inc_amout_to").val(); //到款金额
	         var inc_date_from =  _$("#inc_date_from_hidden").val(); //到款日期
	         var inc_date_to =  _$("#inc_date_to_hidden").val(); //到款日期
	         var claim_status_bd =  _$("#claim_status_bd").val(); //认领状态
	         var voucher_status =  _$("#voucher_status").val(); //凭证状态
	         if( (inc_cust_name == "" || inc_cust_name== null) && (last_claim_user_name == "" || last_claim_user_name== null) &&(inc_amout_from == "" || inc_amout_from== null) &&(inc_amout_to == "" || inc_amout_to== null) &&(inc_date_from == "" || inc_date_from== null) &&(inc_date_to == "" || inc_date_to== null) &&(claim_status_bd == "" || claim_status_bd== null) &&(voucher_status == "" || voucher_status== null)  ){
	           alert("不输入任何条件会导致数据量过大，造成导出失败，请输入相应的查询条件！");
	           return;
	         }
	         form.action="<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=exportIncomingToExcel&inc_cust_name="+encodeURI(inc_cust_name)+"&last_claim_user_name="+
	                             encodeURI(last_claim_user_name)+"&inc_amout_from="+inc_amout_from+"&inc_amout_to="+inc_amout_to+"&inc_date_from="+
	                             inc_date_from+"&inc_date_to="+inc_date_to+"&claim_status_bd="+claim_status_bd+"&voucher_status="+
	                             voucher_status;
	         form.submit();
      }
	
</script>	
</fmt:bundle>