//社保产品福利办理好收费勾选后设置值
function checkyanglao(rowNo, code) {

    var aa = "sc_" + rowNo;
    //if(code!=null &&　code!='200'){
    //	    $id(aa).checked=false;
    //     alert('对不起，该社保产品不能设置为福利办理好收费！');
    //}else{
    var datacell = $id("grdCityEnsureTbody");
    var dataset = datacell.dataset;
    if ($id(aa).checked) {//勾选上
        dataset.get(rowNo).setProperty("is_charge_on_security", "1");
    } else {//勾选去掉
        dataset.get(rowNo).setProperty("is_charge_on_security", "0");
    }
    //}

}

//如果为服务费才可勾选,勾选后设置值
function checkfuwufei(rowNo, code) {
    var aa = "fl_" + rowNo;
    if (code != null && code != '3463') {
        $id(aa).checked = false;
        alert('对不起，该福利产品不能设置为福利办理好收费！');
    } else {
        var datacell = $id("fulitbody");
        var dataset = datacell.dataset;
        if ($id(aa).checked) {//勾选上
            dataset.get(rowNo).setProperty("is_charge_on_security", "1");
        } else {//勾选去掉
            dataset.get(rowNo).setProperty("is_charge_on_security", "0");
        }
    }

}

//如果勾了预收，收费频率只能选月付
function checkprepay() {
    var datacell = $id("grdCityEnsureTbody");
    var dataset = datacell.dataset;

    var frequence = $id("dselect1").value;//dselect选择后的值

    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset

    var prepay = datasettr.getProperty("is_prepay");

    if (prepay == '1' && frequence != '1') {
        alert('对不起，勾选了预收，只能选择每月付！');
        $id("dselect1").setValue('1');
        datasettr.setProperty("charge_frequency_bd", '1');
        return;
    }

}

//如果勾了预收，收费频率只能选月付
function checkprepay1() {
    var datacell = $id("fulitbody");
    var dataset = datacell.dataset;

    var frequence = $id("dselect2").value;//dselect选择后的值

    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset

    var prepay = datasettr.getProperty("is_prepay");

    if (prepay == '1' && frequence != '1') {
        alert('对不起，勾选了预收，只能选择每月付！');
        $id("dselect2").setValue('1');
        datasettr.setProperty("charge_frequency_bd", '1');
        return;
    }

}

function findSelections(checkboxName) {  //从列表中找出选中的id值列表
    var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
    var number = 0;  //定义游标
    var ids = null;  //定义id值的数组
    for (var i = 0; i < elementCheckbox.length; i++) {  //循环checkbox组
        if (elementCheckbox[i].checked) {  //如果被选中
            number += 1;  //游标加1
            if (ids == null) {
                ids = new Array(0);
            }
            ids.push(elementCheckbox[i].value);  //加入选中的checkbox
        }
    }
    return ids;
}

//批量删除·
function DelSite() {
    var ids = findSelections("checkbox_template");  //取得多选框的选择项
    if (ids == null) {  //如果ids为空
        alert('请至少选择一个社保公积金产品！');
        return;
    }
    if (confirm('确定要删除所选的社保产品吗？')) {  //如果用户在确认对话框按"确定"
        var datacell = $id("grdCityEnsureTbody");
        var dataset = datacell.dataset;
        for (var j = 0; j < ids.length; j++) {  //循环checkbox组选中的
            dataset.removeEntity(dataset.findEntity("id", ids[j]), true);
        }

    }
    $id("grdCityEnsureTbody").refresh();
}

//**************************以下为计算金额的公用方法*************************
//得到数值
function getNumber(obj) {
    if (obj == null) return 0;
    if (!checkFloat(obj) || obj + "" == "") {
        return 0;
    } else {
        return parseFloat("" + obj);
    }
}
//检查输入参数是否为浮点数
function checkFloat(str) {
    var rc = true;
    oneDecimal = false;
    if (str + "" == "undefined" || str == null || str == '') {
        rc = false;
    } else {
        for (i = 0; i < str.length; i++) {
            ch = str.charAt(i);
            if (i == 0 && ch == '-') {
                continue;
            }
            if (ch == "." && !oneDecimal) {
                oneDecimal = true;
                continue;
            }
            if (ch == ",") {
                continue;
            }
            if ((ch < "0") || (ch > '9')) {
                rc = false;
                break;
            }
        }
    }
    return rc;
}
//判断某个六位数是不是年份月份格式yyyymm
function checkMonth(yearMonth, msg) {
    if (yearMonth == "") return true;
    var rtn = true;
    var s = yearMonth + "";
    //alert(s.length);
    if (s.length != 6) rtn = false;
    if (!checkNumber(yearMonth))rtn = false; //必须全是数字
    var year = s.substring(0, 4);
    var month = s.substring(4, 6);
    if (parseFloat(year) < 2000 || parseFloat(year) > 2030) rtn = false;
    if (parseFloat(month) < 1 || parseFloat(month) > 12) rtn = false;

    if (!rtn) {
        alert(msg + "输入日期格式或范围不正确!");
    }
    return rtn;
}

