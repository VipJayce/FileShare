<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp" %>
<%@include file="/common/skins/skin0/component.jsp" %>
<%@include file="/jsp/faerp/finance/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>无标题文档</title>
        <link href="<%=request.getContextPath()%>/style/common.css" rel="stylesheet" type="text/css"/>
        <link href="<%=request.getContextPath()%>/style/index.css" rel="stylesheet" type="text/css"/>
        <style type="text/css">
            tr.odd {
                background: #fff;
            }
            tr.even {
                background: #f9fcfd;
            }

        </style>
    </head>
    <script type="text/javascript">
        var _jQuery = window.jQuery, _$ = window.$;
        jQuery.noConflict();
        //打印发票
        function printer_onclick() {
            if (confirm("<fmt:message key='alert_is_print'/>")) {
                var fin_invoice_id = "${requestScope.fin_invoice_id}";
                var voucher_bill_id = "${requestScope.voucher_bill_id}";//需要红冲的账单ID
                var url = "<%=request.getContextPath()%>/FininvoiceAction.do?cmd=printerInvoice&invoiceid=" + fin_invoice_id;
                jQuery.post(url, function (data) {
                    var reData = data.split("|");
                    if (reData[0] == "1") {
                        alert("<fmt:message key='alert_print_success'/>");
                        //生成红冲凭证
                        if (voucher_bill_id != null && voucher_bill_id != "") {
                            alert(createBillVoucher(voucher_bill_id));
                        }
                        $id("printerbutton").disabled = "";
                        window.close();
                        window.opener.simpleQuery_onClick();
                        return;
                    } else {
                        alert("<fmt:message key='alert_error'/>");
                        $id("printerbutton").disabled = "";
                        return;
                    }
                });
            }
        }

        //生成红冲凭证
        function createBillVoucher(bill_ids) {
            var _now = "${requestScope.currentDate}";
            var turl = "/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateBill&bill_ids=" + bill_ids + "&vtype=转" + "&vtitle=转账凭证" + "&buztype=0&voucher_type=hongchong";
            turl = turl + "&date=" + _now;
            turl = encodeURI(turl);
            jQuery.ajax({
                url: turl,
                type: 'GET',
                dataType: 'html',
                async: false,
                timeout: 10000,
                error: function (text) {
                    return text;
                },
                success: function (text) {
                    return text;
                }
            });
        }
    </script>
    <body>
    <form name="datacell_formid" id="datacell_formid" method="post">
        <div id="right" style="height: 700px;overflow-y:scroll;">
            <w:panel id="panel1" title="发票基本信息">
                <div class="box_3">
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                        <tr>
                            <td class="td_1">发票台头</td>
                            <td class="td_2">${ivo.receipt_title}</td>
                            <td class="td_1">开票属性</td>
                            <td class="td_2" style="width:40%;">
                                    ${requestScope.open_desc}
                            </td>
                        </tr>
                        <tr>
                            <td class="td_1">纳税人身份类型</td>
                            <td class="td_2">${ivo.taxpayer_id_type == '1' ? "增值税一般纳税人" : "非增值税一般纳税人"}</td>
                            <td class="td_1">纳税人识别号</td>
                            <td class="td_2">${ivo.taxpayer_id_no}</td>
                        </tr>
                        <tr>
                            <td class="td_1">客户地址</td>
                            <td class="td_2">${ivo.tax_reg_addr}</td>
                            <td class="td_1">客户电话</td>
                            <td class="td_2">${ivo.tax_reg_tel_no}</td>
                        </tr>
                        <tr>
                            <td class="td_1">客户开户行</td>
                            <td class="td_2">${ivo.tax_reg_bank}</td>
                            <td class="td_1">客户企业帐号</td>
                            <td class="td_2">${ivo.tax_reg_card_no}</td>
                        </tr>
                        <tr>
                            <td class="td_1">发票金额</td>
                            <td class="td_2">${ivo.invoice_amount}</td>
                            <td class="td_1">是否需要快递</td>
                            <td class="td_2">${ivo.is_express == 1 ? '是' : '否'}</td>
                        </tr>
                        <tr>
                            <td class="td_1">发票类型</td>
                            <td class="td_2">${ivo.invoice_type == 1 ? '专票' : '普票'}</td>
                            <td class="td_1">实收金额</td>
                            <td class="td_2">${requestScope.received_amount}</td>
                        </tr>
                        <tr>
                            <td class="td_1">账单金额</td>
                            <td class="td_2">${requestScope.bill_amount}</td>
                            <td class="td_1">小额调整</td>
                            <td class="td_2">${requestScope.small_amount}</td>
                        </tr>
                        <tr>
                            <td class="td_1">开票备注</td>
                            <td class="td_2" colspan="3">${requestScope.invoice_desc}</td>
                        </tr>
                    </table>
                </div>
            </w:panel>
            <w:panel id="panelPost" title="邮寄信息">
                <div class="box_3">
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                        <tr>
                            <td class="td_1">联系人</td>
                            <td class="td_2">${ivo.contact_person}</td>
                            <td class="td_1">联系电话</td>
                            <td class="td_2">${ivo.contact_tel}</td>
                        </tr>
                        <tr>
                            <td class="td_1">邮寄地址</td>
                            <td class="td_2">${ivo.contact_address}</td>
                            <td class="td_1">邮编</td>
                            <td class="td_2">${ivo.zip_code}</td>
                        </tr>
                    </table>
                </div>
            </w:panel>
            <w:panel id="listPanel" title="发票预览" expand="true">
                <div id="div1" style="margin:10px 0px 0px 10px;">
                    <r:datacell
                            queryAction="/FAERP/FinverificationAction.do?cmd=getInvoiceItem&fin_invoice_id=${requestScope.fin_invoice_id}"
                            id="celllist1"
                            paramFormId="datacell_formid"
                            width="99%" height="150px"
                            xpath="FinBillPublicVo">
                        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                        <r:field fieldName="fin_small_subjects_bd" label="开票项目" width="200px" allowModify="false">
                            <h:text/>
                        </r:field>
                        <r:field fieldName="amount" label="金额" width="200px" allowModify="false"
                                 onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})"/>
                        <r:field fieldName="vat_rate" label="税率" width="100px" defaultValue="6%" allowModify="false"/>
                        <r:field fieldName="vat_mount" label="税额" width="100px" allowModify="false"
                                 onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})"/>
                        <r:field fieldName="isBackCalc" label="是否系统倒算" width="100px" allowModify="false">
                            <d:select dictTypeId="TrueOrFalse"/>
                        </r:field>
                    </r:datacell>
                </div>
            </w:panel>
            <% if (request.getAttribute("fin_invoice_id") != null) { %>
            <div id="values_div1" style="float:left; width:40%;height:200px; margin-top:5px;">
                <w:panel id="panel3" title="发票详细信息" expand="true">
                    <div id="div2" style="margin:10px 0px 0px 10px;">
                        <r:datacell
                                queryAction="/FAERP/FinverificationAction.do?cmd=getInvoiceSubject&fin_invoice_id=${requestScope.fin_invoice_id}"
                                id="celllist3"
                                paramFormId="datacell_formid"
                                width="98%" height="200px"
                                xpath="FinBillPublicVo"
                                readonly="true">
                            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                            <r:field fieldName="fin_subjects_code" label="开票项目" width="200px" allowModify="false">
                                <d:select dictTypeId="FIN_SUBJECTS_BD"/>
                            </r:field>
                            <r:field fieldName="fin_small_subjects_bd" label="分类统计">
                                <d:select dictTypeId="FIN_SMALL_SUBJECTS_BD"/>
                            </r:field>
                            <r:field fieldName="amount" label="金额">
                                <h:text/>
                            </r:field>
                        </r:datacell>
                    </div>
                </w:panel>
            </div>

            <div id="values_div2" style="float:right; width:58%;height:200px;margin-top:5px;">
                <w:panel id="panel4" title="客户其他应收" expand="true">
                    <div id="div3" style="margin:10px 0px 0px 10px;">
                        <r:datacell
                                queryAction="/FAERP/FinverificationAction.do?cmd=getInvoiceOtherReceivable&fin_invoice_id=${requestScope.fin_invoice_id}"
                                id="celllist4"
                                paramFormId="datacell_formid"
                                width="98%" height="200px"
                                xpath="FinBillPublicVo"
                                readonly="true">
                            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                            <r:field fieldName="bill_year_month" label="应收年月" width="70px">
                                <h:text/>
                            </r:field>
                            <r:field fieldName="charge_item_bd" label="项目名称" width="220px">
                                <d:select dictTypeId="CHARGE_ITEM_BD"/>
                            </r:field>
                            <r:field fieldName="amount" label="金额" width="120px">
                                <h:text/>
                            </r:field>
                            <r:field fieldName="charge_desc" label="备注" width="320px">
                                <h:text/>
                            </r:field>
                        </r:datacell>
                    </div>
                </w:panel>
            </div>
            <%}%>
            <div style="text-align: center;padding-top:10px;width:100%;height:20px;">
                <input class="icon_2" type="button" id="printerbutton" value="打印发票"
                       onClick="printer_onclick() ;">
                <input type="button" class="icon_2" value="关闭" onClick="javascript:window.close();">
            </div>
        </div>
    </form>
    </body>
</fmt:bundle>
</html>




