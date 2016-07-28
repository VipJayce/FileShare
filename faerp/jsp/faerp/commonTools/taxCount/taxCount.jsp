<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个调税计算</title>
<link href="<%=request.getContextPath()%>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<script language="javascript">
//tab切换
    
    function setTab03Syn ( i )
    {
        selectTab03Syn(i);
    }
    
    function selectTab03Syn ( i )
    {
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabConInner1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("TabConInner2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabConInner1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("TabConInner2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
        }
    }
    </script>
    
    <script>
    
     
     
         function rtnFunc(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
         jQuery("#tab_id").val(arg[0]);
         jQuery("#tab_name").val(arg[1]);
         
        return false ;
    }
    
        
         function rtnFuntax(arg){
        var lookup = $id("lk_tax");
        lookup.value = arg[0];
        lookup.displayValue = arg[1];
         jQuery("#tab_id").val(arg[0]);
         jQuery("#tab_name").val(arg[1]);
         
        return false ;
    }
     
     
     
     
     
        function detail_onClick(){  //实现转到详细页面
             var taxId =document.getElementById("tab_id").value;
            
            datacell_formid.action="<%=request.getContextPath()%>/TaxTableAction.do?cmd=forwardDetail&id=" + taxId + "&pageModel=detail" ;
            datacell_formid.submit();
       
    }
        

  
         //计算
    function count(msg){

    var tax_id=_$("#tab_id").val();
    
    if(tax_id==""){
            alert("请选择税率表");
            return;
            
    }else{
    
         if(msg=="gongzi"){
        var salary=_$("#salary").val();
        salary = salary.replace(/[ ]/g,""); 
        
        var salaryFormat=_$("#salaryFormat").val();
        if(salaryFormat==0){
            alert("请选择工资形式");
            return;
        }
        
        if(salary==""){
            alert("工资额不能为空");
            return;
        }else{
        //如果输入的工资中含有,，刚将,替换成空格
            if (salary.indexOf(',')>0){
            var tmp=",";
            var reg=new RegExp("\\"+tmp,"g");
            salary=salary.replace(reg,"");
            }
            else if(salary.indexOf('，')>0){
              var tmp="，";
            var reg=new RegExp("\\"+tmp,"g");
            salary=salary.replace(reg,"");
                
            }
        }
      _$.ajax({
            type: "post",
            dataType :"json",
            url:"<%=request.getContextPath()%>/TaxTableAction.do?cmd=getTaxbySalary" ,
            data:{"msg":msg,"tax_id":tax_id,"salary":salary,"salaryFormat":salaryFormat},
          success:function(result){
            _$("#individualIncomeTax").val(result.ratePayment);
             _$("#calculationOfWages").val(result.afterTax);
                  }
     
             });
          
        }else if(msg=="nianzhongjiang"){
            var yearbonus=_$("#yearbonus").val();
              yearbonus = yearbonus.replace(/[ ]/g,""); 
            if(yearbonus==""){
            alert("请填写税前年终奖");
            return;
              }else{
              //如果输入的工资中含有,，刚将,替换成空格
            if (yearbonus.indexOf(',')>0){
            var tmp=",";
            var reg=new RegExp("\\"+tmp,"g");
            yearbonus=yearbonus.replace(reg,"");
            }
             else if(yearbonus.indexOf('，')>0){
              var tmp="，";
            var reg=new RegExp("\\"+tmp,"g");
            yearbonus=yearbonus.replace(reg,"");      
            }
        }
          _$.ajax({
            type: "post",
            dataType :"json",
            url:"<%=request.getContextPath()%>/TaxTableAction.do?cmd=getTaxbySalary" ,
            data:{"msg":msg,"tax_id":tax_id,"yearbonus":yearbonus},
          success:function(result){
            _$("#ratePayment").val(result.ratePayment);
             _$("#afterTax").val(result.afterTax);
                  }
             });
        
        }
            
        
    }
    
  
    }
        
        
        
        
    function showdetails(thisObj){

        var d = _$(thisObj);
        var pos = d.offset(); 

        var dHeight = _$("#shuilv").height(); 
        var dWidth = _$("#shuilv").width(); 
        
        var dtop = pos.top + dHeight ; 
        var dleft = pos.left + dWidth ; 
 
        var winWidth =_$(window).width();//当前窗口可视宽度
        var winHeight =_$(window).height();//高度
 
 
 
        var t = pos.top +dHeight; // 弹出框的上边位置
        var l = pos.left ;  // 弹出框的左边位置
 
        if(dleft > winWidth){
            l = pos.left - dWidth;
            
        }
        if(dtop > winHeight){
            t = pos.top - dHeight;
            
        } 
        if(dWidth > winWidth){
            l= 0;
        }
        if(dHeight > winHeight){
            t = 0;
        }

        _$("#huilvDiv").css({ "top": t, "left": l }).show(); 
 
    }

        
    </script>
  
