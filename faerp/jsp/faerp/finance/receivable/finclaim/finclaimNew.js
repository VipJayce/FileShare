_$(document).ready(function() {
    if(_$("#bill_whether_write_off").val()=='1'){
        _$("#lk_cust_id_button").hide();
        _$("#cost_center_id_button").hide();
        //_$("#cost_center_id_input").attr("disabled", true);
        _$("#bill_year_month").attr("disabled", true);
        writeTable4_1Row(_$("#bill_whether_write_off").val(),_$("#inc_name").val());//财务登录后执行查询 条件为没有客户id 没有成本中心，仅有金额条件
    }
      

    //页面加载的时候，默认页签3中的div_3中的input为disabled
    _$("#div_3 input").attr("disabled", true);
    _$("#div_1 input").removeAttr("disabled");
    
    //如果从预收进来，那么差额做为未认领不能选中
    if (_$("#balanceAmount").val() == '1' ) {
        _$("#claimingall2").attr("disabled", true);
        _$("#claimingall4").attr("disabled", true);
        _$("#claimingall6").attr("disabled", true);
        //选择预收
        _$("#claimingall1").attr("checked", true);
    }

    /**
     * 选择客户
     */
    if ($id("lk_cust_id")) {
        $id("lk_cust_id").onReturnFunc = function (returnValue){
            var lookup = $id("lk_cust_id");
            lookup.value = returnValue[0];
            _$("#cust_id").val(returnValue[0]);
            _$("#cust_code").val(returnValue[1]);
            _$("#cust_name").val(returnValue[2]);
            _$("#is_zhongliang").val(returnValue[5]);//2015-10-27 yangyuting add 
            //是否有汇差
            var is_remittance_error = returnValue[3];
            _$("#is_remittance").val(is_remittance_error);
            var is_finance_invoice = returnValue[4];
            _$("#is_finance_invoice").val(is_finance_invoice);
            checkRemIsReadonly();
            lookup.displayValue = returnValue[2];
            $id("cost_center_id").addParam("cust_id", returnValue[0]);
            $id("cost_center_id").loadData();
            $id("cost_center_id").refresh();
            return false;
        }
    }
    
    //如果是从预收进来，那么，页面加载时就会把客户信息放入到cust_id的input中
    var cust_id = _$("#cust_id").val();
    if (cust_id && $id("cost_center_id")) {
        //等combselect全部加载完后再根据cust_id带出成本中心
        $id("cost_center_id").afterInit = function () {
            $id("cost_center_id").addParam("cust_id", cust_id);
            $id("cost_center_id").loadData();
            $id("cost_center_id").refresh();
            _$("#cost_center_name").val(_$("#cost_center_id_input").val());
        }
    }

    /**
     * 选择成本中心后，写入hidden
     */
    if ($id("cost_center_id")) {
        $id("cost_center_id").onChangeFunc = function() {
           _$("#cost_center_name").val(_$("#cost_center_id_input").val());
           //alert(_$("#is_finance_invoice").val())
        }
    }

    // 鼠标离开账期后，AJAX获取数据，写入table
    if(_$("#bill_whether_write_off").val()!='1'){
    _$("#bill_year_month").bind("blur", function() {
        //有汇差，显示汇差，把汇差的只读属性去掉
    	_$("#div_1 input[id='txt_odd']").val('0');
        _$("#div_1 input[id='txt_rem']").val('0');
        
        _$("#div_1 label[id='v_yu_e']").text("");
        _$("#div_1 label[id='v_yu_e_input']").text("");
         
        checkRemIsReadonly();
        YMblueAndKdown(_$(this));
        _$("#balanceAmount").val('3');
        _$("#div_1 label[id='sumv']").text(0);
        _$("#div_1 input[id='sumv_h']").val(0);
        _$("#v_n_sumv_h").val("0");
        _$("#v_bill_id").val("");
        showt();
    })};
    
// ====================================点击table1（全部认领）的全部认领的全选按钮 BEGIN =============================
    //全选按钮已取消，checkbox改为radio
    if (_$("#chkall")) {
        _$("#chkall").click(function() {
            var flag = false;
            // 因为出不来$(this).attr("checked")，所以这里转为flag
            if (_$(this).attr("checked")) {
                flag = true;
            } else {
                flag = false;
            }
            _$("#table1 :checkbox").attr("checked", flag);// 为什么不能用？
            // 加减计算
            var sum = 0;
            _$("input[id^='bam_']").each(function() {
                var checkbox = _$(this).parents("tr").children().children()[0];
                if (_$(checkbox).attr("checked")) {
                    //判断有无余额
                    var osa = Math.abs(_$(this).parents("tr").find("input[name='osa']").val());
                    if (osa != "" && osa != '0') {
                        sum += parseFloat(osa);
                    } else {
                        sum += parseFloat(_$(this).val());
                    }
                }
            });
            sum = sum.toFixed(4);
            _$("#div_1 label[id='sumv']").text(fmoney(sum, 4));
            _$("#div_1 input[id='sumv_h']").val(sum);
            showt();
        });
    }
    
    _$("#table1 tr").live("click", function() {
    	_$("#div_1 input[id='txt_odd']").val('0');
        _$("#div_1 input[id='txt_rem']").val('0');
        //var checkbox = _$(this).children().children()[0];
        var checkbox = _$(this).find("input[type='radio']");
        checkbox.attr("checked", "checked");
        var sum = 0;
        //未认领金额
        var un1 =Number( _$("#un_claim_amout_h").val());
               un1 = un1.toFixed(4);
        var small_amount =0; 
        //因为之前是checkbox，且可以多选，所以这样遍历选中的
        //现在改为了redio，但这里不改，仍然满足要求
        _$("input[id^='bam_']").each(function() {
            checkbox = _$(this).parents("tr").children().children()[0];
            if (_$(checkbox).attr("checked")) {
                //var hidval = _$(this).val();//?hidval没有找到？
                //sum += parseFloat(hidval);
                //判断有无余额
            	//alert("账单ID："+_$(this).parents("tr").find("input[name='bill_ids']").val());
            	//////////////////认领的账单ID
            	_$("#v_bill_id").val(_$(this).parents("tr").find("input[name='bill_ids']").val());
                var osa = Math.abs(_$(this).parents("tr").find("input[name='osa']").val());
                var smallA=_$(this).parents("tr").find("input[name='smallamount']").val();
                if (osa != "" && osa != '0') {
                    sum += parseFloat(osa);
                } else {
                    sum += parseFloat(_$(this).val());
                }
                   if (smallA != "" && smallA != '0') {
                    small_amount += parseFloat(smallA);
                } else {
                    small_amount += parseFloat(0);//如果为空 则给0值
                }
            }
        });
        sum = sum.toFixed(4);
        var adv_h = _$("#adv_h").val();
        //alert("sum="+sum);
        if(parseFloat(adv_h)>0){//注释  有预收 
        	    
                    if((parseFloat(un1)+parseFloat(adv_h)) >=parseFloat(sum)){
                    _$("#div_1 label[id='sumv']").text(fmoney(sum, 4));
                    _$("#div_1 input[id='sumv_h']").val(parseFloat(sum).toFixed(3));
                    _$("#div_1 input[id='v_n_sumv_h']").val(parseFloat(sum).toFixed(3));
                    }else{
                                _$("#div_1 label[id='sumv']").text(fmoney(sum, 4));//
                                _$("#div_1 input[id='v_n_sumv_h']").val(parseFloat(sum).toFixed(3));
                                _$("#div_1 input[id='sumv_h']").val((parseFloat(un1)+parseFloat(adv_h)).toFixed(4));
                    }
                    
        }else{
        	       
        	        if(parseFloat(un1) >=parseFloat(sum)){
                    _$("#div_1 label[id='sumv']").text(fmoney(sum, 4));
                    _$("#div_1 input[id='sumv_h']").val(parseFloat(sum).toFixed(3));
                    _$("#div_1 input[id='v_n_sumv_h']").val(parseFloat(sum).toFixed(3));
                    }else{
                                _$("#div_1 label[id='sumv']").text(fmoney(sum, 4));//
                                _$("#div_1 input[id='v_n_sumv_h']").val(parseFloat(sum).toFixed(3));
                                _$("#div_1 input[id='sumv_h']").val(parseFloat(un1).toFixed(4));

                    }
        }

        /////////////////////////////////////////////////////////////////////////
        if(sum>0){
                var checkboxflag = false;
                _$("#advancestable :checkbox").each(function(i) {
                    if (i > 0) {
                        if (_$(this).attr("checked")) {
                            checkboxflag = true;
                        } else {
                            checkboxflag = false;
                            return false; 
                        }
                    }
                });
                
               var advsum = parseFloat(_$("#adv_h").val());
               var balanceflag = _$("#balanceflag").val();
               if(balanceflag!=""&&balanceflag){
                        _$("#balanceAmount").val('1');
               }else if(parseFloat(sum)>0&&(parseFloat(advsum)>0)){
                        _$("#balanceAmount").val('2');
               }else{
                        _$("#balanceAmount").val('3');
               }
               //showt();
        }
        /////////////////////////////////////////////////
        //当未认领金额大于应收金额
         var balance = parseFloat(un1) - parseFloat(sum);
        if (Math.abs(balance) <= 10) {
                _$("#div_1 label[id='v_yu_e']").text("");
                _$("#div_1 label[id='v_yu_e_input']").text("");

                var v_txt_rem = _$("#div_1 input[id='txt_rem']").val();
                
                       if(balance=="0"||balance==""){
                              balance="0";
                       }
            
                       if(sum=="0"||sum==""){
                              sum="0";
                       }
                       
                       if(v_txt_rem=="0"||v_txt_rem==""){
                              v_txt_rem="0";
                       }
                var v_txt_ver=parseFloat(sum)+parseFloat(balance)+parseFloat(v_txt_rem);;
               //如果差额在10块钱以内，
                if (Math.abs(balance) <= 10) {
                        //_$("#div_1 input[id='txt_rem']").val("0");
                        _$("#div_1 input[id='txt_odd']").val(parseFloat(balance).toFixed(2));
                        //_$("#div_1 input[id='v_txt_odd']").val(parseFloat(balance).toFixed(2));
                        _$("#div_1 input[id='txt_ver']").val(v_txt_ver.toFixed(4));
                        _$("#div_1 input[id='sumv_h']").val(v_txt_ver.toFixed(4));
                    //alert("ver2="+ver);
                }else{
                        _$("#div_1 input[id='txt_ver']").val(parseFloat(sum).toFixed(4));
                }
                
        }else{//当未认领金额小于应收金额时
        	 _$("#div_1 label[id='v_yu_e']").text("+余额");
        	 _$("#div_1 label[id='v_yu_e_input']").text("+"+(parseFloat(sum)-parseFloat(un1)));
        	 _$("#div_1 input[id='txt_ver']").val(un1);//sumv_h
             //alert("当未认领金额小于应收金额时");
        }
        showt();
        if( small_amount!="0"&&small_amount != ""  ){
        _$("#div_1 input[id='txt_odd']").val(Number(small_amount));//更新小额，计算完成后锁定
        //_$("#div_1 input[id='txt_odd']").blur();
        _$("#div_1 input[id='txt_odd']").attr("readonly", "readonly");
        if((Math.abs(balance)-Math.abs(small_amount)) > 10){
        _$("#div_1 input[id='txt_odd']").blur();
        }
        }
         if(_$("#bill_whether_write_off").val()=='1'){
             var bill_year_month = _$(this).find("input[id='billyearmonth']").val();
             document.getElementById("bill_year_month").value = bill_year_month;
         }
    });
    
// ====================================点击table1（全部认领）的全部认领的全选按钮 END =============================
//预收款明细表的全选按钮
    _$("#chk_adv_all").bind("click", function() {
        var flag = false;
        // 因为出不来_$(this).attr("checked")，所以这里转为flag
        if (_$(this).attr("checked")) {
            flag = true;
        } else {
            flag = false;
        }
       var v_sum=_$("#sumv_h").val();
               
       if(v_sum=="0.0000"){
                v_sum = _$("#div_3 input[id='sumv_h']").val();
        }
       var un1 =Number( _$("#un_claim_amout_h").val());
       var v_txt_difference =Number( _$("#txt_difference").val());
    	/////////////////////////////////////////////////////////////////////////////////////////////////////////
    	if(parseFloat(v_sum)>parseFloat(un1)){
                     if(!flag){//未选择预收
                        //alert("到款额不够必须使用预收11！");
                        _$("#balanceAmount").val('1');
                            _$("#advancestable :checkbox:gt(0)").attr("checked", true);
                             var flag = false;
                            _$("#advancestable :checkbox").each(function(i) {
                                if (i > 0) {
                                    if (_$(this).attr("checked")) {
                                        flag = true;
                                    } else {
                                        flag = false;
                                        return false;
                                    }
                                }
                            });
                            _$("#chk_adv_all").attr("checked", flag);
                            var advsum = 0;
                            _$("input[id^='adbl_']").each(function() {
                                var chk = _$(this).parents("tr").children().children()[0];
                                if (_$(chk).attr("checked")) {
                                    advsum += parseFloat(_$(this).val());
                                }
                            });
                            _$("#adv_h").val(advsum);
                            if(v_txt_difference<0){
                                if(advsum<=0){
                                       _$("#balanceAmount").val('3');
                                }else{
                                       _$("#balanceAmount").val('2');
                                }
                                showt();
                            }
                            
                     }else{}
                    flag = true;
                }
                
    	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
        _$("#advancestable :checkbox").attr("checked", flag);
        if(flag){
             _$("#balanceAmount").val('1');
        }else{
        	_$("#balanceAmount").val('3');
        }
        //累计预收金额
        var advsum = 0;
        _$("input[id^='adbl_']").each(function() {
            var chk = _$(this).parents("tr").children().children()[0];
            if (_$(chk).attr("checked")) {
                advsum += parseFloat(_$(this).val());
            }
        });
        
        _$("#adv_h").val(advsum);

        //写预收对应的核销ID
        _$("input[name='adv_verids_copy']").each(function(){
            var chk = _$(this).parents("tr").find(":checkbox");
            if (_$(chk).attr("checked")) {
                _$(this).parents("tr").find("input[name='adv_verids']").val(_$(this).val());
            } else {
                _$(this).parents("tr").find("input[name='adv_verids']").val(null);
            }
        });
        
       var balanceflag = _$("#balanceflag").val();
       if(balanceflag!=""&&balanceflag){
                _$("#balanceAmount").val('1');
       }else if(parseFloat(v_sum)>0&&(parseFloat(advsum)>0)){
                _$("#balanceAmount").val('2');
       }
       
       showt();
    });

    //预收款明细表的单选按钮
    _$("#advancestable :checkbox:gt(0)").live("click", function() {
        var flag = false;
        _$("#advancestable :checkbox").each(function(i) {
            if (i > 0) {
                if (_$(this).attr("checked")) {
                    flag = true;
                } else {
                    flag = false;
                    return false;
                }
            }
        });
        _$("#chk_adv_all").attr("checked", flag);
        var advsum = 0;
        _$("input[id^='adbl_']").each(function() {
            var chk = _$(this).parents("tr").children().children()[0];
            if (_$(chk).attr("checked")) {
                advsum += parseFloat(_$(this).val());
            }
        });
            
        _$("#adv_h").val(advsum);
        showt();
        var copyval = _$(this).parents("tr").find("input[name='adv_verids_copy']").val();
        if (_$(this).attr("checked")) {
            _$(this).parents("tr").find("input[name='adv_verids']").val(copyval);
        } else {
            _$(this).parents("tr").find("input[name='adv_verids']").val(null);
        }
        //应收总额
        var sum=_$("#sumv_h").val();
        if(sum=="0.0000"){
                sum = _$("#div_3 input[id='sumv_h']").val();
        }
        var un1 = _$("#un_claim_amout_h").val();
        var balanceflag = _$("#balanceflag").val();
       //alert(balanceflag+"_______"+parseFloat(sum)+"==============="+parseFloat(advsum));
       if(balanceflag!=""&&balanceflag){
                _$("#balanceAmount").val('1');
       }else if(parseFloat(sum)>0&&(parseFloat(advsum)>0)){
                _$("#balanceAmount").val('2');
       }else{
                _$("#balanceAmount").val('3');
       }
       
       showt();
       
    });

    // 全部认领_页面加载时就显示：到款未认领+预收款-所选应收
    showt(null, true);
    
    //切换页签时，重新执行鼠标离开账单年月事件，并重新执行显示"到款未认领+预收款-所选应收"
    _$("#font1").bind('click', function(){
       YMblueAndKdown(_$("#bill_year_month"));
       _$("#div_3 input").attr("disabled", true);
       _$("#div_1 input").removeAttr("disabled");
       //是否有汇差
        var is_remittance_error = _$("#is_remittance").val();
        if (is_remittance_error == '1') {
                //有汇差，显示汇差，把汇差的只读属性去掉
                _$("#div_1 input[id='txt_rem']").removeAttr("readonly");
                _$("#div_1 input[id='txt_rem']").css({background: "white" });
            } else {
                //无汇差，显示小额
                _$("#div_1 input[id='txt_rem']").attr("readonly", true);
                _$("#div_1 input[id='txt_rem']").css({background: "#f0f0f0" });
            }
       showt();
    });

    _$("#font3").bind('click', function(){
       YMblueAndKdown(_$("#bill_year_month"));
       _$("#div_1 input").attr("disabled", true);
       _$("#div_3 input").removeAttr("disabled");
       //是否有汇差
        var is_remittance_error = _$("#is_remittance").val();
        if (is_remittance_error == '1') {
            //有汇差，显示汇差，把汇差的只读属性去掉
            _$("#div_3 input[id='txt_rem']").removeAttr("readonly");
            _$("#div_3 input[id='txt_rem']").css({background: "white" });
        } else {
            //无汇差，显示小额
            _$("#div_3 input[id='txt_rem']").attr("readonly", true);
            _$("#div_3 input[id='txt_rem']").css({background: "#f0f0f0" });
        }
       showt();
    });
    

    //table3_1(账单)的行点击事件
    _$("#table3_1 tr:gt(0)").live("click", function(){
        showProgressBar();
        var bill_radio = _$(this).children().children().eq(0);//.attr("id");
        _$(bill_radio).attr("checked", "checked");
        var billid = _$(bill_radio).attr("id");
        billid = billid.split("_")[1];
        _$("#billid").val(billid);
        //alert(billid);
        writeTable3Row(billid,1,200);//分页信息
        var t3_sumv_h = 0;
        _$("#div_3 input[id='sumv_h']").val(t3_sumv_h);
        showt();
        //hideProgressBar();
        var sum = 0;
        //是否选择预收
        _$("input[id^='bam_']").each(function() {
            checkbox = _$(this).parents("tr").children().children()[0];
            if (_$(checkbox).attr("checked")) {
                //判断有无余额
                var osa = Math.abs(_$(this).parents("tr").find("input[name='osa']").val());
                if (osa != "" && osa != '0') {
                    sum += parseFloat(osa);
                } else {
                    sum += parseFloat(_$(this).val());
                }
            }
        });
        
         sum = sum.toFixed(4);
        _$("#div_1 label[id='sumv']").text(fmoney(sum, 4));
        _$("#div_1 input[id='sumv_h']").val(sum);
        showt();
        ////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////明细认领只使用预收选中预收
        var v_balanceAmount=_$("#balanceAmount").val();
                if(v_balanceAmount=="1"){
                        var checkboxflag = false;
                        _$("#advancestable :checkbox").each(function(i) {
                            if (i > 0) {
                                if (_$(this).attr("checked")) {
                                    checkboxflag = true;
                                } else {
                                    checkboxflag = false;
                                    return false; 
                                }
                            }
                        });

                     if(!checkboxflag){//未选择预收
                            _$("#balanceAmount").val('1');
                            _$("#advancestable :checkbox:gt(0)").attr("checked", true);
                             var flag = false;
                            _$("#advancestable :checkbox").each(function(i) {
                                if (i > 0) {
                                    if (_$(this).attr("checked")) {
                                        flag = true;
                                    } else {
                                        flag = false;
                                        return false;
                                    }
                                }
                            });
                            _$("#chk_adv_all").attr("checked", flag);
                            var advsum = 0;
                            _$("input[id^='adbl_']").each(function() {
                                var chk = _$(this).parents("tr").children().children()[0];
                                if (_$(chk).attr("checked")) {
                                    advsum += parseFloat(_$(this).val());
                                }
                            });
                            _$("#adv_h").val(advsum);
                            showt();    
                     }
                }
    });

    /*
    //输入核销金额后计算
    var txt_ver = _$("#div_1 input[id='txt_ver']");
    if (txt_ver) {
        _$(txt_ver).keyup(function() {
            var ver_monty = _$.trim(_$("#div_1 input[id='txt_ver']").val());
            if (ver_monty != '') {
                if (!isNaN(ver_monty)) {
                    showt(ver_monty);
                } else if (ver_monty == '-') {
                    //负数，可以通过
                } else {
                    alert("不是数字，请重新输入。");
                    return false;
                }
            } else {
                _$("#div_1 input[id='txt_odd']").val("0");
                _$("#div_1 input[id='txt_rem']").val("0");
                    
            }
        });
    }
    */
    //////小额输入验证
    var txt_odd = _$("#div_1 input[id='txt_odd']");
    if (txt_odd) {
        _$(txt_odd).keyup(function() {
        	var v_txt_odd = _$.trim(_$("#div_1 input[id='txt_odd']").val());
            if (v_txt_odd != '') {
                if (!isNaN(v_txt_odd)) {
                } else if (v_txt_odd == '-') {
                        //负数，可以通过
                } else {
                    alert("不是数字，请重新输入。");
                    _$("#div_1 input[id='txt_odd']").val("0");
                    return false;
                }
            }
        });
        
        
        _$(txt_odd).blur(function() {
        	var v_txt_odd = _$.trim(_$("#div_1 input[id='txt_odd']").val());
        	//alert("v_txt_odd="+v_txt_odd);
            var v_txt_rem = _$.trim(_$("#div_1 input[id='txt_rem']").val());
            var v_sumv = _$("#sumv").text().replace(/,/g, "");
               if(v_txt_odd=="0"||v_txt_odd==""){
                      v_txt_odd="0";
               }
    
               if(v_txt_rem=="0"||v_txt_rem==""){
                      v_txt_rem="0";
                      //_$("#div_1 input[id='txt_odd']").val(v_txt_odd);
               }
            var v_sumv_h=parseFloat(v_sumv)+parseFloat(v_txt_odd)+parseFloat(v_txt_rem);
            if (v_txt_odd != '') {
                if (!isNaN(v_txt_odd)) {
                	       //alert("v_sumv_h="+v_sumv_h.toFixed(4));
                           if((parseFloat(v_txt_odd)<=10)&&(parseFloat(v_txt_odd)>=-10)){
                               //var v_txt_ver=parseFloat(v_sumv)+parseFloat(v_txt_odd);
                               _$("#div_1 input[id='txt_ver']").val(v_sumv_h.toFixed(4));
                               _$("#div_1 input[id='sumv_h']").val(v_sumv_h.toFixed(4));
                               _$("#div_1 input[id='v_txt_odd']").val(parseFloat(v_txt_odd));//页面保存小额调整
                           }else{
                               alert("小额调整范围为-10至10之间！");
                               _$("#div_1 input[id='txt_odd']").val(_$("#div_1 input[id='v_txt_odd']").val());
                               _$("#div_1 input[id='txt_rem']").val(v_txt_rem);
                               return false;
                           }
                } else if (v_txt_odd == '-') {
                	               alert("不是数字，请重新输入。");
                                    _$("#div_1 input[id='txt_rem']").val("0");
                                    return false;
                        //负数，可以通过
                        if((parseFloat(v_txt_odd)<=10)&&(parseFloat(v_txt_odd)>=-10)){
                               _$("#div_1 input[id='txt_ver']").val(v_sumv_h.toFixed(4));
                               _$("#div_1 input[id='sumv_h']").val(v_sumv_h.toFixed(4));
                               _$("#div_1 input[id='v_txt_odd']").val(parseFloat(v_txt_odd));//页面保存小额调整
                           }else{
                               alert("小额调整范围为-10至10之间！");
                               _$("#div_1 input[id='txt_odd']").val(_$("#div_1 input[id='v_txt_odd']").val());
                               _$("#div_1 input[id='txt_rem']").val(v_txt_rem);
                               return false;
                           }
                } else {
                    //alert("不是数字，请重新输入。");
                    _$("#div_1 input[id='txt_odd']").val(v_txt_odd);
                    _$("#div_1 input[id='txt_rem']").val(v_txt_rem);
                    return false;
                }
            }
            showt();
        });
        
    }

    
    //////汇差输入验证
    var txt_rem = _$("#div_1 input[id='txt_rem']");
    _$(txt_rem).keyup(function() {
        var v_txt_rem = _$.trim(_$("#div_1 input[id='txt_rem']").val());
        //var v_txt_rem = _$.trim(_$("#div_1 input[id='txt_rem']").val());
        if (v_txt_rem != '') {
            if (!isNaN(v_txt_rem)) {
            } else if (v_txt_rem == '-') {
                    //负数，可以通过
            } else {
                alert("不是数字，请重新输入。");
                _$("#div_1 input[id='txt_rem']").val("0");
                return false;
            }
        }
        
        var v_sum=_$("#v_n_sumv_h").val();
        var txt_odd = _$("#div_1 input[id='txt_odd']").val();
        var txt_ver = _$("#div_1 input[id='txt_ver']").val();
        
        if(txt_odd=="0"||txt_odd==""){
                  txt_odd="0";
         }
        //alert("______"+parseFloat(txt_ver)+"=="+(parseFloat(v_sum)+parseFloat(txt_odd)));
        /*
        if(parseFloat(txt_ver)==(parseFloat(v_sum)+parseFloat(txt_odd))){
        	_$("#div_1 input[id='txt_rem']").val("0");
            return false;
        }
        */
    });
                        
                        
  _$(txt_rem).blur(function() {
  	    var is_remittance_error = _$("#is_remittance").val();
        if (is_remittance_error == '1') {
        var v_txt_rem = _$.trim(_$("#div_1 input[id='txt_rem']").val());
        var v_txt_odd=_$("#div_1 input[id='txt_odd']").val();
        
        var v_sumv = _$("#sumv").text().replace(/,/g, "");
        
          if(v_txt_odd=="0"||v_txt_odd==""){
                  v_txt_odd="0";
           }

           if(v_txt_rem=="0"||v_txt_rem==""){
                  v_txt_rem="0";
                  //_$("#div_1 input[id='txt_rem']").val(v_txt_rem);
           }
        //核销金额=应收金额+小额调整+汇差
        var v_sumv_h=parseFloat(v_sumv)+parseFloat(v_txt_odd)+parseFloat(v_txt_rem);
        //alert("111v_sumv_h="+v_sumv_h.toFixed(4));//_$("#div_1 input[id='sumv_h']").val(v_sumv_h.toFixed(4));
        if (v_txt_rem != '') {
            if (!isNaN(v_txt_rem)) {
                           _$("#div_1 input[id='txt_ver']").val(v_sumv_h.toFixed(4));
                           _$("#div_1 input[id='sumv_h']").val(v_sumv_h.toFixed(4));
                           _$("#v_txt_rem").val(parseFloat(v_txt_rem));//页面保存汇差
            } else if (v_txt_rem == '-') {
            	alert("不是数字，请重新输入。");
                _$("#div_1 input[id='txt_rem']").val("0");
               return false;
               /*
                    //负数，可以通过
                           _$("#div_1 input[id='txt_ver']").val(v_sumv_h.toFixed(4));
                           _$("#div_1 input[id='sumv_h']").val(v_sumv_h.toFixed(4));
                           _$("#v_txt_rem").val(parseFloat(v_txt_rem));//页面保存汇差
                           */
            } else {
                //alert("不是数字，请重新输入。");
                _$("#div_1 input[id='txt_odd']").val(v_txt_odd);
                _$("#div_1 input[id='txt_rem']").val(v_txt_rem);
               return false;
            }
        }
        
        showt();
        }
  });

    //输入核销金额后计算
    var txt_ver = _$("#div_3 input[id='txt_ver']");
    if (txt_ver) {
        _$(txt_ver).keyup(function() {
            var ver_monty = _$.trim(_$("#div_3 input[id='txt_ver']").val());
            if (ver_monty != '') {
                if (!isNaN(ver_monty)) {
                    showt(ver_monty);
                } else if (ver_monty == '-') {
                    //负数，可以通过
                } else {
                    alert("不是数字，请重新输入。");
                    return false;
                }
            } else {
                //小额
                _$("#txt_add").val("");
                //汇差
                _$("#txt_rem").val("");
            }
        });
    }
    
    var txt_odd = _$("#div_3 input[id='txt_odd']");
    if (txt_odd) {
        _$(txt_odd).keyup(function() {
            var ver_monty = _$.trim(_$("#div_3 input[id='txt_odd']").val());
            if (ver_monty != '') {
                if (!isNaN(ver_monty)) {
                } else if (ver_monty == '-') {
                        //负数，可以通过
                } else {
                    alert("不是数字，请重新输入。");
                    return false;
                }
            }
        });
    }
    
    var txt_rem = _$("#div_3 input[id='txt_rem']");
    _$(txt_rem).keyup(function() {
        var ver_monty = _$.trim(_$("#div_3 input[id='txt_rem']").val());
        if (ver_monty != '') {
            if (!isNaN(ver_monty)) {
            } else if (ver_monty == '-') {
                    //负数，可以通过
            } else {
                alert("不是数字，请重新输入。");
                return false;
            }
        }
    });
//======================================明细认领的textbox联动 end===============================
 
});

