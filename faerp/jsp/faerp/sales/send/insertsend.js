function IsTelephone(obj) { // 正则判断
	var pattern = /(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)/;
	if (pattern.test(obj)) {
		return true;
	} else {
		return false;
	}
}

function insert_onClick(saveOrUpdate) { // 插入单条数据
    if (checkSubmit(saveOrUpdate)) {//yangyuting 2014-7-16判断提交的是更新还是新增
		// 有ID表示修改委派单，此ID为修改的委派单ID
		var id = _$("#id").val();
		_$.ajax({
			type : "post",
			data : _$("form").serialize(),
			url : venusbase + "/SendAction.do?cmd=checkInsert",// &contract_id="
			// + contract_id
			// +
			// "&cust_send_id="
			// +
			// cust_send_id,
			dataType : "html",
			success : function(data) {
				if (data) {
					alert(data);
					return false;
				} else {
					if (id) {
						// 修改
						/*form.action = venusbase
								+ "/SendAction.do?cmd=update&city_id="
								+ $id("city_id").getValue();*/
						var action = venusbase
                                + "/SendAction.do?cmd=update&city_id="
                                + $id("city_id").getValue();
                        var myAjax = new Ajax(action);
                        var form =document.getElementById("newupdate");
                        if (form) {
                            for (var i = 0; i < form.elements.length; i++) {
                                var elem = form.elements[i];
                                if (elem.name) {
                                    myAjax.addParam(elem.name,
                                            getElementValue(elem));
                                }
                            }
                        }
                        myAjax.submit();
                        var returnNode = myAjax.getResponseXMLDom();
                        if (returnNode) {
                            alert("" + myAjax.getProperty("returnValue"));
                            /*
                             * window['returnValue'] = "" +
                             * myAjax.getProperty("returnValue");
                             */
                            window.close();
                            window.opener.simpleQuery_onClick();
                        }else{
                            alert("更新失败!");
                        }
					} else {
						// 新增
						/*
						 * form.action = venusbase +
						 * "/SendAction.do?cmd=insert&city_id=" +
						 * $id("city_id").getValue();
						 */
						 //2015-6-5 yangyuting add 判断城市是否为上海该成本中心是否为E化用户
						var cost_center_id=_$("#cost_center_id_hidden").val();
						 var cityId=$id("city_id").getValue();
						 var IsE="0";//为了给下面保存委派单标示是否为E化的委派单所用， 0=非E；1=E化
						 var checkResult=checkIsE(cost_center_id);//
				        if("IsE"==checkResult){
				            IsE="1";
				        }
				        
						var action = venusbase
								+ "/SendAction.do?cmd=insert&city_id="
								+ $id("city_id").getValue()+"&IsE="+IsE;
						var myAjax = new Ajax(action);
						var form = $id("newinsert");
						if (form) {
							for (var i = 0; i < form.elements.length; i++) {
								var elem = form.elements[i];
								if (elem.name) {
									myAjax.addParam(elem.name,
											getElementValue(elem));
								}
							}
						}
						myAjax.submit();
						var returnNode = myAjax.getResponseXMLDom();
						if (returnNode) {
							alert("" + myAjax.getProperty("returnValue"));
							/*
							 * window['returnValue'] = "" +
							 * myAjax.getProperty("returnValue");
							 */
							window.close();
							window.opener.simpleQuery_onClick();
						}else{
							alert("保存失败!");
						}
					}
				}
			}
		});
	}
}

/**
 * author: 马宏敏 提交时验证
 */