//四舍五入
function floatRound(myFloat, mfNumber) {
    if (mfNumber == 0) {
        return Math.round(myFloat);
    } else {
        var cutNumber = Math.pow(10, mfNumber);
        return Math.round((myFloat + 0.000000000001) * cutNumber) / cutNumber;
    }
}

/**计算一个社保
 base 基数 ratio 比例 addMoney 附加金额 iPrecise 精确值 iCarry 进位方式
 **/
function calInsurance(base, ratio, addMoney, iPrecisePara, iCarryPara) {
    var iPrecise = "" + iPrecisePara;
    var iCarry = "" + iCarryPara;
    if (iPrecise == "") iPrecise = "2";
    if (iCarry == "") iCarry = "1";
    var anMoney;
    //alert(base+":"+ratio+":"+addMoney+":"+iPrecise+":"+iCarry);
    anMoney = floatRound(base * ratio, 5);
    if (parseFloat(iPrecise) <= 2) {//小数位小于等于2位，不是精确值
        if (iCarry == "1") {//四舍五入
        } else if (iCarry == "2") {//先四舍五入再见零进整
            var extStr = "0.";
            for (var i = 0; i < parseFloat(iPrecise); i++) {
                extStr = extStr + "0";
            }
            extStr = extStr + "4";
            var extDouble = parseFloat(extStr);
            anMoney = anMoney + extDouble;
        } else if (iCarry == "3") {//见零进整
            var tmpMoney = anMoney + "";
            var dotPos = tmpMoney.indexOf(".");
            if (dotPos >= 0) {//有小数点
                var preMoney = tmpMoney.substring(0, dotPos + 1 + parseFloat(iPrecise)) + "0";
                tmpMoney = tmpMoney.substring(dotPos + 1 + parseFloat(iPrecise));
                if (tmpMoney != "") {
                    if (parseFloat(tmpMoney) > 0) {//需要见零进位
                        anMoney = parseFloat(preMoney) + Math.pow(10, -1 * parseFloat(iPrecise));
                    }
                }
            }
        }
        anMoney = floatRound(anMoney, parseFloat(iPrecise));

    } else {  //小数位大于2位，是精确值
        anMoney = floatRound(anMoney, parseFloat(iPrecise));
    }
    return anMoney + addMoney;
}

//具体页面中计算,入离职用到(陈小佩重新修改)
function calculateInsurance(record) {
    var base = getNumber(record.getProperty("base"));
    var eRatio = getNumber(record.getProperty("e_ratio"));//企业比例
    var pRatio = getNumber(record.getProperty("p_ratio")); //个人比例
    var eApdMoney = getNumber(record.getProperty("e_add_ratio")); //企业附加金额
    var pApdMoney = getNumber(record.getProperty("p_add_ratio")); //个人附加金额

    var eMoney = 0, pMoney = 0, money = 0;
    //单位金额
    if (eRatio > 0 || eApdMoney > 0) {
        if (eRatio > 0 && base <= 0) return false;
        eMoney = calInsurance(base, eRatio, eApdMoney, record.getProperty("e_precision_bd"), record.getProperty("e_caculate_type_bd"));
    }
    //个人金额
    if (pRatio > 0 || pApdMoney > 0) {
        if (pRatio > 0 && base <= 0) return false;
        pMoney = calInsurance(base, pRatio, pApdMoney, record.getProperty("p_precision_bd"), record.getProperty("p_caculate_type_bd"));
    }
    if (eMoney + pMoney > 0) {
        money = eMoney + pMoney;
        record.setProperty("e_money", eMoney.toFixed(4));//小数点后保留4位
        record.setProperty("p_money", pMoney.toFixed(4));
        record.setProperty("money", money.toFixed(4));
    }
}

//*******************以下为日期联动变化的js方法**************************

