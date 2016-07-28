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
//具体页面中计算,入离职用到(陈小佩重新修改)
function calculateInsurance(record){
   var base=getNumber($(record).find("input[name='base']").val());
   var eRatio=getNumber($(record).find("input[name='e_ratio']").val());//企业比例
   var pRatio=getNumber($(record).find("input[name='p_ratio']").val()); //个人比例
   var eApdMoney=getNumber($(record).find("input[name='e_add_ratio']").val()); //企业附加金额
   var pApdMoney=getNumber($(record).find("input[name='p_add_ratio']").val()); //个人附加金额

   var eMoney=0,pMoney=0,money=0;
   //单位金额   
   if (eRatio>0||eApdMoney>0){
      if (eRatio>0 && base<=0) return false;
      eMoney=calInsurance(base,eRatio,eApdMoney,$(record).find("input[name='e_precision_bd']").val(),$(record).find("input[name='e_caculate_type_bd']").val());
   }
   //个人金额
   if (pRatio>0||pApdMoney>0){
      if (pRatio>0 && base<=0) return false;
      pMoney=calInsurance(base,pRatio,pApdMoney,$(record).find("input[name='p_precision_bd']").val(),$(record).find("input[name='p_caculate_type_bd']").val());
   }   
   if (eMoney+pMoney>0){
      money=eMoney+pMoney;      
      record.find("input[name='e_money']").val(eMoney.toFixed(4));//小数点后保留4位
      record.find("input[name='p_money']").val(pMoney.toFixed(4));
      record.find("input[name='money']").val(money.toFixed(4));
   }
}

//具体页面中计算.社保用到,与calculateInsurance不同处用“*”标出
function calculateInsurance1(record){
   var base=getNumber(record.getValue("BASE"));
   var eRatio=getNumber(record.getValue("E_RATIO"));//企业比例
   var pRatio=getNumber(record.getValue("P_RATIO")); //个人比例
   var eApdMoney=getNumber(record.getValue("E_ADD_MONEY")); //企业附加金额
   var pApdMoney=getNumber(record.getValue("P_ADD_MONEY")); //个人附加金额

   var eMoney=0,pMoney=0,money=0;
   //单位金额   
   if (eRatio>0||eApdMoney>0){
      if (eRatio>0 && base<=0) return false;
      eMoney=calInsurance(base,eRatio,eApdMoney,record.getString("E_PRECISION"),record.getString("E_CACULATE_TYPE"));
   }
   //个人金额
   if (pRatio>0||pApdMoney>0){
      if (pRatio>0 && base<=0) return false;
      pMoney=calInsurance(base,pRatio,pApdMoney,record.getString("P_PRECISION"),record.getString("P_CACULATE_TYPE"));
   }   
   if (eMoney+pMoney>0){
      money=eMoney+pMoney;      
      record.setValue("E_MONEY",eMoney);
      record.setValue("P_MONEY",pMoney);
      record.setValue("MONEY",money);
      record.setValue("EXACT_E_MONEY",floatRound(base*eRatio+eApdMoney,5));//************************************
      record.setValue("EXACT_P_MONEY",floatRound(base*pRatio+pApdMoney,5));//************************************
   }
}
/**
 * 批量入职和变更的横表计算（陈小佩重新修改）
 *recordEmp 一个员工（一行记录）; fieldName 改变了基数的社保产品序号; recordInsurance 一个产品的比例及计算方式信息行
**/
function calculateInsuranceMulti(recordEmp,indexs,recordInsurance){
   var base=getNumber($(recordEmp).find("input[name='base_"+indexs+"']").val());
   var eRatio=getNumber($(recordInsurance).find("input[name='e_ratio']").val());//企业比例
   var pRatio=getNumber($(recordInsurance).find("input[name='p_ratio']").val()); //个人比例
   var eApdMoney=getNumber($(recordInsurance).find("input[name='e_add_ratio']").val()); //企业附加金额
   var pApdMoney=getNumber($(recordInsurance).find("input[name='p_add_ratio']").val()); //个人附加金额
   var eMoney=0,pMoney=0,money=0;
   //单位金额   
   if (eRatio>0||eApdMoney>0){
      if (eRatio>0 && base<=0) return false;
      eMoney=calInsurance(base,eRatio,eApdMoney,$(recordInsurance).find("input[name='e_precision_bd']").val(),$(recordInsurance).find("input[name='e_caculate_type_bd']").val());
   }
   //个人金额
   if (pRatio>0||pApdMoney>0){
      if (pRatio>0 && base<=0) return false;
      pMoney=calInsurance(base,pRatio,pApdMoney,$(recordInsurance).find("input[name='p_precision_bd']").val(),$(recordInsurance).find("input[name='p_caculate_type_bd']").val());
   }   
   if (eMoney+pMoney>0){
      money=eMoney+pMoney;      
      recordEmp.find("input[name='e_money_"+indexs+"']").val(eMoney.toFixed(4));//小数点后保留4位
      recordEmp.find("input[name='p_money_"+indexs+"']").val(pMoney.toFixed(4));
      recordEmp.find("input[name='money_"+indexs+"']").val(money.toFixed(4));
   }
   //addSumMulti(recordEmp);
}
//已经选择的社保类
function writeSocial(){
  if (datasetSocialSecurityGroup.getCurrent()==null){
     datasetSocialSecurityGroup.insertRecord();
  }
  var rcd = datasetInsurance.getFirstRecord();
  var ids="-100,", names="",cityIds="";
  while (rcd) {
    if (ids.indexOf(","+rcd.getString("SOCIAL_SECURITY_GROUP_ID")+",")<0){
       ids=ids+rcd.getString("SOCIAL_SECURITY_GROUP_ID")+",";
       names=names+rcd.getString("GROUP_NAME")+" ";  
       cityIds=cityIds+rcd.getString("CITY_ID")+",";
    }
    rcd = rcd.getNextRecord();
  }
  ids+="-100";
  cityIds+="-100";
  datasetSocialSecurityGroup.setValue("selected_group_ids",ids);
  datasetSocialSecurityGroup.setValue("selected_group_names",names);
  datasetSocialSecurityGroup.setValue("selected_city_ids",cityIds);
}