</head>
<body>


         <div id="bg" class="xixi1"  >
            <div id="font1" class="tab1"  onMouseDown="setTab03Syn(1);document.getElementById('bg').className='xixi1'">工资推算</div>
            <div id="font2" class="tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='xixi2'">年终奖计算</div>
        </div>
            <script language="javascript">
    writeTableTop("个调税计算",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
        
         <div id="TabCon1">

         <div id="TabConInner1" >
         <form name="datacell_formid" action="" id="datacell_formid" method="post">


<div id="auDivParent0"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild0',this,'<%=request.getContextPath()%>/')" >&nbsp;
        税前/税后工资推算
        </td>
    </tr>
</table>
</div>

<div id="auDivChild0"  style="padding_top:20px;background-color: #EAEAEA"> 
<table class="table_div_content" >
<tr><td>
    <table class="table_noFrame" width="100%" style="margin-top: 10px;" border="0">
        <tr>
            <td width="20%" align="right"><span class="style_required_red">* </span>选择税率表</td>
            <td width="35%" align="left">
       <w:lookup onReturnFunc="rtnFunc" style="width: 400px;" readonly="true" id="lk_clz" lookupUrl="/TaxTableAction.do?cmd=toShuilv"  displayValue="${requestScope.tax_table_name}" dialogTitle="选择税率表" height="400"  width="500" />
                  <input type="hidden" id="tab_id" name="tax_id"/>
                  <input type="hidden" id="tab_name" name="tax_table_name" />

            </td>
            <td  align="right" colspan="2" width="80px;"><input name="button_ok" class="button_ellipse" style="float: left;" type="button" value="查看税率" onClick="javascript:detail_onClick();"></td>
            
        </tr>
        <tr>
            <td width="15%" align="right"><span class="style_required_red">* </span>工资形式</td>
            <td width="35%" align="left">
               <select style="width: 420px;" id="salaryFormat" name="salaryFormat" >
               <option value="0"></option>
                <option value="1">税前</option>
               <option value="2">税后</option>
               </select>
         
                
            </td>
            <td width="18%" align="right"><span class="style_required_red">* </span>工资额</td>
            <td width="35%" align="left"><input name="salary" id="salary" class="text_field" type="text"  style="width: 420px;"   ></td>
        </tr>
        
         <tr>
          
            <td  align="center" colspan="4" style="margin-top: 20px;margin-bottom: 30px;padding-bottom: 10px;padding-top: 10px;">
            <input name="button_ok" class="button_ellipse"   type="button" value="计算" onClick="javascript:count('gongzi');"></td>
        </tr>
    </table>

</td></tr>
</table>
</div>
                    
<div id="auDivParent1"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild1',this,'<%=request.getContextPath()%>/')">&nbsp;
        计算结果
        </td>
  
    </tr>
</table>
</div>


<div id="auDivChild1"  style="padding_top:20px;"> 
<table class="table_div_content" >
<tr><td>
    <table class="table_noFrame" width="100%" style="margin-bottom: 30px;margin-top: 10px;">
        <tr>
            <td width="15%" align="right">个人所得税</td>
            <td width="35%" align="left">
                <input type="text" class="text_field" style="width: 420px;" id="individualIncomeTax" />
            </td>
            <td width="15%" align="right">计算工资</td>
            <td width="35%" align="left"><input name="button_ok" class="text_field" type="text"  style="width: 420px;" id="calculationOfWages"  ></td>
        </tr>

    </table>

</td></tr>
</table>
</div>

 </form>
 
      </div>
 </div>

      <div id="TabCon2" style="display:none" >
        
           <div id="TabConInner2" style="display:none" >
       <form name="datacell_formid2" id="datacell_formid2" action="" method="post"> 
     
     <div id="auDivParent0"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild0',this,'<%=request.getContextPath()%>/')" >&nbsp;
        年终奖所得税计算
        </td>
    </tr>
</table>
</div>

<div id="auDivChild0"  style="padding_top:20px;"> 
<table class="table_div_content" >
<tr><td>
    <table class="table_noFrame" width="100%" style="margin-top: 10px;">
        <tr>
            <td width="15%" align="right"><span class="style_required_red">* </span>选择税率表</td>
            <td width="35%" align="left">
             <w:lookup onReturnFunc="rtnFuntax" readonly="true" id="lk_tax"  style="width: 400px;"  lookupUrl="/TaxTableAction.do?cmd=toShuilv"  displayValue="${requestScope.tax_table_name}" dialogTitle="选择税率表" height="300"  width="500" />
  
            </td>

            <td  align="right" colspan="2"><input name="button_ok" class="button_ellipse" style="float: left;" type="button" value="查看税率" onClick="javascript:detail_onClick();"></td>
            
        </tr>
        <tr>
            <td width="15%" align="right"><span class="style_required_red">* </span>税前年终奖</td>
            <td width="35%" align="left">
             
                <input type="text" class="text_field" name="login_id" inputName="" value="" style="width: 420px;" id="yearbonus"/>
                
            </td>
            <td width="15%" align="right"></td>
            <td width="35%" align="left"></td>
        </tr>
        
         <tr>
          
            <td  align="center" colspan="4" style="margin-top: 20px;margin-bottom: 30px;padding-bottom: 10px;padding-top: 10px;">
            <input name="button_ok" class="button_ellipse"   type="button" value="计算" onClick="javascript:count('nianzhongjiang');"></td>
        </tr>
    </table>

</td></tr>
</table>
</div>
                    
<div id="auDivParent1"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild1',this,'<%=request.getContextPath()%>/')">&nbsp;
        计算结果
        </td>
  
    </tr>
</table>
</div>


<div id="auDivChild1"  style="padding_top:20px;"> 
<table class="table_div_content" >
<tr><td>
    <table class="table_noFrame" width="100%" style="margin-bottom: 30px;margin-top: 10px;">
        <tr>
            <td width="20%" align="right">年终奖交税额</td>
            <td width="35%" align="left">
                <input type="text" class="text_field" style="width: 410px;" id="ratePayment" />
            </td>
            <td width="20%" align="right">税后年终奖</td>
            <td width="35%" align="left"><input name="button_ok" class="text_field" type="text"  style="width: 410px;"  id="afterTax"></td>
        </tr>

    </table>

</td></tr>
</table>
</div>
     
     
     
</form>
</div>

       
       </div>
         
</body>
</html>

