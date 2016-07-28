<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.employeepost.epimpempdata.epimpempdata_resource" prefix="rayoo.employeepost.epimpempdata.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">

 function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp'   );>";
    }
    
    

  
  
  
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
	function findCheckbox_onClick() {  //从多选框到修改页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/EpimpempdataAction.do?id=" + ids;
		form.cmd.value = "find";
		form.submit();
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
 		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null)	{  //如果ids为空
			alert('<fmt:message key="select_records"/>');
			return;
		}
		if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
	    	form.action="<%=request.getContextPath()%>/EpimpempdataAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
    	form.cmd.value = "simpleQuery";
    	form.submit();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/epimpempdata/insertEpimpempdata.jsp";
		form.submit();
	}
	
	
	
	function exp_onClick(){  //实现转到详细页面
		form.action="<%=request.getContextPath()%>/EpimpempdataAction.do";
		form.cmd.value = "exp";
		form.submit();
	}

</script>
</head>
<body>

<form name="form" method="post"   id="datacell_formid"  action="<%=request.getContextPath()%>/EpimpempdataAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" id="cmd1"   name="cmd1" value="queryAll">
    <input type="hidden"  id="action1"  name="action1" value="EpimpempdataAction.do">
 
 <%   
String IMPORT_ID="";
 String INTERFACE_TYPE="";
 IMPORT_ID=(String)request.getAttribute("IMPORT_ID");
 INTERFACE_TYPE=(String)request.getAttribute("INTERFACE_TYPE");


%>
<input  type="hidden"  name="IMPORT_ID" id="IMPORT_ID" value="<%=IMPORT_ID %>">
<input  type="hidden"  name="INTERFACE_TYPE" id="INTERFACE_TYPE" value="<%=INTERFACE_TYPE %>">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco("<fmt:message key="sh_imp_look_rs_list"/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


		

	



</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<li class="a">    	<a  onClick="javascript:exp_onClick();"><fmt:message key="export"/></a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EpimpempdataAction.do?cmd=queryAll"
        width="99%"
        xpath="EpimpempdataVo"
        submitXpath="EpimpempdataVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" messagekey="operate" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>           
       <r:field fieldName="a_1" messagekey="employee_name" width="100px">
                  
       </r:field>    
      <r:field fieldName="b_2" width="140px" messagekey="emp_unique_num">
      </r:field>
      <r:field fieldName="c_3" width="140px" messagekey="card_num1">
      </r:field>
       <r:field fieldName="d_4" messagekey="send_and_dispatch">
       <d:select dictTypeId="EMP_POST_TYPE_BD" />
      </r:field>
      <r:field fieldName="e_5" messagekey="card_type">
      <d:select dictTypeId="ID_CARD_TYPE_BD" />
      </r:field>
      <r:field fieldName="f_6" messagekey="send_id">
      </r:field>
       <r:field fieldName="g_7" messagekey="quotation_code1" width="130px"   align="center">
       </r:field>
      <r:field fieldName="h_8" messagekey="on_post_date"  allowModify="false">
      </r:field>
      <r:field fieldName="i_9" messagekey="ss_start_time">
        <w:date format="yyyy-MM-dd" />
      </r:field>
      <r:field fieldName="j_10" messagekey="tel"  allowModify="false">
      </r:field>
      
        <r:field fieldName="k_11" messagekey="on_post_classification"  allowModify="false">
        
      </r:field>
           <r:field fieldName="l_12" messagekey="on_post_notice"  allowModify="false">
      </r:field>
      
       <r:field fieldName="m_13" messagekey="fund_jishu">
      </r:field>
      
       <r:field fieldName="n_14" messagekey="zf_fund_jishu">
      </r:field>
      
       <r:field fieldName="o_15" messagekey="bc_zf_fund_bl">
      </r:field>
      
       <r:field fieldName="p_16" messagekey="bc_zf_fund_jishu">
      </r:field>
      
       <r:field fieldName="q_17" messagekey="zbe_jishu">
      </r:field>
      
      <r:field fieldName="r_18" messagekey="zbe_not_jishu">
      </r:field>
      
       <r:field fieldName="s_19" messagekey="fee_begin_date">
      </r:field>
       <r:field fieldName="t_20" messagekey="send_begin_date">
      </r:field>
       <r:field fieldName="u_21" messagekey="send_end_date">
      </r:field>
      
       <r:field fieldName="v_22" messagekey="begin_date1">
       
       
      </r:field>
       <r:field fieldName="w_23" messagekey="end_date1">
      </r:field>
       <r:field fieldName="x_24" messagekey="saler">
      </r:field>
       <r:field fieldName="y_25" messagekey="begin_date2">
      </r:field>
       <r:field fieldName="z_26" messagekey="end_date2">
      </r:field>
       <r:field fieldName="aa_27" messagekey="saler2">
      </r:field>
      <r:field fieldName="ct_98" label="工作制" allowModify="false">
      <d:select dictTypeId="WORKING_BD" />
      </r:field>
       <r:field fieldName="ab_28" messagekey="mobile">
      </r:field>
       <r:field fieldName="ac_29" messagekey="emp_cust_code1">
      </r:field>
      
       <r:field fieldName="ad_30" messagekey="address1">
      </r:field>
      
      <r:field fieldName="ae_31" messagekey="zip_code1">
      </r:field>
      <r:field fieldName="af_32" messagekey="hukou_address">
      </r:field>
      <r:field fieldName="ag_33" messagekey="e_email">
      </r:field>
      <r:field fieldName="ah_34" messagekey="bank_name">
      </r:field>
      <r:field fieldName="ai_35" messagekey="account_num">
      </r:field>
      <r:field fieldName="aj_36" messagekey="account_private_id">
      </r:field>
      <r:field fieldName="ak_37" messagekey="account_city_id">
      </r:field>
      <r:field fieldName="al_38" messagekey="account_num_name">
      </r:field>
      <r:field fieldName="am_39" messagekey="bank_type">
      </r:field>
      <r:field fieldName="an_40" messagekey="is_tax" allowModify="false">
      <d:select dictTypeId="IS_TAX"></d:select>
      </r:field>
      <r:field fieldName="ao_41" messagekey="job_num">
      </r:field>
      <r:field fieldName="ap_42" messagekey="hro">
      </r:field>
      <r:field fieldName="aq_43" messagekey="business">
      </r:field>
      <r:field fieldName="ar_44" messagekey="emp_status">
      </r:field>
      <r:field fieldName="as_45" messagekey="is_import_client">
      </r:field>
      <!-- 魏佳新增，批量导入，入职备注字段 -->
      <r:field fieldName="at_46" messagekey="post_remarks">
      </r:field>
      <r:field fieldName="import_result" messagekey="imp_rs" allowModify="false">
            <d:select dictTypeId="IMP_FLAG" />
      </r:field>
            <r:field fieldName="failure_reason" messagekey="error_result"   width="200px">
      </r:field>
      
    </r:datacell>
    </div>
 
 

</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
</script>
</body>
</html>

<script language="javascript">

</script>	
