    //给某些列加载复选框
    function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='checkbox' id='is_check_"+rowNo+"' checked name='is_check_on' value='1' onclick='checkemp(\"" +rowNo+"\");'>";
        
    }
    
    //批量入职福利办理好收费复选框
    function setCheckboxStatus1_1(value,entity,rowNo,cellNo){
    	//var is_preget =  jQuery("input[name='is_preget']").val();
    	//if(is_preget=='0'){//委派单实收
            entity.setProperty("is_charge_on_security","1");
            return "<input type='checkbox' id='sc_"+rowNo+"' checked name='is_charge_on_security' value='1' onclick='checkyanglao(\"" +rowNo+"\",\"" +entity.getProperty("product_code")+"\" );'>";
    	//}else{
        //    return "<input type='checkbox' id='sc_"+rowNo+"' name='is_charge_on_security' value='1' onclick='checkyanglao(\"" +rowNo+"\",\"" +entity.getProperty("product_code")+"\" );'>";	
        //}
    }
    
    function setCheckboxStatus2_1(value,entity,rowNo,cellNo){
    	//var is_preget =  jQuery("input[name='is_preget']").val();
        var product_code=entity.getProperty("product_code");
        //if(product_code!=null&&product_code=='3463' && is_preget=='0'){
        if(product_code!=null&&product_code=='3463'){
        	entity.setProperty("is_charge_on_security","1");
            return "<input type='checkbox' id='fl_"+rowNo+"' checked name='is_charge_on_security' value='1' onclick='checkfuwufei(\"" +rowNo+"\",\"" +entity.getProperty("product_code")+"\" );'>";
        }else{
            return "<input type='checkbox' id='fl_"+rowNo+"' name='is_charge_on_security' value='1' onclick='checkfuwufei(\"" +rowNo+"\",\"" +entity.getProperty("product_code")+"\" );'>";
        }
    }
    
    //申报变更福利办理好收费复选框
    function setCheckboxStatus1(value,entity,rowNo,cellNo){
        if ('1' == entity.getProperty("is_charge_on_security")){
            return "<input type='checkbox' id='sc_"+rowNo+"' checked name='is_charge_on_security' value='1' onclick='checkyanglao(\"" +rowNo+"\",\"" +entity.getProperty("product_code")+"\" );'>";
        }else{
        	return "<input type='checkbox' id='sc_"+rowNo+"' name='is_charge_on_security' value='1' onclick='checkyanglao(\"" +rowNo+"\",\"" +entity.getProperty("product_code")+"\" );'>";
        }
    }
    
    function setCheckboxStatus2(value,entity,rowNo,cellNo){
       if ('1' == entity.getProperty("is_charge_on_security")){
            return "<input type='checkbox' id='fl_"+rowNo+"'  checked name='is_charge_on_security' value='1' onclick='checkfuwufei(\"" +rowNo+"\",\"" +entity.getProperty("product_code")+"\" );'>";
        }else{
            return "<input type='checkbox' id='fl_"+rowNo+"'  name='is_charge_on_security' value='1' onclick='checkfuwufei(\"" +rowNo+"\",\"" +entity.getProperty("product_code")+"\" );'>";
        }
    }
    
    function checkemp(rowNo){
    	     var aa ="is_check_"+rowNo;
             var datacell = $id("firsttbody");
             var dataset = datacell.dataset;
             //原来勾选了就把勾去掉，原来没有勾就把勾打上，此写法有一定出错风险
             if(dataset.get(rowNo).getProperty("is_check")=='1'){
             	dataset.get(rowNo).setProperty("is_check","0");
             }else{
             	dataset.get(rowNo).setProperty("is_check","1");
             }
             
            //以下写法针对第一行有问题，其他行可行
            //if($id(aa).checked){//勾选上
            //    dataset.get(rowNo).setProperty("is_check","1");
            //}else{//勾选去掉
            //    dataset.get(rowNo).setProperty("is_check","0");
            //}
       
    }
    
    //社保产品福利办理好收费勾选后设置值
    function checkyanglao(rowNo,code){
        var aa ="sc_"+rowNo;
       //if(code!=null &&　code!='200'){
       //     $id(aa).checked=false;
       //     alert('对不起，该社保产品不能设置为福利办理好收费！');
       //}else{
             var datacell = $id("grdCityEnsureTbody");
             var dataset = datacell.dataset;
            if($id(aa).checked){//勾选上
                dataset.get(rowNo).setProperty("is_charge_on_security","1");
            }else{//勾选去掉
                dataset.get(rowNo).setProperty("is_charge_on_security","0");
            }
       //}
       
    }
    
    //如果为服务费才可勾选,勾选后设置值
    function checkfuwufei(rowNo,code){
        var aa ="fl_"+rowNo;
       if(code!=null && code!='3463'){
            $id(aa).checked=false;
            alert('对不起，该福利产品不能设置为福利办理好收费！');
       }else{
             var datacell = $id("fulitbody");
             var dataset = datacell.dataset;
            if($id(aa).checked){//勾选上
                dataset.get(rowNo).setProperty("is_charge_on_security","1");
            }else{//勾选去掉
                dataset.get(rowNo).setProperty("is_charge_on_security","0");
            }
       }
       
    }
    
    //社保产品列表，点击是否福利办理好收费全选按钮
    function chargeAll_onClick(obj){
        var datacell = $id("grdCityEnsureTbody");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
            if(obj.checked){//勾选上
                dataset.get(i).setProperty("is_charge_on_security","1");
                $id("sc_"+i).checked=true;
            }else{//勾选去掉
                dataset.get(i).setProperty("is_charge_on_security","0");
                $id("sc_"+i).checked=false;
            }
        }
       
    }
    
    //社保产品列表，点击是否预收全选按钮
    function prepayAll_onClick(obj){
        var datacell = $id("grdCityEnsureTbody");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
            if(obj.checked){//勾选上
                var frequence = dataset.get(i).getProperty("charge_frequency_bd");
                if(frequence!='1'){
                    dataset.get(i).setProperty("is_prepay",'0');
                }else{
                    dataset.get(i).setProperty("is_prepay","1");
                }
            }else{//勾选去掉
                dataset.get(i).setProperty("is_prepay","0");
            }
            datacell.refreshRow(datacell.getRow(i));
        }
    }
    
    //福利产品列表，点击是否预收全选按钮
    function prepayAll_onClick1(obj){
        var datacell = $id("fulitbody");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
            if(obj.checked){//勾选上
                var frequence = dataset.get(i).getProperty("charge_frequency_bd");
                if(frequence!='1'){
                    dataset.get(i).setProperty("is_prepay",'0');
                }else{
                    dataset.get(i).setProperty("is_prepay","1");
                }
            }else{//勾选去掉
                dataset.get(i).setProperty("is_prepay","0");
            }
            datacell.refreshRow(datacell.getRow(i));
        }
    }
    
    //如果勾了预收，收费频率只能选月付
    function checkprepay(){
        var datacell = $id("grdCityEnsureTbody");
        var dataset =datacell.dataset;
        
        var frequence = $id("dselect1").value;//dselect选择后的值
        
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
        var prepay = datasettr.getProperty("is_prepay");
        
       if(prepay=='1' && frequence!='1'){
            alert('对不起，勾选了预收，只能选择每月付！');
            $id("dselect1").setValue('1');
            datasettr.setProperty("charge_frequency_bd",'1');
            return;
            
       }
       
    }
    
    //如果勾了预收，收费频率只能选月付
    function checkprepay1(){
        var datacell = $id("fulitbody");
        var dataset =datacell.dataset;
        
        var frequence = $id("dselect2").value;//dselect选择后的值
        
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
        var prepay = datasettr.getProperty("is_prepay");
        
       if(prepay=='1' && frequence!='1'){
            alert('对不起，勾选了预收，只能选择每月付！');
            $id("dselect2").setValue('1');
            datasettr.setProperty("charge_frequency_bd",'1');
            return;
       }
       
    }
    
    
    
    //全局的批量入职日期变化了，批量收费起始日期、所有行的入职日期、合同起止日期也要跟着变化
    function toAllInputDate(){
        var input_date = $id("pl_apply_on_post_date").getValue();
        if(input_date==null || input_date==''){
        	alert('输入的批量员工入职日期为空或格式不正确！');
            return;
        }
        var start_date=tostartDate(input_date);
        var end_date1=addYear(input_date,2);
        
        $id("pl_charge_start_date").setValue(start_date);//会同步调用toAllChargeDate()方法
        
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        
        var datacell1 = $id("secondtbody");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
        	var emp_id = dataset.get(i).getProperty("emp_id");
        	var emp_name = dataset.get(i).getProperty("emp_name");
        	var emp_post_type = dataset.get(i).getProperty("contract_type_bd");
        	
        	//判断新输入的入职日期不能小于该员工的离职日期
            jQuery.ajax({
               url: vpath+'/EmppostAction.do?cmd=checkApplyDate&emp_id='+emp_id+'&apply_date='+input_date,
               type: 'GET',
               dataType: 'html',
               async: false,
               timeout: 10000,
               error: function(){
                   alert('Error loading XML document');
                       return  null;
                   },
               success: function(text){
                   if(text==1){       
                         alert('员工'+emp_name+'已办理离职，且离职日期未到，新输入的入职日期不能早于离职日期，请重新选择！');
                         dataset.get(i).setProperty("apply_on_post_date",'');
                         return;
                   }else{
                    	dataset.get(i).setProperty("apply_on_post_date",input_date);
                                    
                        //同步更新该员工劳动合同起止日期
                        var datasettr1 = dataset1.findEntity("id",emp_id );
                        datasettr1.setProperty("start_date",input_date);
                        datasettr1.setProperty("end_date",end_date1);
                                    
                        if(emp_post_type=='1' || emp_post_type=='3'){
                            datasettr1.setProperty("send_start_date",input_date);
                            datasettr1.setProperty("send_end_date",end_date1);
                        }
                                    
                              
                        datacell.refreshRow(datacell.getRow(i));
                   }
               }
            });
           
        }
        datacell1.refresh();
        
    }
    
    //全局的批量收费起始日期变化了，所有的收费起止日期也要跟着变化，同时更新基数不为空的值(针对批量入职)
    function toAllChargeDate(){
        var input_date = $id("pl_charge_start_date").getValue();
        if(input_date==null || input_date==''){
            alert('输入的批量收费起始时间为空或格式不正确！');
            return;
        }
        var start_date=tostartDate(input_date);
        var end_date=toendDate(start_date);
                
        $id("pl_charge_start_date").setValue(start_date);
        $id("pl_charge_end_date").setValue(end_date);
        
        //第一个列表更新收费起止日期、福利收费起始日期
        var datacell = $id("firsttbody");
        var dataset = datacell.dataset;//取得页面的datacell
        
        //行循环
        for(var i=0; i<dataset.getLength(); i++){
            dataset.get(i).setProperty("charge_start_date",start_date);
            dataset.get(i).setProperty("charge_end_date",end_date);
            
            var yearmonth = start_date.substring(0,4)+start_date.substring(5,7);
            
            var fields = datacell.fields;//获得页面所有的列
            //列循环，使用页面field名称设值
            for(var j=0; j<fields.length; j++){
                var field = fields[j];
                var fieldName = field.fieldName;
                //更新福利收费起始日期
                if (fieldName.indexOf("fl_sf_start_date") == 0){
                    dataset.get(i).setProperty(fieldName,start_date);
                }
                if(fieldName.indexOf("sf_start_date") == 0){
                    dataset.get(i).setProperty(fieldName,yearmonth);
                }
                if (fieldName.indexOf("base") == 0){
                    //修改基数不为空的值
                    if(dataset.get(i).getProperty(fieldName)!=null || dataset.get(i).getProperty(fieldName)!=''){
                        //得到社保产品id
                        var basename = fieldName.split('_');
                        var security_product_id = basename[1];
                        var base = dataset.get(i).getProperty(fieldName);
                        //根据新的起始收费日期重新判断基数范围，并计算金额
                        anyAmount1(dataset.get(i),security_product_id,base);
                    }
                        
                }
            }
            datacell.refreshRow(datacell.getRow(i));
        }
    }
    
    //根据入职日期得到收费起始日期
    function tostartDate(input_date){
        var date=input_date.split('-');
        var sf_start='';
        
        //收费起始日期
        if(date[2]<'16'){//上半月
            sf_start=date[0]+'-'+date[1]+'-01';
        }else{//下半月
            //12月
            if(date[1]=='12'){
                var year=parseInt(date[0])+1;
                sf_start=year+'-01-01';
            }else{
                //1~9月
                if(date[1].substr(0,1)=='0'){
                    var mon=parseInt(date[1].substr(1,1))+1;
                    if(mon<10){
                        sf_start=date[0]+'-0'+mon+'-01';
                    }else{
                        sf_start=date[0]+'-'+mon+'-01';
                    }
                }else{//10~11月
                    var mon=parseInt(date[1])+1;
                    sf_start=date[0]+'-'+mon+'-01';
                }
            }
        }
        
        return sf_start;
    
    }
    
     //收费结束日期为起始日期加两年减一天，如：起始日期为2012-08-01，结束日期为2014-07-31
    function toendDate(sf_start){
        var date=sf_start.split('-');
        var sf_end='';
        
        //如果是1月1日
        if(date[1]=='01' && date[2]=='01'){
            var year=parseInt(date[0])+1;
            sf_end=year+'-12-31';
        }else{
            var year=parseInt(date[0])+2;
            //1~9月
            if(date[1].substr(0,1)=='0'){
                var mon=parseInt(date[1].substr(1,1))-1;
                var day=monthlastday(year,mon);
                sf_end=year+'-0'+mon+'-'+day;
            }else{//10~11月
                var mon=parseInt(date[1])-1;
                var day=monthlastday(year,mon);
                if(mon<10){
                    sf_end=year+'-0'+mon+'-'+day;
                }else{
                    sf_end=year+'-'+mon+'-'+day;
                }   
            }
        }
        
        return sf_end;
    
    }
    
    //根据年月得到该月的最后一天，参数为数值型
    function monthlastday(year,month){
        var day=30;
        if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
            day=31;
        }
        if(month==2){
            day=28;
            //判断是否闰年
          //  if(year%4==0&&((theYear%100!=0)||(theYear%400==0))){
            if(year%4==0&&((year%100!=0)||(year%400==0))){
            day=29;
            }
        }
        return day;
    }
    
     //当前日期直接年份加两年
    function addTwoYear(input_date){
        var date=input_date.split('-');
        var sf_end='';
        
        var year=parseInt(date[0])+2;
        //2月29日的情况
        if(date[1]=='02' && date[2]=='29'){
            sf_end=year+'-02-28';
        }else{
            sf_end=year+'-'+date[1]+'-'+date[2];
        }
        
        return sf_end;
    
    }
    
