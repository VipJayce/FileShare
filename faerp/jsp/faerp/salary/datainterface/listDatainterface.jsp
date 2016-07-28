<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/common/common.jsp"%>
<%
String session_clz_id = session.getAttribute("session_clz_id")==null?"":session.getAttribute("session_clz_id").toString();
String session_clz_name = session.getAttribute("session_clz_name")==null?"":session.getAttribute("session_clz_name").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<fmt:bundle basename="rayoo.salary.datainterface.datainterface_resource" prefix="rayoo.salary.datainterface.">
	<head>
	<title><fmt:message key='dateinterface'/></title>
	<script language="javascript">
	jQuery(document).ready(function(){
		var session_clz_id = "<%=session_clz_id%>";
		var session_clz_name = "<%=session_clz_name%>";
		if(session_clz_id && session_clz_name){
			jQuery("#salary_class_id").val(session_clz_id);
			var lookup = $id("lk_clz");
	    	lookup.setDisplayValue(session_clz_name) ;
		}
	});
     //选择薪资类别
	function rtnFunc(arg){
		
	    var lookup = $id("lk_clz");
	    lookup.value = arg[0];
	    lookup.displayValue = arg[1];
	    var salary_class_id = document.getElementById("salary_class_id") ;
	    salary_class_id.value = arg[0] ;
	    $id("salary_class_name").value=arg[1];
	    toReload_onclick()  ;
	    return false ;
	}
	
	function toUpdate_onclick() { //到修改记录页面
	    var dc = $id("dc_inter");
        var clz = dc.getActiveEntity();
        if(!clz){
            alert("<fmt:message key='alert_select_one'/>");
            return ;
        }
        var sa_inf_id = clz.getValue("id");
        var datacell_formid = $id("datacell_formid") ;
        datacell_formid.action ="<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=detail&sa_inf_id="+sa_inf_id;
        datacell_formid.submit();    
    }
    
	function toAdd_onclick() { //到增加记录页面
	    var sa_class_id = $id("salary_class_id").value ;
	    if(sa_class_id == null||sa_class_id==''){
	       alert("<fmt:message key='alert_select_class'/>") ;
	       return false ;
	    }
        var datacell_formid = $id("datacell_formid") ;
        datacell_formid.action ="<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=inifInsertShow&sa_class_id="+sa_class_id;
        datacell_formid.submit();    
        return true ;
    }
    
	//function toDownLoad_onclick(){
	//      window.location="<%=request.getContextPath()%>/jsp/faerp/salary/datainterface/interfaceData.xls" ;
	//}
	
	function toDownLoad_onclick(){
		$id("datacell_formid").action = "<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=downLoadExcel" ;
		$id("datacell_formid").submit();
    }
	
	function toDownLoadDt_onclick(){
	    var dc = $id("dc_inter");
        var clz = dc.getActiveEntity();
        if(!clz){
            alert("<fmt:message key='alert_select_one'/>");
            return ;
        }
        var sa_inf_id = clz.getValue("id");
        var datacell_formid = $id("datacell_formid") ;
        datacell_formid.action ="<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=reportDatainterfaceData&sa_inf_id="+sa_inf_id;
        datacell_formid.submit();    
        
    }
	
	function toSave_onclick() { 
	    $id("dc_inter").submit();
	}   
	function toReload_onclick() {
	     $id("dc_inter").reload();
	}
	function queryDataInterface(){
    	$id("dc_inter").reload();
	}
	function deleteDataInterface(){
		if(confirm("<fmt:message key='alert_is_cancel'/>")){
	       	$id("dc_inter").deleteRow();
    		$id("dc_inter").submit();
	    }
    	
	}
	//弹出导出层
	function pop(type){
	    
	    var dc = $id("dc_inter");
        var clz = dc.getActiveEntity();
        if(!clz){
            alert("<fmt:message key='alert_select_one'/>");
            return ;
        }
        var sa_inf_id = clz.getValue("id");
        var salary_class_id=$id("salary_class_id").value;
		var url = "" ;
	   if(type==1){
	       url="<%=request.getContextPath()%>/jsp/faerp/salary/datainterface/inputdata.jsp?sa_inf_id="+sa_inf_id+"&salary_class_id="+salary_class_id+"&random="+Math.random();
	       showModalCenter(url, window, callBack, 640, 310, "<fmt:message key='input_data'/>");  //增加子岗位
	   }else{
	    	//var batchId = $id("batchId").value;
        	var pay_name = $id("pay_name").value;
        	var last_imp_id = clz.getValue("last_import_id");
	        url="<%=request.getContextPath()%>/jsp/faerp/salary/datainterface/exceptioninputdata.jsp?batchId="+last_imp_id+"&pay_name="+pay_name;
	        var winWidth=800,winHeight=400,winLeft=null,winTop=null;
	        var topWin = _get_top_window();
			var theBody = topWin.document.getElementsByTagName("BODY")[0];
			if(winLeft==null||winLeft==""){
				winLeft = ((topWin.document.body.clientWidth-winWidth)/2+topWin.document.body.scrollLeft);
				if(winLeft<0) winLeft=0;
			}
			else
				winLeft = parseInt(winLeft,10);
			if(winTop==null||winTop==""){
				winTop = ((EOStopWin.document.body.clientHeight-winHeight)/2+topWin.document.body.scrollTop)
				if(winTop<0)winTop=0;
			}
			else
			   winTop = parseInt(winTop,10);
	        openNewWindow(url, winWidth, winHeight, winLeft, 100);  //增加子岗位
	   }
	}
	
	function callBack(reg){
        //alert("操作完成！");
        if(reg){
        	if(reg[0] && reg[1]){
        		$id("batchId").value=reg[0];
        		$id("pay_name").value=reg[1];
        	}
        }
        
        $id("dc_inter").loadData();
        $id("dc_inter").refresh();
    }
	//显示一般的链接
	function showLink(value,entity,rowNo,cellNo){
		if(value){
			return "<a href='<%=request.getContextPath()%>/DatainterfaceAction.do?cmd=downLoad&infoid="+entity.getProperty("last_import_id")+"'  style='color: #0033CC; font-weight: bold; text-decoration: underline;'>"+value+"</a>";
		}
	    
	}
