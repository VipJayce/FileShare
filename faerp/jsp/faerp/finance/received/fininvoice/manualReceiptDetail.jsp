<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<%@include file="/common/common.jsp" %>
<%@include file="/common/skins/skin0/component.jsp" %>
<%@include file="/jsp/faerp/finance/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/WfCommonAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src="<%=request.getContextPath()%>/scripts/common.js"></script>
<script type='text/javascript'
        src="<venus:base/>/jsp/faerp/finance/received/fininvoice/viewbillingdetails.js"></script>
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
        <%
            CostcenterVo cvo = request.getAttribute("pb_cost_center_vo") != null ? (CostcenterVo) request.getAttribute("pb_cost_center_vo") : new CostcenterVo();
            String open_invoice_bd = request.getAttribute("open_invoice_bd") == null ? "" : request.getAttribute("open_invoice_bd").toString();
        %>
        <script type="text/javascript">
            var _jQuery = window.jQuery, _$ = window.$;
            jQuery.noConflict();
            function save_onClick() {
                var dataset1 = $id("celllist1").dataset;
                var len1 = $id("celllist1").getAllRows().length;
                if (len1 < 1) {
                    alert("不能保存空的收据明细！");
                    return;
                }
                var invoice_amount = $id("invoice_amount").value;
                if (invoice_amount != null && parseFloat(invoice_amount) == 0) {
                    alert("收据金额不能等于零");
                    return;
                }
                /* update by zoe date 20160502 增值税后不能再比对该金额
                var received_amount = "${requestScope.received_amount}";
                if (parseFloat(received_amount) > 0) {
                    if (parseFloat(received_amount) != parseFloat(invoice_amount)) {//2014年4月8日 如果开票总额大于实收金额，则不允许开票 sqp
                        alert("实收的手工开票账单申请开票，收据金额必须与实收金额一致！");
                        return;
                    }
                }*/
                var invoice_desc = $id("invoice_desc").value;
                if (invoice_desc != "" && invoice_desc.length > 45) {
                    alert("备注最多只能输入45个字符！");
                    return false;
                }
                //获取开票属性
                var open_invoice = _$('#open_invoice').val();
                //获取是否需要快递
                var is_express = _$('#is_express').val();
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
                var attachName = _$("#attachNameInput").val();
                var attachAddress = _$("#attackAddressInput").val();
                var dc1 = $id("celllist1");
                var count = dc1.getCurrentRowCount();
                var arry = new Array();//开票项目
                var billYMArray = new Array();//开票账期
                var verifyArray = new Array();//验证开票项目
                for (var i = 0; i < count; i++) {
                    var row = dc1.table.tBodies[0].rows[i];
                    var entity = dc1.getEntity(row);
                    var subject_amount = entity.getValue("amount");
                    if (subject_amount != null && subject_amount != "" && subject_amount != "0") {
                        if (subject_amount < 0) {
                            alert("收据明细金额不允许为负数!");
                            return false;
                        }
                        arry[i] = entity.getValue("fin_small_subjects_bd");
                        billYMArray[i] = entity.getValue("bill_year_month");
                        verifyArray[i] = entity.getValue("fin_small_subjects_bd") + entity.getValue("bill_year_month");
                    }
                }
                //验证选择开票项目的正确性
                if (isRepeat(verifyArray, true) && isErrSelect(arry, billYMArray) && isErrBillYM(billYMArray)) {
                    document.getElementById("butsav").disabled = "disabled";
                    var action = "<%=request.getContextPath()%>/FinbillAction.do?cmd=saveManualInvoiceData";
                    var cost_id = document.getElementById("cost_id").value;
                    //将两个datacell的xml内容合并
                    var xmlSubmit = dc1.dataset.toString();
                    var myAjax = new Ajax(action);
                    myAjax.addParam("bill_id", "${requestScope.bill_ids}");
                    myAjax.addParam("cost_id", cost_id);
                    myAjax.addParam("invoice_desc", invoice_desc);
                    myAjax.addParam("invoice_amount", invoice_amount);
                    myAjax.addParam("invoice_type", "3");
                    myAjax.addParam("open_invoice", open_invoice);
                    myAjax.addParam("template_id", "${template_id}");
                    myAjax.addParam("received_amount", "${requestScope.received_amount}");
                    myAjax.addParam("attachName", attachName);
                    myAjax.addParam("attachAddress", attachAddress);
                    myAjax.addParam("receipt_title", $id("text4").value);
                    myAjax.addParam("contact_person", $id("contact_person").value);
                    myAjax.addParam("contact_address", $id("contact_address").value);
                    myAjax.addParam("contact_tel1", $id("contact_tel1").value);
                    myAjax.submitXML(xmlSubmit, 'UTF-8');
                    var returnNode = myAjax.getResponseXMLDom();
                    if (returnNode) {
                        var re_Data = myAjax.getValue("root/data/returnValue");
                        DWREngine.setAsync(false);//数据同步
                        if (re_Data == 1) {
                            alert("申请成功!");
                            window.opener.$id("celllist1").loadData();
                            window.opener.$id("celllist1").refresh();
                            window.close();
                        } else {
                            alert("申请失败，请检查收据项目是否设置正确！");
                        }
                    }
                }
            }

            _$(document).ready(function () {
                var invoice_type = "${requestScope.invoice_type}";
                if (invoice_type != "") {
                    if (invoice_type == "1") {
                        _$("#invoice_type1").attr("checked", "checked");
                    } else if (invoice_type == "2") {
                        _$("#invoice_type2").attr("checked", "checked");
                    } else {
                        _$("#invoice_type3").attr("checked", "checked");
                    }
                }

                $id("celllist1").afterLoadData = function() {
                    var dataCell = $id("celllist1");
                    var dataSet = dataCell.dataset;
                    var count = dataSet.values.length;//记录数
                    var total_amount = 0.00;
                    for(var i=0;i<count;i++) {
                        var entity = dataSet.get(i);
                        var amount = entity.getProperty("amount");
                        amount = parseFloat(amount);
                        total_amount += amount;
                    }
                    _$("#view_invoice_amount").html(total_amount);
                    _$("#invoice_amount").val(total_amount);
                }

                $id("celllist1").beforeEdit = function (cell, colIndex, rowIndex) {
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

                $id("celllist1").afterEdit = function (newValue, oldValue) {
                    var datacell = $id("celllist1");
                    var activeRow = datacell.activeRow;
                    var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
                    var amount_old = datasettr.getProperty("amount_old");
                    if (newValue != "" && newValue != null) {
                        if (!checkFloat(newValue)) {
                            alert('输入的金额必须为浮点型数值！');
                            datasettr.setProperty("amount", amount_old);
                            return;
                        }
                    }
                    if (parseFloat(newValue) < 0) {//2014年7月9日 添加
                        alert("输入的金额不能是负数！");
                        datasettr.setProperty("amount", amount_old);
                        return;
                    }
                    //重新开票总额
                    countAllMoney();
                }
            });

            //打开文件上传对话框
            function UploadFileWindow() {
                window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp');
            }

            function rtnFuncReceiptTitle(arg) {
                var lookup = $id("receipt_title");
                lookup.value = arg[0];
                lookup.displayValue = arg[0];
                $id("text4").value = arg[0];
                //update by whj 2015-07-15 由于页面显示 但是这些字段在后台并没有保存 所以注释掉
                $id("contact_person").value = arg[3] == null ? "" : arg[3];//联系人
                $id("contact_address").value = arg[4] == null ? "" : arg[4];//联系地址
                $id("contact_tel1").value = arg[6] == null ? "" : arg[6];//联系电话
                return false;
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
            function isErrSelect(arry, billMonthArray) {
                var flag = false;
                var arr1 = ["4", "7", "1", "3"];
                var arr2 = ["5", "7", "1"];
                var arr3 = ["6", "3", "1"];
                if (varifyArr(arr1, arry, billMonthArray) && varifyArr(arr2, arry, billMonthArray) && varifyArr(arr3, arry, billMonthArray)) {
                    flag = true;
                } else {
                    alert("请选择正确的开票项目！");
                }
                return flag;
            }
            function varifyArr(arr1, arr2, billMonthArray) {
                var count = 0;
                //业务上重复开票项目的年月  只有年月相同才判断为重复
                var errorSelectArray = new Array();
                for (i = 0; i < arr2.length; i++) {
                    if (_$.inArray(arr2[i], arr1) != -1) {
                        count += 1;
                        errorSelectArray[i] = billMonthArray[i];
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
        </script>
    </head>
    <body>
    <form name="datacell_formid" id="datacell_formid" method="post">
        <input name="text4" type="hidden" id="text4" value="${pb_cost_center_vo.receipt_title}"/>
        <input type="hidden" id="invoice_amount_old" value="${requestScope.bill_amount}"/>
        <input type="hidden" id="cost_id" value="${pb_cost_center_vo.id}"/>
        <input type="hidden" id="open_invoice" name="open_invoice" value="<%=open_invoice_bd%>"/>
        <input type="hidden" name="invoice_amount" id="invoice_amount" value="${requestScope.invoice_amount}"/>
        <input type="hidden" name="bill_amount" id="bill_amount" value="${requestScope.bill_amount}"/>
        <input type="hidden" name="received_amount" id="received_amount" value="${requestScope.received_amount}"/>
        <input type="hidden" id="contact_person" name="contact_person" value="${pb_cost_center_vo.contact_person}"/>
        <input type="hidden" id="contact_tel1" name="contact_tel1" value="${pb_cost_center_vo.contact_tel1}"/>
        <input type="hidden" id="contact_address" name="contact_address" value="${pb_cost_center_vo.contact_address}"/>
        <input type="hidden" id="zip_code" name="zip_code" value="${pb_cost_center_vo.zip_code}"/>
        <input type="hidden" id="is_express" name="is_express" value="${pb_cost_center_vo.is_finance_send}"/>
        <div id="right" style="height: 700px;overflow-y:scroll;">
            <w:panel id="panelBaseInfo" title="收据基本信息">
                <div class="box_3">
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                        <tr>
                            <td class="td_1">收据台头</td>
                            <td class="td_2">
                                <w:lookup onReturnFunc="rtnFuncReceiptTitle"
                                          readonly="false" id="receipt_title" name="receipt_title"
                                          property="receipt_title" displayProperty="receipt_title"
                                          displayValue="${pb_cost_center_vo.receipt_title}"
                                          lookupUrl="/CustomersimpleAction.do?cmd=getReceiptTitleWithGroup&costid=${pb_cost_center_vo.customer_id}"
                                          height="440" width="600" style="width:280px" allowInput="false"/>
                            </td>
                            <td class="td_1">开票属性</td>
                            <% if (request.getAttribute("fin_invoice_id") != null) { %>
                            <td class="td_2" style="width:40%;">
                                <%=request.getAttribute("open_desc") %>
                            </td>
                            <%} else { %>
                            <td class="td_2" style="width:40%;">
                                <%=open_invoice_bd.equals("0") ? "系统开票" : "手动开票"%>
                            </td>
                            <%}%>
                        </tr>
                        <tr>
                            <td class="td_1">收据金额</td>
                            <td class="td_2" id="view_invoice_amount">${requestScope.invoice_amount}</td>
                            <td class="td_1">账单金额</td>
                            <td class="td_2">${requestScope.bill_amount}</td>
                        </tr>
                        <tr>
                            <td class="td_1">实收金额</td>
                            <td class="td_2">${requestScope.received_amount}</td>
                            <td class="td_1">服务年月</td>
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
                        </tr>
                        <tr>
                            <td class="td_1">上传收费单</td>
                            <td class="td_2">
                                <input type="text" id="attachNameInput" class="text_field_reference_readonly"
                                       name="attachNameInput" inputName="附件地址" value="" hiddenInputId="attach_name"/>
                                <img class="refButtonClass"
                                     src="<%=request.getContextPath()%>/images/icon/reference.gif"
                                     onClick="javascript:UploadFileWindow();"/>
                                <input type="hidden" id="attackAddressInput" name="attach_address" value="">
                            </td>
                            <td class="td_1">是否需要快递</td>
                            <td class="td_2">${pb_cost_center_vo.is_finance_send == 1 ? '是' : '否'}</td>
                        </tr>
                        <tr>
                            <td class="td_1">备注</td>
                            <td class="td_2" style="height: 80px;" colspan="3">
                                <textarea name="invoice_desc" class="sText" style="width: 40%;height: 95%;" id="invoice_desc"
                                       type="text" value="${requestScope.invoice_desc}"></textarea>
                                <span style="padding-bottom: 50px;color: red;font-weight :bold;">（输入的内容会打印到收据中）</span>
                            </td>
                        </tr>
                    </table>
                </div>
            </w:panel>
            <w:panel id="panelPost" title="邮递信息" expand="true">
                <div class="box_3">
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                        <tr>
                            <td class="td_1">联系人</td>
                            <td class="td_2">${pb_cost_center_vo.contact_person}</td>
                            <td class="td_1">联系电话</td>
                            <td class="td_2" style="width:40%;">${pb_cost_center_vo.contact_tel1}</td>
                        </tr>
                        <tr>
                            <td class="td_1">邮寄地址</td>
                            <td class="td_2">${pb_cost_center_vo.contact_address}</td>
                            <td class="td_1">邮编</td>
                            <td class="td_2">${pb_cost_center_vo.zip_code}</td>
                        </tr>
                    </table>
                </div>
            </w:panel>
            <w:panel id="panelItem" title="收据项目预览" expand="true">
                <div class="button_right" style="margin-top: 5px;margin-left: 13px;">
                    <input class="c" type="button" value="新增" onClick="toAdd_onClick();">
                    <span style="color: red;font-weight :bold;">（注：收据明细金额输入0或为空则不保存到收据项目中）</span>
                </div>
                <div id="div1" style="margin:10px 0px 0px 10px;">
                    <r:datacell
                            queryAction="/FAERP/FinverificationAction.do?cmd=getInvoiceSubInErrorApply&fin_invoice_id=${requestScope.fin_invoice_id}&bill_ids=${requestScope.bill_ids}&cost_center_id=${pb_cost_center_vo.id}&template_id=${template_id}&invoice_type=1"
                            id="celllist1"
                            paramFormId="datacell_formid"
                            width="99%" height="150px"
                            xpath="FinBillPublicVo"
                            pageSize="8">
                        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                        <r:field fieldName="fin_small_subjects_bd" label="收据项目" width="200px" allowModify="true">
                            <d:select dictTypeId="FIN_SUBJECTS_BD"/>
                        </r:field>
                        <r:field fieldName="bill_year_month" label="账单年月(格式：YYMM)" width="200px" allowModify="true">
                            <h:text/>
                        </r:field>
                        <r:field fieldName="amount" label="金额" width="200px">
                            <h:text/>
                        </r:field>
                    </r:datacell>
                </div>
            </w:panel>
        </div>
        <div class="mx_button" style="text-align: center;margin-top:-30px;">
            <input type="button" class="icon_2" value="确定" id="butsav" onClick="javascript:save_onClick()"/>
            <input type="button" class="icon_2" value="关闭" onClick="javascript:window.close();">
        </div>
    </form>
    </body>
</fmt:bundle>
</html>