function checkSubmit(saveOrUpdate) {
    if (!_$("#send_name").val()) {
        alert('委派单名称不能为空。');
        return false;
    }
    if (!_$("#is_tax").val()) {
        alert('是否FESCO报税不能为空。');
        return false;
    }
    if(_$("#cust_receive_id").val()==AGENT_SH){
        if(!(_$("#city_id_hidden").val()==CITY_ID_SH)){
            alert('城市只能选择上海');
            return false;
        }
    }
    if(_$("#cust_receive_id").val()==AGENT_BJ){
        if(!(_$("#city_id_hidden").val()==CITY_ID_BJ)){
            alert('城市只能选择北京');
            return false;
        }
    }
    if(_$("#cust_receive_id").val()==AGENT_WD){
        if(_$("#city_id_hidden").val()==CITY_ID_SH || _$("#city_id_hidden").val()==CITY_ID_BJ){
            alert('城市只能选择外地');
            return false;
        }
    }
    //2014-6-25 yangyuting modify
    if(saveOrUpdate=="save"){//yangyuting 2014-7-16判断提交的是更新还是新增
        if (!_$("#cost_center_id_hidden").val()) {
            alert('成本中心不能为空');
            return false;
        }
    }
//  if (!_$("#cost_center_id").val()) {
//      alert('成本中心不能为空。');
//      return false;
//  }

	// 账单日
	var payment_day = _$("#payment_day").val();
	if (!payment_day) {
		alert('账单日不能为空。');
		return false;
	} else {
		if (!isNumber(payment_day)) {
			alert('账单日期必须为数字。');
			return false;
		} else {
			if (payment_day < 1 || payment_day > 31) {
				alert('日期有效值为1-31。');
				return false;
			}
		}
	}

	var email = _$("#email").val();
	if (email) {
		if (!checkEmail(email)) {
			alert("邮箱格式不正确。");
			return false;
		}
	}

	// 邮编6位数字
	var zip_code = _$("#zip_code").val();
	if (zip_code) {
		if (!isNumber(zip_code)) {
			alert('邮编必须为数字。');
			return false;
		} else {
			if (zip_code.length != 6) {
				alert('邮编必须为6位。');
				return false;
			}
		}
	}

	var subpackage_cost = _$("#subpackage_cost").val();
	if (subpackage_cost) {
		if (!isNaN(subpackage_cost)) {
		} else {
			alert('分包费用的金额格式不正确。');
			return false
		}
	}

	if (!_$("#security_unit_id_hidden").val()) {
		alert('社保福利办理方不能为空。');
		return false;
	}
	
	if (!_$("#fund_security_unit_id_hidden").val()) {
        alert('公积金福利办理方不能为空。');
        return false;
    }
    
    if (!_$("#hire_security_unit_id_hidden").val()) {
        alert('用退工福利办理方不能为空。');
        return false;
    }

	if (!_$("#is_employ_notice").val()) {
		alert("是否有入职通知不能为空。");
		return false;
	}

	if (!_$("#is_handicapped_monthly_bd").val()) {
		alert("是否月付残保金不能为空。");
		return false;
	}
	if ($id("city_id").getValue() == "") {
		alert("省市不能为空!");
		return false;
	}
    
    if (_$("#is_preget").val() == "") {
        alert("收费属性不能为空!");
        return false;
    }
  //2015-6-9 yangyuting add 
   var is_laborbook=_$("#is_laborbook").val();   
   if ($id("city_id").getValue() == "1099110100000000050"&&(null==is_laborbook||""==is_laborbook)) {
        alert("省市为上海,'是否劳动手册'为必选项!");
        return false;
    }
	return true;
}

// 验证邮箱
function checkEmail(el) {
	var regu = "^(([0-9a-zA-Z]+)|([0-9a-zA-Z]+[_.0-9a-zA-Z-]*[0-9a-zA-Z-]+))@([a-zA-Z0-9-]+[.])+([a-zA-Z]|net|NET|asia|ASIA|com|COM|gov|GOV|mil|MIL|org|ORG|edu|EDU|int|INT|cn|CN|cc|CC)$"
	var re = new RegExp(regu);
	if (el.search(re) == -1) {
		return false;
	}
	return true;
}

/**
 * 查找合同
 */
function toFindContract(obj) {
	$id("contract_id").value = obj[0];
	$id("contract_id").displayValue = obj[1];// 显示合同名称
	_$("#contract_id_hidden").val(obj[0]);
	document.form.customer_name.value = obj[3];// 显示客户名称
	document.form.customer_id.value = obj[5];
	sendinsert();
	// alert("aaa");
}

// 选择合同甲方
function rtnFunc(arg) {
	var lookup = $id("cust_send_id");
	lookup.value = arg[0];
	lookup.displayValue = arg[1];
	_$("#cust_send_name").val(arg[1]);
	// arg[2]为code
}

function rtnFunc1(arg) {
	var lookup = $id("cust_receive_id");
	lookup.value = arg[0];
	lookup.displayValue = arg[1];
	_$("#cust_receive_id").val(arg[1]);
}

function rtnFunc2(arg) {
	var lookup = $id("cust_payee_id");
	lookup.value = arg[0];
	lookup.displayValue = arg[1];
	_$("#cust_payee_id").val(arg[1]);
}

function rtnFunc3(arg) {
	var lookup = $id("cust_bill_id");
	lookup.value = arg[0];
	lookup.displayValue = arg[1];
	_$("#cust_bill_id").val(arg[1]);
}

function contractdetail() {
	var id = document.getElementById('contract_id_hidden').value;
	if (id == null || id == '') {
		alert('请选择合同');
		return;
	}
	var ids = window
			.showModalDialog(
					venusbase + '/SendAction.do?cmd=detailSal&id=' + id
							+ '&detail=detail&date=' + new Date(),
					'',
					'dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
	if (ids == undefined)
		return;
}

/**2015-6-5 yangyuting add 查询该成本中心是否为E化户 **/
function checkIsE(cost_center_id){
	 var isE="";
// 检查该成本中心户是否是E化户，
       jQuery.ajax({
             url: venusbase+'/QuickemppostAction.do?cmd=checkIsEByCostCenterId&cost_center_id='+cost_center_id,
             type: 'GET',
             dataType: 'html',
              async: false,
             timeout: 80000,
             error: function(){
                 alert('查询该客户是否为E化客户失败， 请联系管理员。');
             },
             success: function(text){
                 if(text!=null){     
                    if(text=="0"){//非E化
                         isE= "NotE";
                     } 
                     else {//是E化
                      /** if(is_laborbook=="1"){//劳动手册=1
                            isE= "IsE_1";
                         }else{//劳动手册=0 or null
                            alert("该委派的成本中心为E化户,'是否劳动手册',必须选择是！");
                             isE= "IsE_0";
                         }  
                         **/ 
                         isE="IsE";
                     }
                 }
             }
             });
	return isE;
}