//检查基数范围逻辑
function checkBase(record){
   if (record.getString("base")!=""){
       if(getNumber(record.getValue("FIXED_BASE"))>0){
            if(record.getValue("base")!=record.getValue("FIXED_BASE")){
               alert(record.getString("PRODUCT_NAME")+"\u57FA\u6570\u5E94\u56FA\u5B9A\u4E3A"+record.getValue("FIXED_BASE"));  //基数应固定为
               //clearRecord(record);
               return false;
            }
       }
       if(getNumber(record.getValue("TOP_BASE"))>0){
            if(record.getValue("base")>record.getValue("TOP_BASE")){
               alert(record.getString("PRODUCT_NAME")+"\u57FA\u6570\u4E0D\u80FD\u5927\u4E8E"+record.getValue("TOP_BASE")); //基数不能大于
               //clearRecord(record);
               return false;
            }
       }
       if(getNumber(record.getValue("LOW_BASE"))>0){
            if(record.getValue("base")<record.getValue("LOW_BASE")){
               alert(record.getString("PRODUCT_NAME")+"\u57FA\u6570\u4E0D\u80FD\u5C0F\u4E8E"+record.getValue("LOW_BASE"));  //基数不能小于
               //clearRecord(record);
               return false;
            }
       }       
   }
   return true;
}
//计算总额
//与addSum1不同用“*”标出
function addSum(writeDataset){
    var sum=0;
    var rcd=datasetInsurance.getFirstRecord();
    while (rcd!=null){
       //if (rcd.getValue("select")==true){
          //if (getNumber(rcd.getValue("money"))>0){
             sum+=getNumber(rcd.getValue("money"));
          //}
       //}
       rcd=rcd.getNextRecord();
    }
    var rcd1=datasetNotInsurance.getFirstRecord();
    while(rcd1!=null){
               if (getNumber(rcd1.getValue("PRODUCT_PRICE"))>0){//******************************
               sum+=getNumber(rcd1.getValue("PRODUCT_PRICE"));//******************************
           }       
       rcd1=rcd1.getNextRecord();
    }
    writeDataset.setValue("contract_fund",sum+"");
}
//计算总额
//
function addSumMulti(rcd){
    var sum=0;
    var dataset=rcd.getDataset();
    for (var i=0;i<dataset.getFieldCount();i++){
       var fieldName=dataset.getField(i).getName();
       if (fieldName.indexOf("money_")>=0 && fieldName.indexOf("emoney_")<0&&fieldName.indexOf("pmoney_")<0){
          sum+=getNumber(rcd.getValue(fieldName));
       }
    }   
    rcd.setValue("contract_fund",sum+"");
}
//计算总额
//与addSum不同用“*”标出
function addSum1(writeDataset){
    var sum=0;
    var rcd=datasetInsurance.getFirstRecord();
    while (rcd!=null){
       if (rcd.getValue("select")==true){
          if (getNumber(rcd.getValue("money"))>0){
             sum+=getNumber(rcd.getValue("money"));
          }
       }
       rcd=rcd.getNextRecord();
    }
    var rcd1=datasetNotInsurance.getFirstRecord();
    while(rcd1!=null){
               if (getNumber(rcd1.getValue("money"))>0){//******************************
               sum+=getNumber(rcd1.getValue("money"));//******************************
           }       
       rcd1=rcd1.getNextRecord();
    }
    writeDataset.setValue("contract_fund",sum+"");
}