/**
 * 认领费用账期鼠标离开事件和回车事件时的方法
 */
function YMblueAndKdown(item) {
    showProgressBar();
    if (_$(item).val()) {
        var ym = _$(item).val();
        var flag = isDateString(ym);
        if (flag) {
            if (ym.length == 5) {
                var y = ym.substring(0, 4);
                var m = ym.substring(4, 5);
                m = "0" + m;
                ym = y + m;
                _$(item).val(ym);// 如果日期输入为5位，补0
                // 根据账期进fin_bill搜索匹配数据
            }

            if ((_$("#cost_center_id_hidden").val() != "" && _$("#cost_center_id_hidden").val() != '0')
                    && _$("cust_id").val() != "") {
                if (_$("#TabCon1").css("display") == "block") {
                    _$("#claimval").val("1");
                    writeTable1Row();
                } else if (_$("#TabCon2").css("display") == "block") {
                    _$("#claimval").val("3");
                    writeTable2Row();
                } else if (_$("#TabCon3").css("display") == "block") {
                    _$("#claimval").val("5");
                    writeTable3_1Row();
                }
                //查询发票
                //writeInvoiceTable();
            } else {
                alert('请选择成本中心。');
                hideProgressBar();
            }
            //清空页面临时保存数据的input
            _$("#salary_billid").val("");//仅工资认领时，选中账单后，填写账单ID
        } else {
            alert('请按格式输入日期。');
            hideProgressBar();
            _$("#bill_year_month").val("");
            return false;
        }
    } else {
        //如果没有日期，则清空table
        clearTable();
        hideProgressBar();
    }
}

