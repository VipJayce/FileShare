// 1.检查输入参数是否全为数字
function checkNumber(str){
    var rc=true;
    if (str+"" == "undefined" || str == null){
        rc=false;
    } else if(str.length==0){
	rc=false;
    } else {
	for(i=0;i<str.length;i++){
	    if(str.charAt(i)<'0' || str.charAt(i)>'9'){
	        rc=false;
	        break;
	    }
	}
    }
    return rc;
}

// 2.检查输入参数是否为整数
function checkInteger(str){
    var rc=true;
    if (str+"" == "undefined" || str == null){
	rc=false;
    } else{
	for(i=0;i<str.length;i++){
            if(i==0 && str.charAt(i)=='-'){
                continue;
            }
            if(str.charAt(i)<'0' || str.charAt(i)>'9'){
                rc=false;
                break;
            }
	}
    }
    return rc;
}
// 3.检查输入参数是否为浮点数
function checkFloat(str){
    var rc=true;
    oneDecimal=false;
    if (str+"" == "undefined" || str == null){
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
	    if ((ch< "0") || (ch >'9')){
	        rc=false;
	        break;
	    }
	}
    }
    return rc;
}

// 6.检查输入参数是否为合法的身份证号码
//18位身份证号码参考 GB 11643
//YanZhijie  2004-03-26
function checkID(sID){	 
    var W=new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1);
    var rc=false;
    if((sID+"" == "undefined") || (sID == null)){
        return rc;
    } 
    else if(sID.length==15){
        rc=true;
        var year="19"+sID.substring(6,8);
        var month=sID.substring(8,10);
        var day=sID.substring(10,12);
        if(isDate(year,month,day)==false) rc=false;
    }
    else if(sID.length==18){
        var nCount=0;
        var nIdNum=0;
        
        var year=""+sID.substring(6,10);
        var month=sID.substring(10,12);
        var day=sID.substring(12,14);
        if(isDate(year,month,day)==false) rc=false;
        
        for(var i=0;i<18;i++){
          var c=sID.charAt(i);
          if((c=='X')||(c=='x')){
             nIdNum=10;
          }  
          else if((c<='9')||(c>='0')){
             nIdNum=c-'0';
          }
          else{
             return rc;
          }
          nCount+=nIdNum*W[i];
        }
        if((nCount%11)==1){
          rc=true;
        }        
    } 
    return rc;
}

//检查是否为合法日期
function isDate(year,month,day)
{
	  yearValue = year;
	  monthValue = month;
	  dayValue = day;
	
	if (yearValue!="" || monthValue!="" || dayValue!=""){
	  maxYear=2100	 
	  if (isNaN(yearValue) || yearValue<1900 || yearValue>parseInt(maxYear))
	  {
	     //alert("年份不正确");
	     //year.focus();
	     return false;
	  }
	  if (isNaN(monthValue) || monthValue<1 || monthValue>12)
	  { 
	     //alert("月份不正确");
	     //month.focus();
	     return false;
	  }
	  if (isNaN(dayValue) || dayValue<1 || dayValue>31)
	  {
	     //alert("日期不正确");
	     //day.focus();
	     return false;
	  }
	  if (((monthValue==4 || monthValue==6 || monthValue==9 || monthValue==11)&& dayValue>30) 
	|| (monthValue==2 && dayValue>29) 
	|| ((monthValue==2 && dayValue>28 && !((yearValue%4==0&&yearValue%100!=0)||(yearValue%400==0)))))
	  {
	    //alert("输入的日期不正确");
	    //day.focus();
	    return false;
	  }
	}	
	return true;  
}

// 11.检查是否全为字母
function isLetter(str){
    var rc=true;
    if (str+"" == "undefined" || str == null){
            rc=false;
    } else {
        for(i=0;i<str.length;i++) {
            if((str.charAt(i)>'Z' && str.charAt(i)<'a')||str.charAt(i)<'A' || str.charAt(i)>'z'){
                    rc=false;
                    break;
            }
        }
    }
    return rc;
}

// 13.检查是否全为空格
function isAllSpace(str) {
    for(i=0;i<str.length-1;i++) {
        if(str.charAt(i)!=' ') {
            if(str.charAt(i)!=0xa1||str.chatAt(i+1)!=0xa1)
                return false;
            else
                i++;
        }
    }
    if(str.charAt(i)!=' ')
        return false;
    return true;
}