/**
 社保补缴计算
 parma@cityIdentify:标记几个特殊城市，用来算滞纳金。"0"：普通城市 "010"：北京 ......
 parma@datasetLateFee:存放滞纳金的计算方法
**/
function calculatSupply(startMonth,endMonth,fundMonth,productId,base,datasetRatio,cityIdentify,datasetLateFee){ 
    var rcdItem=datasetSocialSecurityItem.getFirstRecord();
      var itemERatio=0,itemPRatio=0;
      while(rcdItem!=null){
         if (productId==rcdItem.getString("PRODUCT_ID")){
               itemERatio=rcdItem.getValue("E_RATIO");
               itemPRatio=rcdItem.getValue("P_RATIO");             
               break;
         }
         rcdItem=rcdItem.getNextRecord();
      } 
    var curMonth=startMonth;
    var supplyEMoney=0,supplyPMoney=0,eLatefee=0,pLatefee=0,exactEMoney=0,exactPMoney=0;
    while (parseFloat(curMonth)<=parseFloat(endMonth)){
          if (productId=="200" && cityIdentify=="010" &&
               (parseFloat(curMonth.substring(0,4))<parseFloat(fundMonth.substring(0,4)))
          ) { //北京养老保险 ****************************************
              var tmp=calInsurance_beijing_200(getNumber(base),curMonth,fundMonth,datasetLateFee);
              supplyEMoney+=tmp[0];
              supplyPMoney+=tmp[1];
              eLatefee+=tmp[2];
              pLatefee+=tmp[3];
              exactEMoney+=tmp[0];
              exactPMoney+=tmp[1];
          }else{     //**************************************************************************************     
                     var findRcd=null;
                       var rcd=datasetRatio.getFirstRecord();
                       while (rcd!=null){
                                      if (rcd.getString("PRODUCT_ID")==productId){            
                                              var ratioStartMonth=toStr(rcd.getString("START_MONTH"));
                                              var ratioEndMonth=toStr(rcd.getString("END_MONTH"));
                                              if( (parseFloat(ratioStartMonth)<=parseFloat(curMonth))&&
                                                 (ratioEndMonth=="" || parseFloat(ratioEndMonth)>=parseFloat(curMonth))
                                                ) {
                                                      if (rcd.getValue("E_RATIO")==itemERatio && rcd.getValue("P_RATIO")==itemPRatio){
                                                         findRcd=rcd;
                                                         break;
                                                      }else{
                                                         findRcd=rcd;
                                                      }                                                   
                                              }               
                                      }
                                      rcd=rcd.getNextRecord();
                       }//while                 
                       if (findRcd!=null){
                            var eRatio=getNumber(findRcd.getString("E_RATIO"));//企业比例
                                      var pRatio=getNumber(findRcd.getString("P_RATIO")); //个人比例
                                      var ePrice=getNumber(findRcd.getString("E_ADD_MONEY")); //企业附加金额
                                      var pPrice=getNumber(findRcd.getString("P_ADD_MONEY"));  //个人附加金额
                                      //var fixBase=getNumber(findRcd.getString("FIXED_BASE"));  //固定基数
                                      var ePrecision=findRcd.getString("E_PRECISION");  //企业精确度
                                      var pPrecision=findRcd.getString("P_PRECISION");  //个人精确度
                                      var eCaculateType=findRcd.getString("E_CACULATE_TYPE");  //企业进位方式
                                      var pCaculateType=findRcd.getString("P_CACULATE_TYPE");  //个人进位方式               
                                                  
                                var eMoney=calInsurance(getNumber(base),eRatio,ePrice,ePrecision,eCaculateType);
                                      var pMoney=calInsurance(getNumber(base),pRatio,pPrice,pPrecision,pCaculateType);
                                      supplyEMoney+=eMoney;
                                      supplyPMoney+=pMoney;  
                                      
                                      exactEMoney+=floatRound(getNumber(base)*eRatio+ePrice,5);
                                      exactPMoney+=floatRound(getNumber(base)*pRatio+pPrice,5);                    
                       }   
                  }//if*******************************************************************************************
                  curMonth=addMonth(curMonth); //加一个月 
    }//while
    var rtn=new Array();
    rtn[0]=supplyEMoney;
    rtn[1]=supplyPMoney;
    rtn[2]=eLatefee;
    rtn[3]=pLatefee;
    rtn[4]=exactEMoney;
    rtn[5]=exactPMoney;
    return rtn;
}