/**
 * 验证日期
 */
function isDateString(sDate) {
    if (sDate.length > 6 || sDate.length < 5) {
        return false;
    }
    var mp = /\d{4}\d{1,2}/;
    var matchArray = sDate.match(mp);
    if (matchArray == null)
        return false;
    var iaMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    var iaDate = new Array(3);
    var year, month, day;
    year = sDate.substring(0, 4);
    year = parseFloat(year)
    month = sDate.substring(4, 6);
    month = parseFloat(month);
    if (year < 1900 || year > 2100)
        return false;
    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0))
        iaMonthDays[1] = 29;
    if (month < 1 || month > 12)
        return false;
    if (day < 1 || day > iaMonthDays[month - 1])
        return false;
    return true;
}

/**
 * 全部认领 添加行
 */

function writeTable1Row() {
    _$.ajax({
        type : "post",
        url : venusbase + "/FinbillAction.do?cmd=showFinBillByYearmonth",
        data : _$("form").serialize(),
        dataType : "json",
        success : function(data) {
            //showProgressBar();
            if (_$("#table1 tr").length > 1) {
                // _$("#table1 tr:not(:first)").remove();这行代码为什么不能用？
                _$("#table1 tr:gt(0)").remove();
            }
            var tr = "";
            var bill = data.finbillVoList;
            var advances = data.advancesVoList;
            _$.each(bill, function(i, n) {
                tr += "<tr class=\""
                        + (i % 2 == 0 ? 'odd' : 'even')+ "\"" + "id=" + "table1_t" + i + " >"
                        //改为只能认领一个账单：
                        //+ "<td><input type=\"radio\"  value=\"checkbox\" name=\"checkbox\"><input type=\"hidden\"  value=\""
                        //+ bill[i].id + "\" name=\"bill_ids\"></td>"
                        + "<td><input type=\"radio\"  value=\"" + bill[i].id + "\" name=\"bill_ids\" onclick=\"selectLockBillId("+bill[i].id+");changeRateAmount(this,'"+bill[i].id+"')\" id=\"" + bill[i].id + "\"></td>"
                        + "<td>&nbsp;" + bill[i].bill_year_month + "</td>"
                        + "<td>&nbsp;" + bill[i].bill_amountForString
                        + "<input type=\"hidden\" id=\"bam_" + i + "\"value=\""
                        + bill[i].bill_amount + "\" />" + "</td>"
                        + "<td>&nbsp;" + bill[i].verification_amountForString + "</td>" 
                        + "<td>&nbsp;" + bill[i].rate_oddsForString 
                        + "<input type=\"hidden\" id=\"smallamount\" name=\"smallamount\" value=\"" + bill[i].rate_odds + "\"/>" //add by sqp 为了页面上获取小额 2014年3月19日 
                        + "</td>" 
                        + "<td>&nbsp;" + bill[i].rate_amount4String + "</td>" 
                        + "<td>&nbsp;" + bill[i].outstanding_amountForString
                        + "<input type=\"hidden\" id=\"osa\" name=\"osa\" value=\"" + bill[i].outstanding_amount + "\"/>"
                        + "</td>"
                        + "<td>&nbsp;" + bill[i].bill_type_bdForValue + "</td>"
                        + "<td>&nbsp;" + bill[i].user_name + "</td>" + "</tr>";
            });
            _$("#table1").append(tr);
            
            //写预收表
            writeAdvances(advances);
            hideProgressBar();
        }
    });
    clearInput();//清页面上保存的数据
}

/**
 * 查找发票数据 add by whj
 */

/**function writeInvoiceTable() {
    _$.ajax({
        type : "post",
        url : venusbase + "/FinbillAction.do?cmd=searchInvoiceNotIn",
        data : _$("form").serialize(),
        dataType : "json",
        success : function(data) {
            //showProgressBar();
            if (_$("#invoice_table tr").length > 1) {
                _$("#invoice_table tr:gt(0)").remove();
            }
            var tr = "";
            var invoice = data.finInvoiceVoList;
            _$.each(invoice, function(i, n) {
                tr += "<tr class=\""
                        + (i % 2 == 0 ? 'odd' : 'even')+ "\"" + "id=" + "invoice_table_t" + i + " >"
                        + "<td><input type=\"radio\"  value=\"" + invoice[i].id + "\" name=\"invoice_id\" onclick=\" setInvoiceAmount('"+invoice[i].invoice_amount+"')\"></td>"
                        + "<td style=\" display: none\">&nbsp;" + invoice[i].id + "</td>"
                        + "<td>&nbsp;" + invoice[i].cust_code + "</td>"
                        + "<td>&nbsp;" + invoice[i].cust_name + "</td>" 
                        + "<td>&nbsp;" + invoice[i].cost_center_name + "</td>" 
                        + "<td>&nbsp;" + invoice[i].invoice_code + "</td>" 
                        + "<td>&nbsp;" + invoice[i].invoice_amount+ "</td>"
                        + "</tr>";
            });
            _$("#invoice_table").append(tr);
            
            hideProgressBar();
        }
    });
}**/

//发票的单选事件
function setInvoiceAmount(invoice_amount){
    _$("#invoice_amount").val(invoice_amount);
}
/**
 * 鼠标离开账单日期，给明细认领的标签页写账单
 */
function writeTable3_1Row() {
    _$.ajax({
        type : "post",
        url : venusbase + "/FinbillAction.do?cmd=showFinBillByYearmonth",
        data : _$("form").serialize(),
        dataType : "json",
        success : function(data) {
            //showProgressBar();
            if (_$("#table3_1 tr").length > 1) {
                _$("#table3_1 tr:gt(0)").remove();
            }
            var tr = "";
            var bill = data.finbillVoList;
            var advances = data.advancesVoList;
            _$.each(bill, function(i, n) {
                tr += "<tr class=\""
                        + (i % 2 == 0 ? 'odd' : 'even')+ "\"" + "id=" + "table1_t" + i + " >"
                        + "<td><input type=\"radio\" name=\"radio\" id=\"radb_" + bill[i].id + "\" onclick=\"changeRateAmount(this,'"+bill[i].id+"')\"/></td>"
                        + "<td>&nbsp;" + bill[i].bill_year_month + "</td>"
                        + "<td>&nbsp;" + bill[i].bill_amountForString + "</td>"
                        + "<td>&nbsp;" + bill[i].verification_amountForString + "</td>"
                        + "<td>&nbsp;" + bill[i].rate_oddsForString + "</td>"
                        + "<td>&nbsp;" + bill[i].rate_amount4String + "</td>"
                        + "<td>&nbsp;" + bill[i].outstanding_amountForString + "</td>"
                        + "<td>&nbsp;" + bill[i].bill_type_bdForValue + "</td>"
                        + "<td>&nbsp;" + bill[i].user_name + "</td>" + "</tr>";
            });
            _$("#table3_1").append(tr);
            //写预收表
            writeAdvances(advances);
            hideProgressBar();
        }
    });
    //清页面上保存的数据
    clearInput();
    //清空table3表
    _$("#table3 tr").remove();
}

/**
 * 产生预收的table
 */
function writeAdvances(advances) {
    //预收
    _$("#advancestable tr:gt(0)").remove();
    tr = "";
    _$.each(advances, function(i, n) {
        tr += "<tr class=\"" + (i % 2 == 0 ? 'odd' : 'even') + "\"" + "id=" + "advancestable_tr" + i + " >"
                + "<td><input type=\"checkbox\" name=\"advcheckbox\"/>"
                + "<input type=\"hidden\" name=\"adv_verids\" />"
                + "<input type=\"hidden\" name=\"adv_verids_copy\" value=\"" + advances[i].id + "\" />"
                + "</td>"
                + "<td>&nbsp;" + advances[i].inc_date + "</td>"
                + "<td>&nbsp;" + advances[i].inc_amoutForString
                + "<input type=\"hidden\" id=\"adam_" + i + "\"value=\"" + advances[i].inc_amout + "\" /></td>"
                + "<td>&nbsp;" + advances[i].balance_amountForString + "<input type=\"hidden\" id=\"adbl_" + i + "\"value=\"" + advances[i].balance_amount
                + "\" /></td>" 
                + "<td>&nbsp;" + advances[i].ver_amountForString 
                + "<input type=\"hidden\" id=\"adver_" + i + "\"value=\"" + advances[i].verification_amount + "\" /></td>"
                + "</tr>";
    });
    _$("#advancestable").append(tr);
}

function writeTable3Row(billid,currentPage,pageSize) {
    //alert(billid);
	//VENUS_PAGE_NO_KEY
	//VENUS_PAGE_COUNT_KEY
	//VENUS_PAGE_SIZE_KEY
    _$.ajax({
        type : "post",
        url : venusbase + "/FinbillitemAction.do?cmd=showFinBillItemByYearmonth&VENUS_PAGE_NO_KEY="+currentPage+"&VENUS_PAGE_SIZE_KEY="+pageSize,
        data : "billid=" + billid,
        dataType : "json",
        success : function(data) {
            //showProgressBar();
            if (data) {
                //if (_$("#table3 tr").length > 1) {
                    //_$("#table3 tr:gt(0)").remove();
                    _$("#table3 tr").remove();
                //}
                var tableTitle = data.tabletitle;//表头
                var tableData = data.objarrlist;//明细表数据
                var tableOneOfffee = data.boVoList;//一次性账单表数据
                var tablepage=data.pageVo;//分页信息
                //alert("tablepage="+tablepage);
                _$("#pageinfo").text("");
                if(tablepage!=null&&tablepage!="null"){
                       _$("#pageinfo").append("<font color='red'>");
                       
                       if(Number(tablepage.currentPage)>1){
                       	_$("#pageinfo").append("<a href='javascript:writeTable3Row(\""+billid+"\",1,"+ tablepage.pageSize +");'>首页</a> &nbsp;&nbsp;");
                       }
                       
                       if(Number(tablepage.currentPage)<Number(tablepage.pageCount)){
                       _$("#pageinfo").append("<a href='javascript:writeTable3Row(\""+billid+"\","+ Number(tablepage.currentPage+1) +","+ tablepage.pageSize +");'>下一页</a>&nbsp;&nbsp;");
                       }

                       if(Number(tablepage.currentPage)!=1){
                       _$("#pageinfo").append("<a href='javascript:writeTable3Row(\""+billid+"\","+ Number(tablepage.currentPage-1) +","+ tablepage.pageSize +");'>上一页</a>&nbsp;&nbsp;");
                       }
                       
                       if(Number(tablepage.currentPage)!=Number(tablepage.pageCount)){
                       _$("#pageinfo").append("<a href='javascript:writeTable3Row(\""+billid+"\","+ Number(tablepage.pageCount) +","+ tablepage.pageSize +");'>尾页</a>&nbsp;&nbsp;");
                       }
                       
                       _$("#pageinfo").append("当前第"+tablepage.currentPage+"页,共"+tablepage.pageCount+"页 <br><p>(当账单明细大于200条记录时为了提高页面运算效率须进行分页认领，每页显示200条明细) </font>");
                }
                if (tableData.length != 0) {
                    var trTitle = "<tr><th width=\"4%\">"
                    //empid隐藏显示
                    + "<input type=\"checkbox\" id=\"itemcheckall\"/></th><th style=\"width:100px\">编号</th><th style=\"width:100px\">姓名</th><th style=\"width:100px\">服务年月</th><th style=\"display:none\">员工ID</th>";
                    _$.each(tableTitle, function(i, n){
                        trTitle += "<th style=\"width:150px; white-space:nowrap;\"><input type=\"checkbox\" id=\"top_" + Number(i+1) + "\"/>" + n + "</th>";
                    });
                    trTitle += "<th>合计</th></tr>"
                    _$("#table3").append(trTitle);
                }
                var tr = "";
                var k = 1;
                _$.each(tableData, function(i, n){
                    tr += "<tr><td><input type=\"checkbox\" id=\"left_" + i + "\"/><input type=\"hidden\" name=\"emp\"/></td>"
                    _$.each(n, function(j, m){
                        if (j < 4) {
                            if (j == 3) {
                                //empid隐藏显示
                                tr += "<td style=\"display:none\"><input type=\"hidden\" value=\"" + m + "\"/>" + m + "</td>";
                            } else {
                                tr += "<td><input type=\"hidden\" value=\"" + m + "\"/>" + m + "</td>";
                            }
                            
                        } else {
                            //[308685, 郁小飞, 201205, 1099810400000306595, 
                            //1099110200000000134, 5500, 0, 工资,|分隔| 1099110200000000135, 120, 0, 个调税]
                            if (j % 4 == 0) {
                                //alert(n[j] + "_" + n[j+1] + "_" + n[j+2] + "_" + n[j+3]);
                                if (n[j+2] == 1) {//如果已经核销过，那么disabled掉
                                    tr += "<td><input type=\"checkbox\" checked=\"checked\" disabled=\"disabled\" onclick=\"return false;\" id=\"con_"+ Number(k) +"\"/><input type=\"hidden\" value=\"" + n[j] + "\"/>" + n[j+1] + "</td>";//m为n[j]
                                } else {
                                    //如果此某员工没有此产品，那么对应的checkbox为disabled  
                                    if (m) {
                                        tr += "<td><input type=\"checkbox\" id=\"con_"+ Number(k) +"\"/><input type=\"hidden\" value=\"" + n[j] + "\"/>" + n[j+1] + "</td>";//m为n[j]
                                    } else {
                                        tr += "<td><input type=\"checkbox\" disabled=\"disabled\" onclick=\"return false;\" id=\"con_"+ Number(k) +"\"/><input type=\"hidden\" value=\"" + n[j] + "\"/>" + n[j+1] + "</td>";//m为n[j]
                                    }
                                    
                                }
                                k++;
                            }
                        }
                    });
                     tr += "<td><label>0</label><input type=\"hidden\" id= \"fin_row_total_h\" class = \"row_total\"></td></tr>";
                });
                _$("#table3").append(tr);
                _$("#table4 tr:gt(0)").remove();
                _$("#checkall_oneOfffee").attr("checked", false);
                tr = "";
                //项目名称，金额，备注，时间
                _$.each(tableOneOfffee, function(i, n) {
                    tr += "<tr>"
                    + "<td><input type=\"checkbox\" name=\"oneofffee_id\" value=\"" + tableOneOfffee[i].id + "\"/></td>"
                    + "<td>" + tableOneOfffee[i].charge_item_bd + "</td>"
                    + "<td><input type=\"hidden\" name=\"oneofffee_id_value\" id=\"oneofffee_id_value\" value=\"" + tableOneOfffee[i].amount + "\"/>" + tableOneOfffee[i].amount + "</td>"
                    + "<td>" + tableOneOfffee[i].charge_desc + "</td>"
                    + "<td>" + tableOneOfffee[i].create_date4String + "</td>"
                    + "</tr>";
                });
                _$("#table4").append(tr);
                hideProgressBar();
            }
        }
    });
}