//入职日期变化了，收费起止日期、福利收费起止日期、合同起止日期等也要跟着变化
function toInputDate() {
    var input_date = $id("apply_on_post_date").getValue();
    var emp_id = jQuery("#emp_id").val();
    if (input_date == null || input_date == '') {
        return;
    }
    //判断新输入的入职日期不能小于该员工的离职日期
    jQuery.ajax({
        url: vpath + '/EmppostAction.do?cmd=checkApplyDate&emp_id=' + emp_id + '&apply_date=' + input_date,
        type: 'GET',
        dataType: 'html',
        timeout: 10000,
        error: function () {
            alert('Error loading XML document');
            return null;
        },
        success: function (text) {
            if (text == 1) {
                alert('该员工已办理离职，且离职日期未到，新输入的入职日期不能早于离职日期，请重新选择！');
                $id("apply_on_post_date").setValue('');
                return;
            } else {
                var emp_post_type = document.getElementById("emp_post_type_bd").value;
                var start_date = tostartDate(input_date);
                var end_date = toendDate(start_date);
                var end_date1 = addYear(input_date, 2);

                $id("charge_start_date").setValue(start_date);//会同步调用changeStartDate()方法更新福利收费日期和基数
                $id("charge_end_date").setValue(end_date);

                $id("start_date").setValue(input_date);
                $id("end_date").setValue(end_date1);
                if (emp_post_type == '1' || emp_post_type == '3') {
                    $id("send_start_date").setValue(input_date);
                    $id("send_end_date").setValue(end_date1);
                }
            }
        }
    });

}

//收费起始日期改变，修改起始收费日期,判断基数不为空的，根据日期所在区段的基数最大值最小值，同步更新产品列表中基数
function changeStartDate() {
    //必须先输入入职日期
    var applydate = $id("apply_on_post_date").getValue();
    if (applydate == null || applydate == '') {
        alert('请先输入员工入职日期！');
        return;
    }

    var input_date = $id("charge_start_date").getValue();
    if (input_date == null || input_date == '') {
        alert('输入的收费起始日期为空或格式不正确！');
        return;
    }
    var end_date = addYear(input_date, 2);
    $id("charge_end_date").setValue(end_date);

    var yearmonth = input_date.substring(0, 4) + input_date.substring(5, 7);
    //修改社保产品起始收费日期
    var datacell = $id("grdCityEnsureTbody");
    var dataset = datacell.dataset;
    for (var i = 0; i < dataset.getLength(); i++) {
        dataset.get(i).setProperty("sf_start_date", yearmonth);
        //修改基数
        if (dataset.get(i).getProperty("base") != null && dataset.get(i).getProperty("base") != '') {
            var curEnt1 = dataset.get(i);
            anyAmount1(curEnt1);
        }
        datacell.refreshRow(datacell.getRow(i));
    }

    //修改福利起始收费日期
    var datacel = $id("fulitbody");
    var dataset1 = datacel.dataset;
    for (var i = 0; i < dataset1.getLength(); i++) {
        dataset1.get(i).setProperty("sf_start_date", input_date);
        datacel.refreshRow(datacel.getRow(i));
    }

}

//根据入职日期得到收费起始日期
function tostartDate(input_date) {
    var date = input_date.split('-');
    var sf_start = '';

    //收费起始日期
    if (date[2] < '16') {//上半月
        sf_start = date[0] + '-' + date[1] + '-01';
    } else {//下半月
        //12月
        if (date[1] == '12') {
            var year = parseInt(date[0]) + 1;
            sf_start = year + '-01-01';
        } else {
            //1~9月
            if (date[1].substr(0, 1) == '0') {
                var mon = parseInt(date[1].substr(1, 1)) + 1;
                if (mon < 10) {
                    sf_start = date[0] + '-0' + mon + '-01';
                } else {
                    sf_start = date[0] + '-' + mon + '-01';
                }
            } else {//10~11月
                var mon = parseInt(date[1]) + 1;
                sf_start = date[0] + '-' + mon + '-01';
            }
        }
    }

    return sf_start;

}

//收费结束日期为起始日期加两年减一天，如：起始日期为2012-08-01，结束日期为2014-07-31
function toendDate(sf_start) {
    var date = sf_start.split('-');
    var sf_end = '';

    //如果是1月1日
    if (date[1] == '01' && date[2] == '01') {
        var year = parseInt(date[0]) + 1;
        sf_end = year + '-12-31';
    } else {
        var year = parseInt(date[0]) + 2;
        //1~9月
        if (date[1].substr(0, 1) == '0') {
            var mon = parseInt(date[1].substr(1, 1)) - 1;
            var day = monthlastday(year, mon);
            sf_end = year + '-0' + mon + '-' + day;
        } else {//10~11月
            var mon = parseInt(date[1]) - 1;
            var day = monthlastday(year, mon);
            if (mon < 10) {
                sf_end = year + '-0' + mon + '-' + day;
            } else {
                sf_end = year + '-' + mon + '-' + day;
            }
        }
    }

    return sf_end;

}