</script>
	</head>
	<body>

	<form method="post" id="datacell_formid" name="datacell_formid" action="">
	<input type="hidden" id="batchId"/>
	<input type="hidden" id="pay_name"/>
	<div id="right">
	<div class="ringht_s">

	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="174" rowspan="10" style="padding-top: 0;">
				<div class="search_title"><fmt:message key='datainterface_search'/></div>
			</td>
		</tr>
		<tr>
			<td align="right"><fmt:message key='salary_class_name'/></td>
			<td align="left">
				<w:lookup onReturnFunc="rtnFunc" readonly="true" id="lk_clz" lookupUrl="/SalaryclassAction.do?cmd=toSalartClzLookup" messagekey="select_lk_clz" height="470" width="840"/>
                <input type="hidden" name="salary_class_id" id="salary_class_id"/>
                <input type="hidden" name="salary_class_name" id="salary_class_name"/>
			</td>
		</tr>
	</table>
	</div>

	<div id="ccParent1" class="button">
	<div class="button_right">
	<!--<ul>
		<li class="xz">     <a onclick="javascript:toDownLoad_onclick();">下载模板</a></li>
		<li class="c">     <a onclick="javascript:toAdd_onclick();">新增</a></li>
		<li class="d">    <a onclick="javascript:deleteDataInterface();">作废</a></li>
		<li class="bc">  <a onclick="javascript:toSave_onclick();">保存</a></li> 
		<li class="b">  	<a  onclick="javascript:toUpdate_onclick();">修改</a> </li>
		 <li class="a">     <a onclick="javascript:toReload_onclick();">刷新</a></li> 
        <li class="p_1"><a id="importCard"  onclick="javascript:pop(1);">数据导入</a> </li>
        <li class="p_1"><a id="showErr"  onclick="javascript:pop(0);">导出问题数据</a> </li>		
	</ul>
     -->
     <input class="xz" type="button"   value="<fmt:message key='button_donwload'/>"  onClick="toDownLoad_onclick();">
     <input class="xz" type="button" style="width: 95px"   value="<fmt:message key='button_donwloaddt'/>"  onClick="toDownLoadDt_onclick();">
     <input class="c" type="button"   value="<fmt:message key='button_add'/>"  <au:authorityBtn code="sjjk_add" type="1"/>  onClick="toAdd_onclick();">
      <input class="d" type="button"   value="<fmt:message key='button_cancel'/>"  <au:authorityBtn code="sjjk_zf" type="1"/>  onClick="deleteDataInterface();">
      <input class="b" type="button"   value="<fmt:message key='button_modify'/>"  <au:authorityBtn code="sjjk_xg" type="1"/>  onClick="toUpdate_onclick();">   
      <input class="p_1" type="button"   value="<fmt:message key='button_input_data'/>"  <au:authorityBtn code="sjjk_sjdr" type="1"/>  onClick="pop(1);">
      <input class="p_1" type="button"   value="<fmt:message key='button_output_err_data'/>"  <au:authorityBtn code="sjjk_error" type="1"/>  onClick="pop(0);">
	</div>
	<div class="clear"></div>
	</div>
	<div style="padding: 8 10 8 8;">
		<r:datacell id="dc_inter"
			queryAction="/FAERP/DatainterfaceAction.do?cmd=seachDatainterfaceData"
			submitAction="/FAERP/DatainterfaceAction.do?cmd=insertDatainterfaceData"
			width="98%" xpath="DatainterfaceVo" submitXpath="DatainterfaceVo"
			paramFormId="datacell_formid" height="320px" >
			<r:toolbar location="bottom" tools="nav,pagesize,info" />
			<r:field fieldName="inf_name" messagekey="inf_name" width="150px" allowModify="false">
				<h:text/>
			</r:field>
			<r:field fieldName="emp_name_col" messagekey="emp_name_col" width="100px" allowModify="false">
				<h:text/>
			</r:field>			
			<r:field fieldName="excel_col_bd" messagekey="excel_col_bd" width="100px" allowModify="false">
				<d:select dictTypeId="EXCEL_COL_BD" />
			</r:field>
			<r:field fieldName="emp_indentify_col" messagekey="emp_indentify_col" width="100px" allowModify="false">
				<h:text/>
			</r:field>			
			<r:field fieldName="row_begin" messagekey="row_begin" width="100px" allowModify="false">
				<h:text validateAttr="type=number;message=开始行输入有误;allowNull=false" />
			</r:field>
			<r:field fieldName="row_end" messagekey="row_end" width="100px"  allowModify="false">
				<h:text validateAttr="type=number;message=结束行输入有误;allowNull=false" />
			</r:field>
			<r:field fieldName="file_original_name" messagekey="file_original_name" width="150px" onRefreshFunc="showLink">
			</r:field>
			<r:field fieldName="import_time" messagekey="import_time" width="100px" allowModify="false">
				<w:date format="yyyy-MM-dd" name="" disabled="true"/> 
			</r:field>
			<r:field fieldName="remarks" messagekey="remarks" width="150px" allowModify="false">
				<h:text />
			</r:field>
		</r:datacell>
</div>
</div>
	</div>
	</form>
</body>
</fmt:bundle>
</html>
