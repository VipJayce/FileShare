<%@ page import="rayoo.finance.receivable.MyUtils" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<fmt:bundle basename="rayoo.finance.receivable.finclaim.finclaim_resource" prefix="rayoo.finance.receivable.finclaim.">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='title_finclaim'/></title>
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
<script language="javascript">
    var venusbase = "<%=request.getContextPath()%>";
    function queryData(){
           var inc_date_to_hid=_$("#inc_date_to_hid_input").val();
           var create_date_to_hid = _$("#create_date_to_hid_input").val();
           //alert(inc_date_to_hid);
            if(inc_date_to_hid!=undefined&&inc_date_to_hid!=""){
            _$("#inc_date_to").val(inc_date_to_hid+" 12:59:59");
            }
            if(create_date_to_hid!=undefined&&create_date_to_hid!=""){
            	_$("#create_date_to").val(create_date_to_hid+" 23:59:59")
            }
            //alert(_$("#inc_date_to").val());
            $id("dcListIncoming").reload();
      }
      
      

</script>

<script language="javascript" src="<venus:base/>/jsp/faerp/finance/receivable/finclaim/listFinclaim.js"></script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" ><!-- action="FinclaimAction.do?cmd=exportExcelFromIncoming" -->
    <input type="hidden" id="batchType" />
