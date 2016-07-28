<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.epimpempdata.vo.EpimpempdataVo" %>
<%@ page import="rayoo.employeepost.epimpempdata.util.IEpimpempdataConstants" %>
<%  //取出本条记录
	EpimpempdataVo resultVo = null;  //定义一个临时的vo变量
	resultVo = (EpimpempdataVo)request.getAttribute(IEpimpempdataConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
	RmVoHelper.replaceToHtml(resultVo);  //把vo中的每个值过滤
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/EpimpempdataAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
 
	
       <div id="right">
		<div class="right_title_bg">
	 <div class=" right_title">	<fmt:message key="detail_page"/>
	 </div>
	 </div>
    	<div class="ringht_s">
 

<div id="ccParent0" class="box_3"> 
<table class="table_div_control">
	<tr> 
		<td>
			<img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('ccChild0',this,'<%=request.getContextPath()%>/')"><fmt:message key="details"/>
		</td>
	</tr>
</table>
</div>

<div id="ccChild0" class="box_3"> 
	<table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td class="td_1" >import_id：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getImport_id())%></td>
		</tr>
		<tr>
			<td class="td_1" >a_1：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getA_1())%></td>
		</tr>
		<tr>
			<td class="td_1" >b_2：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getB_2())%></td>
		</tr>
		<tr>
			<td class="td_1" >c_3：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getC_3())%></td>
		</tr>
		<tr>
			<td class="td_1" >d_4：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getD_4())%></td>
		</tr>
		<tr>
			<td class="td_1" >e_5：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getE_5())%></td>
		</tr>
		<tr>
			<td class="td_1" >f_6：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getF_6())%></td>
		</tr>
		<tr>
			<td class="td_1" >g_7：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getG_7())%></td>
		</tr>
		<tr>
			<td class="td_1" >h_8：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getH_8())%></td>
		</tr>
		<tr>
			<td class="td_1" >i_9：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getI_9())%></td>
		</tr>
		<tr>
			<td class="td_1" >j_10：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getJ_10())%></td>
		</tr>
		<tr>
			<td class="td_1" >k_11：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getK_11())%></td>
		</tr>
		<tr>
			<td class="td_1" >l_12：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getL_12())%></td>
		</tr>
		<tr>
			<td class="td_1" >m_13：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getM_13())%></td>
		</tr>
		<tr>
			<td class="td_1" >n_14：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getN_14())%></td>
		</tr>
		<tr>
			<td class="td_1" >o_15：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getO_15())%></td>
		</tr>
		<tr>
			<td class="td_1" >p_16：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getP_16())%></td>
		</tr>
		<tr>
			<td class="td_1" >q_17：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getQ_17())%></td>
		</tr>
		<tr>
			<td class="td_1" >r_18：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getR_18())%></td>
		</tr>
		<tr>
			<td class="td_1" >s_19：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getS_19())%></td>
		</tr>
		<tr>
			<td class="td_1" >t_20：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getT_20())%></td>
		</tr>
		<tr>
			<td class="td_1" >u_21：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getU_21())%></td>
		</tr>
		<tr>
			<td class="td_1" >v_22：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getV_22())%></td>
		</tr>
		<tr>
			<td class="td_1" >w_23：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getW_23())%></td>
		</tr>
		<tr>
			<td class="td_1" >x_24：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getX_24())%></td>
		</tr>
		<tr>
			<td class="td_1" >y_25：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getY_25())%></td>
		</tr>
		<tr>
			<td class="td_1" >z_26：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getZ_26())%></td>
		</tr>
		<tr>
			<td class="td_1" >aa_27：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAa_27())%></td>
		</tr>
		<tr>
			<td class="td_1" >ab_28：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAb_28())%></td>
		</tr>
		<tr>
			<td class="td_1" >ac_29：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAc_29())%></td>
		</tr>
		<tr>
			<td class="td_1" >ad_30：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAd_30())%></td>
		</tr>
		<tr>
			<td class="td_1" >ae_31：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAe_31())%></td>
		</tr>
		<tr>
			<td class="td_1" >af_32：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAf_32())%></td>
		</tr>
		<tr>
			<td class="td_1" >ag_33：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAg_33())%></td>
		</tr>
		<tr>
			<td class="td_1" >ah_34：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAh_34())%></td>
		</tr>
		<tr>
			<td class="td_1" >ai_35：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAi_35())%></td>
		</tr>
		<tr>
			<td class="td_1" >aj_36：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAj_36())%></td>
		</tr>
		<tr>
			<td class="td_1" >ak_37：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAk_37())%></td>
		</tr>
		<tr>
			<td class="td_1" >al_38：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAl_38())%></td>
		</tr>
		<tr>
			<td class="td_1" >am_39：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAm_39())%></td>
		</tr>
		<tr>
			<td class="td_1" >an_40：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAn_40())%></td>
		</tr>
		<tr>
			<td class="td_1" >ao_41：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAo_41())%></td>
		</tr>
		<tr>
			<td class="td_1" >ap_42：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAp_42())%></td>
		</tr>
		<tr>
			<td class="td_1" >aq_43：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAq_43())%></td>
		</tr>
		<tr>
			<td class="td_1" >ar_44：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAr_44())%></td>
		</tr>
		<tr>
			<td class="td_1" >as_45：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAs_45())%></td>
		</tr>
		<tr>
			<td class="td_1" >at_46：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAt_46())%></td>
		</tr>
		<tr>
			<td class="td_1" >au_47：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAu_47())%></td>
		</tr>
		<tr>
			<td class="td_1" >av_48：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAv_48())%></td>
		</tr>
		<tr>
			<td class="td_1" >aw_49：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAw_49())%></td>
		</tr>
		<tr>
			<td class="td_1" >ax_50：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAx_50())%></td>
		</tr>
		<tr>
			<td class="td_1" >ay_51：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAy_51())%></td>
		</tr>
		<tr>
			<td class="td_1" >az_52：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getAz_52())%></td>
		</tr>
		<tr>
			<td class="td_1" >ba_53：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBa_53())%></td>
		</tr>
		<tr>
			<td class="td_1" >bb_54：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBb_54())%></td>
		</tr>
		<tr>
			<td class="td_1" >bc_55：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBc_55())%></td>
		</tr>
		<tr>
			<td class="td_1" >bd_56：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBd_56())%></td>
		</tr>
		<tr>
			<td class="td_1" >be_57：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBe_57())%></td>
		</tr>
		<tr>
			<td class="td_1" >bf_58：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBf_58())%></td>
		</tr>
		<tr>
			<td class="td_1" >bg_59：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBg_59())%></td>
		</tr>
		<tr>
			<td class="td_1" >bh_60：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBh_60())%></td>
		</tr>
		<tr>
			<td class="td_1" >bi_61：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBi_61())%></td>
		</tr>
		<tr>
			<td class="td_1" >bj_62：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBj_62())%></td>
		</tr>
		<tr>
			<td class="td_1" >bk_63：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBk_63())%></td>
		</tr>
		<tr>
			<td class="td_1" >bl_64：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBl_64())%></td>
		</tr>
		<tr>
			<td class="td_1" >bm_65：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBm_65())%></td>
		</tr>
		<tr>
			<td class="td_1" >bn_66：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBn_66())%></td>
		</tr>
		<tr>
			<td class="td_1" >bo_67：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBo_67())%></td>
		</tr>
		<tr>
			<td class="td_1" >bp_68：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBp_68())%></td>
		</tr>
		<tr>
			<td class="td_1" >bq_69：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBq_69())%></td>
		</tr>
		<tr>
			<td class="td_1" >br_70：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBr_70())%></td>
		</tr>
		<tr>
			<td class="td_1" >bs_71：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBs_71())%></td>
		</tr>
		<tr>
			<td class="td_1" >bt_72：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBt_72())%></td>
		</tr>
		<tr>
			<td class="td_1" >bu_73：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBu_73())%></td>
		</tr>
		<tr>
			<td class="td_1" >bv_74：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBv_74())%></td>
		</tr>
		<tr>
			<td class="td_1" >bw_75：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBw_75())%></td>
		</tr>
		<tr>
			<td class="td_1" >bx_76：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBx_76())%></td>
		</tr>
		<tr>
			<td class="td_1" >by_77：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBy_77())%></td>
		</tr>
		<tr>
			<td class="td_1" >bz_78：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getBz_78())%></td>
		</tr>
		<tr>
			<td class="td_1" >ca_79：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCa_79())%></td>
		</tr>
		<tr>
			<td class="td_1" >cb_80：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCb_80())%></td>
		</tr>
		<tr>
			<td class="td_1" >cc_81：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCc_81())%></td>
		</tr>
		<tr>
			<td class="td_1" >cd_82：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCd_82())%></td>
		</tr>
		<tr>
			<td class="td_1" >ce_83：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCe_83())%></td>
		</tr>
		<tr>
			<td class="td_1" >cf_84：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCf_84())%></td>
		</tr>
		<tr>
			<td class="td_1" >cg_85：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCg_85())%></td>
		</tr>
		<tr>
			<td class="td_1" >ch_86：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCh_86())%></td>
		</tr>
		<tr>
			<td class="td_1" >ci_87：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCi_87())%></td>
		</tr>
		<tr>
			<td class="td_1" >cj_88：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCj_88())%></td>
		</tr>
		<tr>
			<td class="td_1" >ck_89：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCk_89())%></td>
		</tr>
		<tr>
			<td class="td_1" >cl_90：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCl_90())%></td>
		</tr>
		<tr>
			<td class="td_1" >cm_91：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCm_91())%></td>
		</tr>
		<tr>
			<td class="td_1" >cn_92：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCn_92())%></td>
		</tr>
		<tr>
			<td class="td_1" >co_93：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCo_93())%></td>
		</tr>
		<tr>
			<td class="td_1" >cp_94：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCp_94())%></td>
		</tr>
		<tr>
			<td class="td_1" >cq_95：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCq_95())%></td>
		</tr>
		<tr>
			<td class="td_1" >cr_96：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCr_96())%></td>
		</tr>
		<tr>
			<td class="td_1" >cs_97：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCs_97())%></td>
		</tr>
		<tr>
			<td class="td_1" >ct_98：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCt_98())%></td>
		</tr>
		<tr>
			<td class="td_1" >cu_99：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCu_99())%></td>
		</tr>
		<tr>
			<td class="td_1" >cv_100：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCv_100())%></td>
		</tr>
		<tr>
			<td class="td_1" >cw_101：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCw_101())%></td>
		</tr>
		<tr>
			<td class="td_1" >cx_102：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCx_102())%></td>
		</tr>
		<tr>
			<td class="td_1" >cy_103：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCy_103())%></td>
		</tr>
		<tr>
			<td class="td_1" >cz_104：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getCz_104())%></td>
		</tr>
		<tr>
			<td class="td_1" >da_105：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDa_105())%></td>
		</tr>
		<tr>
			<td class="td_1" >db_106：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDb_106())%></td>
		</tr>
		<tr>
			<td class="td_1" >dc_107：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDc_107())%></td>
		</tr>
		<tr>
			<td class="td_1" >dd_108：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDd_108())%></td>
		</tr>
		<tr>
			<td class="td_1" >de_109：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDe_109())%></td>
		</tr>
		<tr>
			<td class="td_1" >df_110：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDf_110())%></td>
		</tr>
		<tr>
			<td class="td_1" >dg_111：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDg_111())%></td>
		</tr>
		<tr>
			<td class="td_1" >dh_112：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDh_112())%></td>
		</tr>
		<tr>
			<td class="td_1" >di_113：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDi_113())%></td>
		</tr>
		<tr>
			<td class="td_1" >dj_114：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDj_114())%></td>
		</tr>
		<tr>
			<td class="td_1" >dk_115：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDk_115())%></td>
		</tr>
		<tr>
			<td class="td_1" >dl_116：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDl_116())%></td>
		</tr>
		<tr>
			<td class="td_1" >dm_117：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDm_117())%></td>
		</tr>
		<tr>
			<td class="td_1" >dn_118：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDn_118())%></td>
		</tr>
		<tr>
			<td class="td_1" >do_119：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDo_119())%></td>
		</tr>
		<tr>
			<td class="td_1" >dp_120：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDp_120())%></td>
		</tr>
		<tr>
			<td class="td_1" >dq_121：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDq_121())%></td>
		</tr>
		<tr>
			<td class="td_1" >dr_122：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDr_122())%></td>
		</tr>
		<tr>
			<td class="td_1" >ds_123：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDs_123())%></td>
		</tr>
		<tr>
			<td class="td_1" >dt_124：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDt_124())%></td>
		</tr>
		<tr>
			<td class="td_1" >du_125：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDu_125())%></td>
		</tr>
		<tr>
			<td class="td_1" >dv_126：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDv_126())%></td>
		</tr>
		<tr>
			<td class="td_1" >dw_127：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDw_127())%></td>
		</tr>
		<tr>
			<td class="td_1" >dx_128：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDx_128())%></td>
		</tr>
		<tr>
			<td class="td_1" >dy_129：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDy_129())%></td>
		</tr>
		<tr>
			<td class="td_1" >dz_130：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getDz_130())%></td>
		</tr>
		<tr>
			<td class="td_1" >ea_131：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEa_131())%></td>
		</tr>
		<tr>
			<td class="td_1" >eb_132：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEb_132())%></td>
		</tr>
		<tr>
			<td class="td_1" >ec_133：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEc_133())%></td>
		</tr>
		<tr>
			<td class="td_1" >ed_134：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEd_134())%></td>
		</tr>
		<tr>
			<td class="td_1" >ee_135：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEe_135())%></td>
		</tr>
		<tr>
			<td class="td_1" >ef_136：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEf_136())%></td>
		</tr>
		<tr>
			<td class="td_1" >eg_137：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEg_137())%></td>
		</tr>
		<tr>
			<td class="td_1" >eh_138：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEh_138())%></td>
		</tr>
		<tr>
			<td class="td_1" >ei_139：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEi_139())%></td>
		</tr>
		<tr>
			<td class="td_1" >ej_140：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEj_140())%></td>
		</tr>
		<tr>
			<td class="td_1" >ek_141：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEk_141())%></td>
		</tr>
		<tr>
			<td class="td_1" >el_142：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEl_142())%></td>
		</tr>
		<tr>
			<td class="td_1" >em_143：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEm_143())%></td>
		</tr>
		<tr>
			<td class="td_1" >en_144：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEn_144())%></td>
		</tr>
		<tr>
			<td class="td_1" >eo_145：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEo_145())%></td>
		</tr>
		<tr>
			<td class="td_1" >ep_146：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEp_146())%></td>
		</tr>
		<tr>
			<td class="td_1" >eq_147：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEq_147())%></td>
		</tr>
		<tr>
			<td class="td_1" >er_148：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEr_148())%></td>
		</tr>
		<tr>
			<td class="td_1" >es_149：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEs_149())%></td>
		</tr>
		<tr>
			<td class="td_1" >et_150：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEt_150())%></td>
		</tr>
		<tr>
			<td class="td_1" >eu_151：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEu_151())%></td>
		</tr>
		<tr>
			<td class="td_1" >ev_152：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEv_152())%></td>
		</tr>
		<tr>
			<td class="td_1" >ew_153：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEw_153())%></td>
		</tr>
		<tr>
			<td class="td_1" >ex_154：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEx_154())%></td>
		</tr>
		<tr>
			<td class="td_1" >ey_155：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEy_155())%></td>
		</tr>
		<tr>
			<td class="td_1" >ez_156：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getEz_156())%></td>
		</tr>
		<tr>
			<td class="td_1" >fa_157：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFa_157())%></td>
		</tr>
		<tr>
			<td class="td_1" >fb_158：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFb_158())%></td>
		</tr>
		<tr>
			<td class="td_1" >fc_159：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFc_159())%></td>
		</tr>
		<tr>
			<td class="td_1" >fd_160：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFd_160())%></td>
		</tr>
		<tr>
			<td class="td_1" >fe_161：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFe_161())%></td>
		</tr>
		<tr>
			<td class="td_1" >ff_162：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFf_162())%></td>
		</tr>
		<tr>
			<td class="td_1" >fg_163：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFg_163())%></td>
		</tr>
		<tr>
			<td class="td_1" >fh_164：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFh_164())%></td>
		</tr>
		<tr>
			<td class="td_1" >fi_165：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFi_165())%></td>
		</tr>
		<tr>
			<td class="td_1" >fj_166：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFj_166())%></td>
		</tr>
		<tr>
			<td class="td_1" >fk_167：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFk_167())%></td>
		</tr>
		<tr>
			<td class="td_1" >fl_168：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFl_168())%></td>
		</tr>
		<tr>
			<td class="td_1" >fm_169：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFm_169())%></td>
		</tr>
		<tr>
			<td class="td_1" >fn_170：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFn_170())%></td>
		</tr>
		<tr>
			<td class="td_1" >fo_171：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFo_171())%></td>
		</tr>
		<tr>
			<td class="td_1" >fp_172：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFp_172())%></td>
		</tr>
		<tr>
			<td class="td_1" >fq_173：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFq_173())%></td>
		</tr>
		<tr>
			<td class="td_1" >fr_174：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFr_174())%></td>
		</tr>
		<tr>
			<td class="td_1" >fs_175：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFs_175())%></td>
		</tr>
		<tr>
			<td class="td_1" >ft_176：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFt_176())%></td>
		</tr>
		<tr>
			<td class="td_1" >fu_177：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFu_177())%></td>
		</tr>
		<tr>
			<td class="td_1" >fv_178：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFv_178())%></td>
		</tr>
		<tr>
			<td class="td_1" >fw_179：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFw_179())%></td>
		</tr>
		<tr>
			<td class="td_1" >fx_180：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFx_180())%></td>
		</tr>
		<tr>
			<td class="td_1" >fy_181：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFy_181())%></td>
		</tr>
		<tr>
			<td class="td_1" >fz_182：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFz_182())%></td>
		</tr>
		<tr>
			<td class="td_1" >ga_183：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGa_183())%></td>
		</tr>
		<tr>
			<td class="td_1" >gb_184：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGb_184())%></td>
		</tr>
		<tr>
			<td class="td_1" >gc_185：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGc_185())%></td>
		</tr>
		<tr>
			<td class="td_1" >gd_186：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGd_186())%></td>
		</tr>
		<tr>
			<td class="td_1" >ge_187：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGe_187())%></td>
		</tr>
		<tr>
			<td class="td_1" >gf_188：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGf_188())%></td>
		</tr>
		<tr>
			<td class="td_1" >gg_189：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGg_189())%></td>
		</tr>
		<tr>
			<td class="td_1" >gh_190：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGh_190())%></td>
		</tr>
		<tr>
			<td class="td_1" >gi_191：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGi_191())%></td>
		</tr>
		<tr>
			<td class="td_1" >gj_192：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGj_192())%></td>
		</tr>
		<tr>
			<td class="td_1" >gk_193：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGk_193())%></td>
		</tr>
		<tr>
			<td class="td_1" >gl_194：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGl_194())%></td>
		</tr>
		<tr>
			<td class="td_1" >gm_195：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGm_195())%></td>
		</tr>
		<tr>
			<td class="td_1" >gn_196：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGn_196())%></td>
		</tr>
		<tr>
			<td class="td_1" >go_197：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGo_197())%></td>
		</tr>
		<tr>
			<td class="td_1" >gp_198：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGp_198())%></td>
		</tr>
		<tr>
			<td class="td_1" >gq_199：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGq_199())%></td>
		</tr>
		<tr>
			<td class="td_1" >gr_200：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGr_200())%></td>
		</tr>
		<tr>
			<td class="td_1" >gs_201：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGs_201())%></td>
		</tr>
		<tr>
			<td class="td_1" >gt_202：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGt_202())%></td>
		</tr>
		<tr>
			<td class="td_1" >gu_203：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGu_203())%></td>
		</tr>
		<tr>
			<td class="td_1" >gv_204：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGv_204())%></td>
		</tr>
		<tr>
			<td class="td_1" >gw_205：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGw_205())%></td>
		</tr>
		<tr>
			<td class="td_1" >gx_206：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGx_206())%></td>
		</tr>
		<tr>
			<td class="td_1" >gy_207：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGy_207())%></td>
		</tr>
		<tr>
			<td class="td_1" >gz_208：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getGz_208())%></td>
		</tr>
		<tr>
			<td class="td_1" >ha_209：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHa_209())%></td>
		</tr>
		<tr>
			<td class="td_1" >hb_210：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHb_210())%></td>
		</tr>
		<tr>
			<td class="td_1" >hc_211：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHc_211())%></td>
		</tr>
		<tr>
			<td class="td_1" >hd_212：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHd_212())%></td>
		</tr>
		<tr>
			<td class="td_1" >he_213：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHe_213())%></td>
		</tr>
		<tr>
			<td class="td_1" >hf_214：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHf_214())%></td>
		</tr>
		<tr>
			<td class="td_1" >hg_215：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHg_215())%></td>
		</tr>
		<tr>
			<td class="td_1" >hh_216：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHh_216())%></td>
		</tr>
		<tr>
			<td class="td_1" >hi_217：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHi_217())%></td>
		</tr>
		<tr>
			<td class="td_1" >hj_218：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHj_218())%></td>
		</tr>
		<tr>
			<td class="td_1" >hk_219：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHk_219())%></td>
		</tr>
		<tr>
			<td class="td_1" >hl_220：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHl_220())%></td>
		</tr>
		<tr>
			<td class="td_1" >hm_221：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHm_221())%></td>
		</tr>
		<tr>
			<td class="td_1" >hn_222：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHn_222())%></td>
		</tr>
		<tr>
			<td class="td_1" >ho_223：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHo_223())%></td>
		</tr>
		<tr>
			<td class="td_1" >hp_224：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHp_224())%></td>
		</tr>
		<tr>
			<td class="td_1" >hq_225：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHq_225())%></td>
		</tr>
		<tr>
			<td class="td_1" >hr_226：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHr_226())%></td>
		</tr>
		<tr>
			<td class="td_1" >hs_227：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHs_227())%></td>
		</tr>
		<tr>
			<td class="td_1" >ht_228：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHt_228())%></td>
		</tr>
		<tr>
			<td class="td_1" >hu_229：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHu_229())%></td>
		</tr>
		<tr>
			<td class="td_1" >hv_230：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHv_230())%></td>
		</tr>
		<tr>
			<td class="td_1" >hw_231：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHw_231())%></td>
		</tr>
		<tr>
			<td class="td_1" >hx_232：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHx_232())%></td>
		</tr>
		<tr>
			<td class="td_1" >hy_233：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHy_233())%></td>
		</tr>
		<tr>
			<td class="td_1" >hz_234：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getHz_234())%></td>
		</tr>
		<tr>
			<td class="td_1" >ia_235：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIa_235())%></td>
		</tr>
		<tr>
			<td class="td_1" >ib_236：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIb_236())%></td>
		</tr>
		<tr>
			<td class="td_1" >ic_237：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIc_237())%></td>
		</tr>
		<tr>
			<td class="td_1" >id_238：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getId_238())%></td>
		</tr>
		<tr>
			<td class="td_1" >ie_239：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIe_239())%></td>
		</tr>
		<tr>
			<td class="td_1" >if_240：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIf_240())%></td>
		</tr>
		<tr>
			<td class="td_1" >ig_241：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIg_241())%></td>
		</tr>
		<tr>
			<td class="td_1" >ih_242：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIh_242())%></td>
		</tr>
		<tr>
			<td class="td_1" >ii_243：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIi_243())%></td>
		</tr>
		<tr>
			<td class="td_1" >ij_244：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIj_244())%></td>
		</tr>
		<tr>
			<td class="td_1" >ik_245：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIk_245())%></td>
		</tr>
		<tr>
			<td class="td_1" >il_246：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIl_246())%></td>
		</tr>
		<tr>
			<td class="td_1" >im_247：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIm_247())%></td>
		</tr>
		<tr>
			<td class="td_1" >in_248：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIn_248())%></td>
		</tr>
		<tr>
			<td class="td_1" >io_249：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIo_249())%></td>
		</tr>
		<tr>
			<td class="td_1" >ip_250：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIp_250())%></td>
		</tr>
		<tr>
			<td class="td_1" >iq_251：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIq_251())%></td>
		</tr>
		<tr>
			<td class="td_1" >ir_252：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIr_252())%></td>
		</tr>
		<tr>
			<td class="td_1" >is_253：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIs_253())%></td>
		</tr>
		<tr>
			<td class="td_1" >it_254：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIt_254())%></td>
		</tr>
		<tr>
			<td class="td_1" >iu_255：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIu_255())%></td>
		</tr>
		<tr>
			<td class="td_1" >iv_256：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getIv_256())%></td>
		</tr>
		<tr>
			<td class="td_1" >import_result：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getImport_result())%></td>
		</tr>
		<tr>
			<td class="td_1" >failure_code：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFailure_code())%></td>
		</tr>
		<tr>
			<td class="td_1" >failure_reason：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getFailure_reason())%></td>
		</tr>
		<tr>
			<td class="td_1" >interface_type：</td>
			<td class="td_2" ><%=RmStringHelper.prt(resultVo.getInterface_type())%></td>
		</tr>
		<tr>
			<td class="td_1" align="right"></td>
			<td class="td_2" align="left"></td>
		</tr>
	</table>
</div>


  	
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:back_onClick();" />
</div>


</div>
<input type="hidden" name="id" value="<%=RmStringHelper.prt(resultVo.getId())%>">

	 </div>

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