/**
 * 仅认领工资 输出行
 */
function writeTable2Row () {
    _$.ajax({
        type : "post",
        url : venusbase + "/FinbillAction.do?cmd=showFinBillByYearmonth&write=2",
        data : _$("form").serialize(),
        dataType : "json",
        success : function(data) {
            if (_$("#table2_2 tr").length > 1) {
                // _$("#table1 tr:not(:first)").remove();这行代码为什么不能用？
                _$("#table2_2 tr:gt(0)").remove();
            }
            var tr = "";
            var bill = data.finbillVoList;
            var advances = data.advancesVoList;
            var salarybath = data.salarybatchVoList
            //应收
            _$.each(bill, function(i, n) {
                tr += "<tr class=\""
                        + (i % 2 == 0 ? 'odd' : 'even')+ "\"" + "id=" + "table2_2_t" + i + " >"
                        + "<td><input type=\"radio\"  name=\"t2_billid\" value=\"" + bill[i].id + "\" disabled=\"disabled\" onclick=\"changeRateAmount(this,'"+bill[i].id+"')\"/></td>"
                        + "<td>&nbsp;" + bill[i].bill_year_month + "</td>"
                        + "<td>&nbsp;" + bill[i].bill_amountForString
                        + "<input type=\"hidden\" id=\"bam_" + i + "\"value=\""
                        + bill[i].bill_amount + "\" />" + "</td>"
                        + "<td>&nbsp;" + bill[i].verification_amountForString
                        + "</td>" + "<td>&nbsp;" + bill[i].rate_oddsForString
                        + "</td>" + "<td>&nbsp;"
                        + bill[i].outstanding_amountForString
                        + "<input type=\"hidden\" name=\"osa\" value=\"" + bill[i].outstanding_amount + "\"/>"
                        + "</td>"
                        + "<td>&nbsp;" + bill[i].bill_type_bdForValue + "</td>"
                        + "<td>&nbsp;" + bill[i].user_name + "</td>" + "</tr>";
            });
            _$("#table2_2").append(tr);
            //写左下角的工资批次表
            tr = "";
            if (_$("#table2_1 tr").length > 1) {
                _$("#table2_1 tr:gt(0)").remove();
            }
            _$.each(salarybath, function(i, n) {
                tr += "<tr class=\""
                        + (i % 2 == 0 ? 'odd' : 'even')+ "\" " + "id=\"" + "table2_1_t" + i + "\" >"
                        + "<td><input type=\"radio\"  name=\"sbid\" value=\"" + salarybath[i].id + "\"/></td>"
                        + "<td>&nbsp;" + salarybath[i].sa_batch_code + "</td>"
                        + "<td>&nbsp;" + salarybath[i].pay_year_month + "</td>"
                        + "<td>&nbsp;" + salarybath[i].bill_year_month + "</td>"
                        + "<td>&nbsp;" + salarybath[i].tax_month + "</td></tr>";
            });
            _$("#table2_1").append(tr);
            
            //写预收表
            writeAdvances(advances);
        }
    });
    clearInput();//清页面上保存的数据
}


// 成本中心改值后，如果账期也存在，且日期格式正确，那么AJAX获取数据，写入table TOTEST
function cost_center_changed(item) {
    if (item.value == "" || item.value == '0') {
        _$("#table1 tr:gt(0)").remove();
        _$("#hid_cost_center_name").val("");
        return false;
    }
       
    if (item.value != "" && _$("#bill_year_month").val() != "") {
        if (isDateString(_$("#bill_year_month").val())) {
            if (_$("#TabCon1").css("display") == "block") {
                writeTable1Row();
            } else if (_$("#TabCon2").css("display") == "block") {
                //writeTable2Row();
                alert('仅认领工资暂不处理');
            } else if (_$("#TabCon3").css("display") == "block") {
                writeTable3_1Row();
            } 
        }
    }
    _$("#hid_cost_center_name").val(_$(item).find("option:selected").text());
}


var claimallNew="0";
var readonly_txt_odd="0";
/**
 * 显示：到款未认领+预收款-所选应收
 * ver_amount 手动输入的核销金额
 */
