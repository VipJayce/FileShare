<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.finance.received.fininvoice.fininvoice_resource" prefix="rayoo.finance.received.fininvoice.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='nobillfininvoice_search'/></title>
<script language="javascript">
    jQuery(document).ready(function() {
        jQuery("#inc_date_from_input").dblclick(function(){
            jQuery(this).val("2014-01-01");
        });
    });
    //第一次不加载数据
    jQuery(function(){
        $id("datacell1").isQueryFirst = false;
        //$id("celllist1").isQueryFirst = false;
    });

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }

   function ClickRow(tid){
       $id("celllist1").addParam("incoming_id",tid);
       reloadDateCell();
    }
    //查询数据
    function showListData(){
        $id("datacell1").addParam("invoice_status",jQuery("#invoice_status").val());
        $id("datacell1").addParam("certificate_status",jQuery("#certificate_status").val());
        $id("datacell1").addParam("red_vouchar_status",jQuery("#redVoucharStatus").val());
        $id("datacell1").addParam("is_del",jQuery("#is_del").val())
        reloadDateCell();
    }

    function reloadDateCell() {
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }

    //导出数据
     function exportToExcel() {
         if(confirm("<fmt:message key='exporttoexl'/>")) {
             form.action="<%=request.getContextPath()%>/FinclaimAction.do?cmd=exportToExcelNoBill&invoice_status="+jQuery("#invoice_status").val()+
             "&certificate_status="+jQuery("#certificate_status").val() + "&is_del="+jQuery("#is_del").val()+"&red_vouchar_status="+jQuery("#redVoucharStatus").val();
                form.submit();
          }
      }




        //无账单开票
        function no_Bill_Fininvoice(flag) {
                    var entity = selectEntity();
                    var title;//弹出框title
                    var incoming_id;
                    var claim_id;
                    if(flag==0){
                          if(!entity){
                               alert("<fmt:message key='alert_select_one'/>");
                               return;
                          }
                          if(entity.getValue("invoice_status_bd") == 3){
                                alert("已开票的不允许重复开票");
                                return;
                          }
                          title = "无账单开票";
                          incoming_id = entity.getValue("incoming_id");
                          claim_id = entity.getValue("id");
                    }else{
                          title = "无认领开票";
                    }
                    var strUrl = "<%=request.getContextPath()%>/FinclaimAction.do?cmd=showFininvoicePageByIncomingId&claim_id=" +claim_id+"&incoming_id="+incoming_id+"&no_amount_flag="+flag;
                    showModalCenter(strUrl, "", show_callback, "880", "450", title);//showReceivable_callback
        }

        function show_callback(value) {
            $id("datacell1").reload();
        }


      function selectEntity() {
            var dc = $id("datacell1");
            var entity = dc.getActiveEntity();
            return entity;
        }

    //modify by yuanzhe 20160307
    function generateVoucher(isFullPage) {
        var ids = getIds(isFullPage);
        if (!ids) {
            if (isFullPage) {
                alert("当前页没有数据,请修改查询参数重新查询。");
                return;
            } else {
                alert("<fmt:message key='alert_select_one'/>");
                return;
            }
        }
        if (confirm("主人，您真的要对你选的数据生成凭证吗？如果确定小E就帮你生成咯！")) {
            var url = "<%=request.getContextPath()%>/FinclaimAction.do";
            jQuery.post(url, {'cmd': 'generateVoucher', 'claimIds': ids}, function (retData) {
                alert(retData);
                if (retData.indexOf("完成") >= 0) {
                    reloadDateCell();
                }
            });
        }
    }

    //modify by yuanzhe 20160307
    function generateRedVoucher(isFullPage) {
        var ids = getIds(isFullPage);
        if (!ids) {
            if (isFullPage) {
                alert("当前页没有数据,请修改查询参数重新查询。");
                return;
            } else {
                alert("<fmt:message key='alert_select_one'/>");
                return;
            }
        }
        if (confirm("主人，您真的要对你选的数据生成凭证吗？如果确定小E就帮你生成咯！")) {
            var url = "<%=request.getContextPath()%>/FinclaimAction.do";
            jQuery.post(url, {'cmd': 'generateRedVoucher', 'claimIds': ids}, function (retData) {
                alert(retData);
                if (retData.indexOf("完成") >= 0) {
                    reloadDateCell();
                }
            });
        }
    }

    //modify by yuanzhe 20160307
    function getIds(isFullPage) {
        var ids = [];
        if (isFullPage) {
            var allPageIds = getIdListInThisPage();
            if (allPageIds.length > 0){
                ids = allPageIds;
            }
        } else {
            var entity = selectEntity();
            if (!!entity) {
                ids[0] = entity.getValue("id");
            }
        }
        return ids;
    }

    //modify by yuanzhe 20160307
    function getIdListInThisPage() {
        var ids = [];
        var dc = $id("datacell1");
        var ds = dc.table.tBodies[0].rows;
        if (ds.length > 0) {
            for(var i = 0; i < ds.length ; i++) {
                var row = ds[i];
                var entity = dc.getEntity(row);
                ids[i] = entity.getValue("id");
            }
        }
        return ids;
    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='title_nobillfininvoice'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="132" rowspan="6" style="padding-top:0;"><div class="search_title"><fmt:message key='billothers_search'/></div> </td>
            <td width="85"/>
            <td width="196"/>
              <td width="143">    </td>
                <td width="240"/>
        </tr>
                <tr>
            <td align="right"><fmt:message key='inc_code'/></td>
            <td align="left"><input type="text" class="text_field" name="inc_code" inputName="到款编号" maxLength="10" value="" style="width: 180px;"/>			</td>
            <td align="right"><fmt:message key='inc_cust_name'/></td>
            <td align="left">
                    <input type="text" class="text_field" name="inc_cust_name" inputName="到款公司名称" maxLength="30" value="" style="width: 180px;"/>
             </td>
            <td align="right"><fmt:message key='last_claim_cust_name'/></td>
            <td align="left">
            <input type="text" class="text_field" name="last_claim_cust_name" inputName="客户名称" maxLength="30" value="" style="width: 180px;"/>
            </td>
        </tr>


        <tr>
            <td align="right"><fmt:message key='inc_date'/></td>
            <td align="left">
                <w:date format="yyyy-MM-dd" id="inc_date_from" name="inc_date_from" width="66px"/><fmt:message key='inc_date_from_to'/><w:date format="yyyy-MM-dd" name="inc_date_to" width="66px"/>
            </td>
            <td align="right"><fmt:message key='inc_amout_from_'/></td>
                        <td align="left">
                        <input type="text" class="text_field"  style="width:80px" name="inc_amout_from" value="" maxLength="15" onKeyUp="if(isNaN(value))execCommand('undo')"  id="transact_day_from"/>到&nbsp;<input type="text" class="text_field" style="width:80px" maxLength="15" onKeyUp="if(isNaN(value))execCommand('undo')"  name="inc_amout_to" value=""  id="transact_day_to" />
                        </td>
            <td align="right"><fmt:message key='claim_amount_from'/></td>
                        <td align="left">
                        <input type="text" class="text_field"  style="width:80px" name="claim_amount_from" value="" maxLength="15" onKeyUp="if(isNaN(value))execCommand('undo')"  id="claim_amount_from"/>到&nbsp;<input type="text" class="text_field" style="width:80px" maxLength="15" onKeyUp="if(isNaN(value))execCommand('undo')"  name="claim_amount_to" value=""  id="claim_amount_to" />
                        </td>
        </tr>

        <tr>
            <td align="right"><fmt:message key='username'/></td>
            <td align="left"><input type="text" class="text_field" name="username" maxLength="20" value="" style="width: 180px;"/>         </td>
            <td align="right">开票状态</td>
            <td align="left">
                <select id="invoice_status" style="width: 180px;">
                    <option value="1">未开票</option>
                    <option value="3">已开票</option>
                    <option value="">全部</option>
                </select>
            </td>
            <td align="right">认领日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="claim_date_from" width="66px"/>到<w:date format="yyyy-MM-dd" name="claim_date_to" width="66px"/>
            </td>
        </tr>
        <tr>
             <td align="right">
                 凭证状态
             </td>
              <td align="left">
              <select id="certificate_status" style="width: 180px;">
                    <option value="">--请选择--</option>
                    <option value="0">未生成</option>
                    <option value="1">已生成</option>
                </select>
             </td>
            <td align="right">
                红冲凭证状态
            </td>
            <td align="left">
                <select id="redVoucharStatus" style="width: 180px;">
                    <option value="">--请选择--</option>
                    <option value="0">未生成</option>
                    <option value="1">已生成</option>
                </select>
            </td>
             <td align="right">
                 认领状态
             </td>
            <td align="left">
                <select id="is_del" style="width: 180px;">
                    <option value="0">正常认领</option>
                    <option value="1">取消认领</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="6" align="center">
                <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
            </td>
        </tr>
</table>
</div>
</form>

<div id="ccParent1" class="button">
 <div class="button_right">
                <input class="dj_3" type="button"   value="<fmt:message key="title_nobillfininvoice"/>"  <au:authorityBtn code="ssgl_wzdkp" type="1"/>   onclick="no_Bill_Fininvoice(0);"  >
                <input class="dj_3" type="button"   value="无认领开票"      <au:authorityBtn code="ssgl_wrlkp" type="1"/>  onclick="no_Bill_Fininvoice(1);"  >
                <input class="e" type="button"   value="<fmt:message key="export"/>"  <au:authorityBtn code="ssgl_wzdkp" type="1"/>   onclick="javascript:exportToExcel();"  >
                <input class="dj_3" type="button"   value="生成单个凭证"  <au:authorityBtn code="ssgl_gv_single" type="1"/>   onclick="javascript:generateVoucher(false);"  >
                <input class="dj_3" type="button"   value="生成整页凭证"  <au:authorityBtn code="ssgl_gv_all" type="1"/>   onclick="javascript:generateVoucher(true);"  >
                <input class="dj_3" type="button"   value="红冲单个凭证"  <au:authorityBtn code="ssgl_grv_single" type="1"/>   onclick="javascript:generateRedVoucher(false);"  >
                <input class="dj_3" type="button"   value="红冲整页凭证"  <au:authorityBtn code="ssgl_grv_all" type="1"/>   onclick="javascript:generateRedVoucher(true);"  >
         </div>
           <div class="clear"></div>
</div>

<div style="padding: 8 0 8 8;">
        <r:datacell
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FinclaimAction.do?cmd=searchDataFinClaim"
        width="98%"
        height="318px"
        xpath="FinclaimVo"
        readonly="true"
        pageSize="100"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field fieldName="inc_code" messagekey="inc_code" width="85px">
        <h:text/>
      </r:field>
      <r:field fieldName="inc_cust_name" messagekey="inc_cust_name" width="180px" >
        <h:text/>
      </r:field>
      <r:field fieldName="inc_amout" messagekey="inc_amout_from_" width="90px">
        <h:text/>
      </r:field>
      <r:field fieldName="inc_date" messagekey="inc_date"  width="90px">
        <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="last_claim_cust_name" messagekey="last_claim_cust_name" width="180px;">
      </r:field>
      <r:field fieldName="claim_amount" messagekey="claim_amount_from" width="90px">
        <h:text/>
      </r:field>
      <r:field fieldName="claim_user_id" messagekey="username" width="90px">
        <h:text/>
      </r:field>
      <r:field fieldName="claim_year_month" messagekey="claim_year_month" width="60px">
      </r:field>
      <r:field fieldName="create_date" messagekey="create_date_"  width="140px;">
        <w:date format="yyyy-MM-dd HH:mm:ss"/>
      </r:field>
      <r:field fieldName="claim_desc" messagekey="claim_desc" width="180px;">
       <h:text/>
      </r:field>
      <r:field fieldName="inc_bank" label="银行" width="80px;">
      </r:field>
      <r:field fieldName="invoice_status_bd" label="开票状态" width="80px;">
        <d:select dictTypeId="INVOICE_STATUS_BD" />
      </r:field>
      <r:field fieldName="is_del" label="认领状态" width="80px;">
        <d:select dictTypeId="CLAIM4VOUCHER_STATUS" />
      </r:field>
       <r:field fieldName="voucher_status" label="凭证状态" width="70px;">
        <d:select dictTypeId="VOUCHER_STATUS" />
      </r:field>
      <r:field fieldName="is_createvoucher" label="红冲凭证状态" width="90px;">
        <d:select dictTypeId="VOUCHER_STATUS" />
       </r:field>
      <r:field fieldName="last_update_user_id" label="最后操作人" width="80px;">
          <h:text/>
      </r:field>
      <r:field fieldName="last_update_date" label="最后操作时间" width="150px;">
          <h:text/>
      </r:field>
    </r:datacell>
    </div>
</div>
</div>
</fmt:bundle>
</body>
</html>

