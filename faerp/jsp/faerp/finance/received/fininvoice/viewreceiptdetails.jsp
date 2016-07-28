<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp" %>
<%@include file="/common/skins/skin0/component.jsp" %>
<%@include file="/jsp/faerp/finance/common.jsp" %>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>无标题文档</title>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/common.css"/>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/index.css"/>
        <script language="JavaScript" src="<%=request.getContextPath()%>/scripts/common.js"></script>
        <script language="JavaScript" src="../../scripts/common.js"></script>
        <script language="javascript"
                src="<venus:base/>/jsp/faerp/finance/received/fininvoice/viewbillingdetails.js"></script>
        <style type="text/css">
            tr.odd {
                background: #fff;
            }

            tr.even {
                background: #f9fcfd;
            }

            .box tr:hover, tr.hover {
                background: #c4e7f8;
            }

            .box tr:selected, tr.selected {
                background-color: #eef8ff;
                border-bottom-color: #daf1ff;
                border-right-color: #daf1ff;
            }

            .fex_row {
                LEFT: expression(document.getElementById('values_div').scrollLeft);
                POSITION: relative;
            }
        </style>
    </head>
    <%
        CostcenterVo cvo = request.getAttribute("pb_cost_center_vo") != null ? (CostcenterVo) request.getAttribute("pb_cost_center_vo") : new CostcenterVo();
        String open_invoice_bd = request.getAttribute("open_invoice_bd") == null ? "" : request.getAttribute("open_invoice_bd").toString();
    %><script type="text/javascript">
    var _jQuery = window.jQuery, _$ = window.$;
    jQuery.noConflict();
    function save_onClick() {
        var dataset1 = $id("celllist1").dataset;
        var len1 = dataset1.getLength();
        if (len1 < 1) {
            alert("您选择账单客户成本中心的发票模板设置可能有误！");
            return;
        }
        var invoice_amount = $id("invoice_amount").value;
        if (invoice_amount != null && (parseFloat(invoice_amount) <= 0)) {
            alert("开票金额不能等于或小于零");
            return;
        }
        var small_amount = document.getElementById("small_amount").value;//获取小额值 2014年3月14日
        var received_amount = "${requestScope.received_amount}";
        var rate_amount = "${requestScope.rate_amount}";
        var gather_flag = "${requestScope.gather_flag}";
        if (parseFloat(rate_amount) == 0) {//如果没有汇差，则检查金额 2014年4月22日
            if (gather_flag == "1") {
                if (parseFloat(received_amount) < parseFloat(invoice_amount)) {//2014年4月8日 如果开票总额大于实收金额，则不允许开票 sqp
                    alert("申请开票金额大于实收金额！");
                    return;
                }
            }
        }
        var invoice_desc = $id("invoice_desc").value;
        if (invoice_desc != "" && invoice_desc.length > 45) {
            alert("备注最多只能输入45个字符！");
            return false;
        }
        //获取开票属性
        var open_invoice = _$("#open_invoice").val();
        //获取是否需要快递
        var is_express = _$("#is_express").val();
        if (is_express == 1) {

            if ("${pb_cost_center_vo.contact_person}" == "" || "${pb_cost_center_vo.contact_person}" == null) {
                alert("需要快递发票则成本中心联系人不能为空!");
                return;
            }
            if ("${pb_cost_center_vo.contact_address}" == "" || "${pb_cost_center_vo.contact_address}" == null) {
                alert("需要快递发票则成本中心邮寄地址不能为空!");
                return;
            }
        }
        var receipt_title = document.getElementById("receipt_title").value;//text3
        var dc1 = $id("celllist1");
        //验证是否有负数开票项目
        var count = dc1.getCurrentRowCount();//当前已经存在的记录数
        for (var i = 0; i < count; i++) {
            var row = dc1.table.tBodies[0].rows[i];
            var entity = dc1.getEntity(row);
            var amount_item = entity.getValue("amount");//明细金额
            if (amount_item != null && amount_item != "" && amount_item < 0) {
                alert("收据明细金额不允许为负数!");
                return false;
            }
        }
        var cost_id = document.getElementById("cost_id").value;//2014年9月5日 增加
        document.getElementById("oprationDiv").style.display = "none";
        //将两个datacell的xml内容合并
        var action = "<%=request.getContextPath()%>/FinbillAction.do?cmd=saveDate";
        var xmlSubmit = dc1.dataset.toString();
        var myAjax = new Ajax(action);
        myAjax.addParam("bill_id", "${requestScope.bill_id}");
        myAjax.addParam("v_bill_id", "${requestScope.v_bill_id}");
        myAjax.addParam("cost_id", cost_id);
        myAjax.addParam("invoice_desc", invoice_desc);
        myAjax.addParam("invoice_amount", invoice_amount);
        myAjax.addParam("invoice_type", "3");
        myAjax.addParam("open_invoice", open_invoice);
        myAjax.addParam("template_id", "${template_id}");
        myAjax.addParam("small_amount", small_amount);
        myAjax.addParam("receipt_title", receipt_title);//2014年6月24日 添加
        myAjax.addParam("contact_person", $id("contact_person").value);
        myAjax.addParam("contact_address", $id("contact_address").value);
        myAjax.addParam("contact_tel1", $id("contact_tel1").value);

        //20160419 add param  @author yuanzhe 防止空指针>>
        myAjax.addParam("taxpayerIdType", '');
        myAjax.addParam("taxpayerIdNo", '');
        myAjax.addParam("taxRegAddr", '');
        myAjax.addParam("taxRegTelNo", '');
        myAjax.addParam("taxRegBank", '');
        myAjax.addParam("taxRegBankAccount", '');
        //20160419 add param <<

        myAjax.submitXML(xmlSubmit, 'UTF-8');
        var returnNode = myAjax.getResponseXMLDom();
        if (returnNode) {
            var re_Data = myAjax.getValue("root/data/returnValue");
            DWREngine.setAsync(false);//数据同步
            //多加了开票属性字段,0已经开票不需要再走审批流程！
            var reData = re_Data.split("|");
            if (reData[0] == "1") {
                alert("<fmt:message key='alert_apply_success'/>");
                //刷新当前页面
                window.opener.$id("celllist1").loadData();
                window.opener.$id("celllist1").refresh();
                window.close();
            } else if (reData[0] == "2") {
                var turl = "/FAERP/jsp/faerp/finance/receivable/finbill/confirmMsg.jsp?v_bill_id=${requestScope.v_bill_id}&bill_id=${requestScope.bill_id}&template_id=${template_id}&invoice_type=" + invoice_type;
                turl = turl + "&invoice_desc=" + invoice_desc + "&pb_cost_center_id=${pb_cost_center_vo.id}&invoice_amount=" + invoice_amount + "&small_amount=" + small_amount + "&receipt_title=" + receipt_title;
                turl = encodeURI(turl);
                showModalCenter(turl, "${requestScope.bill_id}", "", 300, 240, "预开票申请说明");
            } else if (reData[0] == "3") {
                alert("选择的账单与上次开票选择的账单数目不一致!");
                return;
            } else if (reData[0] == "4") {
                alert("选择的账单已经申请过开票不必重复申请!");
                return;
            } else if (reData[0] == "5") {
                alert("账单中有产品未在发票模板中配置!");
                return;
            } else if (reData[0] == "6") {
                alert("账单财务科目\n\n" + reData[1] + "\n\n未在发票Code中配置!");
                return;
            } else {
                alert(reData[1]);
                return;
            }
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
    function CurentDate() {
        var now = new Date();
        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate();            //日
        var hh = now.getHours();            //时
        var mm = now.getMinutes();          //分
        var clock = year + "-";
        if (day <= 25) {
            if (month < 10) {
                clock += "0";
            }
            clock += month + "-";
        } else {
            if (month < 10) {
                clock += "0";
            }
            clock += (month + 1) + "-";
        }
        if (day <= 25) {
            if (day < 10) {
                clock += "0";
            }
            clock += day + "";
        } else {
            clock += "01";
        }
        return (clock);
    }

    _$(document).ready(function () {
        var invoice_type = "${requestScope.invoice_type}";
        var received_amount = "${requestScope.received_amount}";
        if (invoice_type != "") {
            if (invoice_type == "1") {
                _$("#invoice_type1").attr("checked", "checked");
            } else if (invoice_type == "2") {
                _$("#invoice_type2").attr("checked", "checked");
            } else {
                _$("#invoice_type3").attr("checked", "checked");
            }
        }
        if (received_amount == 0) {//如果是未实收，则允许输入小额调整
            var flag = "${requestScope.fin_invoice_id}";
            //2014年6月6日  添加汇差属性的判断
            var sa = "${pb_cost_center_vo.is_remittance_error}";//是否有汇差属性
            if (sa == "") {//如果为空，则认为没有汇差
                sa = "0";
            }
            if ((flag == "" || flag == "null" || flag == null) && sa == "0") {
                //    document.getElementById("small_amount").disabled='';
            }
        }
        $id("celllist1").beforeEdit = function (cell, colIndex, rowIndex) {
            var fin_invoice_id = "${requestScope.fin_invoice_id}";
            var received_amount = "${requestScope.received_amount}";//实收金额
            var bill_amount = "${requestScope.bill_amount}";//账单金额
            //  var BILL_GATHER_STATUS_BD
            // 实收状态1部分实收2实收完成3未实收
            var bill_gather_status_bd = "${requestScope.bill_gather_status_bd}";
            if (received_amount == "") {
                received_amount = "0";
            }
            if (bill_amount == "") {
                bill_amount = "0";
            }
            if (fin_invoice_id != "") {
                return false;
            }
        }

        $id("celllist1").afterEdit = function (newValue, oldValue) {
            var datacell = $id("celllist1");
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
            var amount_old = datasettr.getProperty("amount_old");
            if (!checkFloat(newValue)) {
                alert('输入的金额必须为浮点型数值！');
                datasettr.setProperty("amount", amount_old);
                return;
            }
            //alert("newValue="+newValue+"________amount_old="+amount_old);
            if (parseFloat(amount_old) == 0) {
                alert("该账单已申请过开票，无其他金额可再次申请！");
                return;
            } else {
                if (parseFloat(newValue) < 0) {//2014年7月9日 添加
                    alert("输入的金额不能是负数！");
                    datasettr.setProperty("amount", amount_old);
                    return;
                }
                if (parseFloat(newValue) > parseFloat(amount_old)) {
                    alert('输入的金额不能大于' + amount_old + '！');
                    datasettr.setProperty("amount", amount_old);
                    return;
                }
            }
            //重新计算总额
            countAllMoney();
        }
    });

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

    function rtnFuncReceiptTitle(arg) {
        var lookup = $id("receipt_title");
        lookup.value = arg[0];
        lookup.displayValue = arg[0];
        //update by whj 2015-07-15 由于页面显示 但是这些字段在后台并没有保存 所以注释掉
        $id("contact_person").value = arg[3] == null ? "" : arg[3];//联系人
        $id("contact_address").value = arg[4] == null ? "" : arg[4];//联系地址
        $id("zip_code").value = arg[5] == null ? "" : arg[5];//邮编
        $id("contact_tel1").value = arg[6] == null ? "" : arg[6];//联系电话
        return false;
    }

    function do_ex() {//输入小额调整的页面运算
        var small_amount = document.getElementById("small_amount").value;//小额调整值
        var apply_invoice_amount = document.getElementById("invoice_amount_old").value;//申请金额()
        if (!checkFloat(small_amount)) {
            alert("输入的金额必须为浮点型数值！");
            document.getElementById("small_amount").value = '';
        } else {
            if (parseFloat(small_amount) > 10 || parseFloat(small_amount) < -10) {
                alert("输入的金额只能在-10和10之间！");
                document.getElementById("small_amount").value = '';
            } else {
                document.getElementById("invoice_amount").value = (parseFloat(apply_invoice_amount) + parseFloat(small_amount)).toFixed(2);//开票金额随小额变动 2014年7月3日 增加保存两位
            }
        }
    }
</script>
    <body>
    <form name="datacell_formid" id="datacell_formid" method="post">
        <input id="invoice_amount_old" name="invoice_amount_old" type="hidden" value="${requestScope.bill_amount}"/>
        <input id="cost_id" name="cost_id" type="hidden" value="${pb_cost_center_vo.id}"/>
        <input id="open_invoice" name="open_invoice" type="hidden" value="<%=open_invoice_bd%>"/>
        <input id="invoice_amount" name="invoice_amount" type="hidden" value="${requestScope.invoice_amount}"/>
        <input id="bill_amount" name="bill_amount" type="hidden" value="${requestScope.bill_amount}"/>
        <input id="received_amount" name="received_amount" type="hidden" value="${requestScope.received_amount}"/>
        <div id="right" style="height: 700px;overflow-y:scroll;">
            <w:panel id="panel1" title="收据基本信息">
                <div class="box_3">
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                        <c:if test="${empty ivo}">
                        <tr>
                            <td class="td_1">收据台头</td>
                            <td class="td_2" style="width:35%">
                                <w:lookup onReturnFunc="rtnFuncReceiptTitle" readonly="false"
                                          id="receipt_title" name="receipt_title" property="receipt_title"
                                          displayProperty="receipt_title"
                                          displayValue="${pb_cost_center_vo.receipt_title}"
                                          lookupUrl="/CustomersimpleAction.do?cmd=getReceiptTitleWithGroup&costid=${pb_cost_center_vo.customer_id}"
                                          height="440" width="600" style="width:280px" allowInput="false"/>
                            </td>
                            <td class="td_1">开票属性</td>
                            <% if (request.getAttribute("fin_invoice_id") != null) { %>
                            <td class="td_2" colspan="2">
                                <%=request.getAttribute("open_desc") %>
                            </td>
                            <%} else { %>
                            <td class="td_2" colspan="2">
                                <%=open_invoice_bd.equals("0") ? "系统开票" : "手动开票"%>
                            </td>
                            <%}%>
                        </tr>
                        </c:if>
                        <c:if test="${not empty ivo}">
                            <tr>
                                <td class="td_1">收据台头</td>
                                <td class="td_2" style="width:35%">
                                    <input name="receipt_title" id="receipt_title" type="hidden" value="${ivo.receipt_title}"/>${ivo.receipt_title}</td>
                                <td class="td_1">开票属性</td>
                                <% if (request.getAttribute("fin_invoice_id") != null) { %>
                                <td class="td_2" colspan="2">
                                    <%=request.getAttribute("open_desc") %>
                                </td>
                                <%} else { %>
                                <td class="td_2" colspan="2">
                                    <%=open_invoice_bd.equals("0") ? "系统开票" : "手动开票"%>
                                </td>
                                <%}%>
                            </tr>
                        </c:if>
                        <tr>
                            <td class="td_1">收据金额</td>
                            <td class="td_2" id="view_invoice_amount">${requestScope.invoice_amount}</td>
                            <td class="td_1">账单金额</td>
                            <td class="td_2">${requestScope.bill_amount}</td>
                        </tr>
                        <tr>
                            <td class="td_1">小额调整</td>
                            <td class="td_2"><input name="small_amount" type="text" class="sText"
                                                    id="small_amount" value="${requestScope.small_amount }"
                                    <c:if test="${requestScope.small_amount !=0 || requestScope.gather_flag ==1}"> disabled="disabled"</c:if>
                                                    style="width: 80%" onblur="do_ex()"/></td>
                            <td class="td_1">实收金额</td>
                            <td class="td_2">${requestScope.received_amount}</td>
                        </tr>
                        <tr>
                            <td class="td_1">备注</td>
                            <td class="td_2" style="height: 50px;">
                                <span style="padding-bottom: 50px;color: red;font-weight :bold;">（输入的内容会打印到收据中）</span></br>
                                <textarea name="invoice_desc" class="sText" style="width: 80%;height: 80px;;" id="invoice_desc"
                                       type="text" value="${requestScope.invoice_desc}"></textarea>
                            </td>
                            <td class="td_1">是否需要快递</td>
                            <td class="td_2">
                                <c:if test="${ empty ivo}">
                                    <input name="is_express" type="hidden"
                                           value="${pb_cost_center_vo.is_finance_send}"/>
                                    ${pb_cost_center_vo.is_finance_send == 1 ? '是' : '否'}
                                </c:if>
                                <c:if test="${not empty ivo}">
                                    <input name="is_express" type="hidden" value="${ivo.is_express}"/>
                                    ${ivo.is_express == 1 ? '是' : '否'}
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </div>
            </w:panel>
            <w:panel id="panelPost" title="邮寄信息">
                <div class="box_3">
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                        <c:if test="${empty ivo}">
                            <input id="contact_person" name="contact_person" type="hidden" value="${pb_cost_center_vo.contact_person}"/>
                            <input id="contact_tel1" name="contact_tel1" type="hidden" value="${pb_cost_center_vo.contact_tel1}"/>
                            <input id="contact_address" name="contact_address" type="hidden" value="${pb_cost_center_vo.contact_address}"/>
                            <input id="zip_code" name="zip_code" type="hidden" value="${pb_cost_center_vo.zip_code}"/>
                            <tr>
                                <td class="td_1">联系人</td>
                                <td class="td_2">${pb_cost_center_vo.contact_person}</td>
                                <td class="td_1">联系电话</td>
                                <td class="td_2">${pb_cost_center_vo.contact_tel1}</td>
                            </tr>
                            <tr>
                                <td class="td_1">邮寄地址</td>
                                <td class="td_2">${pb_cost_center_vo.contact_address}</td>
                                <td class="td_1">邮编</td>
                                <td class="td_2">${pb_cost_center_vo.zip_code}</td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty ivo}">
                            <input id="contact_person" name="contact_person" type="hidden" value="${ivo.contact_person}"/>
                            <input id="contact_tel1" name="contact_tel1" type="hidden" value="${ivo.contact_tel}"/>
                            <input id="contact_address" name="contact_address" type="hidden" value="${ivo.contact_address}"/>
                            <input id="zip_code" name="zip_code" type="hidden" value="${ivo.zip_code}"/>
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
                        </c:if>
                    </table>
                </div>
            </w:panel>
            <c:if test="${empty view}">
                <w:panel id="panel2" title="收据预览" expand="true">
                    <div id="div1" style="margin:10px 0px 0px 10px;">
                        <r:datacell
                                queryAction="/FAERP/FinverificationAction.do?cmd=getInvoiceSubsidiarySubject&fin_invoice_id=${requestScope.fin_invoice_id}&bill_ids=${requestScope.bill_id}&cost_center_id=${pb_cost_center_vo.id}&template_id=${template_id}&invoice_type=1"
                                id="celllist1"
                                paramFormId="datacell_formid"
                                width="99%" height="150px"
                                xpath="FinBillPublicVo" >
                            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                            <r:field fieldName="fin_small_subjects_bd" label="收据项目" width="200px" allowModify="false">
                                <h:text/>
                            </r:field>
                            <r:field fieldName="amount" label="金额" width="200px"
                                     onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                                <h:text/>
                            </r:field>
                        </r:datacell>
                    </div>
                </w:panel>
            </c:if>

            <!--  如果是查看明细 则直接从item表里查出来-->
            <c:if test="${not empty view}">
                <w:panel id="panel2" title="收据预览" expand="true">
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
                            <r:field fieldName="amount" label="金额" width="200px"
                                     onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                                <h:text/>
                            </r:field>
                        </r:datacell>
                    </div>
                </w:panel>
            </c:if>


            <% if (request.getAttribute("fin_invoice_id") != null) { %>
            <div id="values_div1" style="float:left; width:40%;height:200px; margin-top:5px;">
                <w:panel id="panel3" title="收据详细信息" expand="true">
                    <div id="div2" style="margin:10px 0px 0px 10px;">
                        <r:datacell
                                queryAction="/FAERP/FinverificationAction.do?cmd=getInvoiceSubject&fin_invoice_id=${requestScope.fin_invoice_id}"
                                id="celllist2"
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
                                id="celllist3"
                                paramFormId="datacell_formid"
                                width="98%" height="200px"
                                xpath="FinBillPublicVo"
                                readonly="true"
                        >
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

            <div id="oprationDiv" class="mx_button" style="text-align: center;padding-top:10px;"><!-- padding-top:10px; -->
                <c:if test="${not empty view}">
                    <input class="icon_2" type="button" id="printerbutton" value="打印发票" onClick="printer_onclick() ;">
                </c:if>
                <c:if test="${empty view}">
                    <input type="button" class="icon_2" name="butsav" value="确定" onClick="javascript:save_onClick()"/>
                </c:if>
                <input type="button" class="icon_2" value="关闭" onClick="javascript:window.close();">
            </div>
        </div>
    </form>
    </body>
</fmt:bundle>
</html>