function showt(ver_amount, initFlag) {
    //alert("alert");
    var un = 0;//到款未认领
    var ver = 0;//核销金额
    if (_$("#balanceAmount").val() == "1") {
        //使用预收认领
        //un = _$("#un_claim_amout_h").val() == "" ? "0" : _$("#un_claim_amout_h").val();
        //因为使用到预收，该预收对应的到款额已被认领完
        un = "0";
    } else {
        //普通到款认领
        if (_$("#un_claim_amout_h").val() == "") {
            un = _$("#inc_amout_h").val();
        } else {
            un = _$("#un_claim_amout_h").val()
        }
    }
    
    var v1_n_sumv_h = parseFloat(_$("#v_n_sumv_h").val());
    //alert("v1_n_sumv_h="+v1_n_sumv_h);
    //预收款
    var adv_h = _$("#adv_h").val();
    var v_sumv_h =  _$("#sumv").text().replace(/,/g, "");
    var v_balanceAmount=_$("#balanceAmount").val();
    
    if (_$("#TabCon1").css("display") == "block") {
        //======================应收+小额+汇差=核销==================================
        sumv_h = _$("#div_1 input[id='sumv_h']").val();
        //alert("sumv_h="+sumv_h);
        var v_balance = parseFloat(un)+parseFloat(adv_h) - parseFloat(v_sumv_h);
        var v_txt_rem = _$.trim(_$("#div_1 input[id='txt_rem']").val());//汇差
        if(v_txt_rem=="0"||v_txt_rem==""){
                              v_txt_rem="0";
        }
        
        var v1_txt_odd = _$.trim(_$("#div_1 input[id='txt_odd']").val());//小额
        if(v1_txt_odd=="0"||v1_txt_odd==""){
                              v1_txt_odd="0";
        }
        //alert("v_sumv_h="+v_sumv_h+"v1_txt_odd="+v1_txt_odd);
        if(parseFloat(v1_txt_odd)==0 && parseFloat(v_txt_rem)==0){
            	if(v1_n_sumv_h>=parseFloat(v_sumv_h)){
            	v1_n_sumv_h=v_sumv_h;
            	//alert("aaaaav1_n_sumv_h="+v1_n_sumv_h);
            	}
        }
        //if (Math.abs(balance) <= 10) {
        if(parseFloat(adv_h)>0){
            	    if(((parseFloat(un)+parseFloat(adv_h)) <parseFloat(v_sumv_h) && (Math.abs(v_balance) >10)) ||  (v1_n_sumv_h!=parseFloat(v_sumv_h)&&parseFloat(v1_txt_odd)==0) ){
                                 _$("#div_1 label[id='v_yu_e']").text("+余额");
                                 ////可输入认领金额
                                if(v1_n_sumv_h==parseFloat(v_sumv_h)){
                                 _$("#div_1 label[id='v_yu_e_input']").text("+"+(parseFloat(v_sumv_h)-(parseFloat(un)+parseFloat(adv_h)-parseFloat(v_txt_rem))).toFixed(4));
                                 _$("#div_1 input[id='txt_ver']").val(parseFloat(un)+parseFloat(adv_h));//sumv_h
                                 sumv_h=(parseFloat(un) + parseFloat(adv_h));
                                 }else{
                                    _$("#div_1 label[id='v_yu_e_input']").text("+"+((parseFloat(v_sumv_h)-(v1_n_sumv_h-parseFloat(v_txt_rem)))).toFixed(4));
                                    _$("#div_1 input[id='txt_ver']").val(v1_n_sumv_h);//sumv_h
                                    sumv_h=v1_n_sumv_h;
                                 }
                                 claimallNew="1";
                                 readonly_txt_odd="1";
                   }else{   
                   	            if((v_balanceAmount!=""&&v_balanceAmount =="1")){
                   	            	if(Math.abs(v_balance) <10){
                   	            		
                   	            	}else{
                   	            		_$("#div_1 input[id='txt_ver']").val(v1_n_sumv_h+parseFloat(v_txt_rem)+parseFloat(v1_txt_odd));//sumv_h
                   	            	}
                   	                sumv_h=v1_n_sumv_h+parseFloat(v_txt_rem)+parseFloat(v1_txt_odd);
                   	            }
                                 _$("#div_1 label[id='v_yu_e']").text("");
                                 _$("#div_1 label[id='v_yu_e_input']").text("");
                                 claimallNew="0";
                                 readonly_txt_odd="0";
                   }
        
        }else{
                 if((parseFloat(un) <parseFloat(v_sumv_h)  && (Math.abs(v_balance) >10))  ||  (v1_n_sumv_h!=parseFloat(v_sumv_h))){
                             _$("#div_1 label[id='v_yu_e']").text("+余额");
                             
                             ////可输入认领金额
                             if(v1_n_sumv_h==parseFloat(v_sumv_h)){
                             	    _$("#div_1 label[id='v_yu_e_input']").text("+"+((parseFloat(v_sumv_h)-(parseFloat(un)-parseFloat(v_txt_rem)))).toFixed(4));
                                    _$("#div_1 input[id='txt_ver']").val(un);//sumv_h
                                    sumv_h=un;
                             }else{
                             	    _$("#div_1 label[id='v_yu_e_input']").text("+"+((parseFloat(v_sumv_h)-(v1_n_sumv_h-parseFloat(v_txt_rem)))).toFixed(4));
                                    _$("#div_1 input[id='txt_ver']").val(v1_n_sumv_h);//sumv_h
                                    sumv_h=v1_n_sumv_h;
                             }
                             
                             claimallNew="1";
                             readonly_txt_odd="1";
               }else{
                             _$("#div_1 label[id='v_yu_e']").text("");
                             _$("#div_1 label[id='v_yu_e_input']").text("");
                             claimallNew="0";
                             readonly_txt_odd="0";
               }
        	
        }

        var v_sumv = _$("#sumv").text().replace(/,/g, "");
        _$("#div_1 label[id='lbl_sumv']").text(v_sumv);//应收
        
        /*
         var v_txt_odd = _$.trim(_$("#div_1 input[id='v_txt_odd']").val());
         //alert("v_txt_odd="+v_txt_odd);
         if(v_txt_odd!=""){
        //小额调整
        _$("#div_1 input[id='txt_odd']").val(parseFloat(v_txt_odd));//应收
         }
         */
         
        _$("#div_1 label[id='lbl_adv']").text(adv_h);//预收
        //差额 = 到款 - 应收
        //alert("到款="+parseFloat(un)+"应收="+parseFloat(sumv_h));
        var balance = 0;
        if(parseFloat(adv_h)>0){
                balance = (parseFloat(un)+parseFloat(adv_h)) - parseFloat(v_sumv_h);
        }else{
        	    if(v1_n_sumv_h==parseFloat(v_sumv_h)){
                        balance = parseFloat(un) - parseFloat(v_sumv_h);
        	    }else{
        	           balance = parseFloat(un) - parseFloat(v1_n_sumv_h);
        	    }
        }
        balance = balance.toFixed(2);
        //alert("balance="+balance);

        //如果差额在10块钱以内，
        if (Math.abs(balance) <= 10 && parseFloat(v_sumv_h)>0) {
        	//_$("#div_1 input[id='txt_odd']").attr("readonly", true);
            if (_$("#is_remittance").val() == '1') {
                //允许汇差，差额为汇差
                //_$("#div_1 input[id='txt_rem']").val(balance);
            } else {
                //不允许汇差，差额为小额
            	//_$("#div_1 input[id='txt_rem']").val("0");
            	//alert("parseFloat(v1_txt_odd)="+parseFloat(v1_txt_odd)+"___parseFloat(v_txt_rem)="+parseFloat(v_txt_rem));
                if(parseFloat(v1_txt_odd)==0 && parseFloat(v_txt_rem)==0){
                	       if((v_balanceAmount!=""&&v_balanceAmount =="1")){
                                    if(Math.abs(v_balance) <10){
                                    	_$("#div_1 input[id='txt_odd']").val(balance);
                                    }
                            }
                  }else{
                      _$("#div_1 input[id='txt_odd']").val(balance);
                  }
                //_$("#div_1 input[id='v_txt_odd']").val(balance);
            }
            //alert("ver_amount="+ver_amount+"ver1="+ver);
            //核销金额=应收+差额
            /*
            if (ver_amount) {
                ver = ver_amount;
            } else {
                ver = parseFloat(sumv_h) + parseFloat(balance);
                sumv_h=ver;
            }
            */
            //alert("ver2="+ver);
        } 
        
        /*
        else {
        	
        	*/
        	//_$("#div_1 input[id='txt_odd']").attr("readonly", false);
            //核销金额=账单的应收金额
        
            //if (ver_amount) {
            //    ver = ver_amount;
            //} else {
            //    ver = sumv_h;
                //差额在|10|块钱以外，小额和汇差默认为0
                //_$("#div_1 input[id='txt_odd']").val('0');
                //_$("#div_1 input[id='txt_rem']").val('0');
            //}
        //}
        //此代码用于规避光标在核销textbox中不受控制
        if (ver_amount) {
        	ver = ver_amount;
        } else {
        	   //当到款小于应收核销金额为到款金额
        	   if(balance<0){
        	   	   if(parseFloat(adv_h)>0){
        	   	   	       if(v1_n_sumv_h==parseFloat(v_sumv_h)){
        	   	                   ver = parseFloat(un)+parseFloat(adv_h);
        	   	   	       }else{
        	   	   	       	       ver=v1_n_sumv_h;
        	   	   	       }
        	   	   }else{
        	   	   	        ///可输入认领金额修改
                             if(v1_n_sumv_h==parseFloat(v_sumv_h)){
        	   	                   ver = un;
                             }else{
                                    ver=v1_n_sumv_h;
                             }
        	   	   }
                }else{
                	if(balance>0 && Math.abs(balance) <= 10){
                		   if(v1_n_sumv_h==parseFloat(v_sumv_h)){
                		   	       if(parseFloat(v1_txt_odd)==0 && parseFloat(v_txt_rem)==0){
                		   	          ver = parseFloat(v_sumv);
                		   	       }else{
                		   	          ver = parseFloat(v_sumv)+parseFloat(balance);
                		   	       }
                	               
                		   }else{
                		          ver = parseFloat(v1_n_sumv_h);
                		   }
                	}else{
                		   if(v1_n_sumv_h==parseFloat(v_sumv_h)){
                	               ver = sumv_h;
                		   }else{
                		          ver=v1_n_sumv_h;
                		   }
                	}
                }
                
            ver=parseFloat(ver).toFixed(3);
            //alert("balance="+balance+"ver="+ver);//_$("#div_1 input[id='sumv_h']").val();
            //alert("v1_txt_odd="+v1_txt_odd+"    v_txt_rem="+v_txt_rem);
            if (Math.abs(balance) <= 10 && parseFloat(ver)>0) {
            //_$("#div_1 input[id='txt_odd']").val(balance);
            	if (v1_txt_odd=="0" && _$("#is_remittance").val() == '1' ) {
                		       if(v1_n_sumv_h==parseFloat(v_sumv_h)){
                    		       	  if(parseFloat(v1_txt_odd)==0 && parseFloat(v_txt_rem)==0){
                    		       	  }else{
                    		       	      _$("#div_1 input[id='txt_rem']").val(balance);
                    		       	  }
                               
                		       }else{
                		       	      if(v_txt_rem!="0"){
                        		       //_$("#div_1 input[id='txt_rem']").val("0");
                        		       	_$("#div_1 input[id='txt_rem']").val(parseFloat(v1_n_sumv_h-parseFloat(v_sumv_h)).toFixed(2));
                        		       	_$("#div_1 label[id='v_yu_e_input']").text("+ 0");
                        		       	claimallNew="0";
                        		       	readonly_txt_odd="1";
                		       	      }
                		       }
                               _$("#div_1 input[id='txt_odd']").val("0");
                 }else{
                              if(parseFloat(v1_txt_odd)==0 && parseFloat(v_txt_rem)==0){
                              }else{
                                  _$("#div_1 input[id='txt_odd']").val(balance);
                              }
                          _$("#div_1 input[id='txt_rem']").val("0");
                 }
            	
            }
            _$("#div_1 input[id='txt_ver']").val(parseFloat(ver).toFixed(4));
            _$("#div_1 input[id='sumv_h']").val(parseFloat(ver));
            //alert("sumv_h="+sumv_h);
        }
        
         /**/
        //==================到款未认领+预收款-核销=余额=============================
        _$("#div_1 label[id='lbl_unclaim']").text(un);
        _$("#div_1 label[id='lbl_balance']").text(adv_h);
        var txtver = _$("#div_1 input[id='txt_ver']").val();
        _$("#div_1 label[id='lbl_ver']").text(txtver);
        var difference = parseFloat(un) + parseFloat(adv_h) - parseFloat(txtver);
        difference = difference.toFixed(4);
        _$("#div_1 label[id='lbl_difference']").text(difference);
        _$("#div_1 input[id='txt_difference']").val(difference);
        
        var balanceflag = _$("#balanceflag").val();
        var calshowt =0;
        var showt ="";
        var showtbt="";
        //alert("balanceflag="+balanceflag);
        var balanceAmount=_$("#balanceAmount").val();
        //alert("balanceAmount="+balanceAmount);
        if((balanceflag!=""&&balanceflag)||(balanceAmount!=""&&balanceAmount == '1')||(balanceAmount!=""&&balanceAmount == '2')){
        	    if((balanceAmount!=""&&balanceAmount == '2')){
        	            calshowt = parseFloat(un) + parseFloat(adv_h) - parseFloat(ver); // - parseFloat(sumv_h);
                        calshowt = calshowt.toFixed(4);
                        
                        showt = fmoney(un, 4) + " + " + fmoney(adv_h, 4) + " - "
                                + fmoney(ver, 4) + " = " + fmoney(calshowt, 4);
                        
                        showtbt="到款未认领+预收款-核销金额=差额";
                        _$("#claimingall2").attr("disabled", false);
                        _$("#claimingall2").attr("checked", true);
        	    }else{
                        calshowt =  parseFloat(adv_h) - parseFloat(ver);
                        calshowt = calshowt.toFixed(4);
                        
                        showt =fmoney(adv_h, 4) + " - "
                                + fmoney(ver, 4) + " = " + fmoney(calshowt, 4);
                       showtbt="预收款-核销金额=差额";
                       //从预收款认领只使用预收款认领
                       if(balanceflag!=""&&balanceflag=="true"){
                                _$("#claimingall2").attr("disabled", true);
                                _$("#claimingall1").attr("checked", true);
                       }else{
                       	//从到款列表进入只使用预收款认领
                                _$("#claimingall2").attr("disabled", false);
                                _$("#claimingall2").attr("checked", true);
                       } 
        	    }
        }else{
                calshowt = parseFloat(un) - parseFloat(ver);//  - parseFloat(sumv_h);
                calshowt = calshowt.toFixed(4);
                
                showt = fmoney(un, 4) + "  - "
                        + fmoney(ver, 4) + " = " + fmoney(calshowt, 4);
                
                showtbt="到款未认领-核销金额=差额";
        }
        //alert("ver="+parseFloat(ver));
        _$("#v_n_sumv_h").val(parseFloat(ver));

        //到款未认领+预收款-所选应收 到款未认领+预收款-核销金额=差额
         _$("#resultbt").text(showtbt);
        _$("#resultv").text(showt);
    } else if(_$("#TabCon2").css("display") == "block") {
        var t2_sumv_h = _$("#t2_sumv_h").val();
        
        var calshowt = parseFloat(un) + parseFloat(adv_h) - parseFloat(t2_sumv_h);
        calshowt = calshowt.toFixed(4);
        var showt = fmoney(un, 4) + " + " + fmoney(adv_h, 4) + " - "
                + fmoney(t2_sumv_h, 4) + " = " + fmoney(calshowt, 4);
    
        //到款未认领+预收款-所选应收
        _$("#t2_resultv").text(showt);
        _$("#t2_cal_res_h").val(calshowt);
    } else if(_$("#TabCon3").css("display") == "block") {
        //======================应收+小额+汇差=核销==================================
        sumv_h = _$("#div_3 input[id='sumv_h']").val();
        _$("#div_3 label[id='lbl_sumv']").text(sumv_h);//应收
        _$("#div_3 label[id='lbl_adv']").text(adv_h);//预收
        //差额 = 到款 - 应收
        var balance = parseFloat(un) - parseFloat(sumv_h);
        balance = balance.toFixed(4);
        //如果差额在10块钱以内，
        if (Math.abs(balance) <= 10) {
            if (_$("#is_remittance").val() == '1') {
                //允许汇差，差额为汇差
                //_$("#div_3 input[id='txt_rem']").val(balance);
            } else {
                //不允许汇差，差额为小额
            	//_$("#div_3 input[id='txt_rem']").val("0");
                //_$("#div_3 input[id='txt_odd']").val(balance);
            }
            //核销金额=应收+差额
            if (ver_amount) {
                ver = ver_amount;
            } else {
                ver = parseFloat(sumv_h) + parseFloat(balance);
            }
        } else {
            //差额在|10|块钱以外，小额和汇差默认为0
            
            //核销金额=账单的应收金额
            if (ver_amount) {
                ver = ver_amount;
            } else {
                ver = sumv_h;
                //_$("#div_3 input[id='txt_odd']").val('0');
                //_$("#div_3 input[id='txt_rem']").val('0');
            }
        }
        //此代码用于规避光标在核销textbox中不受控制
        if (ver_amount) {
        } else {
            ver = parseFloat(ver).toFixed(4);
            _$("#div_3 input[id='txt_ver']").val(ver);
        }
        
        //==================到款未认领+预收款-核销=余额=============================
        _$("#div_3 label[id='lbl_unclaim']").text(un);
        _$("#div_3 label[id='lbl_balance']").text(adv_h);
        var txtver = _$("#div_3 input[id='txt_ver']").val();
        _$("#div_3 label[id='lbl_ver']").text(txtver);
        var difference = parseFloat(un) + parseFloat(adv_h) - parseFloat(txtver);
        difference = difference.toFixed(4);
        _$("#div_3 label[id='lbl_difference']").text(difference);
        _$("#div_3 input[id='txt_difference']").val(difference);
        //=====================================================================
        
        var balanceflag = _$("#balanceflag").val();
        var calshowt =0;
        var showt ="";
        var showtbt="";
        //alert("balanceflag="+balanceflag);
        var balanceAmount=_$("#balanceAmount").val();
        //alert("balanceAmount="+balanceAmount);
        if((balanceflag!=""&&balanceflag)||(balanceAmount!=""&&balanceAmount == '1')||(balanceAmount!=""&&balanceAmount == '2')){
                if((balanceAmount!=""&&balanceAmount == '2')){
                        calshowt = parseFloat(un) + parseFloat(adv_h) - parseFloat(sumv_h);
                        calshowt = calshowt.toFixed(4);
                        
                        showt = fmoney(un, 4) + " + " + fmoney(adv_h, 4) + " - "
                                + fmoney(sumv_h, 4) + " = " + fmoney(calshowt, 4);
                        
                        showtbt="到款未认领+预收款-核销金额=差额";
                        _$("#claimingall6").attr("disabled", false);
                        _$("#claimingall6").attr("checked", true);
                }else{
                        calshowt =  parseFloat(adv_h) - parseFloat(sumv_h);
                        calshowt = calshowt.toFixed(4);
                        
                        showt =fmoney(adv_h, 4) + " - "
                                + fmoney(sumv_h, 4) + " = " + fmoney(calshowt, 4);
                       showtbt="预收款-核销金额=差额";
                       //从预收款认领只使用预收款认领
                       if(balanceflag!=""&&balanceflag=="true"){
                                _$("#claimingall6").attr("disabled", true);
                                _$("#claimingall5").attr("checked", true);
                       }else{
                        //从到款列表进入只使用预收款认领
                                _$("#claimingall6").attr("disabled", false);
                                _$("#claimingall6").attr("checked", true);
                       } 
                }
        }else{
                calshowt = parseFloat(un) - parseFloat(sumv_h);
                calshowt = calshowt.toFixed(4);
                
                showt = fmoney(un, 4) + "  - "
                        + fmoney(sumv_h, 4) + " = " + fmoney(calshowt, 4);
                
                showtbt="到款未认领-核销金额=差额";
        }

        //到款未认领+预收款-所选应收 到款未认领+预收款-核销金额=差额
         _$("#resultbt3").text(showtbt);
        _$("#resultv3").text(showt);
    }

   if (claimallNew == '0' && readonly_txt_odd== '0') {
        _$("#div_1 input[id='txt_odd']").removeAttr("readonly");
        _$("#div_1 input[id='txt_odd']").css({background: "white" });
    } else {
        _$("#div_1 input[id='txt_odd']").attr("readonly", true);
        _$("#div_1 input[id='txt_odd']").css({background: "#f0f0f0" });
        
        _$("#div_1 input[id='txt_odd']").val('0');
    }
    
    var v_yu_e_input=_$("#div_1 label[id='v_yu_e_input']").text().replace(/,/g, "");
    if(v_yu_e_input!=null && v_yu_e_input!=""){
              if(parseFloat(v_yu_e_input)==0){
                    claimallNew="0";
              }
    }
            
            
   var v_balanceflag=_$("#balanceflag").val();
   var v_balanceAmount=balanceAmount;
   //var v_sumv_h=_$("#sumv_h").val();
   var v_txt_ver=_$("#txt_ver").val();
   var v_txt_difference=_$("#txt_difference").val();
   var v_inc_amout_h=_$("#inc_amout_h").val();
   //alert("v_balanceAmount="+v_balanceAmount);
   //alert("到款金额="+v_inc_amout_h+"\n是否从预收进入："+v_balanceflag+"\n是否使用了预收："+v_balanceAmount+"\nv_sumv_h="+v_sumv_h+"\nv_txt_ver="+v_txt_ver+"\nv_txt_difference="+v_txt_difference);
}





function clearInput() {
    _$("#chkall").attr("checked", false);
    _$("#sumv").text("0.00");//全部认领的 "所选应收金额合计"
    _$("#sumv_h").val("0");  //全部认领的 隐藏域"所选应收金额合计"
    //清预收款
    _$("#chk_adv_all").attr("checked", false);
    _$("#adv_h").val("0");
    
    //清table2_1 和 table2_2
    _$("#sumempsalary").text('0');
    _$("#sumempfax").text('0');
    _$("#sumsalary").text('0.00');
    _$("#sumtax").text('0.00');
    _$("#t2_sumv_h").val('0');
    _$("#t2_sumemp_h").val('0');
    _$("#taxbd").val('0');
    _$("#billid").val("");
    
    //清table3的所选应收金额合计
    _$("#t3_sumv").text("0.00");
    _$("#t3_sumv_h").val("0");
    _$("#salary_billid").val("");
    
    
    showt();
}

function clearTable() {
    _$("#table1 tr:gt(0)").remove();
    _$("#table2_1 tr:gt(0)").remove();
    _$("#table2_2 tr:gt(0)").remove();
    _$("#table3_1 tr:gt(0)").remove();
    _$("#table3 tr").remove();
    _$("#balanceAmount").val('3');
}