//将回车键换为TAB键
function document_onkeydown() {
	switch( window.event.keyCode){
                case 13:
		 var sObjType=event.srcElement.type;
		 var sTag=event.srcElement.tagName;
		 if(sTag=="INPUT"||sTag=="SELECT"){
		 	if(sObjType=="button"||sObjType=="textarea"){
		 		//不处理
			}
		    else{
				 window.event.keyCode = 9;                         					
		    }
		 }	
		
	}

}
//将日期加一年
//如:参数是2004-01-01 则返回 2004-12-31
//参数类型须是 yyyy/mm/dd 或 yyyy--mm-dd
function addYear(beginDate){
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
       	      retYear=year;
       	      retMonth=12;
       	      retDay=31;
           }
       	   if(month==2||month==4||month==6||month==8||month==9||month==11){  //前一月为大月
       	      retYear=year+1;
       	      retMonth=month-1;
       	      retDay=31;
       	   }
       	   if(month==5||month==7||month==10||month==12){    //前一月为小月
       	      retYear=year+1;
       	      retMonth=month-1;
       	      retDay=30;
       	   }
       	   if(month==3){    //前一月是2月
       	      retYear=year+1;
       	      retMonth=month-1;	
       	      if((retYear%4==0&&retYear%100!=0)||(retYear%400==0)){  //润年	
       	         retDay="29";
       	      }else{                     //不是 润年
       	         retDay="28";
       	      }	
       	   }        	
    }else{
        retYear=year+1;
        retMonth=month;
        retDay=day-1;
    }
    if(retMonth<10) retMonth="0"+retMonth;
    if(retDay<10) retDay="0"+retDay;
    return retYear+"/"+retMonth+"/"+retDay;     
}

//去处两端空格
function trim(inString)
{
   var l,i,g,t,r;  
    inString=inString+"";
    l=inString.length;
    t=inString;
   for(i=0;i<l;i++)
   {
       g=inString.substring(i,i+1);
       if(g==" ")
       {
          t=inString.substring(i+1,l);
        }
       else
       {
         break;;
       }
    }
   r=t;
   l=t.length;
   //Delete the spaces back
   for(i=l;i>0;i--)
   {
      g=t.substring(i,i-1);
      if(g==" ")
      {
        r=t.substring(i-1,0);
      }
      else
     {
        break;
     }
   }
   return(r);
}


//得到客户端系统时间 yyyy/mm/dd
function getClientDate(){
	var theDate1 = new Date();
	var year,month,day,retDate;
	year=(theDate1.getYear() < 1000 ? theDate1.getYear() + 1900 : theDate1.getYear());		  
	month = theDate1.getMonth();
	day = theDate1.getDate();
	//alert("sss");
	//alert(parseFloat(day));
	if(parseFloat(day)<10){ 
	   day="0"+day;
	   //alert(day);
	}   
	var monthname = 
	new Array ("01","02","03","04","05","06","07","08","09","10","11","12" );
	month=(monthname[month]);	
	//alert(year+"/"+month+"/"+day);
	retDate=year+"/"+month+"/"+day;
	return retDate;
}

//将一个 字符串 中的一个子串 去掉。
//第一个参数为字符串，第二个参数为子串。
function rmvSubStr(str,subStr){
  var pos=str.indexOf(subStr);
  if(pos<0){
  	  return str;
  }else{
	  var subLen=subStr.length;
	  var s1=str.substring(0,pos);
	  var s2=str.substring(pos+subLen,str.length);
	  var s=s1+s2;
	  return s;	
  }
}

//比较两个日期值大小，日期格式必须为yyyy/mm/dd或yyyy-mm-dd 
//前面的日期大，返回1，后面的大，返回-1，相等，返回0
function compareDate(d1,d2){  
   if(d2=="") return -1;
   var year1,year2,month1,month2,day1,day2,iY1,iY2,iM1,iM2,iD1,iD2;	
   year1=d1.substring(0,4);
   month1=d1.substring(5,7);
   day1=d1.substring(8,d1.length);
   year2=d2.substring(0,4);
   month2=d2.substring(5,7);
   day2=d2.substring(8,d2.length);
   iY1=parseFloat(year1);
   iM1=parseFloat(month1);
   iD1=parseFloat(day1);
   iY2=parseFloat(year2);
   iM2=parseFloat(month2);
   iD2=parseFloat(day2);   
   if((iY1==iY2)&&(iM1==iM2)&&(iD1==iD2)){
   	return 0;
   }
   if((iY1==iY2)&&(iM1==iM2)){
	if(iD1>iD2) return 1;
	if(iD1<iD2) return -1; 
   }
   if(iY1==iY2){
	if(iM1>iM2) return 1;
 	if(iM1<iM2) return -1;
   }
   if(iY1>iY2) return 1;
   if(iY1<iY2) return -1;
}

//判断某个六位数是不是月份
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
     alert(msg+"输入格式不正确!");     
  }  
  return rtn;
}

//对六位的数月份增加一个月
function addMonth(curMonth){
  var y=curMonth.substring(0,4);
  var m=curMonth.substring(4,6);
  if(m=="12"){
     m="1";
     y=parseFloat(y)+1+"";
  }else{
     m=parseFloat(m)+1+"";
  }
  if(m.length==1) m="0"+m;
  return y+""+m;  
}

//六位月份的 月数计算
//theMonth 月
//calMonths 要加减的月数  为负则是减
function calculateMonth(theMonth,calMonths){ 
	var yyyy=theMonth.substring(0,4);
	var mm=parseFloat(theMonth.substring(4,6))-1;
	var bday = new Date(yyyy,mm, 1);
	bday.setMonth(bday.getMonth()+calMonths);
	mm=bday.getMonth()+1;
	var rtn=bday.getYear()+(mm<10?("0"+mm):(""+mm));
	return rtn;	
}