/**
 社保补缴计算,修改页面用
 parma@cityIdentify:标记几个特殊城市，用来算滞纳金。"0"：普通城市 "010"：北京 ......
 parma@datasetLateFee:存放滞纳金的计算方法
**/
function calculatSupplyForModify(startMonth,endMonth,fundMonth,productId,base,datasetRatio,cityIdentify,datasetLateFee){    
    var curMonth=startMonth;
    var supplyEMoney=0,supplyPMoney=0,eLatefee=0,pLatefee=0,exactEMoney=0,exactPMoney=0;
    while (parseFloat(curMonth)<=parseFloat(endMonth)){
          if (productId=="200" && cityIdentify=="010" &&
               (parseFloat(curMonth.substring(0,4))<parseFloat(fundMonth.substring(0,4)))
          ) { //北京养老保险 ****************************************
              var tmp=calInsurance_beijing_200(getNumber(base),curMonth,fundMonth,datasetLateFee);
              supplyEMoney+=tmp[0];
              supplyPMoney+=tmp[1];
              eLatefee+=tmp[2];
              pLatefee+=tmp[3];
              exactEMoney+=tmp[0];
              exactPMoney+=tmp[1];
          }else{     //**************************************************************************************     
                       var rcd=datasetRatio.getFirstRecord();
                       while (rcd!=null){
                                  if (rcd.getString("PRODUCT_ID")==productId){            
                                      var ratioStartMonth=toStr(rcd.getString("START_MONTH"));
                                      var ratioEndMonth=toStr(rcd.getString("END_MONTH"));
                                      if( (parseFloat(ratioStartMonth)<=parseFloat(curMonth))&&
                                         (ratioEndMonth=="" || parseFloat(ratioEndMonth)>=parseFloat(curMonth))
                                        ) {
                                          var eRatio=getNumber(rcd.getString("E_RATIO"));//企业比例
                                          var pRatio=getNumber(rcd.getString("P_RATIO")); //个人比例
                                          var ePrice=getNumber(rcd.getString("E_ADD_MONEY")); //企业附加金额
                                          var pPrice=getNumber(rcd.getString("P_ADD_MONEY"));  //个人附加金额
                                          //var fixBase=getNumber(rcd.getString("FIXED_BASE"));  //固定基数
                                          var ePrecision=rcd.getString("E_PRECISION");  //企业精确度
                                          var pPrecision=rcd.getString("P_PRECISION");  //个人精确度
                                          var eCaculateType=rcd.getString("E_CACULATE_TYPE");  //企业进位方式
                                          var pCaculateType=rcd.getString("P_CACULATE_TYPE");  //个人进位方式               
                                                      
                                    var eMoney=calInsurance(getNumber(base),eRatio,ePrice,ePrecision,eCaculateType);
                                          var pMoney=calInsurance(getNumber(base),pRatio,pPrice,pPrecision,pCaculateType);
                                          supplyEMoney+=eMoney;
                                          supplyPMoney+=pMoney;  
                                          
                                          exactEMoney+=floatRound(getNumber(base)*eRatio+ePrice,5);
                                          exactPMoney+=floatRound(getNumber(base)*pRatio+pPrice,5);
                                          break;
                                      }               
                                  }
                                  rcd=rcd.getNextRecord();
                       }//while
      }//if*******************************************************************************************
      curMonth=addMonth(curMonth); //加一个月 
    }//while
    var rtn=new Array();
    rtn[0]=supplyEMoney;
    rtn[1]=supplyPMoney;
    rtn[2]=eLatefee;
    rtn[3]=pLatefee;
    rtn[4]=exactEMoney;
    rtn[5]=exactPMoney;
    return rtn;
}