//根据年月得到该月的最后一天，参数为数值型
function monthlastday(year, month) {
    var day = 30;
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        day = 31;
    }
    if (month == 2) {
        day = 28;
        //判断是否闰年
        if (year % 4 == 0 && ((theYear % 100 != 0) || (theYear % 400 == 0))) {
            day = 29;
        }
    }
    return day;
}

//当前日期直接年份加两年
function addTwoYear(input_date) {
    var date = input_date.split('-');
    var sf_end = '';

    var year = parseInt(date[0]) + 2;
    //2月29日的情况
    if (date[1] == '02' && date[2] == '29') {
        sf_end = year + '-02-28';
    } else {
        sf_end = year + '-' + date[1] + '-' + date[2];
    }

    return sf_end;

}

//将日期加num年减一天
//如:参数是2004-01-01 则返回 2005-12-31
//参数类型须是yyyy-mm-dd
function addYear(beginDate, num) {
    if (beginDate == "") return "";
    var year1 = beginDate.substring(0, 4);
    var month1 = beginDate.substring(5, 7);
    var day1 = beginDate.substring(8, beginDate.length);
    var year = parseFloat(year1);
    var month = parseFloat(month1);
    var day = parseFloat(day1);
    var retYear, retMonth, retDay;
    if (day == 1) {  //为每个月的1日
        if (month == 1) {  //1月1日
            retYear = year + num - 1;
            retMonth = 12;
            retDay = 31;
        }
        if (month == 2 || month == 4 || month == 6 || month == 8 || month == 9 || month == 11) {  //前一月为大月
            retYear = year + num;
            retMonth = month - 1;
            retDay = 31;
        }
        if (month == 5 || month == 7 || month == 10 || month == 12) {    //前一月为小月
            retYear = year + num;
            retMonth = month - 1;
            retDay = 30;
        }
        if (month == 3) {    //前一月是2月
            retYear = year + num;
            retMonth = month - 1;
            if ((retYear % 4 == 0 && retYear % 100 != 0) || (retYear % 400 == 0)) {  //润年
                retDay = "29";
            } else {                     //不是 润年
                retDay = "28";
            }
        }
    } else {
        retYear = year + num;
        retMonth = month;
        retDay = day - 1;
    }
    if (retMonth < 10) retMonth = "0" + retMonth;
    if (retDay < 10) retDay = "0" + retDay;
    return retYear + "-" + retMonth + "-" + retDay;
}

//********************************以下为弹出层选择比例的js方法***************************8
jQuery(document).ready(function () {
    jQuery("#showratio tr").live("click", function () {
        updatetoTbody(this);
    });

});

function toappenddiv(group_id, id) {
    var showratio = jQuery("#showratio");
    showratio.empty();

    jQuery.getJSON(vpath + "/EmppostAction.do?cmd=searchProductsById&date=" + new Date() + "", {
        "group_id": group_id,
        "security_product_id": id
    }, function (json) {

        for (var i = 0; i < json.saia.length; i++) {

            var tr = jQuery("<tr onMouseOver=\"this.style.textDecoration='underline'\" onMouseOut=\"this.style.textDecoration='none'\"></tr>");
            jQuery(tr).attr("style", "cursor:hand");

            var td0 = jQuery("<td align='center' width='15%'></td>");
            var html1 = jQuery("<input type='hidden' name='div_security_product_id' value=''>");
            jQuery(html1).attr("value", json.saia[i].id);
            jQuery(td0).append(html1);
            var html2 = jQuery("<input type='hidden' name='div_product_id' value=''>");
            jQuery(html2).attr("value", json.saia[i].product_id);
            jQuery(td0).append(html2);
            var html3 = jQuery("<input type='hidden' name='div_e_precision_bd' value=''>");
            jQuery(html3).attr("value", json.saia[i].e_precision_bd);
            jQuery(td0).append(html3);
            var html4 = jQuery("<input type='hidden' name='div_e_caculate_type_bd' value=''>");
            jQuery(html4).attr("value", json.saia[i].e_caculate_type_bd);
            jQuery(td0).append(html4);
            var html5 = jQuery("<input type='hidden' name='div_p_precision_bd' value=''>");
            jQuery(html5).attr("value", json.saia[i].p_precision_bd);
            jQuery(td0).append(html5);
            var html6 = jQuery("<input type='hidden' name='div_p_caculate_type_bd' value=''>");
            jQuery(html6).attr("value", json.saia[i].p_caculate_type_bd);
            jQuery(td0).append(html6);
            jQuery(td0).append(json.saia[i].product_name);
            jQuery(tr).append(td0);

            var td5 = jQuery("<td align='center'></td>");
            jQuery(td5).append(json.saia[i].e_ratio);
            jQuery(tr).append(td5);

            var td6 = jQuery("<td align='center'></td>");
            jQuery(td6).append(json.saia[i].p_ratio);
            jQuery(tr).append(td6);

            var td2 = jQuery("<td align='center'></td>");
            jQuery(td2).append(json.saia[i].charge_frequency_bd);
            jQuery(tr).append(td2);

            var td3 = jQuery("<td align='center'></td>");
            jQuery(td3).append(json.saia[i].e_add_ratio);
            jQuery(tr).append(td3);

            var td4 = jQuery("<td align='center'></td>");
            jQuery(td4).append(json.saia[i].p_add_ratio);
            jQuery(tr).append(td4);

            jQuery(showratio).append(tr);

        }
    });
}