//将日期加num年减一天
//如:参数是2004-01-01 则返回 2005-12-31
//参数类型须是yyyy-mm-dd
function addYear(beginDate,num){
    if(beginDate=="") return "";
    var year1=beginDate.substring(0,4);
    var month1=beginDate.substring(5,7);
    var day1=beginDate.substring(8,beginDate.length);   
    var year = parseFloat(year1);
    var month = parseFloat(month1);
    var day = parseFloat(day1);
    var retYear,retMonth,retDay;
    if(day==1){  //为每个月的1日
           if(month==1){  //1月1日
              retYear=year+num-1;
              retMonth=12;
              retDay=31;
           }
           if(month==2||month==4||month==6||month==8||month==9||month==11){  //前一月为大月
              retYear=year+num;
              retMonth=month-1;
              retDay=31;
           }
           if(month==5||month==7||month==10||month==12){    //前一月为小月
              retYear=year+num;
              retMonth=month-1;
              retDay=30;
           }
           if(month==3){    //前一月是2月
              retYear=year+num;
              retMonth=month-1; 
              if((retYear%4==0&&retYear%100!=0)||(retYear%400==0)){  //润年   
                 retDay="29";
              }else{                     //不是 润年
                 retDay="28";
              } 
           }            
    }else{
        retYear=year+num;
        retMonth=month;
        retDay=day-1;
    }
    if(retMonth<10) retMonth="0"+retMonth;
    if(retDay<10) retDay="0"+retDay;
    return retYear+"-"+retMonth+"-"+retDay;     
}
    
