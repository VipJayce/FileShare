<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/global.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/q_box.js"></script>
<fmt:bundle basename="rayoo.employeepost.epwelfare.epwelfare_resource" prefix="rayoo.employeepost.epwelfare.">
	<head>
	<title><fmt:message key="fuli_sc"/></title>

	<script language="javascript">
    function setSelectForBean(selectId,data,key,value,selectvalue){
        
           DWRUtil.addOptions(selectId,data,key,value);
           DWRUtil.setValue(selectId,selectvalue); 
    }
    
    function checkMonth(mm){
        if((mm+'').length!=6){
        return false;
        }
        if(((mm+'').substr(0,4))<2000 || ((mm+'').substr(0,4))>2030){
          return false;
        }
        if(((mm+'').substr(4,2))<1 || ((mm+'').substr(4,2))>12){
          return false;
        }
        return true;
    }
     //福利生成  生成用户
    function createWelfare_onClick()
    {
         
         var form=document.getElementById("form_welfare_product");
         var wt= document.getElementById("txt_welfare_time").value; 
         
 //        var small_pro= $id("small_product_code").getValue(); 
 
 //       var pro= $id("product_id").getValue(); 
        var pro= document.getElementById("product_id").value; 
   /*
         if(small_pro==""||small_pro==null){
            alert("福利类型不能为空！");
            return;
        }
        */
        if(pro==""||pro==null){
            alert("<fmt:message key="product_not_null"/>");
            return;
        }           
        if(!checkMonth( wt)){      
           alert('<fmt:message key="notice"/>');
           return false;
        } 
        else{
            //年度体检
            if(pro == '1099110200000000102'){
                 if(wt.substr(4,2) == '04' || wt.substr(4,2) == '11'){
		         }else{
		           alert("<fmt:message key="notice2"/>") ;
		           return  false ;
		         }
            }
        }    
         $("#but2").attr("value",'正在生成名单');
         jQuery("#but22").css("display","none");
         jQuery("#loading").css("display","block");

//           jQuery("#loading").css("disabled","disabled");
        form.cmd.value="createWelfare";
        form.submit();
    }
    
   function elasticityWelfare()
    {
        var wt= document.getElementById("txt_flexible_welfare_time").value;          
        if(!checkMonth( wt)){      
           alert('<fmt:message key="notice"/>');
           return false;
        }        
        /*
         $("#ebutl").attr("value",'正在生成名单');
         jQuery("#ebut2").css("display","none");
         jQuery("#eloading").css("display","block");
        */
        form.cmd.value="elasticityWelfare";
        form.submit();
    } 
</script>

	<link href="<%=request.getContextPath()%>/css/q_box_style.css" rel="stylesheet" type="text/css" />
	</head>
	<body>
	<form name="form" action="<%=request.getContextPath()%>/EpwelfareAction.do" 	id="form_welfare_product" method="post">
	
	<input type="hidden"	id="cmd" name="cmd" value="">
	<div id="right">
	<script language="javascript">writeTableTopFesco('<fmt:message key="fuli_sc"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
	</div>

	<div class="ringht_s">
	<div style="padding: 20px 0 10px 10px;"><fmt:message key="notice3"/></div>
	<div class="box_xinzeng"
		style="height: 250px; overflow-y: hidden; overflow-x: hidden;"><!--基本信息 -->
	<div class="xz_title" style="margin: 10px"><fmt:message key="choose_fuli_product"/></div>
	
	<table width="100%" border="0" cellspacing="1" cellpadding="0"
		bgcolor="#c5dbe2">
		<tr>
			<td width="15%" class="td_1"><span style="color: red">*</span><fmt:message key="fuli_product"/>
			</td>
			<td width="20%" class="td_2">
			<select  id="product_id" name="product">
			     <option value=""><fmt:message key="please_choose"/></option>
			      <option value="1099110200000000102"><fmt:message key="ndtj"/></option>  
			     <option value="1099800100000000028"><fmt:message key="dgqfl"/></option>
			     <option value="1099800100000000024"><fmt:message key="zqybfl"/></option>
			     <option value="8099800100000000002"><fmt:message key="sgdhqfl"/></option>
			     <option value="1099800100000000041"><fmt:message key="dypfl"/></option>
			     <option value="8099800100000000004"><fmt:message key="etjlwfl"/></option>
			     <!-- 
			       <option value="1099110200000000188">弹性福利</option>
			        -->
			</select>
			</td>
			 <td class="td_1"><span style="color: red">*</span><fmt:message key="welfare_month"/></td>
            <td class="td_2">
            
            <input type="text" class="text_field" id="txt_welfare_time" name="enjoy_date" /></td>
		</tr>
		<tr>
			<td class="td_1">&nbsp;</td>
			<td class="td_2">&nbsp;</td>
			<td class="td_1">&nbsp;</td>
			<td class="td_2">
			<div id="but22">
			<input type="button" id="but" class="icon_3"
				<au:authorityBtn code="flsc_scmd" type="1"/>
				onclick="createWelfare_onClick()" value="<fmt:message key="shengchengmd"/>" />
				</div>
				
			<div id="loading" style="display: none;">
			<input type="button"
				id="but2" class="icon_3"
				<au:authorityBtn code="flsc_scmd" type="1"/> value="" /> <img
				src="<%=request.getContextPath()%>/images/loading01.gif"
				height="20px" width="20px" /></div>
			</td>
		</tr>
	</table>
	<br />
	<br />
	<div class="xz_title"><fmt:message key="tanxingfl"/></div>
	<table width="100%" border="0" cellspacing="1" cellpadding="0"
		bgcolor="#c5dbe2">
		<tr>
			<td width="15%" class="td_1"><fmt:message key="fl_begin_date"/></td>
			<td width="20%" class="td_2"><input type="text"
				class="text_field" id="txt_flexible_welfare_time" name="enjoy_date1" /></td>
			<td width="15%" class="td_1">&nbsp;</td>
			<td width="20%" class="td_2">
		
			     <input type="button" id="ebut" class="icon_3"
                value="<fmt:message key="sc_and_exp_info"/>" <au:authorityBtn code="flsc_exp" type="1"/>
                onclick="elasticityWelfare()" />
                <!-- 
                    <div id="ebut2">
                </div>
            <div id="eloading" style="display: none;">
            <input type="button"    id="ebutl" class="icon_3"
                <au:authorityBtn code="flsc_scmd" type="1"/> value="" />
                 <img
                src="<%=request.getContextPath()%>/images/loading01.gif"
                height="20px" width="20px" />
                
                </div>
			
	 -->
				
				</td>
				
			<td class="td_2"></td>
		</tr>
	</table>
	<br />
	</div>
	</div>
	</div>
	</form>
</fmt:bundle>
</body>
</html>

<script language="javascript"> 
 function changeSmallType(){
    var curValue = $id("small_product_code").getValue();     
        $id("product_id").disabled = false;   
         $id("product_id").addParam("code", curValue);
         $id("product_id").loadData();
         $id("product_id").refresh(); 
 }
</script>
