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
        <link href="<%=request.getContextPath()%>/style/common.css" rel="stylesheet" type="text/css"/>
        <link href="<%=request.getContextPath()%>/style/index.css" rel="stylesheet" type="text/css"/>
        <script language="JavaScript" src="<%=request.getContextPath()%>/scripts/common.js"></script>
        <style type="text/css">
            #list_invoice table tr:nth-child(odd) td { background: #fff; }
            #list_invoice table tr:nth-child(even) td { background: #f9fcfd; }
            #list_invoice table tr:hover { background: #c4e7f8; }
            #list_invoice table tr:active { background-color: #eef8ff; border-bottom-color: #daf1ff; border-right-color: #daf1ff; }
        </style>
    </head>
    <%
        CostcenterVo cvo = request.getAttribute("pb_cost_center_vo") != null ? (CostcenterVo) request.getAttribute("pb_cost_center_vo") : new CostcenterVo();
        String open_invoice_bd = request.getAttribute("open_invoice_bd") == null ? "" : request.getAttribute("open_invoice_bd").toString();
    %>
    <script language="JavaScript" src="../../scripts/common.js"></script>
    <script language="javascript"
            src="<venus:base/>/jsp/faerp/finance/received/fininvoice/invoice_validate.js"></script>
    <script type="text/javascript">
        var _jQuery = window.jQuery, _$ = window.$;
        jQuery.noConflict();
        function save_onClick() {
            document.getElementById("butsav").display = "none";
             //发票抬头不能为空
            var receipt_title = $id("receipt_title_hide").value;
            if (!receipt_title) {
                alert("发票抬头不能为空，请选择发票抬头后点击确认。");
                return;
            }

            //发票备注不能多于45个字
            var invoice_desc = $id("invoice_desc").value;
            if (invoice_desc != "" && invoice_desc.length > 45) {
                alert("发票备注最多只能输入45个字符！");
                return;
            }

            //开票金额不能小于或等于零
            var total_invoice_amount = $id("total_invoice_amount").innerText;
            var invoice_amount = parseFloat(total_invoice_amount);
            if (parseFloat(invoice_amount) == 0) {
                alert("开票金额不能等于零");
                return;
            }

            //必须上传收费单
            var attackAddressInputValue = $id("attackAddressInput").value;
            if (!attackAddressInputValue) {
                alert("必须上传收费单。");
                return;
            }

            //获取是否需要快递
            var is_express = $id('is_express').value;
            if (is_express == 1) {
                if ("${pb_cost_center_vo.contact_person}" == "" || "${pb_cost_center_vo.contact_person}" == null) {
                    alert("需要快递发票则成本中心联系人不能为空!");
                    return;
                }
                if ("${pb_cost_center_vo.contact_address}" == "" || "${pb_cost_center_vo.contact_address}" == null) {
                    alert("需要快递发票则成本中心邮寄地址不能为空!");
                    return;
                }
                if ("${pb_cost_center_vo.contact_tel1}" == "" || "${pb_cost_center_vo.contact_tel1}" == null) {
                    alert("需要快递发票则成本中心联系电话不能为空!");
                    return;
                }
            }
            //获取基础信息
            var dataCell = $id("celllist1")
            var dataSet1 = dataCell.dataset;

            //如果列表中没有任何一项，不能开据发票
            var len1 = dataSet1.getLength();
            if (len1 < 1) {
                alert("不能保存空的发票明细！");
                return;
            }

            //20160419 验证成本中心中的相关信息不能为空 @author yuanzhe >>
            if ("${pb_cost_center_vo.taxpayer_identity_type}" == '1' && Utils.validate.hasGeneralTaxpayer(dataCell)) {
                 var taxpayerIdType = $id("taxpayerIdType").value;
                var taxpayerIdNo = $id("taxpayerIdNo").value;
                var taxRegAddr = $id("taxRegAddr").value;
                var taxRegTelNo = $id("taxRegTelNo").value;
                var taxRegBank = $id("taxRegBank").value;
                var taxRegBankAccount = $id("taxRegBankAccount").value;
                if (!taxpayerIdType || !taxpayerIdNo || !taxRegAddr || !taxRegTelNo || !taxRegBank || !taxRegBankAccount) {
                    alert("纳税人身份类型、纳税人识别号、客户地址、客户电话、客户开户行、客户开户行账号，\n以上都必须填写才能开据增值发票。\n请到成本中心输入以上内容后开票。");
                    return false;
                }
            }

            //检验在非一般纳税人中是否包含专票
            if ("${pb_cost_center_vo.taxpayer_identity_type}" !== "1" && Utils.validate.hasProInvoiceInNonGeneralTaxpayer(dataCell)) {
                alert("非一般纳税人不能含有专票");
                return;
            }

            //验证代收付不能开具专票
            if (Utils.validate.hasDSFApplyProfessInvoice(dataCell)) {
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

            var array = new Array(0);//开票项目
            var billYMArray = new Array(0);//开票账期
            var verifyArray = new Array(0);//验证开票项目
            var rateArray = new Array(0);//税率

            //插入所有数据到数组里
            Utils.common.forEachDataCell(dataCell, function(entity){
                array.push(entity.getValue("fin_small_subjects_bd"));
                billYMArray.push(entity.getValue("bill_year_month"));
                rateArray.push(entity.getValue("bill_year_month") + entity.getValue("vat_rate") + entity.getValue("is_payticket_for_delegate") + "1");
                verifyArray.push(entity.getValue("fin_small_subjects_bd") + entity.getValue("bill_year_month") + entity.getValue("vat_rate") + entity.getValue("is_payticket_for_delegate") + '1');
            });

            //验证选择开票项目的正确性
            if (isRepeat(verifyArray, true) && isErrSelect(array, rateArray) && isErrBillYM(billYMArray)) {
                DWREngine.setAsync(false);//数据同步
                //将两个datacell的xml内容合并
                var xmlSubmit = dataSet1.toString();
                commitData(xmlSubmit, function (myAjax) {
                    var re_Data = myAjax.getValue("root/data/returnValue");
                    if (re_Data == 1) {
                        alert("申请成功!");
                    } else {
                        alert("申请失败!");
                     }
                });
                window.opener.$id("celllist1").loadData();
                window.opener.$id("celllist1").refresh();
                window.close();
            }
        }

        //modify by yuanzhe 20160524 提交开票信息
        function commitData(xmlSubmit, callback) {
            var action = "<%=request.getContextPath()%>/FinbillAction.do?cmd=saveManualInvoiceData";
            var myAjax = new Ajax(action);
            myAjax.addParam("bill_id", "${requestScope.bill_ids}");
            myAjax.addParam("cost_id", $id("cost_id").value);
            myAjax.addParam("invoice_desc", $id("invoice_desc").value);
            myAjax.addParam("open_invoice", _$('#open_invoice').val());
            myAjax.addParam("template_id", "${template_id}");
            myAjax.addParam("received_amount", "${requestScope.received_amount}");
            myAjax.addParam("attachName", _$("#attachNameInput").val());
            myAjax.addParam("attachAddress", _$("#attackAddressInput").val());
            myAjax.addParam("receipt_title", $id("receipt_title_hide").value);
            myAjax.addParam("contact_person", $id("contact_person").value);
            myAjax.addParam("contact_address", $id("contact_address").value);
            myAjax.addParam("contact_tel1", $id("contact_tel1").value);
            myAjax.addParam("zip_code", $id("zip_code").value);
            myAjax.submitXML(xmlSubmit, 'UTF-8');
            var returnNode = myAjax.getResponseXMLDom();
            if (!!returnNode) {
                callback.call(this, myAjax);
            }
        }

        function afterEdit(dataCell, newValue, trName) {
            var activeRow = dataCell.activeRow;
            var curCellNum = dataCell.activeCell.cellIndex;
            if (curCellNum == 2 || curCellNum == 3) {
                var dataSetTr = dataCell.getEntity(activeRow);//得到当前操作的行dataset
                var amount_old = dataSetTr.getProperty("amount_old");
                if (newValue != "" && newValue != null) {
                    if (!Utils.common.isFloat(newValue)) {
                        alert('必须输入浮点型数值，谢谢合作，预祝您操作愉快。');
                        dataSetTr.setProperty("amount", amount_old);
                        dataSetTr.setProperty("vat_rate", "");
                        dataSetTr.setProperty("vat_mount", "");
                        return;
                    }
                }

                if (parseFloat(newValue) < 0.01 && parseFloat(newValue) != 0) {//2014年7月9日 添加
                    alert("输入的数值不合法，请输入大于0.01的数字，谢谢合作，预祝您操作愉快。");
                    dataSetTr.setProperty("amount", amount_old);
                    dataSetTr.setProperty("vat_rate", "");
                    dataSetTr.setProperty("vat_mount", "");
                    return;
                }

                var rates = dataSetTr.getProperty("vat_rate");
                var amount = dataSetTr.getProperty("amount");
                if (!!rates && !!amount) {
                    var vat_amount = Utils.common.invoiceRound(parseFloat(rates) * parseFloat(amount));
                    dataSetTr.setProperty("vat_mount", vat_amount);
                    dataSetTr.setProperty("totalAmount", (parseFloat(vat_amount) + Utils.common.invoiceRound(amount)));
                }

                //重新开票总额
                $id(trName).innerText = Utils.common.getTotalAmount(dataCell);
            }
        }

        function beforeEdit(cell, colIndex, rowIndex) {
            //初始化金额  去除预开时不能更改的限制
            var received_amount = "${requestScope.received_amount}";//实收金额
            var bill_amount = "${requestScope.bill_amount}";//账单金额
            // 实收状态1部分实收2实收完成3未实收
            var bill_gather_status_bd = "${requestScope.bill_gather_status_bd}";
            if (received_amount == "") {
                received_amount = "0";
            }
            if (bill_amount == "") {
                bill_amount = "0";
            }
        }

        _$(document).ready(function () {
            var dc = $id("celllist1");
            dc.afterLoadData = function () {
                var total_amount = Utils.common.getTotalAmount(dc);
                _$("#total_invoice_amount").html(total_amount);
                Utils.common.statAllEntityTotalAmount(dc);
            };
            dc.beforeEdit = beforeEdit;
            dc.afterEdit = function (newValue, oldValue) {
                afterEdit(dc, newValue, "total_invoice_amount");
            };
        });


        //打开文件上传对话框
        function UploadFileWindow() {
            window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp');
        }

        //新增开票项目
        function toAdd_onClick() {
            $id("celllist1").addRow();
        }

        //判断开票项目是否重复
        function isRepeat(arry, vFlag) {
            var s = arry.join(",") + ","; //把数组ary转化为字符串
            var flag = true;
            for (var i = 0; i < arry.length; i++) {
                if (arry[i] != "" && arry[i] != null) {
                    if (s.replace(arry[i] + ",", "").indexOf(arry[i] + ",") > -1) {    //匹配字符串S中当前i的数组值，并替换为空；在当前循环里查看S中是否有重复
                        if (vFlag == true) {
                            alert("开票项目选择重复！");
                        }
                        flag = false;
                        break;
                    }
                }
            }
            return flag;
        }

        //判断开票项目从业务上是否有重复
        function isErrSelect(arry, rateArray) {
            var flag = false;
            var arr1 = ["4", "7", "1", "3"];
            var arr2 = ["5", "7", "1"];
            var arr3 = ["6", "3", "1"];
            if (varifyArr(arr1, arry, rateArray) && varifyArr(arr2, arry, rateArray) && varifyArr(arr3, arry, rateArray)) {
                flag = true;
            } else {
                alert("请选择正确的开票项目！");
            }
            return flag;
        }

        //验证是否含有这个数组
        function varifyArr(arr1, arr2, rateArray) {
            var count = 0;
            //业务上重复开票项目的年月  只有年月相同才判断为重复
            var errorSelectArray = new Array();
            for (var i = 0; i < arr2.length; i++) {
                if (_$.inArray(arr2[i], arr1) != -1) {
                    errorSelectArray[i] = rateArray[i];
                    count += 1;
                }
            }
            //如果出现2次则返回false
            if (count > 1 && isRepeat(errorSelectArray, false) == false) {
                return false;
            } else {
                return true;
            }
        }

        //判断账期是否正确
        function isErrBillYM(arry) {
            var flag = true;
            for (i = 0; i < arry.length; i++) {
                if (arry[i] != null && arry[i] != "") {
                    if (arry[i].length != 4) {
                        alert("请输入正确的四位账期！");
                        flag = false;
                        break;
                    } else {
                        var regDate = new RegExp("[0-9]{2}(0?[1-9]|1[0-2])$");
                        if (arry[i].substring(2) == "00") {
                            alert("请输入正确的年月账期！");
                            flag = false;
                            break;
                        }
                        if (isNaN(arry[i]) == true) {
                            alert("请输入正确的年月账期！");
                            flag = false;
                            break;
                        }
                        if (arry[i].match(regDate)[0] != arry[i]) {
                            alert("请输入正确的年月账期！");
                            flag = false;
                            break;
                        }
                    }
                }
            }
            return flag;
        }
        function rtnFuncReceiptTitle(arg) {
            var lookup = $id("receipt_title");
            lookup.value = arg[0];
            lookup.displayValue = arg[0];
            $id("receipt_title_hide").value = arg[0];
            //update by whj 2015-07-15 由于页面显示 但是这些字段在后台并没有保存 所以注释掉
            $id("contact_person").value = arg[3] == null ? "" : arg[3];//联系人
            $id("contact_address").value = arg[4] == null ? "" : arg[4];//联系地址
            $id("contact_tel1").value = arg[6] == null ? "" : arg[6];//联系电话
            $id("contact_people").innerHTML = arg[3] == null ? "" : arg[3];//联系人
            $id("contact_telphone").innerHTML = arg[6] == null ? "" : arg[6];//联系电话
            $id("adress1").innerHTML = arg[4] == null ? "" : arg[4];//联系地址
           	$id('taxpayer_idtype').innerHTML = arg[8]=="1" ? "增值税一般纳税人" : "非增值税一般纳税人";
            $id("cost_id").value=arg[7];
            //此处只作为页面展示  >>
            $id("taxpayerIdType").value = arg[8];
            $id('taxpayer_idnum').innerHTML = arg[9] == null ? "" : arg[9];//纳税人身份唯一号
            $id("taxpayerIdNo").value = arg[9];
            $id('taxpayer_banktype').innerHTML = arg[10] == null ? "" : arg[10];//客户开户行
            $id("taxRegBank").value = arg[10];
            $id('taxpayer_bankaccount').innerHTML = arg[11] == null ? "" : arg[11];//客户开户账号
            $id("taxRegBankAccount").value = arg[11];
            $id('taxpayer_adress').innerHTML = arg[12] == null ? "" : arg[12];//客户地址
            $id("taxRegAddr").value = arg[12];
            $id('taxpayer_telephone').innerHTML = arg[13] == null ? "" : arg[13];//客户电话
            $id("taxRegTelNo").value = arg[13];
            //此处只作为页面展示  <<
            var actionString = "/FAERP/FinverificationAction.do?cmd=getInvoiceSubInErrorApply&fin_invoice_id=${requestScope.fin_invoice_id}&bill_ids=${requestScope.bill_ids}&cost_center_id="+arg[7]+"&template_id=${template_id}";
            $id("celllist1").queryAction= actionString;
            $id("celllist1").loadData();
            $id("celllist1").refresh();
            return false;
        }
    </script>
    <body>
    <form name="datacell_formid" id="datacell_formid" method="post">
        <input type="hidden" id="cost_id" value="${pb_cost_center_vo.id}"/>
        <input type="hidden" id="invoice_amount_old" value="${requestScope.bill_amount}"/>
        <input type="hidden" name="bill_amount" id="bill_amount" value="${requestScope.bill_amount}"/>
        <input type="hidden" name="received_amount" id="received_amount" value="${requestScope.received_amount}" />

        <input type="hidden" name="contact_person" id="contact_person" value="${pb_cost_center_vo.contact_person}"/>
        <input type="hidden" name="contact_tel1" id="contact_tel1" value="${pb_cost_center_vo.contact_tel1}"/>
        <input type="hidden" name="contact_address" id="contact_address" value="${pb_cost_center_vo.contact_address}"/>
        <input type="hidden" name="zip_code" id="zip_code" value="${pb_cost_center_vo.zip_code}"/>
        <input type="hidden" name="is_express" value="${pb_cost_center_vo.is_finance_send}"/>
        <input type="hidden" name="receipt_title_hide"  id="receipt_title_hide" value="${pb_cost_center_vo.receipt_title}"/>
        <input type="hidden" name="is_express" id="is_express" value="${pb_cost_center_vo.is_finance_send}"/>

        <input type="hidden" name="taxpayerIdType" id="taxpayerIdType" value="${pb_cost_center_vo.taxpayer_identity_type}"/>
        <input type="hidden" name="taxpayerIdNo" id="taxpayerIdNo" value="${pb_cost_center_vo.taxpayer_identification_number}"/>
        <input type="hidden" name="taxRegAddr" id="taxRegAddr" value="${pb_cost_center_vo.tax_registration_address}"/>
        <input type="hidden" name="taxRegTelNo" id="taxRegTelNo" value="${pb_cost_center_vo.tax_registration_telnum}"/>
        <input type="hidden" name="taxRegBank" id="taxRegBank" value="${pb_cost_center_vo.tax_registration_bank}"/>
        <input type="hidden" name="taxRegBankAccount" id="taxRegBankAccount" value="${pb_cost_center_vo.tax_registration_bank_account}"/>
        <div id="right" style="height: 700px;overflow-y:scroll;">
            <w:panel id="panel1" title="发票基本信息">
                <div class="box_3">
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                        <tr>
                            <td class="td_1">发票台头</td>
                            <td class="td_2">
                             <w:lookup onReturnFunc="rtnFuncReceiptTitle"
                                          readonly="false" id="receipt_title" name="receipt_title"
                                          property="receipt_title" displayProperty="receipt_title"
                                          displayValue="${pb_cost_center_vo.receipt_title}"
                                          lookupUrl="/CustomersimpleAction.do?cmd=getReceiptTitleWithGroup&costid=${pb_cost_center_vo.customer_id}"
                                          height="440" width="600" style="width:280px" allowInput="false"/></td>
                            <td class="td_1">开票属性</td>
                            <td class="td_2" style="width:40%;">手动开票</td>
                        </tr>
                        <tr>
                            <td class="td_1">纳税人身份类型</td>
                            <td class="td_2" id="taxpayer_idtype">${pb_cost_center_vo.taxpayer_identity_type == '1' ? "增值税一般纳税人" : "非增值税一般纳税人"}</td>
                            <td class="td_1">纳税人识别号</td>
                            <td class="td_2" id="taxpayer_idnum">${pb_cost_center_vo.taxpayer_identification_number}</td>
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
                            <td class="td_2" id="taxpayer_bankaccount">${pb_cost_center_vo.tax_registration_bank_account}</td>
                        </tr>
                        <tr>
                            <td class="td_1">开票总额</td>
                            <td class="td_2" id="total_invoice_amount">0.00</td>
                            <td class="td_1">账单金额</td>
                            <td class="td_2">${requestScope.bill_amount}</td>
                        </tr>
                        <tr>
                            <td class="td_1">实收金额</td>
                            <td class="td_2">${requestScope.received_amount}</td>
                            <td class="td_1">是否需要快递</td>
                            <td class="td_2">${pb_cost_center_vo.is_finance_send == 1 ? '是' : '否'}</td>
                        </tr>
                        <tr>
                            <td class="td_1">发票服务年月</td>
                            <td class="td_2">
                                <c:if test="${pb_cost_center_vo.is_display_year_month ==0}">
                                    不显示
                                </c:if>
                                <c:if test="${pb_cost_center_vo.is_display_year_month ==1}">
                                    显示当月
                                </c:if>
                                <c:if test="${pb_cost_center_vo.is_display_year_month ==2}">
                                    显示上月
                                </c:if>
                            </td>
                            <td class="td_1">上传收费单</td>
                            <td class="td_2">
                                <input type="text" id="attachNameInput" class="text_field_reference_readonly"
                                       name="attachNameInput" inputName="附件地址" value="" hiddenInputId="attach_name"/>
                                <img class="refButtonClass"
                                     src="<%=request.getContextPath()%>/images/icon/reference.gif"
                                     onClick="javascript:UploadFileWindow();"/>
                                <input type="hidden" id="attackAddressInput" name="attach_address"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td_1">开票备注</td>
                            <td class="td_2" colspan="3">
                                <textarea name="invoice_desc" class="sText" style="width: 60%; height: 50px;" id="invoice_desc"
                                          type="text" value="${requestScope.invoice_desc}"></textarea>
                                <span style="padding-bottom: 50px;color: red;font-weight :bold;">（输入的内容会打印到发票中）</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </w:panel>
            <w:panel id="panelPost" title="邮寄信息" expand="true">
                <div class="box_3">
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                        <tr>
                            <td class="td_1">联系人</td>
                            <td class="td_2" id="contact_people">${pb_cost_center_vo.contact_person}</td>
                            <td class="td_1">联系电话</td>
                            <td class="td_2" id="contact_telphone" style="width:40%;">${pb_cost_center_vo.contact_tel1}</td>
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
                <div class="button_right" style="margin-top: 5px;margin-left: 13px;">
                    <input class="c" type="button" value="新增" onClick="toAdd_onClick();">
                    <font style="color: red;font-weight :bold;">（注：开票项金额输入0或为空则不保存到发票项目中）</font>
                </div>
                <div id="list_invoice" style="margin:10px 0px 0px 10px;">
                    <r:datacell
                            queryAction="/FAERP/FinverificationAction.do?cmd=getInvoiceSubInErrorApply&fin_invoice_id=${requestScope.fin_invoice_id}&bill_ids=${requestScope.bill_ids}&cost_center_id=${pb_cost_center_vo.id}&template_id=${template_id}"
                            id="celllist1"
                            paramFormId="datacell_formid"
                            width="99%" height="150px"
                            xpath="FinBillPublicVo"
                            pageSize="8">
                        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                        <r:field fieldName="fin_small_subjects_bd" label="开票项目" width="200px" allowModify="true">
                            <d:select dictTypeId="FIN_SUBJECTS_BD"/>
                        </r:field>
                        <r:field fieldName="bill_year_month" label="账单年月(格式：YYMM)" width="200px" allowModify="true">
                            <h:text/>
                        </r:field>
                        <r:field fieldName="amount" label="金额" width="200px"
                                 onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text/>
                        </r:field>
                        <r:field fieldName="vat_rate" label="税率" width="100px">
                            <h:text/>
                        </r:field>
                        <r:field fieldName="vat_mount" label="税额" width="100px" allowModify="false"
                                 onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})"/>
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
            <div class="mx_button" style="text-align: center;">
                <input type="button" class="icon_2" value="确定" id="butsav" onClick="javascript:save_onClick()"/>
                <input type="button" class="icon_2" value="关闭" onClick="javascript:window.close();">
            </div>
        </div>
    </form>
    </body>
</fmt:bundle>
</html>