//**************************以下为计算金额的公用方法*************************    
//得到数值
function getNumber(obj){
   if (obj==null) return 0;
   if (!checkFloat(obj)||obj+""==""){
    return 0;
   }else{
        return parseFloat(""+obj);
   }
}
//检查输入参数是否为浮点数
function checkFloat(str){
    var rc=true;
    oneDecimal=false;
    if (str+"" == "undefined" || str == null || str==''){
        rc=false;
    } else{
        for(i=0;i<str.length;i++){
            ch=str.charAt(i);
            if(i==0 && ch=='-'){
            continue;
            }
            if(ch=="." && !oneDecimal){
            oneDecimal=true;
                continue;
            }
            if(ch==","){
                continue;
            }
            if ((ch< "0") || (ch >'9')){
                rc=false;
                break;
            }
        }
    }
    return rc;
}   
//判断某个六位数是不是年份月份格式yyyymm
function checkMonth(yearMonth,msg){
  if(yearMonth=="") return true;  
  var rtn=true;
  var s=yearMonth+"";
  //alert(s.length);
  if(s.length!=6) rtn=false;
  if(!checkNumber(yearMonth))rtn=false; //必须全是数字
  var year=s.substring(0,4);
  var month=s.substring(4,6);
  if(parseFloat(year)<2000 || parseFloat(year)>2030) rtn=false;
  if(parseFloat(month)<1 || parseFloat(month)>12) rtn=false;
  
  if(!rtn){
     alert(msg+"输入日期格式或范围不正确!");     
  }  
  return rtn;
}