//点击浮动层的某一条，修改列表中对应的条目（同一个product_id，不同的社保产品）
//同时，重新根据新的产品判断基数范围，并且重新计算金额
function updatetoTbody(obj) {
    var showratio = jQuery(obj);//div浮动层被点击的行对象
    var product_id = jQuery(showratio).find("input[name='div_product_id']").val();//浮动层被点击的product_id值

    var security_product_id = jQuery(showratio).find("input[name='div_security_product_id']").val();
    var e_ratio = jQuery(showratio).find('td').eq(1).text();
    var p_ratio = jQuery(showratio).find('td').eq(2).text();
    var charge_frequency_bd = jQuery(showratio).find('td').eq(3).text();
    var e_add_ratio = jQuery(showratio).find('td').eq(4).text();
    var p_add_ratio = jQuery(showratio).find('td').eq(5).text();
    var e_precision_bd = jQuery(showratio).find("input[name='div_e_precision_bd']").val();
    var p_precision_bd = jQuery(showratio).find("input[name='div_p_precision_bd']").val();
    var e_caculate_type_bd = jQuery(showratio).find("input[name='div_e_caculate_type_bd']").val();
    var p_caculate_type_bd = jQuery(showratio).find("input[name='div_p_caculate_type_bd']").val();

    var datacell = $id("grdCityEnsureTbody");//datacell列表对象
    var dataset = datacell.dataset;
    var trentity = dataset.findEntity("product_id", product_id);//列表中对应的相同product_id的行
    trentity.setProperty("id", security_product_id);
    trentity.setProperty("e_ratio", e_ratio);
    trentity.setProperty("p_ratio", p_ratio);
    trentity.setProperty("frequency_bd", charge_frequency_bd);
    trentity.setProperty("e_add_ratio", e_add_ratio);
    trentity.setProperty("p_add_ratio", p_add_ratio);
    trentity.setProperty("e_precision_bd", e_precision_bd);
    trentity.setProperty("p_precision_bd", p_precision_bd);
    trentity.setProperty("e_caculate_type_bd", e_caculate_type_bd);
    trentity.setProperty("p_caculate_type_bd", p_caculate_type_bd);

    var base = trentity.getProperty("base");
    if (base != null && base != '') {
        //重新计算该行的各项金额
        anyAmount1(trentity);
        //重新计算总额
        countAllMoney();
    }
}

//显示浮动层
function show(obj) {
    var dc1 = $id("grdCityEnsureTbody");
    var activeRow = dc1.activeRow;
    var entity = dc1.getEntity(activeRow);
    var group_id = entity.getProperty("group_id");
    var id = entity.getProperty("id");
    //先调用ajax查询与所选社保产品属于同一产品的社保产品列表，加载到浮动层div中
    toappenddiv(group_id, id);

    window.event.cancelBubble = true;
    var divId = document.getElementById("div1");
    var cellPosition = getPosition(dc1.activeCell);

    divId.style.left = cellPosition.left + dc1.activeCell.offsetWidth + 2;
    divId.style.top = cellPosition.top + dc1.activeCell.offsetHeight + 2;
    divId.style.width = "500";
    divId.style.heigth = "400";
    divId.style.background = '#FFFFFF';
    divId.style.display = "block";

}
//点击其他位置，隐藏浮动层
function hideDiv() {
    var divId = document.getElementById("div1");
    //alert(event.srcElement.tagName);
    if (!checkEventObj(event.srcElement, "div1"))
        divId.style.display = "none";
}