/**
 社保补缴计算(针对杭州补丁)
 parma@cityIdentify:标记几个特殊城市，用来算滞纳金。"0"：普通城市 "010"：北京 ......
 parma@datasetLateFee:存放滞纳金的计算方法
**/
function calculatSupplyHangZhouPatch(startMonth,endMonth,fundMonth,base,eRatio,pRatio,ePrice,pPrice,ePrecision,pPrecision,eCaculateType,pCaculateType){ 
    var curMonth=startMonth;
    var supplyEMoney=0,supplyPMoney=0,eLatefee=0,pLatefee=0,exactEMoney=0,exactPMoney=0;
    while (parseFloat(curMonth)<=parseFloat(endMonth)){       
      var eRatio=getNumber(datasetSocialSecuritySupplyItemEdit.getString("E_RATIO"));//企业比例
      var pRatio=getNumber(datasetSocialSecuritySupplyItemEdit.getString("P_RATIO")); //个人比例
      var ePrice=getNumber(datasetSocialSecuritySupplyItemEdit.getString("E_ADD_MONEY")); //企业附加金额
      var pPrice=getNumber(datasetSocialSecuritySupplyItemEdit.getString("P_ADD_MONEY"));  //个人附加金额
      //var fixBase=getNumber(rcd.getString("FIXED_BASE"));  //固定基数
      var ePrecision=datasetSocialSecuritySupplyItemEdit.getString("E_PRECISION");  //企业精确度
      var pPrecision=datasetSocialSecuritySupplyItemEdit.getString("P_PRECISION");  //个人精确度
      var eCaculateType=datasetSocialSecuritySupplyItemEdit.getString("E_CACULATE_TYPE");  //企业进位方式
      var pCaculateType=datasetSocialSecuritySupplyItemEdit.getString("P_CACULATE_TYPE");  //个人进位方式               
          
          var eMoney=calInsurance(getNumber(base),eRatio,ePrice,ePrecision,eCaculateType);
      var pMoney=calInsurance(getNumber(base),pRatio,pPrice,pPrecision,pCaculateType);
      supplyEMoney+=eMoney;
      supplyPMoney+=pMoney;  
      
      exactEMoney+=floatRound(getNumber(base)*eRatio+ePrice,5);
      exactPMoney+=floatRound(getNumber(base)*pRatio+pPrice,5);           
      
      curMonth=addMonth(curMonth); //加一个月 
    }//while
    var rtn=new Array();
    rtn[0]=supplyEMoney;
    rtn[1]=supplyPMoney;
    rtn[2]=eLatefee;
    rtn[3]=pLatefee;
    rtn[4]=exactEMoney;
    rtn[5]=exactPMoney;
    return rtn;
}

