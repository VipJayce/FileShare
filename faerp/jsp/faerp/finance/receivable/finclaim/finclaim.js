_$(document).ready(function() {
    
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
            //是否有汇差
            var is_remittance_error = returnValue[3];
            _$("#is_remittance").val(is_remittance_error);
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
        }
    }
    
    
    // 鼠标离开账期后，AJAX获取数据，写入table
    _$("#bill_year_month").bind("blur", function() {
        //有汇差，显示汇差，把汇差的只读属性去掉
    	_$("#div_1 input[id='txt_odd']").val('0');
        _$("#div_1 input[id='txt_rem']").val('0');
        
        checkRemIsReadonly();
        YMblueAndKdown(_$(this));
        _$("#balanceAmount").val('3');
        _$("#div_1 label[id='sumv']").text(0);
        _$("#div_1 input[id='sumv_h']").val(0);
    });
    
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
        //因为之前是checkbox，且可以多选，所以这样遍历选中的
        //现在改为了redio，但这里不改，仍然满足要求
        _$("input[id^='bam_']").each(function() {
            checkbox = _$(this).parents("tr").children().children()[0];
            if (_$(checkbox).attr("checked")) {
                //var hidval = _$(this).val();//?hidval没有找到？
                //sum += parseFloat(hidval);
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
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////杜辉阳增加
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
                //alert("advsum="+advsum);
                var un1 =Number( _$("#un_claim_amout_h").val());
                un1 = un1.toFixed(4);
                
                
                /*
                
                
                //当核销金额大于到款额
                //alert("sum="+sum+">un1="+un1+"sum>un1"+(parseFloat(sum)>parseFloat(un1)));
                if(parseFloat(sum)>parseFloat(un1)){
                     if(!checkboxflag){//未选择预收
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
                            //var advsum = 0;
                            _$("input[id^='adbl_']").each(function() {
                                var chk = _$(this).parents("tr").children().children()[0];
                                if (_$(chk).attr("checked")) {
                                    advsum += parseFloat(_$(this).val());
                                }
                            });
                            _$("#adv_h").val(advsum);
                            showt();   
                            var v_txt_difference = _$("#div_1 input[id='txt_difference']").val();
                            //alert("v_txt_difference="+v_txt_difference);
                           if(v_txt_difference<0){
                                if(advsum<=0){
                                       _$("#balanceAmount").val('3');
                                }else{
                                       _$("#balanceAmount").val('2');
                                }
                                showt();
                            }
                            
                     }else{
                            //alert("已选择了预收！");
                            //if(advsum>=sum){
                            //     alert("预收大于核销先使用预收");
                            //     _$("#balanceAmount").val('1');
                           // }
                    }
                }else{
                            _$("#balanceAmount").val('3');
                            showt();
                }
                
               //当核销金额小于预收金额
                if(parseFloat(sum)<=parseFloat(advsum)){
                    _$("#balanceAmount").val('1');
                     showt();    
                }
                
                
                */
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
       
        }
        /////////////////////////////////////////////////杜辉阳增加
        
        
        sumv_h = _$("#div_1 input[id='sumv_h']").val();
        var balance = parseFloat(un1) - parseFloat(sumv_h);
        var v_sumv = _$("#sumv").text().replace(/,/g, "");
        var v_txt_rem = _$("#div_1 input[id='txt_rem']").val();
        
               if(balance=="0"||balance==""){
                      balance="0";
               }
    
               if(v_sumv=="0"||v_sumv==""){
                      v_sumv="0";
               }
               
               if(v_txt_rem=="0"||v_txt_rem==""){
                      v_txt_rem="0";
               }
        var v_txt_ver=parseFloat(v_sumv)+parseFloat(balance)+parseFloat(v_txt_rem);;
       //如果差额在10块钱以内，
        if (Math.abs(balance) <= 10) {
        	   //alert(balance);
                //_$("#div_1 input[id='txt_rem']").val("0");
                _$("#div_1 input[id='txt_odd']").val(parseFloat(balance).toFixed(2));
                _$("#div_1 input[id='v_txt_odd']").val(parseFloat(balance).toFixed(2));
                _$("#div_1 input[id='txt_ver']").val(v_txt_ver.toFixed(4));
                _$("#div_1 input[id='sumv_h']").val(v_txt_ver.toFixed(4));
            //alert("ver2="+ver);
        }
        
        showt();
        
        
    });
    
// ====================================点击table1（全部认领）的全部认领的全选按钮 END =============================
    

