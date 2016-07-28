<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp" %>
<%@include file="/common/skins/skin0/component.jsp" %>
<%@include file="/jsp/faerp/finance/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.finance.receivable.finbill.finbill_resource" prefix="rayoo.finance.receivable.finbill.">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>申请开票</title>
        <link href="<%=request.getContextPath()%>/css/common.css" rel="stylesheet" type="text/css"/>
        <link href="<%=request.getContextPath()%>/css/index.css" rel="stylesheet" type="text/css"/>
        <style type="text/css">
            #list_invoice table tr:nth-child(odd) td { background: #fff; }
            #list_invoice table tr:nth-child(even) td { background: #f9fcfd; }
            #list_invoice table tr:hover { background: #c4e7f8; }
            #list_invoice table tr:active { background-color: #eef8ff; border-bottom-color: #daf1ff; border-right-color: #daf1ff; }
        </style>
        <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
        <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
        <script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
        <script type='text/javascript' src="<%=request.getContextPath()%>/js/common.js"></script>
        <script type='text/javascript' src="../../js/common.js"></script>
        <script type='text/javascript' src="<venus:base/>/jsp/faerp/finance/received/fininvoice/invoice_validate.js"></script>
        <h:script src="/js/jquery/jquery-1.7.2.min.js"/>
    <script type="text/javascript">
        var _jQuery = window.jQuery, _$ = window.$;
        jQuery.noConflict();
        function save_onClick() {
            document.getElementById("btnSave").style.display = "none";
            //发票的抬头不能为空
            var cost_id = $id("cost_id").value;
            if (!cost_id) {
                alert("成本中心编号不正确，页面会重新刷新，重新获取成本中心信息。");
                window.opener.$id("celllist1").loadData();
                window.opener.$id("celllist1").refresh();
                window.close();
                return;
            }
            //如果是从手工开票界面跳转过来，必须选择收费单上传
            <c:if test="${requestScope.mustUpload == '1'}">
            var attackAddressInputValue = $id("attackAddressInput").value;
            if (!attackAddressInputValue) {
                alert("必须上传收费单。");
                return;
            }
            </c:if>
            //判断开票总金额是否为零，如果为零则不能提交
            var total_invoice_amount = $id("total_invoice_amount").innerText;
            var invoice_amount = parseFloat(total_invoice_amount);
            if (parseFloat(invoice_amount) <= 0) {
                alert("开票金额不能小于或等于零。");
                return;
            }

            //如果实收金额大于零，开票金额不能大于实收金额。
            var received_amount = "${requestScope.received_amount}";
            var rate_amount = "${requestScope.rate_amount}";
            var gather_flag = "${requestScope.gather_flag}";
            if (parseFloat(rate_amount) === 0) {//如果没有汇差，则检查金额 2014年4月22日
                if (gather_flag == "1") {
                    if (parseFloat(received_amount) < parseFloat(invoice_amount)) {//2014年4月8日 如果开票总额大于实收金额，则不允许开票 sqp
                        alert("申请开票金额大于实收金额！");
                        return;
                    }
                }
            }

            //发票的备注信息不能大于45个字符。
            var invoice_desc = $id("invoice_desc").value;
            if (invoice_desc !== "" && invoice_desc.length >= 46) {
                alert("发票备注最多只能输入45个字符！");
                return false;
            }

            //获取是否需要快递，如果需要快递需要在成本中心加入联系人和地址信息
            if ("${pb_cost_center_vo.is_finance_send}" === "1") {
                if ("${pb_cost_center_vo.contact_person}" === "" || "${pb_cost_center_vo.contact_person}" === "null") {
                    alert("需要快递发票则成本中心联系人不能为空!");
                    return;
                }
                if ("${pb_cost_center_vo.contact_address}" === "" || "${pb_cost_center_vo.contact_address}" === "null") {
                    alert("需要快递发票则成本中心邮寄地址不能为空!");
                    return;
                }
                if ("${pb_cost_center_vo.contact_tel1}" === "" || "${pb_cost_center_vo.contact_tel1}" === "null") {
                    alert("需要快递发票则成本中心联系电话不能为空!");
                    return;
                }
            }

            //获取提交明细信息
            var dataCell = $id("celllist1");
            var dataSet1 = dataCell.dataset;

            //如果提交的项目列表为空，则不能进行提交
            var len1 = dataSet1.getLength();
            if (len1 <= 0) {
                alert("对不起，您开具的发票没有查询到开票项，可能是由于数据愿意导致，请核查数据后重新开票或联系运维部门进行数据确认。");
                return;
            }

            //判断是否存在小额调整，如果存在则强制为开所有金额。
            var small_amount_input = $id("small_amount");
            if (!!small_amount_input) {
                var small_amount = small_amount_input.value;//获取小额值 2014年3月14日
                if (parseFloat(small_amount) > 0) {
                    var static_invoice = parseFloat($id("static_invoice_amount").value);
                    if (invoice_amount < static_invoice) {
                        alert("添加小额调整后，只能全额开票。");
                        Utils.common.backOldAmount(dataCell);
                        return;
                    }
                }
            }

            //增值票开据时，必须存在如下信息 -- 20160612 ljd modify  ： 在一般纳税仅开具普票时 可不维护部分信息
            if ("${pb_cost_center_vo.taxpayer_identity_type}" === "1" && Utils.validate.hasGeneralTaxpayer(dataCell)) {
                var taxpayerIdType = $id("taxpayer_idtype").innerHTML;
                var taxpayerIdNo = $id("taxpayer_idnum").innerHTML;
                var taxRegAddr = $id("taxpayer_adress").innerHTML;
                var taxRegTelNo = $id("taxpayer_telephone").innerHTML;
                var taxRegBank = $id("taxpayer_banktype").innerHTML;
                var taxRegBankAccount = $id("taxpayer_bankaccount").innerHTML;
                if (!taxpayerIdType || !taxpayerIdNo || !taxRegAddr || !taxRegTelNo || !taxRegBank || !taxRegBankAccount) {
                    alert("纳税人身份类型、纳税人识别号、客户地址、客户电话、客户开户行、客户开户行账号，\n以上都必须填写才能开据增值发票。\n请到成本中心输入以上内容后开票。");
                    return false;
                }
            }

            if ("${pb_cost_center_vo.taxpayer_identity_type}" !== "1" && Utils.validate.hasProInvoiceInNonGeneralTaxpayer(dataCell)) {
                alert("非一般纳税人不能含有专票");
                return;
            }

            //验证代收付不能开具专票
            if (Utils.validate.hasDSFApplyProfessInvoice(dataCell, "${pb_cost_center_vo.is_display_year_month}")) {
                alert("代收付不能开具专票。");
                return;
            }

            //验证税率不为零和每项的类型必选
            if (Utils.validate.validateTaxRateEqualsZero(dataCell)) {
                alert("存在增值税率为零的开票项，系统不允许开票。");
                return;
            }

            //验证是否有负数存在于开票项目
            if (Utils.validate.hasNegativeNumber(dataCell)) {
                alert("开票明细金额不允许为负数，系统不允许开票。");
                return false;
            }

            //验证完成保存发票信息
            var xmlSubmit = dataSet1.toString();
            commitData(xmlSubmit, function (myAjax) {//保存普票
                var re_Data = myAjax.getValue("root/data/returnValue");
                alertMessage(re_Data);//如果是全额开票则计算尾差
                var static_invoice_amount = $id("static_invoice_amount").value;
                var static_total_amount = parseFloat(static_invoice_amount);
                var apply_total_amount = parseFloat(total_invoice_amount);
                if (static_total_amount <= apply_total_amount) {
                    var myAjax = new Ajax("<%=request.getContextPath()%>/FinbillAction.do?cmd=calcDiffAmount");
                    myAjax.addParam("bill_id", "${requestScope.bill_id}");
                    myAjax.submit();
                    var returnNode = myAjax.getResponseXMLDom();
                    if (!returnNode) {
                        alert("尾差回写发生异常，请联系IT部门进行解决。");
                    }
                }
            });

            window.opener.$id("celllist1").loadData();
            window.opener.$id("celllist1").refresh();
            window.close();
        }

        //modify by zoe 20160510
        function alertMessage(re_Data) {
            var messagePair = {
                "1":"申请开票成功",
                "2":"预开票需要填写申请说明",
                "3":"选择的账单与上次开票选择的账单数目不一致!",
                "4":"选择的账单已经申请过开票不必重复申请!",
                "5":"账单中有产品未在发票模板中配置!",
                "6":"账单财务科目项未在发票Code中配置!"
            };
            var message = "";
            var messages = re_Data.split(",");
            messages.forEach(function(item){
                if (!!item) {
                    var reData = item.split("|");
                    var messageItem = messagePair[reData[0]];
                    if (!!messageItem) {
                        message += messageItem + "--" + reData[1] + "\n";
                    } else {
                        message += reData[0] + "--" + reData[1] + "\n";
                    }
                }
            });
            alert(message);
        }

        //modify by zoe 20160510
        function commitData(xmlSubmit, callback) {
            var myAjax = new Ajax("<%=request.getContextPath()%>/FinbillAction.do?cmd=saveDate");
            myAjax.addParam("bill_id", "${requestScope.bill_id}");
            myAjax.addParam("v_bill_id", "${requestScope.v_bill_id}");
            myAjax.addParam("cost_id", $id("cost_id").value);
            myAjax.addParam("invoice_desc", $id("invoice_desc").value);
            myAjax.addParam("open_invoice", $id("open_invoice").value);
            myAjax.addParam("template_id", "${template_id}");
            myAjax.addParam("small_amount", $id("small_amount").value);
            <c:if test="${requestScope.mustUpload == '1'}">
            myAjax.addParam("attachName", _$("#attachNameInput").val());
            myAjax.addParam("attachAddress", _$("#attackAddressInput").val());
            </c:if>
            myAjax.submitXML(xmlSubmit, "UTF-8");
            var returnNode = myAjax.getResponseXMLDom();
            if (!!returnNode) {
                callback.call(this, myAjax);
            }
        }

        //modify by zoe 20160523
        function UploadFileWindow() {
            window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp');
        }


        //modify by zoe 20160523
        function beforeEdit(cell, colIndex, rowIndex) {
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

        //modify by zoe 20160523
        function afterEdit(dataCell, newValue, trName) {
            var activeRow = dataCell.activeRow;
            var curCellNum = dataCell.activeCell.cellIndex;
            if (curCellNum == 1) {
                var dataSetTr = dataCell.getEntity(activeRow);//得到当前操作的行dataset
                var amount_old = dataSetTr.getProperty("amount_old");
                var hasBackToOldAmount = false;
                if (parseFloat(amount_old) == 0) {
                    alert("该账单已申请过开票，无其他金额可再次申请，谢谢合作，祝您操作愉快。");
                    hasBackToOldAmount = true;
                }else if (!Utils.common.isFloat(newValue)) {
                    alert('输入的金额必须为浮点型数值，谢谢合作，祝您操作愉快。');
                    hasBackToOldAmount = true;
                } else if (parseFloat(newValue) < 0.01 && parseFloat(newValue) != 0) {
                    alert("输入金额为非法数字，请输入不小于0.01的数字，谢谢合作，祝您操作愉快。");
                    hasBackToOldAmount = true;
                } else if (parseFloat(newValue) > (parseFloat(amount_old) + 0.05)) {
                    alert('输入的金额不能大于' + amount_old + '，并允許有5分錢的上浮，谢谢合作，祝您操作愉快。');
                    hasBackToOldAmount = true;
                }

                //如果输入存在异常，则去原有的旧值
                if (hasBackToOldAmount) {
                    dataSetTr.setProperty("amount", amount_old);
                    newValue = amount_old;
                }
                //计算税费
                var rates = dataSetTr.getProperty("vat_rate");
                var vat_amount = parseFloat(parseFloat(newValue) * parseFloat(rates)).toFixed(2);
                dataSetTr.setProperty("vat_mount", vat_amount);
                dataSetTr.setProperty("totalAmount", (parseFloat(vat_amount) + Utils.common.invoiceRound(newValue)));
                //重新计算总额
                $id(trName).innerText = Utils.common.getTotalAmount(dataCell);
            }
        }

        //modify by zoe 20160523
        function do_ex() {//输入小额调整的页面运算
            var small_amount = $id("small_amount").value;//小额调整值
            if (!checkFloat(small_amount) || parseFloat(small_amount) > 10 || parseFloat(small_amount) < -10) {
                alert("输入的金额必须为浮点型数值和金额只能在-10和10之间！");
                $id("small_amount").value = '0';
                $id("total_invoice_amount").innerText = $id("old_invoice_amount").value;
            } else {
                if (parseFloat($id("total_invoice_amount").innerText) > 0) {
                    var invoice_amount = $id("old_invoice_amount").value;
                    invoice_amount = (parseFloat(invoice_amount) + parseFloat(small_amount)).toFixed(2);
                    $id("total_invoice_amount").innerText = invoice_amount;
                    $id("celllist1").disable(true);
                }
            }
        }

        _$(document).ready(function () {
            var dc = $id("celllist1");
            dc.afterLoadData = function () {
                var dataLength = dc.dataset.getLength();
                if (dataLength === 0) {
                    document.getElementById("btnSave").style.display = 'none';
                } else if (dataLength > 0) {
                    var totalAmount = Utils.common.getTotalAmount(dc);
                    _$("#total_invoice_amount").html(totalAmount);
                    _$("#old_invoice_amount").val(totalAmount);
                    _$("#static_invoice_amount").val(totalAmount);
                    Utils.common.statAllEntityTotalAmount(dc);
                }
            };
            dc.beforeEdit = beforeEdit;
            dc.afterEdit = function (newValue, oldValue) {
                afterEdit(dc, newValue, "total_invoice_amount");
                var total_invoice_amount = $id("total_invoice_amount").innerText;
                _$("#old_invoice_amount").val(total_invoice_amount);
                var small_amount_input = $id("small_amount");
                if (!!small_amount_input && !small_amount_input.disabled) {
                    var small_amount = small_amount_input.value;
                    var hasSmallAmount = parseFloat(small_amount) > 0;
                    var hasAmount = parseFloat($id("total_invoice_amount").innerText) > 0;
                    if (hasSmallAmount && hasAmount) {
                        var total_amount = parseFloat(parseFloat(total_invoice_amount) + parseFloat(small_amount));
                        $id("total_invoice_amount").innerText = parseFloat(total_amount).toFixed(2);
                    }
                }
            };
        });

        function rtnFuncReceiptTitle(arg) {
            var lookup = $id("receipt_title");
            lookup.value = arg[0];
            lookup.displayValue = arg[0];
            $id("cost_id").value = arg[7];
            $id("contact_people").innerHTML = arg[3] == null ? "" : arg[3];//联系人
            $id("contact_telphone").innerHTML = arg[6] == null ? "" : arg[6];//联系电话
            $id("adress1").innerHTML = arg[4] == null ? "" : arg[4];//联系地址
            $id('taxpayer_idtype').innerHTML = arg[8]=="1" ? "增值税一般纳税人" : "非增值税一般纳税人";
            $id('taxpayer_idnum').innerHTML = arg[9] == null ? "" : arg[9];//纳税人身份唯一号
            $id('taxpayer_banktype').innerHTML = arg[10] == null ? "" : arg[10];//客户开户行
            $id('taxpayer_bankaccount').innerHTML = arg[11] == null ? "" : arg[11];//客户开户账号
            $id('taxpayer_adress').innerHTML = arg[12] == null ? "" : arg[12];//客户地址
            $id('taxpayer_telephone').innerHTML = arg[13] == null ? "" : arg[13];//客户电话
            var actionString = "/FAERP/FinverificationAction.do?cmd=getInvoiceSubsidiarySubject&fin_invoice_id=${requestScope.fin_invoice_id}&bill_ids=${requestScope.bill_id}&cost_center_id="+arg[7]+"&template_id=${template_id}";
            $id("celllist1").queryAction= actionString;
            $id("celllist1").loadData();
            $id("celllist1").refresh();
            return false;
        }
    </script>
    </head>
    <body>
    <form name="datacell_formid" id="datacell_formid" method="post">
        <input type="hidden" id="selected_invoice_type"/>
        <input type="hidden" id="old_invoice_amount"/>
        <input type="hidden" id="static_invoice_amount"/>
        <input type="hidden" id="cost_id" name="cost_id" value="${pb_cost_center_vo.id}"/>
        <input type="hidden" id="open_invoice" name="open_invoice" value="${requestScope.open_invoice_bd}"/>
        <input type="hidden" id="bill_amount" name="bill_amount" value="${requestScope.bill_amount}"/>
        <input type="hidden" id="received_amount" name="received_amount" value="${requestScope.received_amount}"/>
        <div id="right" style="height: 700px;overflow-y:scroll;">
            <w:panel id="panel1" title="发票基本信息">
                <div class="box_3">
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                        <tr>
                            <td class="td_1">发票台头</td>
                            <td class="td_2"> <w:lookup onReturnFunc="rtnFuncReceiptTitle" readonly="false"
                                          id="receipt_title" name="receipt_title" property="receipt_title"
                                          displayProperty="receipt_title"
                                          displayValue="${pb_cost_center_vo.receipt_title}"
                                          lookupUrl="/CustomersimpleAction.do?cmd=getReceiptTitleWithGroup&costid=${pb_cost_center_vo.customer_id}"
                                          height="440" width="600" style="width:280px" allowInput="false"/>
                            </td>
                            <td class="td_1">开票属性</td>
                            <td class="td_2" style="width:40%;">
                                ${"0" eq open_invoice_bd ? "系统开票" : "手工开票"}
                            </td>
                        </tr>
                        <tr>
                            <td class="td_1">纳税人身份类型</td>
                            <td class="td_2"
                                id="taxpayer_idtype">${pb_cost_center_vo.taxpayer_identity_type == '1' ? "增值税一般纳税人" : "非增值税一般纳税人"}</td>
                            <td class="td_1">纳税人识别号</td>
                            <td class="td_2"
                                id="taxpayer_idnum">${pb_cost_center_vo.taxpayer_identification_number}</td>
                        </tr>
                        <tr>
                            <td class="td_1">客户地址</td>
                            <td class="td_2" id="taxpayer_adress">${pb_cost_center_vo.tax_registration_address}</td>
                            <td class="td_1">客户电话</td>
                            <td class="td_2" id="taxpayer_telephone">${pb_cost_center_vo.tax_registration_telnum}</td>
                        </tr>
                        <tr>
                            <td class="td_1">客户开户行</td>
                            <td class="td_2" id="taxpayer_banktype">${pb_cost_center_vo.tax_registration_bank}</td>
                            <td class="td_1">客户企业帐号</td>
                            <td class="td_2"
                                id="taxpayer_bankaccount">${pb_cost_center_vo.tax_registration_bank_account}</td>
                        </tr>
                        <tr>
                            <td class="td_1">开票总额</td>
                            <td class="td_2" id="total_invoice_amount">0.00</td>
                            <td class="td_1">实收金额</td>
                            <td class="td_2">${requestScope.received_amount}</td>
                        </tr>
                        <tr>
                            <td class="td_1">账单金额</td>
                            <td class="td_2">${requestScope.bill_amount}</td>
                            <td class="td_1">是否需要快递</td>
                            <td class="td_2">${pb_cost_center_vo.is_finance_send == 1 ? '是' : '否'}</td>
                        </tr>
                        <tr>
                            <td class="td_1">小额调整</td>
                            <td class="td_2" <c:if test="${requestScope.mustUpload != '1'}">colspan="3"</c:if>>
                                <input name="small_amount" class="sText" style="width:40%"
                                    id="small_amount" value="${requestScope.small_amount }"
                                    onblur="do_ex()"
                                    <c:if test="${requestScope.small_amount !=0 || requestScope.gather_flag ==1}">
                                        disabled="disabled"
                                    </c:if>/>
                                <span style="padding-bottom: 50px;color: red;font-weight :bold;">（只会调整到零税率项）</span>
                                ${requestScope.type}
                            </td>
                            <c:if test="${requestScope.mustUpload == '1'}">
                            <td class="td_1">上传收费单</td>
                            <td class="td_2">
                                <input type="text" id="attachNameInput" class="text_field_reference_readonly"
                                           name="attachNameInput" inputName="附件地址" value=""
                                           hiddenInputId="attach_name"/>
                                <img class="refButtonClass"
                                     src="<%=request.getContextPath()%>/images/icon/reference.gif"
                                     onClick="javascript:UploadFileWindow();"/>
                                <input type="hidden" id="attackAddressInput" name="attach_address"/>
                            </td>
                            </c:if>
                        </tr>
                        <tr>
                            <td class="td_1">开票备注</td>
                            <td class="td_2" colspan="3">
                                <textarea name="invoice_desc" class="sText" id="invoice_desc"
                                          value="${requestScope.invoice_desc}"
                                          style="width:60%;height:50px;overflow: auto;"></textarea>
                                <span style="padding-bottom: 50px;color: red;font-weight :bold;">（输入的内容会打印到发票中,备注请不要超过45个字。）</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </w:panel>
            <w:panel id="panelPost" title="邮寄信息">
                <div class="box_3">
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                        <tr>
                            <td class="td_1">联系人</td>
                            <td class="td_2" id="contact_people">${pb_cost_center_vo.contact_person}</td>
                            <td class="td_1">联系电话</td>
                            <td class="td_2" id="contact_telphone"
                                style="width:40%;">${pb_cost_center_vo.contact_tel1}</td>
                        </tr>
                        <tr>
                            <td class="td_1">邮寄地址</td>
                            <td class="td_2" id="adress1">${pb_cost_center_vo.contact_address}</td>
                            <td class="td_1">邮编</td>
                            <td class="td_2" id="youbian">${pb_cost_center_vo.zip_code}</td>
                        </tr>
                    </table>
                </div>
            </w:panel>
            <w:panel id="DetailPanel" title="发票预览" expand="true">
                <div id="list_invoice" style="margin:10px 0px 0px 10px;">
                    <r:datacell
                            queryAction="/FAERP/FinverificationAction.do?cmd=getInvoiceSubsidiarySubject&fin_invoice_id=${requestScope.fin_invoice_id}&bill_ids=${requestScope.bill_id}&cost_center_id=${pb_cost_center_vo.id}&template_id=${template_id}"
                            id="celllist1"
                            paramFormId="datacell_formid"
                            width="99%" height="150px"
                            xpath="FinBillPublicVo">
                        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                        <r:field fieldName="fin_small_subjects_bd" label="开票项目" width="200px" allowModify="false">
                            <d:select dictTypeId="FIN_SUBJECTS_BD"/>
                        </r:field>
                        <r:field fieldName="amount" label="金额" width="100px"
                                 onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text/>
                        </r:field>
                        <r:field fieldName="vat_rate" label="税率" width="100px" defaultValue="6%" allowModify="false"/>
                        <r:field fieldName="vat_mount" label="税额" width="100px" allowModify="false"/>
                        <r:field fieldName="totalAmount" label="价税合计" width="100px" allowModify="false"
                                 onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})"/>
                        <r:field fieldName="is_payticket_for_delegate" label="发票项类型" width="100px">
                            <d:select dictTypeId="INVOICE_TYPE"/>
                        </r:field>
                        <r:field fieldName="isBackCalc" label="是否系统倒算" width="100px" allowModify="false">
                            <d:select dictTypeId="TrueOrFalse"/>
                        </r:field>
                    </r:datacell>
                </div>
            </w:panel>
            <div style="text-align: center;padding-top:10px;width:100%;height:20px;">
                <input type="button" class="icon_2" value="确定" id="btnSave" onClick="save_onClick();"/>
                <input type="button" class="icon_2" value="关闭" onClick="javascript:window.close();">
            </div>
        </div>
    </form>
    </body>
</fmt:bundle>
</html>