//社保补缴三个月份检查
function checkSupplyMonth(dataset,field,startMonth,endMonth,fundMonth){
    if(field.getName()=="START_MONTH"){
       if(!checkMonth(startMonth,"\u8865\u7F34\u8D77\u59CB\u6708")){ //补缴起始月
           dataset.setValue("START_MONTH",""); 
           return false;
       }else if(startMonth!=""){
           //if(parseFloat(startMonth)<parseFloat(datasetSocialSecurity.getString("START_MONTH"))){
              //alert("补缴起始月不能早于缴费起始月！");
              //dataset.setValue("START_MONTH",""); 
           //}
       }         
    }
    if(field.getName()=="END_MONTH"){
       if(!checkMonth(endMonth,"\u8865\u7F34\u622A\u81F3\u6708")){  //补缴截至月
           dataset.setValue("END_MONTH","");
           return false;   
       }       
    }
    if(field.getName()=="FUND_MONTH"){
       if(!checkMonth(fundMonth,"\u62A5\u8868\u6708")){  //报表月
           dataset.setValue("FUND_MONTH","");
           return false;   
       }    
    }
    if(startMonth!="" && endMonth!=""){
         if(parseFloat(startMonth)>parseFloat(endMonth)){
            alert("\u8865\u7F34\u8D77\u59CB\u6708\u4E0D\u80FD\u665A\u4E8E\u8865\u7F34\u622A\u81F3\u6708!"); //补缴起始月不能晚于补缴截至月
            dataset.setValue("START_MONTH",""); 
            return false;
         }
    }
    if(startMonth!="" && fundMonth!=""){
         if(parseFloat(startMonth)>=parseFloat(fundMonth)){
            alert("\u8865\u7F34\u8D77\u59CB\u6708\u5FC5\u987B\u5C0F\u4E8E\u62A5\u8868\u6708!");  //补缴起始月必须小于报表月
            dataset.setValue("START_MONTH",""); 
            return false;
         }
    }
    
    if(fundMonth!="" && endMonth!=""){
         if(parseFloat(endMonth)>parseFloat(fundMonth)){
            alert("\u8865\u7F34\u622A\u81F3\u6708\u4E0D\u80FD\u665A\u4E8E\u62A5\u8868\u6708!"); //补缴截至月不能晚于报表月
            dataset.setValue("END_MONTH","");
            return false;
         }
    }

}

/*北京养老滞纳金计算
 *parma@ base 基数
 *parma@ supplyMonth 补缴月
 *parma@ fundMonth 补缴资金发生月份
 *parma@ datasetLateFee 存放北京社保滞纳金计算方法
 */
function calInsurance_beijing_200(base,supplyMonth,fundMonth,datasetLateFee){
   var fundYear=fundMonth.substring(0,4);
   var supplyYear=supplyMonth.substring(0,4);
   var rcd=datasetLateFee.getFirstRecord();
   var money=0,eMoney=0,pMoney=0,eLateMoney=0,pLateMoney=0;
   var finded=0;maxYear=0;
   while (rcd){
      if (parseFloat(rcd.getString("FUND_YEAR"))>maxYear){
       maxYear=parseFloat(rcd.getString("FUND_YEAR"));
      }
      if (rcd.getString("FUND_YEAR")==fundYear){
         if (rcd.getString("SUPPLY_YEAR")==supplyYear){
            money=base*(rcd.getValue("E_RATIO")+rcd.getValue("P_RATIO"))*rcd.getValue("THE_RATIO");
            pMoney=base*rcd.getValue("P_RATIO");
            eMoney=money-pMoney;
            eLateMoney=eMoney-base*rcd.getValue("E_RATIO");
            pLateMoney=pMoney-base*rcd.getValue("P_RATIO");
            finded=1;
            break;
         }
      }
      rcd=rcd.getNextRecord();  
   }
   if (finded==0){
    rcd=datasetLateFee.getFirstRecord();
    while (rcd){
          if (rcd.getString("FUND_YEAR")==(maxYear+"")){
             if (rcd.getString("SUPPLY_YEAR")==supplyYear){
                money=base*(rcd.getValue("E_RATIO")+rcd.getValue("P_RATIO"))*rcd.getValue("THE_RATIO");
                pMoney=base*rcd.getValue("P_RATIO");
                eMoney=money-pMoney;
                eLateMoney=eMoney-base*rcd.getValue("E_RATIO");
                pLateMoney=pMoney-base*rcd.getValue("P_RATIO");
                finded=1;
                break;
             }
          }
          rcd=rcd.getNextRecord();  
    }
   }
   var rtn=new Array();
   rtn[0]=floatRound(eMoney-eLateMoney,2);
   rtn[1]=floatRound(pMoney-pLateMoney,2);
   rtn[2]=floatRound(eLateMoney,2);
   rtn[3]=floatRound(pLateMoney,2);
   return rtn;
}

