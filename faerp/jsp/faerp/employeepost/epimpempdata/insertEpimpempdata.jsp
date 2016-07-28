<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.epimpempdata.vo.EpimpempdataVo" %>
<%@ page import="rayoo.employeepost.epimpempdata.util.IEpimpempdataConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	EpimpempdataVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IEpimpempdataConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (EpimpempdataVo)request.getAttribute(IEpimpempdataConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	    if(checkAllForms()){
		form.action="<%=request.getContextPath()%>/EpimpempdataAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/EpimpempdataAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/EpimpempdataAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key="modify_page"/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key="insert_page"/>','<%=request.getContextPath()%>/');
</script>


 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
		<tr>
			<td class="td_1" >import_id</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="import_id" inputName="import_id" value="" maxLength="9.5" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >a_1</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="a_1" inputName="a_1" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >b_2</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="b_2" inputName="b_2" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >c_3</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="c_3" inputName="c_3" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >d_4</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="d_4" inputName="d_4" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >e_5</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="e_5" inputName="e_5" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >f_6</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="f_6" inputName="f_6" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >g_7</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="g_7" inputName="g_7" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >h_8</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="h_8" inputName="h_8" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >i_9</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="i_9" inputName="i_9" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >j_10</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="j_10" inputName="j_10" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >k_11</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="k_11" inputName="k_11" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >l_12</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="l_12" inputName="l_12" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >m_13</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="m_13" inputName="m_13" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >n_14</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="n_14" inputName="n_14" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >o_15</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="o_15" inputName="o_15" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >p_16</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="p_16" inputName="p_16" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >q_17</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="q_17" inputName="q_17" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >r_18</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="r_18" inputName="r_18" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >s_19</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="s_19" inputName="s_19" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >t_20</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="t_20" inputName="t_20" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >u_21</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="u_21" inputName="u_21" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >v_22</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="v_22" inputName="v_22" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >w_23</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="w_23" inputName="w_23" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >x_24</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="x_24" inputName="x_24" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >y_25</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="y_25" inputName="y_25" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >z_26</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="z_26" inputName="z_26" value="" maxLength="250" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >aa_27</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="aa_27" inputName="aa_27" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ab_28</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ab_28" inputName="ab_28" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ac_29</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ac_29" inputName="ac_29" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ad_30</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ad_30" inputName="ad_30" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ae_31</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ae_31" inputName="ae_31" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >af_32</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="af_32" inputName="af_32" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ag_33</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ag_33" inputName="ag_33" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ah_34</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ah_34" inputName="ah_34" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ai_35</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ai_35" inputName="ai_35" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >aj_36</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="aj_36" inputName="aj_36" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ak_37</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ak_37" inputName="ak_37" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >al_38</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="al_38" inputName="al_38" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >am_39</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="am_39" inputName="am_39" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >an_40</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="an_40" inputName="an_40" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ao_41</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ao_41" inputName="ao_41" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ap_42</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ap_42" inputName="ap_42" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >aq_43</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="aq_43" inputName="aq_43" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ar_44</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ar_44" inputName="ar_44" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >as_45</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="as_45" inputName="as_45" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >at_46</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="at_46" inputName="at_46" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >au_47</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="au_47" inputName="au_47" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >av_48</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="av_48" inputName="av_48" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >aw_49</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="aw_49" inputName="aw_49" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ax_50</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ax_50" inputName="ax_50" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ay_51</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ay_51" inputName="ay_51" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >az_52</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="az_52" inputName="az_52" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ba_53</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ba_53" inputName="ba_53" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bb_54</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bb_54" inputName="bb_54" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bc_55</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bc_55" inputName="bc_55" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bd_56</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bd_56" inputName="bd_56" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >be_57</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="be_57" inputName="be_57" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bf_58</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bf_58" inputName="bf_58" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bg_59</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bg_59" inputName="bg_59" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bh_60</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bh_60" inputName="bh_60" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bi_61</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bi_61" inputName="bi_61" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bj_62</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bj_62" inputName="bj_62" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bk_63</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bk_63" inputName="bk_63" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bl_64</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bl_64" inputName="bl_64" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bm_65</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bm_65" inputName="bm_65" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bn_66</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bn_66" inputName="bn_66" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bo_67</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bo_67" inputName="bo_67" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bp_68</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bp_68" inputName="bp_68" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bq_69</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bq_69" inputName="bq_69" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >br_70</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="br_70" inputName="br_70" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bs_71</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bs_71" inputName="bs_71" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bt_72</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bt_72" inputName="bt_72" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bu_73</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bu_73" inputName="bu_73" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bv_74</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bv_74" inputName="bv_74" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bw_75</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bw_75" inputName="bw_75" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bx_76</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bx_76" inputName="bx_76" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >by_77</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="by_77" inputName="by_77" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >bz_78</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="bz_78" inputName="bz_78" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ca_79</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ca_79" inputName="ca_79" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cb_80</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cb_80" inputName="cb_80" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cc_81</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cc_81" inputName="cc_81" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cd_82</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cd_82" inputName="cd_82" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ce_83</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ce_83" inputName="ce_83" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cf_84</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cf_84" inputName="cf_84" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cg_85</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cg_85" inputName="cg_85" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ch_86</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ch_86" inputName="ch_86" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ci_87</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ci_87" inputName="ci_87" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cj_88</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cj_88" inputName="cj_88" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ck_89</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ck_89" inputName="ck_89" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cl_90</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cl_90" inputName="cl_90" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cm_91</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cm_91" inputName="cm_91" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cn_92</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cn_92" inputName="cn_92" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >co_93</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="co_93" inputName="co_93" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cp_94</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cp_94" inputName="cp_94" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cq_95</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cq_95" inputName="cq_95" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cr_96</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cr_96" inputName="cr_96" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cs_97</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cs_97" inputName="cs_97" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ct_98</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ct_98" inputName="ct_98" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cu_99</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cu_99" inputName="cu_99" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cv_100</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cv_100" inputName="cv_100" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cw_101</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cw_101" inputName="cw_101" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cx_102</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cx_102" inputName="cx_102" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cy_103</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cy_103" inputName="cy_103" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >cz_104</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="cz_104" inputName="cz_104" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >da_105</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="da_105" inputName="da_105" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >db_106</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="db_106" inputName="db_106" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dc_107</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dc_107" inputName="dc_107" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dd_108</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dd_108" inputName="dd_108" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >de_109</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="de_109" inputName="de_109" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >df_110</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="df_110" inputName="df_110" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dg_111</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dg_111" inputName="dg_111" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dh_112</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dh_112" inputName="dh_112" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >di_113</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="di_113" inputName="di_113" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dj_114</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dj_114" inputName="dj_114" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dk_115</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dk_115" inputName="dk_115" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dl_116</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dl_116" inputName="dl_116" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dm_117</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dm_117" inputName="dm_117" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dn_118</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dn_118" inputName="dn_118" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >do_119</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="do_119" inputName="do_119" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dp_120</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dp_120" inputName="dp_120" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dq_121</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dq_121" inputName="dq_121" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dr_122</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dr_122" inputName="dr_122" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ds_123</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ds_123" inputName="ds_123" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dt_124</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dt_124" inputName="dt_124" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >du_125</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="du_125" inputName="du_125" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dv_126</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dv_126" inputName="dv_126" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dw_127</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dw_127" inputName="dw_127" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dx_128</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dx_128" inputName="dx_128" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dy_129</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dy_129" inputName="dy_129" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >dz_130</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="dz_130" inputName="dz_130" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ea_131</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ea_131" inputName="ea_131" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >eb_132</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="eb_132" inputName="eb_132" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ec_133</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ec_133" inputName="ec_133" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ed_134</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ed_134" inputName="ed_134" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ee_135</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ee_135" inputName="ee_135" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ef_136</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ef_136" inputName="ef_136" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >eg_137</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="eg_137" inputName="eg_137" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >eh_138</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="eh_138" inputName="eh_138" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ei_139</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ei_139" inputName="ei_139" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ej_140</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ej_140" inputName="ej_140" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ek_141</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ek_141" inputName="ek_141" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >el_142</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="el_142" inputName="el_142" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >em_143</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="em_143" inputName="em_143" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >en_144</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="en_144" inputName="en_144" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >eo_145</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="eo_145" inputName="eo_145" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ep_146</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ep_146" inputName="ep_146" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >eq_147</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="eq_147" inputName="eq_147" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >er_148</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="er_148" inputName="er_148" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >es_149</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="es_149" inputName="es_149" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >et_150</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="et_150" inputName="et_150" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >eu_151</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="eu_151" inputName="eu_151" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ev_152</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ev_152" inputName="ev_152" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ew_153</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ew_153" inputName="ew_153" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ex_154</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ex_154" inputName="ex_154" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ey_155</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ey_155" inputName="ey_155" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ez_156</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ez_156" inputName="ez_156" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fa_157</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fa_157" inputName="fa_157" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fb_158</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fb_158" inputName="fb_158" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fc_159</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fc_159" inputName="fc_159" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fd_160</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fd_160" inputName="fd_160" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fe_161</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fe_161" inputName="fe_161" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ff_162</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ff_162" inputName="ff_162" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fg_163</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fg_163" inputName="fg_163" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fh_164</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fh_164" inputName="fh_164" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fi_165</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fi_165" inputName="fi_165" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fj_166</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fj_166" inputName="fj_166" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fk_167</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fk_167" inputName="fk_167" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fl_168</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fl_168" inputName="fl_168" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fm_169</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fm_169" inputName="fm_169" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fn_170</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fn_170" inputName="fn_170" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fo_171</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fo_171" inputName="fo_171" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fp_172</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fp_172" inputName="fp_172" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fq_173</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fq_173" inputName="fq_173" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fr_174</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fr_174" inputName="fr_174" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fs_175</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fs_175" inputName="fs_175" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ft_176</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ft_176" inputName="ft_176" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fu_177</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fu_177" inputName="fu_177" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fv_178</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fv_178" inputName="fv_178" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fw_179</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fw_179" inputName="fw_179" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fx_180</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fx_180" inputName="fx_180" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fy_181</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fy_181" inputName="fy_181" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >fz_182</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="fz_182" inputName="fz_182" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ga_183</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ga_183" inputName="ga_183" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gb_184</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gb_184" inputName="gb_184" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gc_185</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gc_185" inputName="gc_185" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gd_186</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gd_186" inputName="gd_186" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ge_187</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ge_187" inputName="ge_187" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gf_188</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gf_188" inputName="gf_188" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gg_189</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gg_189" inputName="gg_189" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gh_190</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gh_190" inputName="gh_190" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gi_191</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gi_191" inputName="gi_191" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gj_192</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gj_192" inputName="gj_192" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gk_193</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gk_193" inputName="gk_193" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gl_194</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gl_194" inputName="gl_194" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gm_195</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gm_195" inputName="gm_195" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gn_196</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gn_196" inputName="gn_196" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >go_197</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="go_197" inputName="go_197" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gp_198</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gp_198" inputName="gp_198" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gq_199</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gq_199" inputName="gq_199" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gr_200</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gr_200" inputName="gr_200" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gs_201</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gs_201" inputName="gs_201" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gt_202</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gt_202" inputName="gt_202" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gu_203</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gu_203" inputName="gu_203" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gv_204</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gv_204" inputName="gv_204" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gw_205</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gw_205" inputName="gw_205" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gx_206</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gx_206" inputName="gx_206" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gy_207</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gy_207" inputName="gy_207" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >gz_208</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="gz_208" inputName="gz_208" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ha_209</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ha_209" inputName="ha_209" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hb_210</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hb_210" inputName="hb_210" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hc_211</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hc_211" inputName="hc_211" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hd_212</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hd_212" inputName="hd_212" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >he_213</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="he_213" inputName="he_213" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hf_214</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hf_214" inputName="hf_214" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hg_215</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hg_215" inputName="hg_215" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hh_216</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hh_216" inputName="hh_216" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hi_217</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hi_217" inputName="hi_217" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hj_218</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hj_218" inputName="hj_218" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hk_219</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hk_219" inputName="hk_219" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hl_220</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hl_220" inputName="hl_220" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hm_221</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hm_221" inputName="hm_221" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hn_222</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hn_222" inputName="hn_222" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ho_223</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ho_223" inputName="ho_223" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hp_224</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hp_224" inputName="hp_224" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hq_225</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hq_225" inputName="hq_225" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hr_226</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hr_226" inputName="hr_226" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hs_227</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hs_227" inputName="hs_227" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ht_228</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ht_228" inputName="ht_228" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hu_229</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hu_229" inputName="hu_229" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hv_230</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hv_230" inputName="hv_230" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hw_231</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hw_231" inputName="hw_231" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hx_232</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hx_232" inputName="hx_232" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hy_233</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hy_233" inputName="hy_233" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >hz_234</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="hz_234" inputName="hz_234" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ia_235</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ia_235" inputName="ia_235" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ib_236</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ib_236" inputName="ib_236" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ic_237</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ic_237" inputName="ic_237" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >id_238</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="id_238" inputName="id_238" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ie_239</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ie_239" inputName="ie_239" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >if_240</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="if_240" inputName="if_240" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ig_241</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ig_241" inputName="ig_241" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ih_242</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ih_242" inputName="ih_242" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ii_243</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ii_243" inputName="ii_243" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ij_244</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ij_244" inputName="ij_244" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ik_245</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ik_245" inputName="ik_245" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >il_246</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="il_246" inputName="il_246" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >im_247</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="im_247" inputName="im_247" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >in_248</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="in_248" inputName="in_248" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >io_249</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="io_249" inputName="io_249" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ip_250</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ip_250" inputName="ip_250" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >iq_251</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="iq_251" inputName="iq_251" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >ir_252</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="ir_252" inputName="ir_252" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >is_253</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="is_253" inputName="is_253" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >it_254</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="it_254" inputName="it_254" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >iu_255</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="iu_255" inputName="iu_255" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >iv_256</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="iv_256" inputName="iv_256" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >import_result</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="import_result" inputName="import_result" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >failure_code</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="failure_code" inputName="failure_code" value="" maxLength="25" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1" >failure_reason</td>
			<td class="td_2 ">
				<input type="text" class="text_field" name="failure_reason" inputName="failure_reason" value="" maxLength="50" />
			</td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td  class="td_1" >interface_type</td>
			<td  class="td_2" >
				<input type="text" class="text_field" name="interface_type" inputName="interface_type" maxLength="23" integerDigits="22" decimalDigits="0" />
			</td>
			<td class="td_2"></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
			<td class="td_2"></td>
		</tr>
	</table>
 

            
   
   
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>         
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
