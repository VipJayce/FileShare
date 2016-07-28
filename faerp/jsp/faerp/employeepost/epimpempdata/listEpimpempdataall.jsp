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
	function detail_onClick(){  //实现转到详细页面
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
		form.cmd.value = "detail";
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
	writeTableTopFesco("<fmt:message key="qg_imp_look_rs_list"/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
				<li class="a">      <a  onClick="javascript:exp_onClick();"><fmt:message key="export"/></a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div style="padding: 8 10 8 8;">
    <r:datacell id="datacell1"
		queryAction="/FAERP/EpimpempdataAction.do?cmd=queryAll" width="99%"
		xpath="EpimpempdataVo" submitXpath="EpimpempdataVo"
		paramFormId="datacell_formid">
		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="emp" messagekey="operate" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
		</r:field>
		<r:field fieldName="a_1" messagekey="employee_name" width="100px"></r:field>
		<r:field fieldName="b_2" width="140px" messagekey="emp_unique_num"></r:field>
		<r:field fieldName="c_3" messagekey="card_num1"></r:field>
		<r:field fieldName="d_4" messagekey="send_and_dispatch">
			<d:select dictTypeId="EMP_POST_TYPE_BD" />
		</r:field>
		<r:field fieldName="e_5" messagekey="card_type">
			<d:select dictTypeId="ID_CARD_TYPE_BD" />
		</r:field>
		<r:field fieldName="f_6" messagekey="send_id"></r:field>
		<r:field fieldName="g_7" messagekey="quotation_code1" width="50px" align="center">
		</r:field>
		<r:field fieldName="h_8" messagekey="on_post_date" allowModify="false"></r:field>
		<r:field fieldName="i_9" messagekey="ss_start_time">
			<w:date format="yyyy-MM-dd" />
		</r:field>
		<r:field fieldName="j_10" messagekey="tel" allowModify="false"></r:field>
		<r:field fieldName="k_11" messagekey="yl_jishu" allowModify="false"></r:field>
		<!-- 
		<r:field fieldName="l_12" messagekey="yl_penson_bili" allowModify="false"></r:field>
		<r:field fieldName="m_13" messagekey="yl_penson_money"></r:field>
		<r:field fieldName="n_14" messagekey="yl_enterprise_bili"></r:field>
		<r:field fieldName="o_15" messagekey="yl_enterprise_money"></r:field>
		<r:field fieldName="p_16" messagekey="yl_money"></r:field>
		<r:field fieldName="q_17" messagekey="sy_jishu"></r:field>
		<r:field fieldName="r_18" messagekey="sy_penson_bili"></r:field>
		<r:field fieldName="s_19" messagekey="sy_penson_money"></r:field>
		<r:field fieldName="t_20" messagekey="sy_enterprise_bili"></r:field>
		<r:field fieldName="u_21" messagekey="sy_enterprise_money"></r:field>
		<r:field fieldName="v_22" messagekey="sy_money"></r:field>
		<r:field fieldName="w_23" messagekey="gs_jishu"></r:field>
		<r:field fieldName="x_24" messagekey="gs_penson_bili"></r:field>
		<r:field fieldName="y_25" messagekey="gs_penson_money"></r:field>
		<r:field fieldName="z_26" messagekey="gs_enterprise_bili"></r:field>
		<r:field fieldName="aa_27" messagekey="gs_enterprise_money"></r:field>
		<r:field fieldName="ab_28" messagekey="gs_money"></r:field>
		<r:field fieldName="ac_29" messagekey="syu_jishu"></r:field>
		<r:field fieldName="ad_30" messagekey="syu_penson_bili"></r:field>
		<r:field fieldName="ae_31" messagekey="syu_penson_money"></r:field>
		<r:field fieldName="af_32" messagekey="syu_enterprise_bili"></r:field>
		<r:field fieldName="ag_33" messagekey="syu_enterprise_money"></r:field>
		<r:field fieldName="ah_34" label="生育保险金额"></r:field>
		<r:field fieldName="ai_35" messagekey="yil_jishu"></r:field>
		<r:field fieldName="aj_36" messagekey="yil_penson_bili"></r:field>
		<r:field fieldName="ak_37" messagekey="yil_penson_money"></r:field>
		<r:field fieldName="al_38" messagekey="yil_enterprise_bili"></r:field>
		<r:field fieldName="am_39" messagekey="yil_enterprise_money"></r:field>
		<r:field fieldName="an_40" messagekey="yil_money"></r:field>
		<r:field fieldName="ao_41" messagekey="db_jishu"></r:field>
		<r:field fieldName="ap_42" messagekey="db_penson_bili"></r:field>
		<r:field fieldName="aq_43" messagekey="db_penson_money"></r:field>
		<r:field fieldName="ar_44" messagekey="db_enterprise_bili"></r:field>
		<r:field fieldName="as_45" messagekey="db_enterprise_money"></r:field>
		<r:field fieldName="at_46" messagekey="db_money"></r:field>
		<r:field fieldName="au_47" messagekey="bx_jishu"></r:field>
		<r:field fieldName="av_48" messagekey="bx_penson_bili"></r:field>
		<r:field fieldName="aw_49" messagekey="bx_penson_money"></r:field>
		<r:field fieldName="ax_50" messagekey="bx_enterprise_bili"></r:field>
		<r:field fieldName="ay_51" messagekey="bx_enterprise_money"></r:field>
		<r:field fieldName="az_52" messagekey="bx_money"></r:field> -->
		<r:field fieldName="ba_53" messagekey="zf_jishu"></r:field>
		<r:field fieldName="bb_54" messagekey="zf_penson_bili"></r:field>
		<r:field fieldName="bc_55" messagekey="zf_penson_money"></r:field>
		<r:field fieldName="bd_56" messagekey="zf_enterprise_bili"></r:field>
		<r:field fieldName="be_57" messagekey="zf_enterprise_money"></r:field>
		<r:field fieldName="bf_58" messagekey="zf_money"></r:field>
		<r:field fieldName="bg_59" messagekey="bczf_jishu"></r:field>
		<r:field fieldName="bh_60" messagekey="bczf_penson_bili"></r:field>
		<r:field fieldName="bi_61" messagekey="bczf_penson_money"></r:field>
		<r:field fieldName="bj_62" messagekey="bczf_enterprise_bili"></r:field>
		<r:field fieldName="bk_63" messagekey="bczf_enterprise_money"></r:field>
		<r:field fieldName="bl_64" messagekey="bczf_money"></r:field>
		<r:field fieldName="bm_65" messagekey="quotation_fee_start_date"></r:field>
		<r:field fieldName="bn_66" messagekey="send1_start_date"></r:field>
		<r:field fieldName="bo_67" messagekey="send1_end_date"></r:field>
		<r:field fieldName="bp_68" messagekey="begin_date1"></r:field>
		<r:field fieldName="bq_69" messagekey="end_date1"></r:field>
		<r:field fieldName="br_70" messagekey="saler"></r:field>
		<r:field fieldName="bs_71" messagekey="begin_date2"></r:field>
		<r:field fieldName="bt_72" messagekey="end_date2"></r:field>
		<r:field fieldName="bu_73" messagekey="saler2"></r:field>
		<r:field fieldName="bv_74" messagekey="mobile"></r:field>
		<r:field fieldName="bw_75" messagekey="emp_cust_code1"></r:field>
		<r:field fieldName="bx_76" messagekey="address1"></r:field>
		<r:field fieldName="by_77" messagekey="zip_code1"></r:field>
		<r:field fieldName="bz_78" messagekey="hukou_address"></r:field>
		<r:field fieldName="ca_79" messagekey="e_email"></r:field>
		<r:field fieldName="cb_80" messagekey="bank_name"></r:field>
		<r:field fieldName="cc_81" messagekey="account_num"></r:field>
		<r:field fieldName="cd_82" messagekey="account_private_id"></r:field>
		<r:field fieldName="ce_83" messagekey="account_city_id"></r:field>
		<r:field fieldName="cf_84" messagekey="account_num_name"></r:field>
		<r:field fieldName="cg_85" messagekey="bank_type"></r:field>
		<r:field fieldName="ch_86" messagekey="city_name"></r:field>
		<r:field fieldName="ci_87" messagekey="is_tax"></r:field>
		<r:field fieldName="cj_88" messagekey="job_num"></r:field>
		<r:field fieldName="ck_89" messagekey="hro"></r:field>
		<r:field fieldName="cl_90" messagekey="business"></r:field>
		<r:field fieldName="cm_91" messagekey="emp_status"></r:field>
		<r:field fieldName="cn_92" messagekey="is_import_client"></r:field>
		<r:field fieldName="co_93" messagekey="post_remarks"></r:field>
		<r:field fieldName="cp_94" label="报税属性">
		  <d:select dictTypeId="TAX_FLAG" />
		</r:field>
		<r:field fieldName="cq_95" label="员工属性">
		  <d:select dictTypeId="EMP_ENTRY_BD" />
		</r:field>
		<r:field fieldName="cr_96" label="社保标准"></r:field>
        <r:field fieldName="cs_97" label="是否线上">
            <d:select dictTypeId="TrueOrFalse" />
        </r:field>
		<r:field fieldName="import_result" messagekey="imp_rs" allowModify="false">
			<d:select dictTypeId="IMP_FLAG" />
		</r:field>
		<r:field fieldName="failure_reason" messagekey="error_result" width="350px"></r:field>

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
