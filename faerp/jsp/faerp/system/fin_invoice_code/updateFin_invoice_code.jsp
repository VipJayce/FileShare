<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">


	function insert_onClick(){  //插入单条数据
	    var fin_subjects_bd = $id("fin_subjects_bd").getValue();
	    var bill_year_month = $id("bill_year_month").value;
		var subjects_name = $id("subjects_name").value;
		
		if(fin_subjects_bd==""||fin_subjects_bd==null){
          alert("请选择财务科目！");
          return;
        }
        
        if(bill_year_month==""||bill_year_month==null){
          alert("请输入账期！");
          form.bill_year_month.focus();
          return;
        }
        
		if(subjects_name==""||subjects_name==null){
		  alert("请输入项目名称！");
		  form.subjects_name.focus();
		  return;
		}
		
		onKey_Up(subjects_name);
		
          var param = jQuery("#datacell_formid").serialize();
          var url="<%=request.getContextPath()%>/FIN_INVOICE_CODEAction.do?cmd=insertData&"+param;
	        jQuery.post(url,function(data){
	            if(data){
		                if(data!=""){
		                alert("保存成功！");
                        window.close();
		                }else{
		                alert("保存失败！");
		                window.close();
		                }
	             }else{
                        alert("保存失败！");
                        window.close();
                        }
             });
	}

    
    function onKey_Up(v_str) {
        if(v_str==""||v_str==null){
          //alert("请输入项目名称！");
          return;
        }
        
        var url="<%=request.getContextPath()%>/FIN_INVOICE_CODEAction.do?cmd=checkSubjectsName&subjects_name=" + v_str+"&id=${bean.id}";
        url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        url = encodeURI(url);
        jQuery.post(url,function(data){
            if(data){
                    if(data!=""){
	                        if(data == '1'){
	                              alert("【"+v_str+"】此项目名称已存在！");
	                              $id("subjects_name").value="";
	                              form.subjects_name.focus();
	                              return;
	                         }
                    }else{
                        alert("操作失败！");
                    }
             }
         });
    }
    

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
  
_$(document).ready(function() {  
       //账期失去焦点调用
	    _$("#bill_year_month").bind("blur", function() {
		       var bill_year_month=_$("#bill_year_month").val();
		       if(bill_year_month==""){
		           //alert("请输入账期！");
		           //document.datacell_formid.bill_year_month.focus();
		           return;
		       }
	       
		        var flag = isDateString(bill_year_month);
		        if (flag) {
			            if (bill_year_month.length == 5) {
			                var y = bill_year_month.substring(0, 4);
			                var m = bill_year_month.substring(4, 5);
			                m = "0" + m;
			                bill_year_month = y + m;
			                _$("#bill_year_month").val(bill_year_month);
			            }
		        }else{
		              alert("账期格式为201301！");
		              _$("#bill_year_month").val("");
		              return;
		        }
       
		       var v_month = bill_year_month.substring(4, 6);     
		       var fin_subjects_bd=$id("fin_subjects_bd").getValue();
		        if(fin_subjects_bd!=""){
		            _$("#subjects_code").val(fin_subjects_bd+v_month);
		        }
        
	    });
	    
	    
	    //账期失去焦点调用
        _$("#fin_subjects_bd_input").bind("blur", function() {
               var bill_year_month=_$("#bill_year_month").val();
               if(bill_year_month==""){
                   //alert("请输入账期！");
                   return;
               }
           
                var flag = isDateString(bill_year_month);
                if (flag) {
                        if (bill_year_month.length == 5) {
                            var y = bill_year_month.substring(0, 4);
                            var m = bill_year_month.substring(4, 5);
                            m = "0" + m;
                            bill_year_month = y + m;
                            _$("#bill_year_month").val(bill_year_month);
                        }
                }
       
               var v_month = bill_year_month.substring(4, 6);     
               var fin_subjects_bd=$id("fin_subjects_bd").getValue();
                if(fin_subjects_bd!=""){
                    _$("#subjects_code").val(fin_subjects_bd+v_month);
                }
        
        });
	    
	    
	    
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
	    
    });
    
    
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" class="sText" value="${bean.id}" name="id"/> 
<div id="right">
<div id="ccChild1"     class="box_xinzeng" style="height: 158px">
<div class="xz_title" style="padding-top: 5px">修改code</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">

        <tr>
            <td  class="td_1" ><span class="style_required_red">* </span>选择财务科目</td>
            <td  class="td_2 ">
            <r:comboSelect id="fin_subjects_bd" name="fin_subjects_bd" queryAction="/FAERP/FIN_INVOICE_CODEAction.do?cmd=getFinSubjectsListData&dd_base=FIN_SUBJECTS_BD"
                       textField="name" valueField="code" xpath="DDBasedataVO" width="190px" value="${bean.fin_subjects_bd}" nullText="--请选择--" />    
            </td>
            <td  class="td_1" ><span class="style_required_red">* </span>账期</td>
            <td  class="td_2" ><input type="text" class="sText"  value="${bean.bill_year_month}"  name="bill_year_month" id="bill_year_month" /></td>
        </tr>
		<tr>
			<td  class="td_1" ><span class="style_required_red">* </span>项目名称</td>
			<td  class="td_2 "><input type="text" class="sText" value="${bean.subjects_name}" name="subjects_name" id="subjects_name" onblur="onKey_Up(this.value)"/></td>
			<td  class="td_1" >项目代码</td>
			<td  class="td_2" ><input type="text" class="sText"  value="${bean.subjects_code}"  name="subjects_code" id="subjects_code" readonly="readonly"/>
            <input type="hidden" class="sText" value="<%=LoginHelper.getPartyId(request)%>" name="create_user_id"/> </td>
		</tr>
	</table>
	   <div  align="center" style="padding-top: 10px;">
            <input type="button" id="bc" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:insert_onClick()" />
            <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
         </div>  
 
</div>         

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>