/**
 * 差额做作为欠款/预收保存    差额作为未认领金额
 */
function subclaim(item,openInvoiceFlag) {
	cookieUtil.setCookie("runClaimType", "onPage");

    //保存核销按钮不可用
    _$("#savaclaim_button").attr("disabled", true);
    _$("#subclaim_back_button").attr("disabled", true);
	var is_finance_invoice = _$("#is_finance_invoice").val()+"";//是否需要开票1 是 0否
    //验证核销的textbox是否正确
    if(!checkVerbox()) {
        //保存核销按钮可用
        _$("#savaclaim_button").attr("disabled", false);
        _$("#subclaim_back_button").attr("disabled", false);
        return false;
    }
    //判断成本中心下是否有发票未与账单关联
    //var fin_invoice_id = "";
     //if(_$('input[name="invoice_id"]').length>0){
         /**if(_$('input[name="invoice_id"]:checked').length ==0){
            alert("该成本中心下有发票未关联到账单，请先选择与所选发票金额一致的账单进行核销！");
            return false;
         }else{**/
           // fin_invoice_id = _$('input[name="invoice_id"]:checked').val();
            //发票金额
           // var invoice_amount = _$("#invoice_amount").val();
            //选择的账单金额
           // var ys_amount = _$("#lbl_sumv").html();
         //}
     //}
    //本次认领金额
    var v_n_sumv_h=_$("#v_n_sumv_h").val();
    var v_sumv_h = _$("#sumv").text().replace(/,/g, "");
    if(v_n_sumv_h!=null && v_n_sumv_h!=""){
            if(parseFloat(v_n_sumv_h)==0){
                    alert("本次认领金额不能等于零。");
                    _$("#v_n_sumv_h").val(v_sumv_h);
                    showt();
                    //保存核销按钮可用
                    _$("#savaclaim_button").attr("disabled", false);
                    _$("#subclaim_back_button").attr("disabled", false);
                    return false;
            }
    }
    var cval = _$(item).parent().prev().find(":checked").val();
    var confirmmsg = '';
    if (cval == '1' || cval == '3' || cval == '5') {
        confirmmsg = "差额做作为欠款/预收保存";
    } else if (cval == '2' || cval == '4' || cval == '6')　{
        confirmmsg = "差额作为未认领金额";
          var lbl_balance = _$("#adv_h").val();
         // alert('预收'+lbl_balance+"核销  "+v_n_sumv_h);
          if(lbl_balance>v_n_sumv_h)
          {
          	 alert('预收金额大于核销金额，不可以选拔差额作为未认领金额');
             //保存核销按钮可用
            _$("#savaclaim_button").attr("disabled", false);
             _$("#subclaim_back_button").attr("disabled", false);
            return false;
          }
    }
    if (confirmmsg == "") {
        alert("请选择核销方式。");
        //保存核销按钮可用
         _$("#savaclaim_button").attr("disabled", false);
        _$("#subclaim_back_button").attr("disabled", false);
        return false
    }
    if(!confirm(confirmmsg + '?')){
        //保存核销按钮可用
        _$("#savaclaim_button").attr("disabled", false);
        _$("#subclaim_back_button").attr("disabled", false);
        return false;
    }
    
    if (_$("#TabCon1").css("display") == "block") {//全部认领
        if (!document.getElementById("claimingall1").checked
            && !document.getElementById("claimingall2").checked) {
            alert("请选择核销方式。");
            //保存核销按钮可用
            _$("#savaclaim_button").attr("disabled", false);
            _$("#subclaim_back_button").attr("disabled", false);
            return false;
        }
        var sumv_h = _$("#div_1 input[id='sumv_h']").val();
        var balanceAmount=_$("#balanceAmount").val();
        if((balanceAmount!=""&&balanceAmount == '1')){
            if (Number(sumv_h) == 0) {
                alert('请选择要使用的预收。');
                //保存核销按钮可用
                _$("#savaclaim_button").attr("disabled", false);
                 _$("#subclaim_back_button").attr("disabled", false);
                return false;
            }
        }else if (Number(sumv_h) == 0) {
            alert('请选择核销账单。');
            //保存核销按钮可用
            _$("#savaclaim_button").attr("disabled", false);
             _$("#subclaim_back_button").attr("disabled", false);
            return false;
        }
        
    } else if (_$("#TabCon2").css("display") == "block") {
    } else if (_$("#TabCon3").css("display") == "block") {
        if (!document.getElementById("claimingall5").checked
            && !document.getElementById("claimingall6").checked) {
            alert("请选择核销方式。");
            //保存核销按钮可用
            _$("#savaclaim_button").attr("disabled", false);
            _$("#subclaim_back_button").attr("disabled", false);
            return false;
        }
        var sumv_h = _$("#div_3 input[id='sumv_h']").val();
        if (Number(sumv_h) == 0) {
            alert('请选择核销明细。');
            //保存核销按钮可用
            _$("#savaclaim_button").attr("disabled", false);
            _$("#subclaim_back_button").attr("disabled", false);
            return false;
        }
    }

    var v_bill_id=_$("#v_bill_id").val()+"";
    ///alert("v_bill_id"+v_bill_id);
    if(v_bill_id==null){
            alert("请选择核销账单。");
            //保存核销按钮可用
            _$("#savaclaim_button").attr("disabled", false);
            _$("#subclaim_back_button").attr("disabled", false);
    }

     //小额调整
     var odds_amount  = _$("#txt_odd").val();
     var cFalg = true;
     //比对发票明细与账单明细
      /**jQuery.ajax({
          url : venusbase + "/FinbillAction.do?cmd=contrastBillAndInvoice&v_bill_id="+v_bill_id+"&odds_amount="+odds_amount+"&_ts="+(new Date()).getTime(),
          type: 'GET',
          dataType: 'html',
          async: false,
          timeout: 10000,
          error: function(){
              alert('Error loading XML document');
              return  null;
          },
          success: function(text){
                               if(text!=null){       
                                     if(text != '1'){
                                          alert(text);
                                          cFalg = false;
                                          return false;
                                     }
                                }
                           }
    });**/
    if(cFalg == false){
        //保存核销按钮可用
        _$("#savaclaim_button").attr("disabled", false);
        _$("#subclaim_back_button").attr("disabled", false);
        return false;
    }
    
    var checkFinClaimlog="0";
    jQuery.ajax({
                    url : venusbase + "/FinbillAction.do?cmd=checkFinClaimlog&v_bill_id="+v_bill_id+"&_ts="+(new Date()).getTime(),
                    type: 'GET',
                    dataType: 'html',
                    async: false,
                    timeout: 10000,
                    error: function(){
                        alert('Error loading XML document');
                        return  null;
                    },
                    success: function(text){
                        if(text!=null){       
                               if(text == '1'){
                                        checkFinClaimlog="1";
                                        return false;
                                   }
                            }
                        }
   });
    
   //此账单正在认领操作中请稍后再操作！
    if(checkFinClaimlog!="0"){
    	    alert("此账单正在认领操作中请稍后再操作！");
    	    /*
    	    _$("#bill_year_month").val("");
    	    _$("#balanceAmount").val('3');
            _$("#div_1 label[id='sumv']").text(0);
            _$("#div_1 input[id='sumv_h']").val(0);
            _$("#v_n_sumv_h").val("0");
            _$("#v_bill_id").val("");
            showt();
            */
    	    var url = venusbase + "/FinclaimAction.do?cmd=leftbar2list";
            window.location.href = url;
            return;
    }
    
    //手工预开的账单 认领时需要保存 sub_item  update  by whj 2014/06/03
    //if(fin_invoice_id !="" && fin_invoice_id != null && fin_invoice_id != "null"){
    jQuery.ajax({
          url : venusbase + "/FinbillAction.do?cmd=saveSGInvoice&v_bill_id="+v_bill_id+"&_ts="+(new Date()).getTime(),
          type: 'GET',
          dataType: 'html',
          async: false,
          timeout: 10000,
          error: function(){
              alert('Error loading XML document');
              return  null;
          },
          success: function(text){
                               if(text!=null){       
                                     if(text != '1'){
                                          alert(text);
                                          cFalg = false;
                                          return false;
                                     }
                                }
                           }
    });
    //}
    if(cFalg == false){
        //保存核销按钮可用
        _$("#savaclaim_button").attr("disabled", false);
        _$("#subclaim_back_button").attr("disabled", false);
     return false;
    }
    //alert("claimallNew");
    //return;
    //ajax后端验证是否符合提交，符合则提交，不符合弹出提示。
    //alert('正确');
    var bill_whether_write_off = _$("#bill_whether_write_off").val();
    if(bill_whether_write_off=='1'){
        var cust_code = _$("input[name='bill_ids']:checked").closest('tr').find('input[id=custCode]').val();
        var cust_id = _$("input[name='bill_ids']:checked").closest('tr').find('input[id=custId]').val();
        var cust_name = _$("input[name='bill_ids']:checked").closest('tr').find('input[id=custName]').val();
        var cost_center_id = _$("input[name='bill_ids']:checked").closest('tr').find('input[id=costCenterId]').val();
        var cost_center_name = _$("input[name='bill_ids']:checked").closest('tr').find('input[id=costCenterName]').val();
    }
    var URL="";
    if(document.getElementById("incoming_count_s").value>1){
        if(bill_whether_write_off=='1'){
            URL=venusbase + "/FinclaimAction.do?cmd=claimallNew&cust_code="+cust_code+"&cust_id="+cust_id+"&cust_name="+encodeURIComponent(cust_name)+"&cost_center_id="+cost_center_id+"&cost_center_name="+encodeURIComponent(cost_center_name);
        }else{
             URL=venusbase + "/FinclaimAction.do?cmd=claimallNew";
        }
    }else{
    if(claimallNew=="1"){
        if(bill_whether_write_off=='1'){
            URL=venusbase + "/FinclaimAction.do?cmd=claimallNew&cust_code="+cust_code+"&cust_id="+cust_id+"&cust_name="+encodeURIComponent(cust_name)+"&cost_center_id="+cost_center_id+"&cost_center_name="+encodeURIComponent(cost_center_name);
        }else{
             URL=venusbase + "/FinclaimAction.do?cmd=claimallNew";
        }
    }else{
        if(bill_whether_write_off=='1'){
            URL=venusbase + "/FinclaimAction.do?cmd=claimall&cust_code="+cust_code+"&cust_id="+cust_id+"&cust_name="+encodeURIComponent(cust_name)+"&cost_center_id="+cost_center_id+"&cost_center_name="+encodeURIComponent(cost_center_name);
        }else{
            URL=venusbase + "/FinclaimAction.do?cmd=claimall";
        }
    }
    }
    //alert("URL="+URL);
    //return;
    showProgressBar();
    //如果开票类型为手动开票，跳过红冲和开票环节
    if (openInvoiceFlag == '1'){
    	alert("当前账单为手动开票，不自动红冲与开票！");
    	url = venusbase + "/FinclaimAction.do?cmd=leftbar2list";
        window.location.href = url;
        return;
    }
    _$.ajax({
        type : "post",
        url : URL,
        data : _$("form").serialize(),
        dataType : "html",
        async: false,
        success : function(data) {
            if(data) {
               if (data == '1') {
                //保存核销按钮不可用
                _$("#savaclaim_button").attr("disabled", true);
                _$("#subclaim_back_button").attr("disabled", true);
                  // alert('认领成功。');
                   
                   //
                   checkCreateVoucher(v_bill_id);
//                   if(is_finance_invoice=="0"){//杨旭 ：这里貌似不准确 先注释掉，下面执行方法里面会判断 账单对应的 成本中心是否 需要开票
//                        checkCreateVoucher(v_bill_id);
//                   }
                   var url;
                   if(confirm("认领成功,是否需要跳入开票界面")){
                       //获得客户id
                       var custId = _$("#lk_cust_id_hidden").val();
                       //获得成本中心id
                       var costId = _$("#cost_center_id_hidden").val();
                       //账期
                       var bill_year_month = _$("#bill_year_month").val();
                       //跳转到查询应收
	                   url = venusbase + "/FinbillAction.do?cmd=queryAll&custId="+custId+"&costId="+costId+"&bill_year_month="+bill_year_month;
	                   window.location.href = url;
                   }else{
                        url = venusbase + "/FinclaimAction.do?cmd=leftbar2list";
                        //window.location.href = url;
                        window.close();
                   }
               } else {
                   alert(data);
               }
            }
            hideProgressBar();
        }
    });
     unlockBillAndClaim(v_bill_id);
        //保存核销按钮可用
       // _$("#savaclaim_button").attr("disabled", false);
       //_$("#subclaim_back_button").attr("disabled", false);       
}

//是否 生成 红冲凭证 ccccc
 function checkCreateVoucher(v_bill_id) {
    _$.ajax({
                    url : venusbase + "/FinbillAction.do?cmd=checkCreateVoucher&v_bill_id="+v_bill_id+"&_ts="+(new Date()).getTime(),
                    type: 'GET',
                    dataType: 'html',
                    async: false,
                    timeout: 10000,
                    error: function(){
                        alert('Error loading XML document');
                        return  null;
                    },
                    success: function(text){//text 即为 历史账单（生成过凭证的，需要红冲的）ID
                        if(text!=null && text != ''){
                               //alert("bill_id="+text);
                        		
                               createBillVoucher(v_bill_id,text); //生成红冲凭证
                               insertVoucher(v_bill_id);// 老账单生成 红冲凭证后， 再生成新账单的凭证 ccccc
                            }
                        }
       });
 }
// 老账单生成 红冲凭证后， 为新账单生成凭证 ccccc
 function insertVoucher(v_bill_id) {
    _$.ajax({
                    url : venusbase + "/FinbillAction.do?cmd=insertVoucher&v_bill_id="+v_bill_id+"&_ts="+(new Date()).getTime(),
                    type: 'GET',
                    dataType: 'html',
                    async: false,
                    timeout: 10000,
                    error: function(){
                        alert('Error loading XML document');
                        return  null;
                    },
                    success: function(text){//text 即为 true or false
                        if(text!=null && text != '' && "true" == text){
                               
                               alert("为新账单生成凭证成功！");
                               
                            }
                        }
       });
 }
 
 //生成红冲凭证
 function createBillVoucher(old_bill_id,bill_ids) {
           //var _now ="${requestScope.currentDate}";
           //CurentDate();
           //alert("_now======"+_now);
           //var v_date=arg[0];//制单日期
           var turl = "/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateBill&bill_ids=" + bill_ids +"&vtype=转"+"&vtitle=转账凭证"+"&buztype=0&voucher_type=hongchong";
           turl=turl+"&date="+_now;  
           //alert("turl======"+turl);
           turl = encodeURI(turl);
           _$.ajax({
           url: turl,
           type: 'GET',
           dataType: 'html',
           async: false,
           timeout: 10000,
           error: function(text){
                   alert(text);
                   hideProgressBar();
                   return  null;
               },
           success: function(text){
           	        if(text!=null &&text=="凭证已成功保存"){
                        alert(text);
                        updateBillCreatevoucher(old_bill_id+","+bill_ids);
                    }else{
//                    	alert("生成红冲凭证失败！\n\n"+text);
                    	alert(text);
                    	var url = venusbase + "/FinclaimAction.do?cmd=leftbar2list";
                        window.location.href = url;
                    }
           }
       });  
 
 }