//四舍五入
function floatRound(myFloat,mfNumber){ 
  if ( mfNumber == 0 ) {
    return Math.round(myFloat); 
  } else { 
    var cutNumber = Math.pow(10,mfNumber); 
    return Math.round((myFloat+0.000000000001) * cutNumber)/cutNumber; 
  } 
}

/**计算一个社保
 base 基数 ratio 比例 addMoney 附加金额 iPrecise 精确值 iCarry 进位方式
**/
function calInsurance(base,ratio,addMoney,iPrecisePara,iCarryPara){
      var iPrecise=""+iPrecisePara;
      var iCarry=""+iCarryPara; 
      if (iPrecise=="") iPrecise="2";
      if (iCarry=="") iCarry="1";
      var anMoney;        
      //alert(base+":"+ratio+":"+addMoney+":"+iPrecise+":"+iCarry);     
      anMoney=floatRound(base*ratio,5);
      if(parseFloat(iPrecise)<=2){//小数位小于等于2位，不是精确值  
        if(iCarry=="1"){//四舍五入
            }else if(iCarry=="2"){//先四舍五入再见零进整
                  var extStr="0.";
              for(var i=0;i<parseFloat(iPrecise);i++){
                 extStr=extStr+"0";
              }
              extStr=extStr+"4";
              var extDouble=parseFloat(extStr);
                  anMoney=anMoney+extDouble;
                  //20160513chenxiaopei 增加先四舍五入的处理
                  anMoney=floatRound(anMoney,parseFloat(iPrecise)+1);
            }else if(iCarry=="3"){//见零进整
                var tmpMoney=anMoney+"";
                var dotPos=tmpMoney.indexOf(".");
                if (dotPos>=0){//有小数点
                    var preMoney=tmpMoney.substring(0,dotPos+1+parseFloat(iPrecise))+"0";
                    tmpMoney=tmpMoney.substring(dotPos+1+parseFloat(iPrecise));
                    if (tmpMoney!=""){
                        if (parseFloat(tmpMoney)>0){//需要见零进位
                            anMoney=parseFloat(preMoney)+Math.pow(10,-1*parseFloat(iPrecise));       
                        }   
                    }   
                }
            }
            anMoney=floatRound(anMoney,parseFloat(iPrecise));               
            
      }else{  //小数位大于2位，是精确值 
                anMoney=floatRound(anMoney,parseFloat(iPrecise));
      }
      return anMoney+addMoney;
}