// ====================================点击table2（仅工资认领） BEGIN =============================
     //table2_2(右下角的账单表格)的行点击事件
    /*
    _$("#table2_2 tr:gt(0)").live("click", function(){
        var bill_radio = _$(this).children().children().eq(0);//.attr("id");
        if (_$(bill_radio).attr("disabled") == "disabled") {
            //如果没有工资批次没有选中，那么账单就不能选择
        } else {
            _$(bill_radio).attr("checked", "checked");
        }
    });
    */
    //点击左边薪资批次的动作
    _$("#table2_1 tr:gt(0)").live("click", function(){
        //如果没有工资批次没有选中，那么账单就不能选择
        var salary_radio = _$(this).children().children().eq(0);//.attr("id");
        _$(salary_radio).attr("checked", "checked");
        _$("#table2_2 :radio").removeAttr("disabled");
    });
    
    //点击右边边账单的动作  明细认领点击账单信息时
    _$("#table2_2 tr:gt(0)").live("click", function(){
    	
    	        var bill_radio = _$(this).children().children().eq(0);//.attr("id");
                if (_$(bill_radio).attr("disabled") == "disabled") {
                    //如果没有工资批次没有选中，那么账单就不能选择
                } else {
                    _$(bill_radio).attr("checked", "checked");
                }

        var salary_radio = _$(this).children().children().eq(0);
        _$("#billid").val(salary_radio.val());
        //alert(_$("#billid").val());
        _$.ajax({
            type : "post",
            url : venusbase + "/FinbillitemAction.do?cmd=getSalarydataSumByBillid",
            data : _$("form").serialize(),
            dataType : "json",
            success : function(data) {
                if (data) {
                    _$("#sumempsalary").text(data.sumempsalary);
                    _$("#sumsalary").text(fmoney(data.sumsalary));
                    _$("#sumsalary_hid").val(data.sumsalary);
                    _$("#sumempfax").text(data.sumempfax);
                    _$("#sumtax").text(fmoney(data.sumtax));
                    _$("#sumtax_hid").val(data.sumtax);
                    _$("#taxbd").val(data.taxbd);
                } else {
                    _$("#sumempsalary").text('0');
                    _$("#sumsalary").text('0.00');
                    _$("#sumsalary_hid").val('0.00');
                    _$("#sumempfax").text('0');
                    _$("#sumtax").text('0.00');
                    _$("#sumtax_hid").val('0.00');
                    _$("#taxbd").val(null);
                }
                
                _$("#t2_sumv_h").val(parseFloat(_$("#sumsalary_hid").val()) + parseFloat(_$("#sumtax_hid").val()));
                showt();
            }
        });
    });
    //获取：1所选只发工资且报税人数 2合计 3所选只发工资不报税人数4合计
    
    
// ====================================点击table2（仅工资认领） END =============================
    
    
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
                            //showt();   
                            
                            //alert("v_txt_difference="+v_txt_difference);
                            if(v_txt_difference<0){
                                if(advsum<=0){
                                       _$("#balanceAmount").val('3');
                                }else{
                                       _$("#balanceAmount").val('2');
                                }
                                showt();
                            }
                            
                     }else{
                            //alert("已选择了预收！");
                            //if(advsum>=sum){
                            //     alert("预收大于核销先使用预收");
                            //     _$("#balanceAmount").val('1');
                           // }
                    }
                    flag = true;
                }
                
    	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /*
        var flag = false;
        // 因为出不来_$(this).attr("checked")，所以这里转为flag
        if (_$(this).attr("checked")) {
            flag = true;
        } else {
            flag = false;
        }
        */
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
        
        /*
       //当核销金额大于到款金额并且预收大于零 并且核销金额大于预收时 使用到款加预收的情况
       if(parseFloat(v_sum)>parseFloat(un1)&&(parseFloat(v_sum)>parseFloat(advsum))&&(parseFloat(advsum)>0)){
                _$("#balanceAmount").val('2');
       }
       */
       var balanceflag = _$("#balanceflag").val();
       //alert(balanceflag+"_______"+parseFloat(sum)+"==============="+parseFloat(advsum));
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
        //alert(sum+">"+un1+"advsum="+advsum);
        
        /*
       if(parseFloat(sum)>parseFloat(un1)&&(parseFloat(sum)>parseFloat(advsum))&&(parseFloat(advsum)>0)){
            _$("#balanceAmount").val('2');
       }else{
       	    
       	     if(parseFloat(advsum)>0){
       	        _$("#balanceAmount").val('1');
       	     }else{
       	            
       	        //当核销金额大于到款额
                if(parseFloat(sum)>parseFloat(un1)){
                	
                         if(!flag){//未选择预收
                                //alert("到款额不够必须使用预收！");
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
                                    
                                    /////////////////////////////////////////////选中预收
                                    _$("#chk_adv_all").attr("checked", true);
                                    var advsum = 0;
                                    _$("input[id^='adbl_']").each(function() {
                                        var chk = _$(this).parents("tr").children().children()[0];
                                        if (_$(chk).attr("checked")) {
                                            advsum += parseFloat(_$(this).val());
                                        }
                                    });
                                    _$("#adv_h").val(advsum);
                                    //showt();    
                         }
                         
                    }else{
                    _$("#balanceAmount").val('3');
                     //showt();    
                    }
       	     }
       }
   
       //当核销金额大于到款金额并且预收大于零 并且核销金额大于预收时 使用到款加预收的情况
       if(parseFloat(sum)>parseFloat(un1)&&(parseFloat(sum)>parseFloat(advsum))&&(parseFloat(advsum)>0)){
                _$("#balanceAmount").val('2');
       }
       */
       
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
    /*
    _$("#font2").bind('click', function(){
       YMblueAndKdown(_$("#bill_year_month"));
       showt();
    });
    */
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
    
    
    //table1的行点击事件，这种写法和上面的checkbox冲突，会有死循环
    /*
    _$("#table1 tr:gt(0)").live("click", function(){
        var bill_checkbox = _$(this).children().children().eq(0);//.attr("id");
        _$(bill_checkbox).click();
    });
    /*
     * 
     */
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
                //var hidval = _$(this).val();//?hidval没有找到？
                //sum += parseFloat(hidval);
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
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////杜辉阳增加
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
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /*
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
                
                var advsum = _$("#adv_h").val();
                //alert("advsum="+advsum);
                var un1 =Number( _$("#un_claim_amout_h").val());
                un1 = un1.toFixed(4);
                //当核销金额大于到款额
                //alert("sum="+sum+">un1="+un1+"sum>un1"+(parseFloat(sum)>parseFloat(un1)));
                if(parseFloat(sum)>parseFloat(un1)){
                     if(!checkboxflag){//未选择预收
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
                            showt();   
                            var v_txt_difference =Number( _$("#txt_difference").val());
                            //alert("v_txt_difference="+v_txt_difference);
                            if(v_txt_difference<0){
                                if(advsum<=0){
                                       _$("#balanceAmount").val('3');
                                }else{
                                       _$("#balanceAmount").val('2');
                                }
                                showt();
                            }
                            
                     }else{
                            //alert("已选择了预收！");
                            //if(advsum>=sum){
                            //     alert("预收大于核销先使用预收");
                            //     _$("#balanceAmount").val('1');
                           // }
                    }
                }else{
                            _$("#balanceAmount").val('3');
                            showt();
                }
                
                
                 //当核销金额小于预收金额
                if(parseFloat(sum)<=parseFloat(advsum)){
                    _$("#balanceAmount").val('1');
                     showt();    
                }
        }
        */
        /////////////////////////////////////////////////杜辉阳增加
    });
    