function checkEventObj(obj, idName) {
    //alert(obj.tagName);
    if (obj && obj.tagName) {
        if (obj.tagName == "BODY") {
            return false;
        }
        if (obj.id == idName) {
            return true;
        }
        else {
            return checkEventObj(obj.parentElement, idName);
        }
    }
    return;
}


//****************************以下为计算金额的js方法******************************

//工资改变，同步更新产品列表中基数
function anySecury() {
    //必须先输入入职日期
    var applydate = $id("apply_on_post_date").getValue();
    if (applydate == null || applydate == '') {
        alert('请先输入员工入职日期！');
        $id("salary").value = '';
        return;
    }

    //必须先输入收费起始日期
    var chargedate = $id("charge_start_date").getValue();
    if (chargedate == null || chargedate == '') {
        alert('请先输入收费起始日期！');
        $id("salary").value = '';
        return;
    }

    var salary = jQuery("#salary").val();
    if (checkFloat(salary)) {
        salary = salary.replace(',', '');
        $id("salary").value = salary;
        //统一批量设置基数值
        //var tbodytr =$('#grdCityEnsureTbody');//列表对象
        //$(tbodytr).find("input[name='base']").val(salary);

        changeBase(salary);

    } else {
        alert('输入的工资必须为浮点型数值！');
        $id("salary").value = '';

        return;
    }

}

//循环每一行，基数为空的则设为salary，同时计算金额
function changeBase(salary) {
    var datacell = $id("grdCityEnsureTbody");
    var dataset = datacell.dataset;//取得页面的datacell
    for (var i = 0; i < dataset.getLength(); i++) {
        if (dataset.get(i).getProperty("base") == null || dataset.get(i).getProperty("base") == '') {
            var curEnt1 = dataset.get(i);
            curEnt1.setProperty("base", salary);
            var security_product_id = dataset.get(i).getProperty("id");
            anyAmount1(curEnt1);
        }
        //datacell.refreshRow(datacell.getRow(i));
    }
    //重新计算总额
    //countAllMoney();


}

//判断本组其他行，根据是否绑定基数判断是否要统一替换基数，替换的行，执行这几行的金额计算
function anyAmount() {
    var datacell = $id("grdCityEnsureTbody");

    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset

    //var datasettr = dataset.findEntity("id", security_product_id);
    var base = datasettr.getProperty("base");

    //必须先输入入职日期
    var applydate = $id("apply_on_post_date").getValue();
    if (applydate == null || applydate == '') {
        alert('请先输入员工入职日期！');
        datasettr.setProperty("base", "");
        return;
    }

    //必须先输入收费起始日期
    var chargedate = $id("charge_start_date").getValue();
    if (chargedate == null || chargedate == '') {
        alert('请先输入收费起始日期！');
        datasettr.setProperty("base", "");
        return;
    }

    if (checkFloat(base)) {
        base = base.replace(',', '');
        datasettr.setProperty("base", base);
        //anyAmount1(security_product_id);//本行重新计算
        changeBase1(datasettr);//本组其他行的操作
    } else {
        alert('输入的产品基数必须为浮点型数值！');
        datasettr.setProperty("base", "");
        return;
    }

}

//循环本组的每一行，判断是否绑定基数
//如果是1,则本组所有行基数设为salary，同时计算金额
//如果是0，则只改本行的基数
function changeBase1(datasettr) {
    var datacell = $id("grdCityEnsureTbody");
    var dataset = datacell.dataset;//取得页面的datacell
    var group_id = datasettr.getProperty("group_id");
    var base = datasettr.getProperty("base");
    //base=base.replace(',','');
    //取得同一组的所有行
    for (var i = 0; i < dataset.getLength(); i++) {
        if (dataset.get(i).getProperty("group_id") != null && dataset.get(i).getProperty("group_id") == group_id) {
            //基数类型为1的，要统一设置为一致
            if (dataset.get(i).getProperty("bind_radix_bd") == '1') {
                dataset.get(i).setProperty("base", base);
            } else {//修改基数为空的值
                if (dataset.get(i).getProperty("base") == '') {
                    dataset.get(i).setProperty("base", base);
                }
            }
            //计算金额
            var curEntity = dataset.get(i);
            anyAmount1(curEntity);
        }
        //datacell.refreshRow(datacell.getRow(i));
    }

    //重新计算总额
    //countAllMoney();

}