/*
   * 计算两个月份之间有多少个月，首尾两个月都包含在内 [闭区间，闭区间](如200701，200702=2)。
   * @param theStartMonth yyyymm 6位
   * @param theEndMonth yyyymm 6位
   * @return
   */
function month6Subtration(theStartMonth,theEndMonth){
  var rtn=0;
  if (parseFloat(theStartMonth)>parseFloat(theEndMonth)){
	  return 0;
  }
  var startYear=parseFloat(theStartMonth.substring(0,4));
  var startMonth=parseFloat(theStartMonth.substring(4));
  var endYear=parseFloat(theEndMonth.substring(0,4));
  var endMonth=parseFloat(theEndMonth.substring(4));		  
  if(endYear-startYear==0){
	  rtn=endMonth-startMonth+1;
  }else{
	  rtn=12-startMonth+1+endMonth;
	  rtn+=12*(endYear-startYear-1);
  }		  
  return rtn;		     
}
/**
   * 计算两个日期之间相差的天数，前闭后开区间。后面减前面，如 20080101，20080102=1
   * @param strDate1，格式yyyyMMdd或yyyy-MM-dd
   * @param strDate2，格式yyyyMMdd或yyyy-MM-dd
   * @return
   * @throws Exception
   */
function dateSubtration(strDate1,strDate2){
	var sRDate,eRDate;
	if (strDate1.length==8){
	   sRDate = new Date(strDate1.substring(0,4),strDate1.substring(4,6),strDate1.substring(6));
	   eRDate = new Date(strDate2.substring(0,4),strDate2.substring(4,6),strDate2.substring(6));	
	}else if(strDate1.length==10){
	   sRDate = new Date(strDate1.substring(0,4),strDate1.substring(5,7),strDate1.substring(8));
	   eRDate = new Date(strDate2.substring(0,4),strDate2.substring(5,7),strDate2.substring(8));
	}else{
	   alert ("日期参数错误");
	   return false;
	}		
	var result = (eRDate-sRDate)/(24*60*60*1000); 	
	return result;
}

/**
   * 日期计算
   * @param strDate，格式yyyyMMdd或yyyy-MM-dd
   * @param dataType 1年 2月 3日
   * @param calValue 增或减的数值
   * @return yyyy-MM-dd
   * @throws Exception
   */
function dateCalculate(strDate,dataType,calValue){
	var theDate; 
	var theMonth,theDay;
	var rtn;
	if (strDate.length==8){
	   theDate = new Date(strDate.substring(0,4),parseFloat(strDate.substring(4,6))-1,strDate.substring(6));
	   theMonth=strDate.substring(0,4)+strDate.substring(4,6);
	   theDay=strDate.substring(6);
	}else if(strDate.length==10){
	   theDate = new Date(strDate.substring(0,4),parseFloat(strDate.substring(5,7))-1,strDate.substring(8));
	   theMonth=strDate.substring(0,4)+strDate.substring(5,7);
	   theDay=strDate.substring(8);
	}else{
	   alert ("日期参数错误");
	   return false;
	}	
	var newMonth;
	if (dataType==1||dataType==2){//年计算,月计算
	   if (dataType==1) newMonth=calculateMonth(theMonth,calValue*12);
	   if (dataType==2) newMonth=calculateMonth(theMonth,calValue);
	   var newLastDay=getLastDayOfMonth(parseFloat(newMonth.substring(0,4)),parseFloat(newMonth.substring(4)));
	   if (parseFloat(theDay)>parseFloat(newLastDay)){ 
              rtn=newMonth.substring(0,4)+"-"+newMonth.substring(4)+"-"+newLastDay;
	   }else{
	      rtn=newMonth.substring(0,4)+"-"+newMonth.substring(4)+"-"+theDay;
	   }
	}	
	if (dataType==3){//日计算
	   theDate.setDate(theDate.getDate()+calValue);
	   var rtnYear=theDate.getYear(),rtnMonth=theDate.getMonth()+1,rtnDate=theDate.getDate();
	   var sy=rtnYear+"",sm=rtnMonth+"",sd=rtnDate+"";
	   rtn=sy+"-"+(rtnMonth<10?"0"+sm:""+sm)+"-"+(rtnDate<10?"0"+sd:""+sd);
	}	
	return rtn;
}
//得到某月的最后一天
function getLastDayOfMonth(theYear,theMonth){
   var rtn=-1;
   if (theMonth==1||theMonth==3||theMonth==5||theMonth==7||theMonth==8||theMonth==10||theMonth==12){
   	rtn=31;
   }
   if (theMonth==4||theMonth==6||theMonth==9||theMonth==11){
   	rtn=30;
   }
   if (theMonth==2){
   	if(theYear%4==0&&((theYear%100!=0)||(theYear%400==0))){
   	   rtn=29;	
   	}else{
   	   rtn=28;
   	}
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
//得到数值
function getNumber(obj){
   if (obj==null) return 0;
   if (!checkFloat(obj)||obj+""==""){
   	return 0;
   }else{
        return parseFloat(""+obj);
   }
}
//得到字符
function toStr(obj){
  if (obj==null) return "";
  return obj;
}