//==================================table3_明细认领_全选按钮_begin=========================================================
    _$("#itemcheckall").live("click", function(){
        var flag;
        if(_$("#itemcheckall").attr("checked")){
            flag = true;
        } else {
            flag = false;
        }
        //对disabled的 checkbox不做动作
        _$("#table3 :checkbox").each(function(){//disabled="disabled"
            if (_$(this).attr("disabled") != "disabled") {
                _$(this).attr("checked", flag);
            }
        });

        ///////////////////////////////////明细认领只使用预收选中预收
        var v_balanceAmount=_$("#balanceAmount").val();
        //alert(" v_balanceAmount "+v_balanceAmount);
        var advsum = 0;
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
                            _$("input[id^='adbl_']").each(function() {
                                var chk = _$(this).parents("tr").children().children()[0];
                                if (_$(chk).attr("checked")) {
                                    advsum += parseFloat(_$(this).val());
                                }
                            });
                            _$("#adv_h").val(advsum); 
                     }
                }
                showt();
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                var v_txt_difference =Number( _$("#div_3 input[id='txt_difference']").val());
                //alert("advsum=="+advsum+"v_txt_difference="+v_txt_difference);
                if(v_txt_difference<0){
                    if(advsum<=0){
                           _$("#balanceAmount").val('3');
                    }else{
                           _$("#balanceAmount").val('2');
                    }
                    showt();
                }

        allClick_cal();
    });
    
    //左边栏点击
    _$("#table3 input[id^='left_']").live("click", function(){
        var flag;
        if(_$(this).attr("checked")){
            flag = true;
        } else {
            flag = false;
        }
        //把此行所有的checkbox 跟随checked
        //_$(this).parents("tr").find(":checkbox").attr("checked", flag);
        //disabled的checkbox不做动作
        _$(this).parents("tr").find(":checkbox").each(function(){
            if (_$(this).attr("disabled") != "disabled") {
                _$(this).attr("checked", flag);
            }
        });
        
        
        /*
        if (!flag) {
            //把全选按钮false;
            _$("#itemcheckall").attr("checked", flag);
            //把上边栏全部false
            _$("#table3 input[id^='top_']").attr("checked", flag);
        } else {
            //判断上边栏是否选中
            var numPerRow = _$("#table3 th").children().filter("input[id^='top_']").length;
            _$("#table3 input[id^='con_']").each(function(i){
                var index = (i + 1) % numPerRow;
                _$("#table3 input[id^='con_']").each(function(j){
                    if (j % numPerRow == index){
                        if (_$(this).attr("checked")) {
                            flag = true;
                        } else {
                            if (_$(this).attr("disabled") != "disabled") {
                                flag = false;
                                return false;
                            }
                        }
                    }
                })
                _$("#table3 th").children().filter("input[id^='top_']").eq(index).attr("checked", flag);
            });
        
        
        
            //判断是否全部选择，如果全部选择，则把全选按钮 true
            flag = false;
            _$("#table3 :checkbox").each(function(i){
                if (i > 0) {
                    if (_$(this).attr("checked")) {
                        flag = true;
                    } else {
                        if (_$(this).attr("disabled") != "disabled") {
                            flag = false;
                            return false;
                        }
                    }
                }
            });
            _$("#itemcheckall").attr("checked", flag);
        }
        */
        leftClick_cal(_$(this));
        allClick_cal();
    });
    //上边栏点击
    _$("#table3 input[id^='top_']").live("click", function(){
        var numPerRow = _$("#table3 th").children().filter(":checkbox").length;
        flag = false;
        if (_$(this).attr("checked")) {
            flag = true;
        } else {
            flag = false;
        }
        var id = _$(this).attr("id");
        id = id.split("_");
        var i = Number(id[1]);
        //此列所有checkbox 跟随checked
        _$("#table3 :checkbox").each(function(j){
            if (j > 0) {//把全选排除在外
                if ((j - i) % numPerRow == 0 && _$(this).attr("disabled") != "disabled") {
                    _$(this).attr("checked", flag);
                }
            }
        });
        if(flag) {
            flag = false;
            _$("#table3 :checkbox").each(function(i){
                //除去第一行表头和左边栏
                if (i > numPerRow - 1 && i % numPerRow != 0) {
                    if (_$(this).attr("checked")) {
                        flag = true;
                    } else {
                        if (_$(this).attr("disabled") != "disabled") {
                            flag = false;
                            return false;
                        }
                    }
                }
            });
            _$("#itemcheckall").attr("checked", flag);
            _$("#table3 input[id^='left_']").attr("checked", flag);
        } else {
            //全选按钮 false;
            _$("#itemcheckall").attr("checked", flag);
            //左边栏全为false
            _$("#table3 input[id^='left_']").attr("checked", flag);
        }
        allClick_cal();
    });
    
    
    
    //除去上边栏和左边栏
    _$("input[id^='con_']").live("click", function(e){
        var numPerRow = _$("#table3 th").children().filter("input[id^='top_']").length;
        if (_$(this).attr('checked')) {
            //左边栏跟随
            var flag = false;
            //得到一行中所有的checkbox
            _$(this).parents("tr").find(":checkbox").each(function(i){
                if (i > 0) {
                    if(_$(this).attr("checked")){
                        flag = true;
                    } else {
                        if (_$(this).attr("disabled") != "disabled") {
                            flag = false;
                            return false;
                        }
                    }
                }
            });
            _$(this).parents("tr").children().children().eq(0).attr("checked", flag);
            //上边栏跟随 topBar
            var id = _$(this).attr("id");
            id = id.split("_");
            id_one = id[1] % numPerRow;//得到第一行的值
            var flag = false;
            _$("input[id^='con_']").each(function(i){
                if ((i+1) % numPerRow == id_one) {
                    if(_$(this).attr("checked")){
                        flag = true;
                    } else {
                        if (_$(this).attr("disabled") != "disabled") {
                            flag = false;
                            return false;
                        }
                    }
                }
            });
            _$("#top_" + (id_one == 0 ? numPerRow : id_one)).attr("checked", flag);
            //全选是否跟随
            _$("input[id^='con_']").each(function(i){
                if(_$(this).attr("checked")){
                    flag = true;
                } else {
                    if (_$(this).attr("disabled") != "disabled") {
                        flag = false;
                        return false;
                    }
                }
            });
            _$("#itemcheckall").attr("checked", flag);
        } else {
            _$(this).parents("tr").children().children().eq(0).attr("checked", false);
            var id = _$(this).attr("id");
            id = id.split("_");
            id = id[1] % numPerRow;//得到第一行
            if (id == 0) {
                id = numPerRow;
            }
            _$("#top_" + id).attr("checked", false);
            _$("#itemcheckall").attr("checked", false);
        }
        allClick_cal();
    });
    
    //一次性收费的全选功能
    _$("#checkall_oneOfffee").bind('click', function(){
        var flag = _$(this).attr("checked");
        //因为为false时，flag为undefined时，不为false
        if (flag) {
            _$("input[name='oneofffee_id']").attr("checked", true);
        } else {
            _$("input[name='oneofffee_id']").attr("checked", false);
        }
        var offArray = new Array();
        
        var sum = _$("#div_3 input[id='sumv_h']").val();
        _$("#table4 :checkbox").each(function(i){
            //把全选按钮排除
            if (i > 0) {
                var curVal = _$(this).parents("tr").find("#oneofffee_id_value").val();
                if (_$(this).attr("checked")) {
                    sum = parseFloat(sum) + parseFloat(curVal);
                    offArray.push(_$(this).val());
                } else {
                    sum = parseFloat(sum) - parseFloat(curVal);
                    offArray.pop(_$(this).val());
                }
            }
        });
        _$("#oneofffeeids").val(offArray);
        _$("#div_3 input[id='sumv_h']").val(sum);
        showt();
    });
    
    //一次性收费，点击单选框，如果构成全选的状态，则把全选框勾上
    _$("input[name='oneofffee_id']").live('click', function(e) {
        var flag = true;
        _$("#table4 :checkbox").each(function(i){
            //把全选按钮排除
            if (i > 0) {
                if (_$(this).attr("checked")) {
                } else {
                    flag = false;
                    return false;
                }
            }
        });
        _$("#checkall_oneOfffee").attr("checked", flag);
        var sum = _$("#div_3 input[id='sumv_h']").val();
        var curVal = _$(this).parents("tr").find("#oneofffee_id_value").val();
        if (!curVal) {
            curVal = 0;
        }
        var offArray = new Array();
        if (_$("#oneofffeeids").val().length > 0) {
            offArray = _$("#oneofffeeids").val().split(",");
        }
        if (_$(this).attr("checked")) {
            sum = parseFloat(sum) + parseFloat(curVal);
            offArray.push(_$(this).val());
        } else {
            sum = parseFloat(sum) - parseFloat(curVal);
            offArray.pop(_$(this).val());
        }
        _$("#oneofffeeids").val(offArray);
        //把选中的金额写到"所选应收"中
        _$("#div_3 input[id='sumv_h']").val(sum);
        showt();
    });
    
    
    