/**
 * 批量入职和变更的横表计算（陈小佩重新修改）
 *recordEmp 一个员工（一行记录）; indexs 改变了基数的社保产品序号; recordInsurance 一个产品的比例及计算方式信息行
**/
function calculateInsuranceMulti(recordEmp,indexs,recordInsurance){
   var base=getNumber(recordEmp.getProperty("base_"+indexs));
   var eRatio=getNumber(recordInsurance.getProperty("e_ratio"));//企业比例
   var pRatio=getNumber(recordInsurance.getProperty("p_ratio")); //个人比例
   var eApdMoney=getNumber(recordInsurance.getProperty("e_add_ratio")); //企业附加金额
   var pApdMoney=getNumber(recordInsurance.getProperty("p_add_ratio")); //个人附加金额
   var eMoney=0,pMoney=0,money=0;
   //单位金额   
   if (eRatio>0||eApdMoney>0){
      if (eRatio>0 && base<=0) return false;
      eMoney=calInsurance(base,eRatio,eApdMoney,recordInsurance.getProperty("e_precision_bd"),recordInsurance.getProperty("e_caculate_type_bd"));
   }
   //个人金额
   if (pRatio>0||pApdMoney>0){
      if (pRatio>0 && base<=0) return false;
      pMoney=calInsurance(base,pRatio,pApdMoney,recordInsurance.getProperty("p_precision_bd"),recordInsurance.getProperty("p_caculate_type_bd"));
   }   
   if (eMoney+pMoney>0){
    
      money=eMoney+pMoney;      
      recordEmp.setProperty("e_money_"+indexs,eMoney.toFixed(4));//小数点后保留4位
      recordEmp.setProperty("p_money_"+indexs,pMoney.toFixed(4));
      recordEmp.setProperty("money_"+indexs,money.toFixed(4));
   }
   //addSumMulti(recordEmp);
}

    //根据产品id和所要查找的字段，从左下方datacell中查找对应的产品，对应的字段值返回
    function findProductVal(product_id,field_name){
        var datacell = $id("grdCityEnsureTbody");
        var dataset = datacell.dataset;//取得页面的datacell
        var svalue = "";
        for(var i=0; i<dataset.getLength(); i++){
            if(dataset.get(i).getProperty("id")!=null && dataset.get(i).getProperty("id")==product_id){
                svalue = dataset.get(i).getProperty(field_name);
                break;
            }
        }
        return svalue;
    
    }
    
    //根据产品id，从左下方datacell中查找对应的行对象
    function findProductTr(product_id){
        var datacell = $id("grdCityEnsureTbody");
        var dataset = datacell.dataset;//取得页面的datacell
        var str = null;
        for(var i=0; i<dataset.getLength(); i++){
            if(dataset.get(i).getProperty("id")!=null && dataset.get(i).getProperty("id")==product_id){
                str = dataset.get(i);
                break;
            }
        }
        return str;
    
    }