<div id="right">
<script language="javascript">
    writeTableTopFesco("认领列表",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="132" rowspan="5" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
        <td colspan="5"/>
    </tr>
  <tr>
      <td align="right"><fmt:message key='inc_amout'/></td>
      <td align="left">
          <input type="text" class="text_field_half" name="inc_amout_from" style="width: 93px"/><fmt:message key='inc_date_to'/><input type="text" class="text_field_half" name="inc_amout_to" style="width: 93px"/>
      </td>
      <td align="right"><fmt:message key='inc_date'/></td>
      <td align="left"><input type="hidden" value="" id="inc_date_to" name="inc_date_to"/>
          <w:date id="inc_date_from" name="inc_date_from" format="yyyy-MM-dd" size="6" style="width: 78px"/><fmt:message key='inc_date_to'/><w:date id="inc_date_to_hid" name="inc_date_to_hid" format="yyyy-MM-dd" size="6" style="width: 78px"/>
      </td>
      <td align="right"><fmt:message key='last_claim_year_month'/></td>
      <td align="left">
          <input type="text" class="text_field" name="last_claim_year_month"/><!-- 费用账期 -->
      </td>
  </tr>
  <tr>
      <td align="right">认领金额</td>
      <td align="left">
           <input type="text" class="text_field_half" name="claim_amount_from" style="width: 93px"/><fmt:message key='inc_date_to'/><input type="text" class="text_field_half" name="claim_amount_to" style="width: 93px"/>
  
      </td>
      <td align="right">认领客户名称</td>
      <td>
            <input type="text" class="text_field" name="customer_name"/>
      </td>
      <td align="right"><fmt:message key='inc_cust_name'/></td>
      <td align="left">
          <input type="text" class="text_field" name="inc_cust_name"/><!-- 到款公司名称 -->
      </td>
  </tr>
  <tr>
         <td align="right"><fmt:message key='voucher_status'/></td>
        <td >
        	<d:select name="voucher_status" dictTypeId="VOUCHER_STATUS" nullLabel="--请选择--" />
        </td>
        <td align="right"><fmt:message key='last_claim_user_name_'/></td>
        <td align="left">
        <r:comboSelect id="last_claim_user_id" name="last_claim_user_id"
                       queryAction="/FAERP/CustServiceAction.do?cmd=getListData&id=${requestScope.kefuid }"
                       textField="name"
                       valueField="partyId"
                       xpath="CustServiceVo"
                       width="200px"
                       messagekey="please_select" />
         </td>
         <td align="right">认款日期</td>
         <td align="left"><input type="hidden" value="" id="create_date_to" name="create_date_to"/><w:date id="create_date_from" name="create_date_from" format="yyyy-MM-dd" size="6" style="width: 78px"/><fmt:message key='inc_date_to'/><w:date id="create_date_to_hid" name="create_date_to_hid" format="yyyy-MM-dd" size="6" style="width: 78px"/></td>
  </tr>
  <tr>
		<td align="right">认领状态</td>
		<td >
            <d:select name="is_del" dictTypeId="CLAIM4VOUCHER_STATUS"  value="0"/>
        </td>
        <td align="right">红冲凭证状态</td>
        <td >
            <d:select name="is_createvoucher" dictTypeId="TrueOrFalse" nullLabel="--请选择--" />
        </td>
        <td align="right"> 到款编号</td>
        <td >
            <input type="text" class="text_field" name="inc_code"/>
        </td>
        </tr>
        <tr>
        <td align="right" colspan="5"></td>
       <td  align="right">
          <input name="button_ok" id="button_ok" class="icon_1"   type="button" value="<fmt:message key='button_query'/>">
           <input type="button" class="icon_1" value="<fmt:message key='button_reset'/>" onClick="javascript:this.form.reset();queryData();">
       </td>
  </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
<input type="hidden" value="" id="incomingID" name="incomingID"/>
<div class="button_right">
  <!--<ul>
      <li class="c"><a>认领</a></li>
      <li class="f"><a>取消认领</a></li>
      <li class="e"><a>导出</a></li>
  </ul>

  <input class="c"  id="c_1" type="button"   value="认领"  <au:authorityBtn code="dkrl_rl" type="1"/>>
    -->
    
 
  <input class="b_1" type="button"   value="<fmt:message key='button_dkrl_voucher_rl'/>"    onClick="showVoucher();">
  <input class="p_1" type="button"   value="<fmt:message key='button_dkrl_batch_voucher'/>"  onClick="batchCreateVoucher();">
   <input class="b_1" type="button"   value="导出"  onClick="exportListData();">
   <input class="b_1" type="button"   value="<fmt:message key='button_dkrl_hongchongvoucher_rl'/>"    onClick="showVoucherHongChong();">
   <input class="p_1" type="button"   value="<fmt:message key='button_dkrl_batch_hongchongvoucher'/>"  onClick="batchCreateHongChongVoucher();">
</div>
<div class="clear"></div>           
</div>
 
<div style="padding: 5 0 8 8;">
    <r:datacell
        id="dcListIncoming"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FinclaimAction.do?cmd=queryClaimAll"
        width="98%"
        height="319px"
        xpath="FININCOMINGVo"
        pageSize="90"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
        <r:field allowModify="false" fieldName="chk"
                 label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
                 sortAt="none" width="30px">
            <h:switchCheckbox name="chk" id="chk" checkedValue="1" uncheckedValue="0"/>
        </r:field>
        <r:field fieldName="claim_amount" label="认领金额" width="100px;"/>
        <r:field fieldName="customer_code" messagekey="customer_code" width="100px;"/>
        <r:field fieldName="customer_name" messagekey="last_claim_cust_name" width="250px;"/>
        <r:field fieldName="last_claim_year_month" messagekey="last_claim_year_month_"/>
        <r:field fieldName="create_date" label="认领时间" width="140" allowModify="false">
            <w:date format="yyyy-MM-dd HH:mm:ss"/>
        </r:field>
        <r:field fieldName="last_claim_user_name" messagekey="last_claim_user_name_"/>
        <r:field fieldName="is_del" label="认领状态" width="90px" allowModify="false">
            <d:select dictTypeId="CLAIM4VOUCHER_STATUS"/>
        </r:field>
        <r:field fieldName="voucher_status" messagekey="voucher_status" width="90px">
            <d:select dictTypeId="VOUCHER_STATUS"/>
        </r:field>
        <r:field fieldName="voucher_ym" messagekey="voucher_ym" width="90px">
        </r:field>
        <r:field fieldName="is_createvoucher" label="红冲凭证状态" width="90px">
            <d:select dictTypeId="IS_CREATEVOUCHER"/>
        </r:field>
        <r:field fieldName="hongchongvoucher_ym" label="红冲凭证号" width="90px">
        </r:field>
        <r:field fieldName="inc_code" messagekey="inc_code" width="100px;"/>
        <r:field fieldName="inc_amout" messagekey="inc_amout" width="80px;"/>
        <r:field fieldName="inc_bank" messagekey="inc_bank" allowModify="false" width="50px;">
            <d:select dictTypeId="BANK"/>
        </r:field>
        <r:field fieldName="inc_date" messagekey="inc_date" allowModify="false" width="100px;">
            <w:date format="yyyy-MM-dd"/>
        </r:field>
        <r:field fieldName="inc_cust_name" messagekey="inc_cust_name" width="250px;"/>
        <r:field fieldName="upload_date" messagekey="upload_date" width="140" allowModify="false">
            <w:date format="yyyy-MM-dd HH:mm:ss"/>
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
            String CurrentTimestamp=MyUtils.Timestamp2String(MyUtils.getCurrentTimestamp(), MyUtils.DEFAULT_DATE);
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
    if(${msg != null && msg != ""}) {
        alert("${msg }");
    }
    
    _$(document).ready(function() {
        $id("dcListIncoming").isQueryFirst = false;
        _$("#inc_date_from_input").dblclick(function(){
            _$(this).val("2014-01-01");
        });
    });

    //addd by yuanzhe 20160203
    function doSetDate() {
        hiddenBg();
        var ids = selectIds();
        if(ids == null || ids == '') {
            alert("<fmt:message key='alert_select_one'/>");
            return;
        }
        var v_date = _$("#create_date_input").val();
        var v_type = _$("#batchType").val();
        var openWindow;
        if (!!v_type && v_type == "1") {
             openWindow = window.open('<%=request.getContextPath()%>/U8_voucher_remarkAction.do?cmd=batchCreateucherClaim&incoming_id='+ids+'&vtype='+encodeURI("转")+'&vtitle='+encodeURI("转账凭证")+'&buztype=0&voucher_gs=010&date='+v_date,'','height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no','_blank');
        } else if (!!v_type && v_type == "0") {
             openWindow = window.open('<%=request.getContextPath()%>/U8_voucher_remarkAction.do?cmd=batchCreateHongChongucherClaim&incoming_id=' + ids + '&vtype=' + encodeURI("转") + '&vtitle=' + encodeURI("转账凭证") + '&buztype=0&voucher_gs=010&date=' + v_date, '', 'height=400, width=600, top=300, left=300, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no', '_blank');
        }
        if (!!openWindow)
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

    //modify by yuanzhe 20160203
    function batchCreateVoucher(){
        var dc = $id("dcListIncoming");
        var entity = dc.getActiveEntity();
        var pz=entity.getProperty("is_del");
        if(pz=="1"){
            alert("取消认领的数据不能生成凭证！");
            return;
        }
        showBg();
        document.getElementById("batchType").value = "1";
    }

    //modify by yuanzhe 20160203
    function batchCreateHongChongVoucher(){
        var reflag=check_hongchong();
        if(reflag=="false"){
            alert("有数据不符合红冲凭证规则，请重新选择！");
            return;
        }
        showBg();
        document.getElementById("batchType").value = "0";
    }

    //add by yuanzhe 20160203
    function refreshTableWhenTheWindowClose(w){
        var timer = setInterval(function(){
            if (w.closed) {
                clearInterval(timer);
                queryData();
            }
        },50);
    }
/**
 * 预览凭证
 */
function showVoucher(){
	var dc = $id("dcListIncoming");
    var entity = dc.getActiveEntity();
    var claim_status=entity.getProperty("is_del");//作为预览界面控制凭证按钮是否可用的条件
    var ids = selectIds();
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
        var url = "/FAERP/U8_voucher_remarkAction.do?cmd=showVoucherClaim&incoming_id=" + incoming_id +"&vtype=转"+"&vtitle=转账凭证"+"&buztype=0&voucher_gs=010&claim_status="+claim_status;
        url = encodeURI(url);
       var openWindow = window.open(url, 'newwindow', s);
        refreshTableWhenTheWindowClose(openWindow);
   }
}

    function selectIds() {
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
    
      function checkAll(item) {
        if (_$(item).attr("checked")) {
            changeEntityChk(true);
            _$(":checkbox").attr("checked", true);
        } else {
            changeEntityChk(false);
            _$(":checkbox").attr("checked", false);
        }
    }
    
    function changeEntityChk(flag) {
	    var dc1 = $id("dcListIncoming").dataset;
	    var values = dc1.values;
	    for(var i=0; i<values.length; i++){
	        var entity = values[i];
	        entity.setProperty("chk", flag);
	    }
	}

 //列表导出
  function exportListData(){
	  var inc_date_to_hid=_$("#inc_date_to_hid_input").val();
	  var create_date_to_hid = _$("#create_date_to_hid_input").val();
 	  if(inc_date_to_hid!=undefined&&inc_date_to_hid!=""){
	    _$("#inc_date_to").val(inc_date_to_hid+" 12:59:59");
	  }
	  if(create_date_to_hid!=undefined&&create_date_to_hid!=""){
	      _$("#create_date_to").val(create_date_to_hid+" 23:59:59")
	  }
       form.action="<%=request.getContextPath()%>/FinclaimAction.do?cmd=export";
       form.submit();
  }
  /**********************************↓红冲系列↓*************************************/
  function showVoucherHongChong(){//预览红冲凭证
    var dc = $id("dcListIncoming");
    var entity = dc.getActiveEntity();
    var claim_status=entity.getProperty("is_del");//作为预览界面控制凭证按钮是否可用的条件
    var  pingzheng_status=entity.getProperty("voucher_status");
    var hongchong_status=entity.getProperty("is_createvoucher");
    var ids = selectIds();
    if(ids == null || ids == '') {
        alert("<fmt:message key='alert_select_one'/>");
        return;
    }
    
    if(ids.length>1){
        alert("<fmt:message key='alert_only_one'/>");
        return;
    }
        
    var incoming_id = ids[0] ;
    if (incoming_id) {
        //w为窗口宽度，h为高度
        var w = 815;
        var h = 460;
        var l = 70;
        var t = 70;
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=yes,location=no,status=no'; 
        var url = "/FAERP/U8_voucher_remarkAction.do?cmd=showHongChongVoucherClaim&incoming_id=" + incoming_id +"&vtype=转"+"&vtitle=转账凭证"+"&buztype=0&voucher_gs=010&claim_status="+claim_status+"&pingzheng_status="+pingzheng_status+"&hongchong_status="+hongchong_status;
        url = encodeURI(url);
       var openWindow = window.open(url, 'newwindow', s);
        refreshTableWhenTheWindowClose(openWindow);
    }
}

 function check_hongchong() {
        var myids = new Array(0);
        var dc = $id("dcListIncoming");
        var ds = dc.dataset;
        var  returnflag="true";
        _$("input[type='checkbox']").each(function(i) {
            //第0个为全选按钮
            if (i != 0 && _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                var hongchong=entity.getValue("is_createvoucher");
                var zhengchang=entity.getValue("voucher_status");
                var claim_status=entity.getValue("is_del");
                if(  claim_status=="0"  || hongchong=="1" || zhengchang=="0"  || zhengchang=="3" ){
                    returnflag="false";
                }
            }
        });
        return returnflag;
    } 
  
  
</script>
</fmt:bundle>