/**
 * 差额做作为欠款/预收保存    差额作为未认领金额
 */
function subclaim_back(item,openInvoiceFlag) {
	cookieUtil.setCookie("runClaimType", "background");
    var is_finance_invoice = _$("#is_finance_invoice").val()+"";//是否需要开票1 是 0否
    //验证核销的textbox是否正确
    if(!checkVerbox()) {
        return false;
    }
    //判断成本中心下是否有发票未与账单关联
    //var fin_invoice_id = "";
     //if(_$('input[name="invoice_id"]').length>0){
         /**if(_$('input[name="invoice_id"]:checked').length ==0){
            alert("该成本中心下有发票未关联到账单，请先选择与所选发票金额一致的账单进行核销！");
            return false;
         }else{**/
           // fin_invoice_id = _$('input[name="invoice_id"]:checked').val();
            //发票金额
           // var invoice_amount = _$("#invoice_amount").val();
            //选择的账单金额
           // var ys_amount = _$("#lbl_sumv").html();
         //}
     //}
    //本次认领金额
    var v_n_sumv_h=_$("#v_n_sumv_h").val();
    var v_sumv_h = _$("#sumv").text().replace(/,/g, "");
    if(v_n_sumv_h!=null && v_n_sumv_h!=""){
            if(parseFloat(v_n_sumv_h)==0){
                    alert("本次认领金额不能等于零。");
                    _$("#v_n_sumv_h").val(v_sumv_h);
                    showt();
                    return false;
            }
    }
    var cval = _$(item).parent().prev().find(":checked").val();
    var confirmmsg = '';
    if (cval == '1' || cval == '3' || cval == '5') {
        confirmmsg = "差额做作为欠款/预收保存";
    } else if (cval == '2' || cval == '4' || cval == '6')　{
        confirmmsg = "差额作为未认领金额";
          var lbl_balance = _$("#adv_h").val();
         // alert('预收'+lbl_balance+"核销  "+v_n_sumv_h);
          if(lbl_balance>v_n_sumv_h)
          {
             alert('预收金额大于核销金额，不可以选拔差额作为未认领金额');
            return false;
          }
    }
    if (confirmmsg == "") {
        alert("请选择核销方式。");
        return false
    }
    if(!confirm(confirmmsg + '?')){
        return false;
    }
    
    if (_$("#TabCon1").css("display") == "block") {//全部认领
        if (!document.getElementById("claimingall1").checked
            && !document.getElementById("claimingall2").checked) {
            alert("请选择核销方式。");
            return false;
        }
        var sumv_h = _$("#div_1 input[id='sumv_h']").val();
        var balanceAmount=_$("#balanceAmount").val();
        if((balanceAmount!=""&&balanceAmount == '1')){
            if (Number(sumv_h) == 0) {
                alert('请选择要使用的预收。');
                return false;
            }
        }else if (Number(sumv_h) == 0) {
            alert('请选择核销账单。');
            return false;
        }
        
    } else if (_$("#TabCon2").css("display") == "block") {
    } else if (_$("#TabCon3").css("display") == "block") {
        if (!document.getElementById("claimingall5").checked
            && !document.getElementById("claimingall6").checked) {
            alert("请选择核销方式。");
            return false;
        }
        var sumv_h = _$("#div_3 input[id='sumv_h']").val();
        if (Number(sumv_h) == 0) {
            alert('请选择核销明细。');
            return false;
        }
    }

    var v_bill_id=_$("#v_bill_id").val()+"";
    ///alert("v_bill_id"+v_bill_id);
    if(v_bill_id==null){
            alert("请选择核销账单。");
    }
    
     //小额调整
     var odds_amount  = _$("#txt_odd").val();
     var cFalg = true;
     //比对发票明细与账单明细
      /**jQuery.ajax({
          url : venusbase + "/FinbillAction.do?cmd=contrastBillAndInvoice&v_bill_id="+v_bill_id+"&odds_amount="+odds_amount+"&_ts="+(new Date()).getTime(),
          type: 'GET',
          dataType: 'html',
          async: false,
          timeout: 10000,
          error: function(){
              alert('Error loading XML document');
              return  null;
          },
          success: function(text){
                               if(text!=null){       
                                     if(text != '1'){
                                          alert(text);
                                          cFalg = false;
                                          return false;
                                     }
                                }
                           }
    });**/
    
    if(cFalg == false){
        return false;
    }
    
    var checkFinClaimlog="0";
    jQuery.ajax({
                    url : venusbase + "/FinbillAction.do?cmd=checkFinClaimlog&v_bill_id="+v_bill_id+"&_ts="+(new Date()).getTime(),
                    type: 'GET',
                    dataType: 'html',
                    async: false,
                    timeout: 10000,
                    error: function(){
                        alert('Error loading XML document');
                        return  null;
                    },
                    success: function(text){
                        if(text!=null){       
                               if(text == '1'){
                                        checkFinClaimlog="1";
                                        return false;
                                   }
                            }
                        }
   });
    
   //此账单正在认领操作中请稍后再操作！
    if(checkFinClaimlog!="0"){
            alert("此账单正在认领操作中请稍后再操作！");
            /*
            _$("#bill_year_month").val("");
            _$("#balanceAmount").val('3');
            _$("#div_1 label[id='sumv']").text(0);
            _$("#div_1 input[id='sumv_h']").val(0);
            _$("#v_n_sumv_h").val("0");
            _$("#v_bill_id").val("");
            showt();
            */
            var url = venusbase + "/FinclaimAction.do?cmd=leftbar2list";
            window.location.href = url;
            return;
    }
    
    //手工预开的账单 认领时需要保存 sub_item  update  by whj 2014/06/03
    //if(fin_invoice_id !="" && fin_invoice_id != null && fin_invoice_id != "null"){
    jQuery.ajax({
          url : venusbase + "/FinbillAction.do?cmd=saveSGInvoice&v_bill_id="+v_bill_id+"&_ts="+(new Date()).getTime(),
          type: 'GET',
          dataType: 'html',
          async: false,
          timeout: 10000,
          error: function(){
              alert('Error loading XML document');
              return  null;
          },
          success: function(text){
                               if(text!=null){       
                                     if(text != '1'){
                                          alert(text);
                                          cFalg = false;
                                          return false;
                                     }
                                }
                           }
    });
    //}
    if(cFalg == false){
        return false;
    }
    
    //alert("claimallNew");
    //return;
    //ajax后端验证是否符合提交，符合则提交，不符合弹出提示。
    //alert('正确');
    var URL="";
    var bill_whether_write_off = _$("#bill_whether_write_off").val();
    if(bill_whether_write_off=='1'){
        var cust_code = _$("input[name='bill_ids']:checked").closest('tr').find('input[id=custCode]').val();
        var cust_id = _$("input[name='bill_ids']:checked").closest('tr').find('input[id=custId]').val();
        var cust_name = _$("input[name='bill_ids']:checked").closest('tr').find('input[id=custName]').val();
        var cost_center_id = _$("input[name='bill_ids']:checked").closest('tr').find('input[id=costCenterId]').val();
        var cost_center_name = _$("input[name='bill_ids']:checked").closest('tr').find('input[id=costCenterName]').val();
    }
    if(document.getElementById("incoming_count_s").value>1){
         if(bill_whether_write_off=='1'){
            URL=venusbase + "/FinclaimAction.do?cmd=claimallNewByBack&cust_code="+cust_code+"&cust_id="+cust_id+"&cust_name="+encodeURIComponent(cust_name)+"&cost_center_id="+cost_center_id+"&cost_center_name="+encodeURIComponent(cost_center_name);
         }else{
            URL=venusbase + "/FinclaimAction.do?cmd=claimallNewByBack";
         }       
    }else{
        if(claimallNew=="1"){
            if(bill_whether_write_off=='1'){
                URL=venusbase + "/FinclaimAction.do?cmd=claimallNewByBack&cust_code="+cust_code+"&cust_id="+cust_id+"&cust_name="+encodeURIComponent(cust_name)+"&cost_center_id="+cost_center_id+"&cost_center_name="+encodeURIComponent(cost_center_name);
            }else{
                URL=venusbase + "/FinclaimAction.do?cmd=claimallNewByBack";
            }   
        }else{
            if(bill_whether_write_off=='1'){
                URL=venusbase + "/FinclaimAction.do?cmd=claimall&cust_code="+cust_code+"&cust_id="+cust_id+"&cust_name="+encodeURIComponent(cust_name)+"&cost_center_id="+cost_center_id+"&cost_center_name="+encodeURIComponent(cost_center_name);
            }else{
                URL=venusbase + "/FinclaimAction.do?cmd=claimall";
            }     
        }
    }
    //alert("URL="+URL);
    //return;
    showProgressBar();
    //如果开票类型为手动开票，跳过红冲和开票环节
    if (openInvoiceFlag == '1'){
        alert("当前账单为手动开票，不自动红冲与开票！");
        url = venusbase + "/FinclaimAction.do?cmd=leftbar2list";
        window.location.href = url;
        return;
    }
    _$.ajax({
        type : "post",
        url : URL,
        data : _$("form").serialize(),
        dataType : "html",
        async: false,
        success : function(data) {
            if(data) {
               if (data == '1') {
                   checkCreateVoucher(v_bill_id);
               }
            }
        }
    });
    
    alert("后台核销已在进行中，在核销完成之前请勿对本次认领的到款和账单进行其他操作。");
    window.close();
}

//是否 生成 红冲凭证 ccccc
 function checkCreateVoucher(v_bill_id) {
    _$.ajax({
                    url : venusbase + "/FinbillAction.do?cmd=checkCreateVoucher&v_bill_id="+v_bill_id+"&_ts="+(new Date()).getTime(),
                    type: 'GET',
                    dataType: 'html',
                    async: false,
                    timeout: 10000,
                    error: function(){
                        alert('Error loading XML document');
                        return  null;
                    },
                    success: function(text){//text 即为 历史账单（生成过凭证的，需要红冲的）ID
                        if(text!=null && text != ''){
                               //alert("bill_id="+text);
                        		
                               createBillVoucher(v_bill_id,text); //生成红冲凭证
                               insertVoucher(v_bill_id);// 老账单生成 红冲凭证后， 再生成新账单的凭证 ccccc
                            }
                        }
       });
 }
// 老账单生成 红冲凭证后， 为新账单生成凭证 ccccc
 function insertVoucher(v_bill_id) {
    _$.ajax({
                    url : venusbase + "/FinbillAction.do?cmd=insertVoucher&v_bill_id="+v_bill_id+"&_ts="+(new Date()).getTime(),
                    type: 'GET',
                    dataType: 'html',
                    async: false,
                    timeout: 10000,
                    error: function(){
                        alert('Error loading XML document');
                        return  null;
                    },
                    success: function(text){//text 即为 true or false
                        if(text!=null && text != '' && "true" == text){
                               
                               alert("为新账单生成凭证成功！");
                               
                            }
                        }
       });
 }
 
 //生成红冲凭证
 function createBillVoucher(old_bill_id,bill_ids) {
           //var _now ="${requestScope.currentDate}";
           //CurentDate();
           //alert("_now======"+_now);
           //var v_date=arg[0];//制单日期
           var turl = "/FAERP/U8_voucher_remarkAction.do?cmd=batchCreateBill&bill_ids=" + bill_ids +"&vtype=转"+"&vtitle=转账凭证"+"&buztype=0&voucher_type=hongchong";
           turl=turl+"&date="+_now;  
           //alert("turl======"+turl);
           turl = encodeURI(turl);
           _$.ajax({
           url: turl,
           type: 'GET',
           dataType: 'html',
           async: false,
           timeout: 10000,
           error: function(text){
                   alert(text);
                   hideProgressBar();
                   return  null;
               },
           success: function(text){
           	        if(text!=null &&text=="凭证已成功保存"){
                        alert(text);
                        updateBillCreatevoucher(old_bill_id+","+bill_ids);
                    }else{
//                    	alert("生成红冲凭证失败！\n\n"+text);
                    	alert(text);
                    	var url = venusbase + "/FinclaimAction.do?cmd=leftbar2list";
                        window.location.href = url;
                    }
           }
       });  
 
 }
 
 
 
  //修改是否已生成红冲凭证 1是0否
  function updateBillCreatevoucher(v_bill_id) {
    _$.ajax({
                    url : venusbase + "/FinbillAction.do?cmd=updateBillCreatevoucher&v_bill_id="+v_bill_id+"&_ts="+(new Date()).getTime(),
                    type: 'GET',
                    dataType: 'html',
                    async: false,
                    timeout: 10000,
                    error: function(){
                        alert('Error loading XML document');
                        return  null;
                    },
                    success: function(text){
                        if(text!=null){
                               alert(text);
                            }
                        }
       });
 }
 
 
  function CurentDate(){
        var now = new Date();
        var year = now.getFullYear();       //年
        var month = now.getMonth() + 1;     //月
        var day = now.getDate();            //日
        var hh = now.getHours();            //时
        var mm = now.getMinutes();          //分
        var clock = year + "-";
        if(day<=25){
            if(month < 10){
            clock += "0";
            }
            clock += month + "-";
        }else{
        	if(month < 10){
            clock += "0";
            }
            clock += (month+1) + "-";
        }
        if(day<=25){
            if(day < 10){
                clock += "0";
                }
            clock += day + "";
        }else{
            clock += "01";
        }
        return(clock); 
    } 