// ==============================table3_明细认领_全选按钮_end===========================================================
  
    
    //======================================全部认领的textbox联动 begin===============================
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
                //小额
                //_$("#txt_add").val("");
                //汇差
                //_$("#txt_rem").val("");
                
                _$("#div_1 input[id='txt_odd']").val("0");
                _$("#div_1 input[id='txt_rem']").val("0");
                    
            }
        });
    }
    
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
                    alert("不是数字，请重新输入。");
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
    
    //var is_remittance_error = _$("#is_remittance").val();
    //    if (is_remittance_error == '1') {
                //有汇差，
                	//if (txt_rem) {
                        _$(txt_rem).keyup(function() {
                            var v_txt_rem = _$.trim(_$("#div_1 input[id='txt_rem']").val());
                            //var v_txt_rem = _$.trim(_$("#div_1 input[id='txt_rem']").val());
                            if (v_txt_rem != '') {
                                if (!isNaN(v_txt_rem)) {
                                } else if (v_txt_rem == '-') {
                                        //负数，可以通过
                                } else {
                                    alert("不是数字，请重新输入。");
                                    return false;
                                }
                            }
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
                                //负数，可以通过
                                       _$("#div_1 input[id='txt_ver']").val(v_sumv_h.toFixed(4));
                                       _$("#div_1 input[id='sumv_h']").val(v_sumv_h.toFixed(4));
                                       _$("#v_txt_rem").val(parseFloat(v_txt_rem));//页面保存汇差
                        } else {
                            alert("不是数字，请重新输入。");
                            _$("#div_1 input[id='txt_odd']").val(v_txt_odd);
                            _$("#div_1 input[id='txt_rem']").val(v_txt_rem);
                           return false;
                        }
                    }
                    
                    showt();
                    }
              });
            
            //}
    
            //} 
    
    //======================================全部认领的textbox联动 end===============================
    
    //======================================明细认领的textbox联动 begin===============================
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
        
        /*
        _$(txt_odd).blur(function() {
            var v_txt_odd = _$.trim(_$("#div_3 input[id='txt_odd']").val());
            var v_txt_rem = _$.trim(_$("#div_3 input[id='txt_rem']").val());
            var v_sumv = _$("#div_3 label[id='sumv']").text().replace(/,/g, "");//sumv
               if(v_txt_odd=="0"||v_txt_odd==""){
                      v_txt_odd="0";
               }
    
               if(v_txt_rem=="0"||v_txt_rem==""){
                      v_txt_rem="0";
               }
            var v_sumv_h=parseFloat(v_sumv)+parseFloat(v_txt_odd)+parseFloat(v_txt_rem);
            if (v_txt_odd != '') {
                if (!isNaN(v_txt_odd)) {
                           if((parseFloat(v_txt_odd)<=10)&&(parseFloat(v_txt_odd)>=-10)){
                               //var v_txt_ver=parseFloat(v_sumv)+parseFloat(v_txt_odd);
                               _$("#div_3 input[id='txt_ver']").val(v_sumv_h.toFixed(4));
                               _$("#div_3 input[id='sumv_h']").val(v_sumv_h.toFixed(4));
                               _$("#div_3 input[id='v_txt_odd']").val(parseFloat(v_txt_odd));//页面保存小额调整
                           }else{
                               alert("小额调整范围为-10至10之间！");
                               _$("#div_3 input[id='txt_odd']").val(v_txt_odd);
                               _$("#div_3 input[id='txt_rem']").val(v_txt_rem);
                               return false;
                           }
                } else if (v_txt_odd == '-') {
                        //负数，可以通过
                        if((parseFloat(v_txt_odd)<=10)&&(parseFloat(v_txt_odd)>=-10)){
                               _$("#div_3 input[id='txt_ver']").val(v_sumv_h.toFixed(4));
                               _$("#div_3 input[id='sumv_h']").val(v_sumv_h.toFixed(4));
                               _$("#div_3 input[id='v_txt_odd']").val(parseFloat(v_txt_odd));//页面保存小额调整
                           }else{
                               alert("小额调整范围为-10至10之间！");
                               _$("#div_3 input[id='txt_odd']").val(v_txt_odd);
                               _$("#div_3 input[id='txt_rem']").val(v_txt_rem);
                               return false;
                           }
                } else {
                    alert("不是数字，请重新输入2。");
                    _$("#div_3 input[id='txt_odd']").val(v_txt_odd);
                    _$("#div_3 input[id='txt_rem']").val(v_txt_rem);
                    return false;
                }
            }
            showt();
        });
        */
        
        
        
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
            } else {
                alert('请选择成本中心。');
                hideProgressBar();
            }
            //清空页面临时保存数据的input
            _$("#salary_billid").val("");//仅工资认领时，选中账单后，填写账单ID
        } else {
            alert('请按格式输入日期。');
            hideProgressBar();
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
                        + "<td><input type=\"radio\"  value=\"" + bill[i].id + "\" name=\"bill_ids\"></td>"
                        + "<td>&nbsp;" + bill[i].bill_year_month + "</td>"
                        + "<td>&nbsp;" + bill[i].bill_amountForString
                        + "<input type=\"hidden\" id=\"bam_" + i + "\"value=\""
                        + bill[i].bill_amount + "\" />" + "</td>"
                        + "<td>&nbsp;" + bill[i].verification_amountForString + "</td>" 
                        + "<td>&nbsp;" + bill[i].rate_oddsForString + "</td>" 
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
                        + "<td><input type=\"radio\" name=\"radio\" id=\"radb_" + bill[i].id + "\"/></td>"
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
                        + "<td><input type=\"radio\"  name=\"t2_billid\" value=\"" + bill[i].id + "\" disabled=\"disabled\"/></td>"
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
    
    //预收款
    var adv_h = _$("#adv_h").val();
    
    if (_$("#TabCon1").css("display") == "block") {
        //======================应收+小额+汇差=核销==================================
        sumv_h = _$("#div_1 input[id='sumv_h']").val();
        var v_sumv = _$("#sumv").text().replace(/,/g, "");
        _$("#div_1 label[id='lbl_sumv']").text(v_sumv);//应收
        
        
         var v_txt_odd = _$.trim(_$("#div_1 input[id='v_txt_odd']").val());
         //alert("v_txt_odd="+v_txt_odd);
         
        //小额调整
        _$("#div_1 input[id='txt_odd']").val(parseFloat(v_txt_odd));//应收
        
        _$("#div_1 label[id='lbl_adv']").text(adv_h);//预收
        //差额 = 到款 - 应收
        //alert("到款="+parseFloat(un)+"应收="+parseFloat(sumv_h));
        var balance = parseFloat(un) - parseFloat(sumv_h);
        
        balance = balance.toFixed(2);
        //alert("balance="+balance);
        
        
        /*
        //如果差额在10块钱以内，
        if (Math.abs(balance) <= 10) {
        	//_$("#div_1 input[id='txt_odd']").attr("readonly", true);
            if (_$("#is_remittance").val() == '1') {
                //允许汇差，差额为汇差
                //_$("#div_1 input[id='txt_rem']").val(balance);
            } else {
                //不允许汇差，差额为小额
            	//_$("#div_1 input[id='txt_rem']").val("0");
                _$("#div_1 input[id='txt_odd']").val(balance);
                _$("#div_1 input[id='v_txt_odd']").val(balance);
            }
            //alert("ver_amount="+ver_amount+"ver1="+ver);
            //核销金额=应收+差额
            if (ver_amount) {
                ver = ver_amount;
            } else {
                ver = parseFloat(sumv_h) + parseFloat(balance);
                sumv_h=ver;
            }
            //alert("ver2="+ver);
        } else {
        	
        	*/
        	//_$("#div_1 input[id='txt_odd']").attr("readonly", false);
            //核销金额=账单的应收金额
            if (ver_amount) {
                ver = ver_amount;
            } else {
                ver = sumv_h;
                //差额在|10|块钱以外，小额和汇差默认为0
                //_$("#div_1 input[id='txt_odd']").val('0');
                //_$("#div_1 input[id='txt_rem']").val('0');
            }
        //}
        //此代码用于规避光标在核销textbox中不受控制
        if (ver_amount) {
        } else {
            _$("#div_1 input[id='txt_ver']").val(parseFloat(ver).toFixed(4));
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
        	            calshowt = parseFloat(un) + parseFloat(adv_h) - parseFloat(sumv_h);
                        calshowt = calshowt.toFixed(4);
                        
                        showt = fmoney(un, 4) + " + " + fmoney(adv_h, 4) + " - "
                                + fmoney(sumv_h, 4) + " = " + fmoney(calshowt, 4);
                        
                        showtbt="到款未认领+预收款-核销金额=差额";
                        _$("#claimingall2").attr("disabled", false);
                        _$("#claimingall2").attr("checked", true);
        	    }else{
                        calshowt =  parseFloat(adv_h) - parseFloat(sumv_h);
                        calshowt = calshowt.toFixed(4);
                        
                        showt =fmoney(adv_h, 4) + " - "
                                + fmoney(sumv_h, 4) + " = " + fmoney(calshowt, 4);
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
                calshowt = parseFloat(un) - parseFloat(sumv_h);
                calshowt = calshowt.toFixed(4);
                
                showt = fmoney(un, 4) + "  - "
                        + fmoney(sumv_h, 4) + " = " + fmoney(calshowt, 4);
                
                showtbt="到款未认领-核销金额=差额";
        }

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
        //=====================================================================杜辉阳添加的代码
        
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
    
   var v_balanceflag=_$("#balanceflag").val();
   var v_balanceAmount=balanceAmount;
   var v_sumv_h=_$("#sumv_h").val();
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
function subclaim(item) {
    //验证核销的textbox是否正确
    if(!checkVerbox()) {
        return false;
    }
    
    var cval = _$(item).parent().prev().find(":checked").val();
    var confirmmsg = '';
    if (cval == '1' || cval == '3' || cval == '5') {
        confirmmsg = "差额做作为欠款/预收保存";
    } else if (cval == '2' || cval == '4' || cval == '6')　{
        confirmmsg = "差额作为未认领金额";
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
        if (Number(sumv_h) == 0) {
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
    
    
    
    //ajax后端验证是否符合提交，符合则提交，不符合弹出提示。
    //alert('正确');
    showProgressBar();
    _$.ajax({
        type : "post",
        url : venusbase + "/FinclaimAction.do?cmd=claimall",
        data : _$("form").serialize(),
        dataType : "html",
        success : function(data) {
            if(data) {
               if (data == '1') {
                   alert('认领成功。');
                   var url = venusbase + "/FinclaimAction.do?cmd=leftbar2list";
                   window.location.href = url;
               } else {
                   alert(data);
               }
            }
            hideProgressBar();
        }
    });
    
}




/**
  * 金额：table3_全选checkbox点击，可以给上边栏以及数据checkbox使用
  */
function allClick_cal() {
    _$("#table3").find("tr").each(function(i){
        if (i > 0) {
            //得到该行的总计
            var fin_row_total_h  = _$(this).find("#fin_row_total_h");
            var label = _$(this).find("label").eq(0);
            var sum = 0;
            //tr里的第6个元素和第5个元素 员工编号+服务年月
            var empid = _$(this).children().children().eq(5).val() + "||" + _$(this).children().children().eq(4).val() + "||"; //_$(this).find("#empid").val() + "|";
            _$(this).find("input[id^='con_']").each(function(j){
                if (_$(this).attr("checked") && _$(this).attr("disabled") != "disabled") {
                    sum += parseFloat(_$(this).parent("td").text() == "" ? 0 : _$(this).parent("td").text());
                    empid += _$(this).next().val() + "||";
                }
            });
            //每一行TD中的数据累加
            _$(fin_row_total_h).val(sum);
            _$(label).text(fmoney(sum, 4));
            empid = empid.substr(0, empid.length-2);
            _$(this).find("input[name='emp']").val(empid);
            //alert(empid);
        }
    });
   calT3TotalSum();
   showt();
   

       
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////杜辉阳增加
       var v_sum=_$("#div_3 input[id='sumv_h']").val();
       var advsum = _$("#adv_h").val();
       var un1 =Number( _$("#un_claim_amout_h").val());
       //alert("v_sum="+v_sum+" un1="+un1+" advsum="+advsum);
       //当核销金额大于到款金额并且预收大于零 并且核销金额大于预收时 使用到款加预收的情况
       if(parseFloat(v_sum)>parseFloat(un1)&&(parseFloat(v_sum)>parseFloat(advsum))&&(parseFloat(advsum)>0)){
       	_$("#balanceAmount").val('2');
       }else{
       
              if(parseFloat(advsum)<=0){
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
                //alert("advsum="+advsum);
                un1 = un1.toFixed(4);
                //当核销金额大于到款额
                //alert("sum="+sum+">un1="+un1+"sum>un1"+(parseFloat(sum)>parseFloat(un1)));
                var v_txt_difference =Number( _$("#txt_difference").val());
                if(parseFloat(v_sum)>parseFloat(un1)){
                     if(!checkboxflag){//未选择预收
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
                            //showt();   
                            
                            //alert("v_txt_difference="+v_txt_difference);
                            if(v_txt_difference<0){
                                if(advsum<=0){
                                       _$("#balanceAmount").val('3');
                                }else{
                                       _$("#balanceAmount").val('2');
                                }
                                //showt();
                            }
                            
                     }else{
                            //alert("已选择了预收！");
                            //if(advsum>=sum){
                            //     alert("预收大于核销先使用预收");
                            //     _$("#balanceAmount").val('1');
                           // }
                    }
                    
                    if(parseFloat(advsum)<=0){
                    _$("#balanceAmount").val('3');
                    }
                }else{
                            _$("#balanceAmount").val('3');
                            //showt();
                }
                //当核销金额小于预收金额
                if(parseFloat(v_sum)<=parseFloat(advsum)){
                    _$("#balanceAmount").val('1');
                     //showt();    
                }
            }
       }
       showt();   
        /////////////////////////////////////////////////杜辉阳增加
        
}



/**
  * 金额：table3_左边栏点击
  */
function leftClick_cal(item) {
    var label = _$(item).parents("tr").find("label");
    var fin_row_total_h = _$(item).parents("tr").find("#fin_row_total_h");
    var sum = 0;
    //tr里的第6个元素和第5个元素 员工编号+服务年月
    var empid = _$(item).parents("tr").children().children().eq(5).val() + "||" + _$(item).parents("tr").children().children().eq(4).val() + "||";
    _$(item).parents("tr").find("input[id^='con_']").each(function(j){
        if (_$(this).attr("checked") && _$(this).attr("disabled") != "disabled") {
            sum += parseFloat(_$(this).parent("td").text() == "" ? 0 : _$(this).parent("td").text());
            empid += _$(this).next().val() + "||";
        }
    });
    //alert(empid);
    _$(fin_row_total_h).val(sum);
    _$(label).text(fmoney(sum, 4));
    empid = empid.substr(0, empid.length-2);
    _$(item).parents("tr").find("input[name='emp']").val(empid);
    calT3TotalSum();
    showt();
}

/**
 * table3_累计明细认领总金额
 * 获取选中的金额，累加，然后显示到所选应收金额合计
 */
function calT3TotalSum() {
    //获取账单明细中的值
    var t3_item_sum = 0;
    _$(".row_total").each(function(){
        t3_item_sum += parseFloat(_$(this).val() == "" ? 0 : _$(this).val());
    });
    //获取一次性收费中选中的值
    var t3_one_sum = 0;
    _$("#table4 :checkbox").each(function(i) {
        //把全选按钮排除
        if (i > 0) {
            var curVal = _$(this).parents("tr").find("#oneofffee_id_value").val();
            if (!curVal) {
                curVal = 0;
            }
            if (_$(this).attr("checked")) {
                t3_one_sum = parseFloat(t3_one_sum) + parseFloat(curVal);
            }
        }
    });
    //把两个页签的值相加
    t3_item_sum = parseFloat(t3_item_sum) + parseFloat(t3_one_sum);
    t3_item_sum = t3_item_sum.toFixed(4);
    //alert("t3_item_sum="+t3_item_sum);
    _$("#div_3 label[id='sumv']").text(fmoney(t3_item_sum, 4));
    _$("#div_3 input[id='sumv_h']").val(t3_item_sum);
        //var v_sum=_$("#div_3 input[id='sumv_h']").val();
    
    ////////////////////////////////////////
    var advsum = parseFloat(_$("#adv_h").val());
    
    var un1 =parseFloat( _$("#un_claim_amout_h").val());
    ////当到款不够且预收未选中时选中预收
    if(t3_item_sum>un1&&(advsum<=0)){
                _$("#balanceAmount").val('1');
                _$("#advancestable :checkbox").attr("checked", true);
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
                _$("input[id^='adbl_']").each(function() {
                    var chk = _$(this).parents("tr").children().children()[0];
                    if (_$(chk).attr("checked")) {
                        advsum += parseFloat(_$(this).val());
                    }
                });

    }
    _$("#adv_h").val(advsum);
    //showt(); 
       //当核销金额大于到款金额并且预收大于零 并且核销金额大于预收时 使用到款加预收的情况
       if(parseFloat(t3_item_sum)>parseFloat(un1)&&(parseFloat(t3_item_sum)>parseFloat(advsum))&&(parseFloat(advsum)>0)){
                _$("#balanceAmount").val('2');
       }
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
        
        var sumv = parseFloat(_$("#div_1 label[id='lbl_sumv']").text());//应收
        var sum2 = parseFloat(txt_ver) - 
                   (parseFloat(txt_odd) +
                   parseFloat(txt_rem));
        if (sumv.toFixed(4) == sum2.toFixed(4)) {
        } else {
            alert('请保证\"应收 + 小额 + 汇差 = 核销\"');
            return false;
        }
        //差额
        var difference = _$("#div_1 input[id='txt_difference']").val();
        if (difference < 0) {
            alert('差额不能小于0');
            return false;
        }
        return true;
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
        return true;
    }
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