//某个产品的基数变动，重新计算各项金额
function anyAmount1(datasettr) {
    var datacell = $id("grdCityEnsureTbody");
    var dataset = datacell.dataset;//取得页面的datacell
    var base = datasettr.getProperty("base");
    var security_product_id = datasettr.getProperty("id");
    //base=base.replace(',','');
    //必须先输入收费起始日期
    var chargedate = $id("charge_start_date").getValue();
    if (chargedate == null || chargedate == '') {
        alert('请先输入收费起始日期！');
        $id("salary").value = '';
        return;
    }

    //取得年月，判断时间段范围
    var date = chargedate.split('-');
    var month = date[0] + date[1];


    //输入的基数数值判断是否超过上下限,如果超过了，则设为最大值或最小值
    jQuery.getJSON(vpath + "/EmppostAction.do?cmd=searchTopLowById&date=" + new Date() + "", {
        "security_product_id": security_product_id,
        "apply_date": month
    }, function (json) {
        for (var i = 0; i < json.saia.length; i++) {

            if (json.saia[i].personal_low_base != null && base < json.saia[i].personal_low_base) {
                //alert('输入的基数低于个人最小值，自动设为最小值！');
                datasettr.setProperty("base", json.saia[i].personal_low_base);
            }
            if (json.saia[i].personal_top_radix != null && base > json.saia[i].personal_top_radix) {
                //alert('输入的基数高于个人最大值，自动设为最大值！');
                datasettr.setProperty("base", json.saia[i].personal_top_radix);
            }
            if (json.saia[i].personal_fixed_radix != null && json.saia[i].personal_fixed_radix > 0 && base != json.saia[i].personal_fixed_radix) {
                //alert('输入的基数自动设为固定基数！');
                datasettr.setProperty("base", json.saia[i].personal_fixed_radix);
            }

        }
        anyAmount2(datasettr);
        for (var i = 0; i < dataset.getLength(); i++) {
            datacell.refreshRow(datacell.getRow(i));
        }
    });
}


//结合企业比例、个人比例等信息，调用公式重新计算各项金额
function anyAmount2(datasettr) {

    var e_ratio = datasettr.getProperty("e_ratio");
    var p_ratio = datasettr.getProperty("p_ratio");
    var e_add_ratio = datasettr.getProperty("e_add_ratio");
    var p_add_ratio = datasettr.getProperty("p_add_ratio");
    if (!checkFloat(e_ratio)) {
        alert('输入的企业比例必须为浮点型数值！');
        datasettr.setProperty("e_ratio", "0");
        return;
    }
    if (!checkFloat(p_ratio)) {
        alert('输入的个人比例必须为浮点型数值！');
        datasettr.setProperty("p_ratio", "0");
        return;
    }
    if (!checkFloat(e_add_ratio)) {
        alert('输入的企业附加金额必须为浮点型数值！');
        datasettr.setProperty("e_add_ratio", "0");
        return;
    }
    if (!checkFloat(p_add_ratio)) {
        alert('输入的个人附加金额必须为浮点型数值！');
        datasettr.setProperty("p_add_ratio", "0");
        return;
    }
    //调用后台函数计算，得到金额，企业金额，个人金额
    calculateInsurance(datasettr);

    countAllMoney();

}

//企业比例有变动（社保产品id有变动），重新计算各项金额
function anyAmount3() {

    var datacell = $id("grdCityEnsureTbody");

    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
    //var datasettr = dataset.findEntity("id", security_product_id);

    var e_ratio = datasettr.getProperty("e_ratio");
    var p_ratio = datasettr.getProperty("p_ratio");
    var e_add_ratio = datasettr.getProperty("e_add_ratio");
    var p_add_ratio = datasettr.getProperty("p_add_ratio");

    datasettr.setProperty("e_ratio", e_ratio.replace(',', ''));
    datasettr.setProperty("p_ratio", p_ratio.replace(',', ''));
    datasettr.setProperty("e_add_ratio", e_add_ratio.replace(',', ''));
    datasettr.setProperty("p_add_ratio", p_add_ratio.replace(',', ''));

    if (!checkFloat(e_ratio)) {
        alert('输入的企业比例必须为浮点型数值！');
        datasettr.setProperty("e_ratio", "0");
        return;
    }
    if (!checkFloat(p_ratio)) {
        alert('输入的个人比例必须为浮点型数值！');
        datasettr.setProperty("p_ratio", "0");
        return;
    }
    if (e_ratio > 1) {
        alert('输入的企业比例数值不能大于1！');
        datasettr.setProperty("e_ratio", "0");
        return;
    }
    if (p_ratio > 1) {
        alert('输入的个人比例数值不能大于1！');
        datasettr.setProperty("p_ratio", "0");
        return;
    }
    if (!checkFloat(e_add_ratio)) {
        alert('输入的企业附加金额必须为浮点型数值！');
        datasettr.setProperty("e_add_ratio", "0");
        return;
    }
    if (!checkFloat(p_add_ratio)) {
        alert('输入的个人附加金额必须为浮点型数值！');
        datasettr.setProperty("p_add_ratio", "0");
        return;
    }
    //调用后台函数计算，得到金额，企业金额，个人金额
    calculateInsurance(datasettr);

    countAllMoney();


}