//************以下为计算社保产品金额的方法，计算社保产品金额一律只操作本行，不干涉其他行的值***********
    
    //工资改变，同步更新产品中的基数
    function anySecury(){
        var datacell = $id("firsttbody");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
        var emp_id = datasettr.getProperty("emp_id");
       //必须先输入入职日期
       var applydate = datasettr.getProperty("apply_on_post_date");
       if(applydate==null || applydate==''){
           alert('请先输入员工入职日期！');
           datasettr.setProperty("salary","");
           return;
       }
       
       var chargedate = datasettr.getProperty("charge_start_date");
       if(chargedate==null || chargedate==''){
             alert('请先输入收费起始日期！');
             datasettr.setProperty("base_"+security_product_id,"");
             return;
        }
       
        var salary = datasettr.getProperty("salary");
        if(checkFloat(salary)){
            //统一批量设置基数值
        	salary=salary.replace(',','');
            datasettr.setProperty("salary",salary);
            changeBase(datasettr,salary);
            
            datacell.endEdit();
            
            //改变第二个页签对应人员的工资
            var datacell1 = $id("secondtbody");
            var dataset1 = datacell1.dataset;//取得页面的datacell
            var datasettr1 = dataset1.findEntity("id",emp_id );
            datasettr1.setProperty("salary",salary);
            datacell1.refresh();
            
            
        }else{
            alert('输入的工资必须为浮点型数值！');
            datasettr.setProperty("salary","");
            
            return;
        }
        
    }
    
     //循环本行所有的社保产品基数，基数为空的则设为salary，同时计算金额
    function changeBase(datasettr,salary){
            var datacell = $id("firsttbody");
            var fields = datacell.fields;//获得页面所有的列
            //列循环，使用页面field名称设值
            for(var j=0; j<fields.length; j++){
                var field = fields[j];
                var fieldName = field.fieldName;
                if (fieldName.indexOf("base") == 0){
                    //修改基数为空的值
                    if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
                        datasettr.setProperty(fieldName,salary);
                    }
                    //得到社保产品id
                    var basename = fieldName.split('_');
                    var security_product_id = basename[1];
                    
                    //计算金额
                    anyAmount1(datasettr,security_product_id,salary);
                }
            }
            
    
    }
    
    //某个产品的基数变化，判断本行其他产品，根据是否绑定基数判断是否要统一替换基数，替换的产品，执行这几个产品的金额计算
    function anyAmount(security_product_id){
       var datacell = $id("firsttbody");
       var activeRow = datacell.activeRow;
       var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
       
       var chargedate = datasettr.getProperty("charge_start_date");
       if(chargedate==null || chargedate==''){
             alert('请先输入收费起始日期！');
             datasettr.setProperty("base_"+security_product_id,"");
             return;
        }
        
        var base =  datasettr.getProperty("base_"+security_product_id);
        if(checkFloat(base)){
        	base=base.replace(',','');
            datasettr.setProperty("base_"+security_product_id,base);
            changeBase1(datasettr,security_product_id,base);//本行所有产品列的操作
            
            datacell.endEdit();
        }else{
            alert('输入的产品基数必须为浮点型数值！');
            datasettr.setProperty("base_"+security_product_id,"");
            
            return;
        }
        
    }
    
    
    //循环本行的每一产品，判断是否绑定基数
    //如果是1,则本组所有产品基数设为base，同时计算金额
    //如果是0，则只改本产品的基数
    function changeBase1(datasettr,security_product_id,base){
        //base=base.replace(',','');
        var datacell = $id("firsttbody");
        var fields = datacell.fields;//获得页面所有的列
        
        //取得当前操作的社保产品的组id
        var group_id =  findProductVal(security_product_id,"group_id");
        
            //列循环，使用页面field名称设值
            for(var j=0; j<fields.length; j++){
                var field = fields[j];
                var fieldName = field.fieldName;
                if (fieldName.indexOf("base") == 0){
                    //得到该社保产品id
                    var basename = fieldName.split('_');
                    var product_id_ff = basename[1];
                    //获得该社保产品的各项属性
                    var str = findProductTr(product_id_ff);
                    var group_id_ff =  str.getProperty("group_id");
                    var bind_radix_bd_ff =  str.getProperty("bind_radix_bd");
                    //判断是否本组的产品
                    if(group_id_ff==group_id){
                        //修改同一组并且需要保持一致的社保产品的基数
                        if(bind_radix_bd_ff=='1'){
                            datasettr.setProperty(fieldName,base);
                        }else{//修改同一组并且基数为空的社保产品的基数
                            if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)=='' ){
                                datasettr.setProperty(fieldName,base);
                            }
                        }
                        
                        anyAmount1(datasettr,product_id_ff,base);
                    }
                }
            }
        

    }
    
    //重新计算某个产品的各项金额(先纠正超过最大值最小值范围的基数）
    function anyAmount1(datasettr,security_product_id,base){
    	//base=base.replace(',','');
       //必须先输入收费起始日期
       var chargedate = datasettr.getProperty("charge_start_date");
       var date=chargedate.split('-');
       var month = date[0]+date[1];
       var isLimitUpperAndLower = document.getElementById("isLimitUpperAndLower").value;
       //输入的基数数值判断是否超过上下限,如果超过了，则设为最大值或最小值
       jQuery.getJSON(vpath+"/EmppostAction.do?cmd=searchTopLowById&date="+new Date()+"",{"security_product_id":security_product_id,"apply_date":month},  function(json){
            for(var i = 0; i < json.saia.length; i++){
                if(json.saia[i].personal_low_base!=null && base<json.saia[i].personal_low_base){
	                if(isLimitUpperAndLower=="0"){
	                   datasettr.setProperty("base_"+security_product_id,base);
	                }else{
	                   //alert('输入的基数低于个人最小值，自动设为最小值！');
                        datasettr.setProperty("base_"+security_product_id,json.saia[i].personal_low_base);
	                }
                }
                
                if(json.saia[i].personal_top_radix!=null && base>json.saia[i].personal_top_radix){
                    if(isLimitUpperAndLower=="0"){
                          datasettr.setProperty("base_"+security_product_id,base);
                       }else{
                          //alert('输入的基数高于个人最大值，自动设为最大值！');
                           datasettr.setProperty("base_"+security_product_id,json.saia[i].personal_top_radix);
                       }
                }
                
                if(json.saia[i].personal_fixed_radix!=null && json.saia[i].personal_fixed_radix>0 && base!=json.saia[i].personal_fixed_radix){
                    if(isLimitUpperAndLower=="0"){
                          datasettr.setProperty("base",base);
                       }else{
                          //alert('输入的基数自动设为固定基数！');
                        datasettr.setProperty("base",json.saia[i].personal_fixed_radix);
                       }
                }
                
            }
            //执行计算
            anyAmount2(datasettr,security_product_id);
                        
            //重新计算总额
            countAllMoney(datasettr);
       });
    }
    
    
    //重新计算某个社保产品对应的各项金额
    function anyAmount2(datasettr,security_product_id){
        var str = findProductTr(security_product_id);
       //获取当前社保产品对应的比例及附加金额
       var e_ratio = str.getProperty("e_ratio");
       var p_ratio = str.getProperty("p_ratio");
       var e_add_ratio = str.getProperty("e_add_ratio");
       var p_add_ratio = str.getProperty("p_add_ratio");
       
       str.setProperty("e_ratio",e_ratio.replace(',',''));
       str.setProperty("p_ratio",p_ratio.replace(',',''));
       str.setProperty("e_add_ratio",e_add_ratio.replace(',',''));
       str.setProperty("p_add_ratio",p_add_ratio.replace(',',''));
       
       if(!checkFloat(e_ratio)){
           alert('上一步设置的企业比例必须为浮点型数值！');
           return;
       }
       if(!checkFloat(p_ratio)){
           alert('上一步设置的个人比例必须为浮点型数值！');
           return;
       }
       if(!checkFloat(e_add_ratio)){
           alert('上一步设置的企业附加金额必须为浮点型数值！');
           return;
       }
       if(!checkFloat(p_add_ratio)){
           alert('上一步设置的个人附加金额必须为浮点型数值！');
           return;
       }
       //调用后台函数caculateMoney.js计算，得到金额，企业金额，个人金额
       calculateInsuranceMulti(datasettr,security_product_id,str);
       
    }
    
    
    //企业金额或个人金额有变动，同步计算总额
    function countMoney(security_product_id){
       var datacell = $id("firsttbody");
       var activeRow = datacell.activeRow;
       var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
       
       var e_money = datasettr.getProperty("e_money_"+security_product_id);
       var p_money = datasettr.getProperty("p_money_"+security_product_id);
       datasettr.setProperty("e_money_"+security_product_id,e_money.replace(',',''));
       datasettr.setProperty("p_money_"+security_product_id,p_money.replace(',',''));
       if(!checkFloat(e_money)){
           alert('输入的企业金额必须为浮点型数值！');
           datasettr.setProperty("e_money_"+security_product_id,"0");
           return;
       }
       if(!checkFloat(p_money)){
           alert('输入的个人金额必须为浮点型数值！');
           datasettr.setProperty("p_money_"+security_product_id,"0");
           return;
       }
       
       var eMoney=0,pMoney=0,money=0;
       if(e_money+p_money>0){
            eMoney = getNumber(e_money);
            pMoney = getNumber(p_money);
            money=eMoney+pMoney;      
            
            datasettr.setProperty("e_money_"+security_product_id,eMoney.toFixed(4));
            datasettr.setProperty("p_money_"+security_product_id,pMoney.toFixed(4));
            datasettr.setProperty("money_"+security_product_id,money.toFixed(4));
       }
       
       //重新计算总额
       countAllMoney(datasettr);
    }
    
    //收费起始月有变动，所有为空的都同步更新
    function anyStartDate(security_product_id){
        var datacell = $id("firsttbody");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
        var fields = datacell.fields;//获得页面所有的列
        
        var sf_start_date = datasettr.getProperty("sf_start_date_"+security_product_id);
        
        if(!checkMonth(sf_start_date,'收费起始月')){
            datasettr.setProperty("sf_start_date","");
            return;
        }
        
        //列循环，使用页面field名称设值
        for(var j=0; j<fields.length; j++){
            var field = fields[j];
            var fieldName = field.fieldName;
            if (fieldName.indexOf("sf_start_date") == 0){
            	if(datasettr.getProperty(fieldName)==null || datasettr.getProperty(fieldName)==''){
            		datasettr.setProperty(fieldName,sf_start_date);
            	}
            }
        }
       
    }
    
    //产品的金额有变化，则修改总额
    function anyMoney(security_product_id){
       var datacell = $id("firsttbody");
       var activeRow = datacell.activeRow;
       var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
       
       var money = datasettr.getProperty("money_"+security_product_id);
        
        if(!checkFloat(money)){
           alert('输入的产品金额必须为浮点型数值！');
           datasettr.setProperty("money_"+security_product_id,"0");
           return;
       }
       datasettr.setProperty("money_"+security_product_id,money.replace(',',''));
       
       //重新计算总额
       countAllMoney(datasettr);
       
    }
    
    //福利产品的金额有变化，则修改总额
    function anyFlMoney(product_id){
       var datacell = $id("firsttbody");
       var activeRow = datacell.activeRow;
       var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
       
       var money = datasettr.getProperty("fl_money_"+product_id);
        
        if(!checkFloat(money)){
           alert('输入的产品金额必须为浮点型数值！');
           datasettr.setProperty("fl_money_"+product_id,"0");
           return;
       }
       datasettr.setProperty("fl_money_"+product_id,money.replace(',',''));
       //重新计算总额
       countAllMoney(datasettr);
       
    }

    
    //计算社保产品和福利产品总额
    function countAllMoney(datasettr){
        var datacell = $id("firsttbody");
        var fields = datacell.fields;//获得页面所有的列
        
        var allmoney=0;
        
        for(var j=0; j<fields.length; j++){
            var field = fields[j];
            var fieldName = field.fieldName;
            if (fieldName.indexOf("money") == 0 || fieldName.indexOf("fl_money") == 0){
                var mm = datasettr.getProperty(fieldName);
                if(checkFloat(mm)){
                	//mm=mm.replace(',','');
                    datasettr.setProperty(fieldName,mm);
                    allmoney+= getNumber(mm);
                }
            
            }
        }
        
        datasettr.setProperty("allmoney",allmoney.toFixed(2));
        
    }
    
    //验证输入的金额格式
    function  checkallmoney(){
        var datacell = $id("firsttbody");
       var activeRow = datacell.activeRow;
       var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
       
       var allmoney = datasettr.getProperty("allmoney");
        
        if(!checkFloat(allmoney)){
           alert('输入的合同总金额必须为浮点型数值！');
           datasettr.setProperty("allmoney","0");
           return;
       }
       datasettr.setProperty("allmoney",allmoney.replace(',',''));
        
    }