function getcustomerList() {
    var data = window
            .showModalDialog(
                    venusbase
                            + '/CustomersimpleAction.do?cmd=queryAllGetByID&date='
                            + new Date(),
                    '',
                    'dialogHeight:550px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    if (data == undefined)
        return;
    document.form.cust_id.value = data[0];
    document.form.cust_code.value = data[1];
    document.form.cust_name.value = data[2];
    customerSelected(document.form.cust_id.value);
}



/**
 * 选择客户后，dwr获取客户成本中心
 * @param {} cust_id
 * @param {} selectValue
 */
function customerSelected(cust_id, selectValue) {
    FinbillAJAXAction.getCostCenterByCustomerID(cust_id, {
        callback : function(data) {
            setSelectForBean("cost_center_id", data, "id", "cost_center_name",
                    "");//_$("#hid_cost_center_id").val()做为选中的值
        }
    });
}


/**
 * 格式化金额
 * @param {} s 金额
 * @param {} n 小数点
 * @return {}
 */
function fmoney(num, n) {
    /*
    n = n > 0 && n <= 20 ? n : 2;
    s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";// 更改这里n数也可确定要保留的小数位
    var l = s.split(".")[0].split("").reverse();
    var r = s.split(".")[1];
    var t = "";
    for (i = 0; i < l.length; i++) {
        t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");
    }
    var retVal = t.split("").reverse().join("") + "." + r.substring(0, 2);// 保留2位小数
    return retVal;
    */
    
    num = num.toString().replace(/\$|\,/g,'');
    if(isNaN(num))
        num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num*100+0.50000000001);
    cents = num%100;
    num = Math.floor(num/100).toString();
    if(cents < 10)
        cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
        num = num.substring(0,num.length-(4*i+3)) + ',' + num.substring(num.length-(4*i+3));
    return (((sign)?'':'-') + num + '.' + cents);
    
}

/**
 * check核销textbox中数值是否正确
 * 
 * @param {} type
 */
function checkVerbox() {
    if (_$("#bill_year_month").val() == "") {
        alert("请输入认领费用账期。");
        return false;
    }
    if (!isDateString(_$("#bill_year_month").val())) {
        alert("日期格式不正确。");
        return false;
    }
    
    var txt_ver = "";//核销
    var txt_odd = "";//小额
    var txt_rem = "";//汇差
    if (_$("#TabCon1").is(":visible")) {
        //如果是全部认领
        txt_ver = _$("#div_1 input[id='txt_ver']").val();
        txt_odd = _$("#div_1 input[id='txt_odd']").val();
        txt_rem = _$("#div_1 input[id='txt_rem']").val();
        if (!_$.isNumeric(txt_ver)) {
            alert('核销金额必须为数字。');
            return false;
        }
        if (!_$.isNumeric(txt_odd)) {
            alert('小额必须为数字。');
            return false;
        }
        if (!_$.isNumeric(txt_rem)) {
            alert('汇差必须为数字。');
            return false;
        }
        
        
        var un1 =Number( _$("#un_claim_amout_h").val());
        var sumv_h = _$("#sumv").text().replace(/,/g, "");
        var v_yu_e_input=_$("#div_1 label[id='v_yu_e_input']").text().replace(/,/g, "");
        if(parseFloat(un1) >=parseFloat(sumv_h)){
                var sumv = parseFloat(_$("#div_1 label[id='lbl_sumv']").text());//应收
                var sum2 = parseFloat(txt_ver) - 
                           (parseFloat(txt_odd) +
                           parseFloat(txt_rem));
                           
                if(v_yu_e_input!=null && v_yu_e_input!=""){
                       sum2=parseFloat(sum2)+parseFloat(v_yu_e_input);
                }
                //alert(sumv.toFixed(4) +"=="+ sum2.toFixed(4)+"___v_yu_e_input=="+v_yu_e_input);
                if (sumv.toFixed(4) == sum2.toFixed(4)) {
                } else {
                    alert('请保证\"应收 + 小额 + 汇差 = 核销\"');
                    return false;
                }
        }
        
        //差额
        var difference = _$("#div_1 input[id='txt_difference']").val();
        if (parseFloat(difference) < 0) {
            alert('差额不能小于0');
            return false;
        }
    } else {
        //明细认领
        //如果是全部认领
        txt_ver = _$("#div_3 input[id='txt_ver']").val();
        txt_odd = _$("#div_3 input[id='txt_odd']").val();
        txt_rem = _$("#div_3 input[id='txt_rem']").val();
        if (!_$.isNumeric(txt_ver)) {
            alert('核销金额必须为数字。');
            return false;
        }
        if (!_$.isNumeric(txt_odd)) {
            alert('小额必须为数字。');
            return false;
        }
        if (!_$.isNumeric(txt_rem)) {
            alert('汇差必须为数字。');
            return false;
        }
        
        var sumv = parseFloat(_$("#div_3 label[id='lbl_sumv']").text());//应收
        var sum2 = parseFloat(txt_ver) - 
                   (parseFloat(txt_odd) +
                   parseFloat(txt_rem));
        if (sumv.toFixed(4) == sum2.toFixed(4)) {
        } else {
            alert('请保证\"应收 + 小额 + 汇差 = 核销\"');
            return false;
        }
        //差额
        var difference = _$("#div_3 input[id='txt_difference']").val();
        if (difference < 0) {
            alert('差额不能小于0');
            return false;
        }
    }
    var str_rate_amount = _$("#rate_amount").val();
    if (!str_rate_amount) {
        str_rate_amount = "1001";
    }
    var last_rate_amount = Math.min(1000,parseFloat(str_rate_amount));
    if (parseFloat(txt_rem) > parseFloat(last_rate_amount)) {
        alert("汇差金额不能大于"+last_rate_amount+"元");
        _$("#div_3 input[id='txt_rem']").val(last_rate_amount);
        return false;
    }
    return true;
}

/**
 * 设置汇差的只读属性
 */
function checkRemIsReadonly() {
    //有汇差，显示汇差，把汇差的只读属性去掉
    var is_remittance_error = _$("#is_remittance").val();
    if (is_remittance_error) {
        if (_$("#TabCon1").is(":visible")) {
            //如果页签为全部认领
            if (is_remittance_error == '1') {
                _$("#div_1 input[id='txt_rem']").removeAttr("readonly");
                _$("#div_1 input[id='txt_rem']").css({background: "white" });
            } else {
                //无汇差，显示小额
                _$("#div_1 input[id='txt_rem']").attr("readonly", true);
                _$("#div_1 input[id='txt_rem']").css({background: "#f0f0f0" });
            }
        } else {
            if (is_remittance_error == '1') {
                _$("#div_3 input[id='txt_rem']").removeAttr("readonly");
                _$("#div_3 input[id='txt_rem']").css({background: "white" });
            } else {
                //无汇差，显示小额
                _$("#div_3 input[id='txt_rem']").attr("readonly", true);
                _$("#div_3 input[id='txt_rem']").css({background: "#f0f0f0" });
            }
        }
    }
    
}


function onKey_Up(v_str) {
            var sumv_h = _$("#sumv").text().replace(/,/g, "");
            if(v_str==""){
                _$("#v_n_sumv_h").val("0");
                showt();
                return ;
            }
            if (Number(sumv_h) == 0) {
                alert('请选择核销账单。');
                _$("#v_n_sumv_h").val("0");
                return false;
            }
            
            if (!isNaN(v_str)) {
                if(parseFloat(v_str)>parseFloat(sumv_h)){
                       alert("本次认领金额不能大于"+sumv_h+"元。");
                       _$("#v_n_sumv_h").val(sumv_h);
                       showt();
                       return;
                }
            } else if (v_str == '-') {
                //负数，可以通过
                return;
            } else {
                alert("不是数字，请重新输入。");
                _$("#v_n_sumv_h").val(sumv_h);
                showt();
                return ;
            }  
            //小额和汇差都设置为零
             _$("#div_1 input[id='txt_odd']").val('0');
             _$("#div_1 input[id='txt_rem']").val('0');
            showt();
}




function setTab_fin(i) {
	_$("#balanceAmount").val('3');
    _$("#div_1 label[id='sumv']").text(0);
    _$("#div_1 input[id='sumv_h']").val(0);
	//showt();
    selectTab_fin(i);
}

function selectTab_fin(i) {
    switch (i) {
        case 1 :
            document.getElementById("TabCon1").style.display = "block";
            document.getElementById("TabCon3").style.display = "none";
            document.getElementById("font1").style.color = "#075587";
            document.getElementById("font3").style.color = "#000000";
            break;
        case 3 :
            document.getElementById("TabCon1").style.display = "none";
            document.getElementById("TabCon3").style.display = "block";
            document.getElementById("font1").style.color = "#000000";
            document.getElementById("font3").style.color = "#075587";
            break;
    }
}

//校验账单开票类型。如果为手动开票在认领后不需要生成红冲凭证和凭证。
function checkAndSubmit(item){
	var v_bill_id=_$("#v_bill_id").val()+"";
	var url = "/FAERP/FinbillAction.do?cmd=checkOpenInvoice&bill_id=" + v_bill_id;
    url = url+"&date="+new Date();  
    url = encodeURI(url);
    _$.ajax({
        url: url,
        type: 'GET',
        dataType: 'html',
        async: false,
        timeout: 10000,
        error: function(text){
            alert(text);
            hideProgressBar();
            return  null;
        },
        success: function(text){
        	openInvoiceFlag = text;
        	if (openInvoiceFlag != '1'){
        		openInvoiceFlag = '0';
        	}
            subclaim(item,openInvoiceFlag);
        }
    });  
}

function selectLockBillId(id) {
    var bill_id = _$("input[name='bill_ids']:checked").val();
    _$("input[name='bill_ids']").each(function(){
         //alert(jQuery(this).val());
    });
    var inc_code = _$("input[name='incoming_code']").val();
    var cust_code = _$("input[name='cust_code']").val();
    _$.ajax({
        type : "post",
        url : venusbase + "/FinclaimAction.do?cmd=lockFinIncomingAndBillByPage&bill_id=" + bill_id + "&incoming_code=" + inc_code + "&cust_code=" + cust_code,
        dataType : "text",
        success : function(data) {
            if (data != "null") {     
                alert(data);
               _$("input[name='bill_ids']").attr("checked", false);
               _$("#v_n_sumv_h").val("0");
            }
        }
    });
}

function unlockBillAndClaim(id) {
    var inc_codes = new Array(0)
    _$("input[name='incoming_code']").each(function(){
         inc_codes.push(jQuery(this).val());
    });
    //alert(inc_codes);
    _$.ajax({
        type : "post",
        url : venusbase + "/FinclaimAction.do?cmd=unLockAllFinClaimAndBillByPage&bill_id=" + id + "&inc_codes=" + inc_codes,
        dataType : "text",
        success : function(data) {
        }
    });
}
/**
 * 财务登录时，给明细认领的标签页写账单
 */
function writeTable4_1Row(bill_whether_write_off,inc_amount) {
    _$.ajax({
        type : "post",
        url : venusbase + "/FinbillAction.do?cmd=showFinBillByYearmonth",
        data : "bill_whether_write_off=" +bill_whether_write_off +"&inc_amount="+inc_amount,
        dataType : "json",
        success : function(data) {
           //showProgressBar();
            if (_$("#table1 tr").length > 1) {
                // _$("#table1 tr:not(:first)").remove();这行代码为什么不能用？
                _$("#table1 tr:gt(0)").remove();
            }
            var tr = "";
            var bill = data.finbillVoList;
            var advances = data.advancesVoList;
            _$.each(bill, function(i, n) {
                tr += "<tr class=\""
                        + (i % 2 == 0 ? 'odd' : 'even')+ "\"" + "id=" + "table1_t" + i + " >"
                        //改为只能认领一个账单：
                        //+ "<td><input type=\"radio\"  value=\"checkbox\" name=\"checkbox\"><input type=\"hidden\"  value=\""
                        //+ bill[i].id + "\" name=\"bill_ids\"></td>"
                        + "<td><input type=\"radio\"  value=\"" + bill[i].id + "\" name=\"bill_ids\" onclick=\"selectLockBillId("+bill[i].id+")\" id=\"" + bill[i].id + "\"></td>"
                        + "<td>&nbsp;" + bill[i].cust_code + "</td>"
                        + "<input type=\"hidden\" id=\"custCode\" name=\"custCode\" value=\"" +bill[i].cust_code+ "\"/>" //add by dongying 20151216 
                        + "<input type=\"hidden\" id=\"custId\" name=\"custId\" value=\"" +bill[i].cust_id+ "\"/>" //add by dongying 20151216 
                        + "<td>&nbsp;" + bill[i].cust_name + "</td>"
                        + "<input type=\"hidden\" id=\"custName\" name=\"custName\" value=\"" +bill[i].cust_name+ "\"/>" //add by dongying 20151216 
                        + "<input type=\"hidden\" id=\"costCenterId\" name=\"costCenterId\" value=\"" +bill[i].cost_center_id+ "\"/>" //add by dongying 20151216
                        + "<td>&nbsp;" + bill[i].cost_center_name + "</td>"
                        + "<input type=\"hidden\" id=\"costCenterName\" name=\"costCenterName\" value=\"" +bill[i].cost_center_name+ "\"/>" //add by dongying 20151216
                        + "<td>&nbsp;" + bill[i].bill_year_month + "</td>"
                        + "<input type=\"hidden\" id=\"billyearmonth\" name=\"billyearmonth\" value=\"" +bill[i].bill_year_month+ "\"/>" //add by dongying 20151211 为了获取费用账期
                        + "<td>&nbsp;" + bill[i].bill_amountForString
                        + "<input type=\"hidden\" id=\"bam_" + i + "\"value=\""
                        + bill[i].bill_amount + "\" />" + "</td>"
                        + "<td>&nbsp;" + bill[i].verification_amountForString + "</td>" 
                        + "<td>&nbsp;" + bill[i].rate_oddsForString 
                        + "<input type=\"hidden\" id=\"smallamount\" name=\"smallamount\" value=\"" + bill[i].rate_odds + "\"/>" //add by sqp 为了页面上获取小额 2014年3月19日 
                        + "</td>" 
                        + "<td>&nbsp;" + bill[i].rate_amount4String + "</td>" 
                        + "<td>&nbsp;" + bill[i].outstanding_amountForString
                        + "<input type=\"hidden\" id=\"osa\" name=\"osa\" value=\"" + bill[i].outstanding_amount + "\"/>"
                        + "</td>"
                        + "<td>&nbsp;" + bill[i].bill_type_bdForValue + "</td>"
                        + "<td>&nbsp;" + bill[i].user_name + "</td>"
                        + "<td>&nbsp;" + bill[i].dept_name+"</td>"+"</tr>";
            });
            _$("#table1").append(tr);
            
            //写预收表
            writeAdvances(advances);
            hideProgressBar();
        }
    });
    //清页面上保存的数据
    clearInput();
    //清空table3表
    _$("#table3 tr").remove();
}

/**
 * 查询所选帐单的汇差
 * @author yuanzhe
 * @date 20160727
 */
function changeRateAmount(target, bill_id) {
    if (target.checked) {
        var actionUrl = venusbase + "/FinclaimAction.do?cmd=getRateAmount&bill_id="+bill_id;
        _$.post(actionUrl,function(data){
            if (!!data) {
                _$("#rate_amount").val(data);
            } else {
                _$("#rate_amount").val("1001");
            }
        });
    }
}