//企业金额或个人金额有变动，同步计算总额
function countMoney() {
    var datacell = $id("grdCityEnsureTbody");

    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
    //var datasettr = dataset.findEntity("id", security_product_id);

    var e_money = datasettr.getProperty("e_money");
    var p_money = datasettr.getProperty("p_money");
    datasettr.setProperty("e_money", e_money.replace(',', ''));
    datasettr.setProperty("p_money", p_money.replace(',', ''));
    if (!checkFloat(e_money)) {
        alert('输入的企业金额必须为浮点型数值！');
        datasettr.setProperty("e_money", "0");
        return;
    }
    if (!checkFloat(p_money)) {
        alert('输入的个人金额必须为浮点型数值！');
        datasettr.setProperty("p_money", "0");
        return;
    }

    var eMoney = 0, pMoney = 0, money = 0;
    if (e_money + p_money > 0) {
        eMoney = getNumber(e_money);
        pMoney = getNumber(p_money);
        money = eMoney + pMoney;

        datasettr.getProperty("e_money", eMoney.toFixed(4));
        datasettr.setProperty("p_money", pMoney.toFixed(4));
        datasettr.setProperty("money", money.toFixed(4));
    }

    //datacell.refresh();
    //重新计算总额
    countAllMoney();
}

//收费起始月有变动，所有为空的都同步更新
function anyStartDate() {
    var datacell = $id("grdCityEnsureTbody");
    var dataset = datacell.dataset;//取得页面的datacell

    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
    //var datasettr = dataset.findEntity("id", security_product_id);

    var sf_start_date = datasettr.getProperty("sf_start_date");

    if (!checkMonth(sf_start_date, '收费起始月')) {
        datasettr.setProperty("sf_start_date", "");
        return;
    }

    for (var i = 0; i < dataset.getLength(); i++) {
        if (dataset.get(i).getProperty("sf_start_date") == null || dataset.get(i).getProperty("sf_start_date") == '') {
            dataset.get(i).setProperty("sf_start_date", sf_start_date);
            //datacell.refreshRow(datacell.getRow(i));
        }
    }

    datacell.refresh();

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

//产品某一行的金额有变化，则修改总额
function anyMoney(obj) {
    var datacell = $id("celllist1");
    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
    var money = datasettr.getProperty("amount");

    if (!checkFloat(money)) {
        alert('输入的金额必须为浮点型数值！');
        datasettr.setProperty("amount", v_amount);
        return;
    }
    //重新计算总额
    countAllMoney();

}

//计算社保产品和福利产品总额
function countAllMoney(isInvoice) {
    var dataSet1 = $id("celllist1").dataset;
    var allMoney = 0.00;
    for (var i = 0; i < dataSet1.getLength(); i++) {
        var mm = dataSet1.get(i);
        allMoney += addAmount(mm, "amount");
        if (!!isInvoice) {
            allMoney += addAmount(mm, "VAT_mount");
        }
    }

    $id("invoice_amount").value = allMoney.toFixed(2);
    $id("view_invoice_amount").innerText = allMoney.toFixed(2);
}

function addAmount(mm, property) {
    var amount = mm.getProperty(property);
    try {
        amount = parseFloat(amount);
    } catch(E) {
        amount = 0.00;
    }
    mm.setProperty(property, amount);
    return amount;
}

//验证输入的金额格式
function checkaddoney(fieldname, msgname) {
    var datacell = $id("grdCityEnsureTbody");
    var activeRow = datacell.activeRow;
    var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
    var e_money = datasettr.getProperty(fieldname);
    e_money = e_money.replace(',', '');
    datasettr.setProperty(fieldname, e_money);
    if (!checkFloat(e_money)) {
        alert('输入的' + msgname + '必须为浮点型数值！');
        datasettr.setProperty(fieldname, "0");
        return;
    }

}

//验证输入的金额格式
function checkallmoney() {
    var allmoney = $id("allmoney").value;
    allmoney = allmoney.replace(',', '');
    jQuery("#allmoney").val(allmoney);
    if (!checkFloat(allmoney)) {
        alert('输入的订单总额必须为浮点型数值！');
        datasettr.setProperty(fieldname, "0");
        return;
    }

}