//修改了补缴明细后的自动计算(社保办理和修改界面调用)
function cal_supply_datail(dataset,record){
   var rcd = dataset.getFirstRecord();
    var sum=0,eSum=0,pSum=0,eLatefee=0,pLatefee=0,exactEMoney=0,exactPMoney=0;
    while (rcd) {
       sum+=rcd.getValue("MONEY");
       eSum+=rcd.getValue("E_MONEY");
       pSum+=rcd.getValue("P_MONEY");
       eLatefee+=rcd.getValue("E_LATEFEE");
       pLatefee+=rcd.getValue("P_LATEFEE");
       exactEMoney+=rcd.getValue("EXACT_E_MONEY");
       exactPMoney+=rcd.getValue("EXACT_P_MONEY");
       rcd = rcd.getNextRecord();
    }       
    datasetSocialSecuritySupply.disableEvents();
    try{
          var rcd1 = datasetSocialSecuritySupply.getFirstRecord();
          while (rcd1) {
             if (rcd1.getString("SOCIAL_SECURITY_SUPPLY_ID")==record.getString("SOCIAL_SECURITY_SUPPLY_ID")){
                rcd1.setValue("MONEY",sum);
                rcd1.setValue("E_MONEY",eSum);
                rcd1.setValue("P_MONEY",pSum);
                rcd1.setValue("E_LATEFEE",eLatefee);
                rcd1.setValue("P_LATEFEE",pLatefee);
                rcd1.setValue("EXACT_E_MONEY",exactEMoney);
                rcd1.setValue("EXACT_P_MONEY",exactPMoney);
                rcd1.setValue("MONTH_MONEY",floatRound(sum/month6Subtration(datasetSocialSecuritySupply.getString("START_MONTH"),datasetSocialSecuritySupply.getString("END_MONTH")),2));
                break;
             }
             rcd1 = rcd1.getNextRecord();
          } 
    }finally {    
          datasetSocialSecuritySupply.enableEvents();
    }                
}
//计算补缴(社保办理和修改界面调用)
function cal_supply(startMonth,endMonth,fundMonth){
    //alert(datasetLateFee);
    var base=datasetSocialSecuritySupply.getValue("BASE");    
    var rtn=null;
    if(startMonth!="" && endMonth!=""){
        var cityId=datasetGroupWithCity.getString("city_id");    
        var cityCode="0";  
        if (cityId==city_beijing){ //北京  
            cityCode="010";
        }   
        //开始计算子项金额
        datasetSocialSecuritySupplyItemEdit.disableEvents();
        try{
            var rcd = datasetSocialSecuritySupplyItemEdit.getFirstRecord();
            while (rcd) {
              rtn=calculatSupply(startMonth,endMonth,fundMonth,rcd.getString("PRODUCT_ID"),base,datasetRatio,cityCode,datasetLateFee);
              if (rtn!=null){
                 rcd.setValue("BASE",base);
                 rcd.setValue("E_MONEY",rtn[0]);
                 rcd.setValue("P_MONEY",rtn[1]);
                 rcd.setValue("MONEY",rtn[0]+rtn[1]);
                 rcd.setValue("E_LATEFEE",rtn[2]);
                 rcd.setValue("P_LATEFEE",rtn[3]);
                 rcd.setValue("EXACT_E_MONEY",rtn[4]);
                 rcd.setValue("EXACT_P_MONEY",rtn[5]);
              }
              rcd = rcd.getNextRecord();
            }        
       }finally{
            datasetSocialSecuritySupplyItemEdit.enableEvents();
       }
       //计算完子项后置总补缴金额
       cal_supply_datail(datasetSocialSecuritySupplyItemEdit,datasetSocialSecuritySupplyItemEdit.getCurrent());
    }
    
}

//除法函数，用来得到精确的除法结果 
//说明：javascript的除法结果会有误差，在两个浮点数相除的时候会比较明显。这个函数返回较为精确的除法结果。 
//调用：accDiv(arg1,arg2) 
//返回值：arg1除以arg2的精确结果
function accDiv(arg1,arg2){  
    var t1=0,t2=0,r1,r2;  
    try{t1=arg1.toString().split(".")[1].length}catch(e){}  
    try{t2=arg2.toString().split(".")[1].length}catch(e){}  
    with(Math){  
        r1=Number(arg1.toString().replace(".",""))  
        r2=Number(arg2.toString().replace(".",""))  
        return (r1/r2)*pow(10,t2-t1);  
       }  
}