<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.system.securitygroup.vo.SecuritygroupVo" %>
<%@ page import="rayoo.system.securitygroup.util.ISecuritygroupConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%  //判断是否为修改页面
	SecuritygroupVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(ISecuritygroupConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (SecuritygroupVo)request.getAttribute(ISecuritygroupConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
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
		form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=insert";
		form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){

	    form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=update";
    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=queryAll&backFlag=true";
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
			<td class="td_1" >省市</td>
			<td class="td_2 ">
				<faerp:cityTag  tagname="city_id"  />			</td>
			<td class="td_1" >社保组名称</td>
			<td class="td_2 "><input type="text" class="text_field" name="group_name" inputName="社保组名称" value="" maxLength="50" /></td>
			<td class="td_1" >入职服务名称</td>
			<td class="td_2 "><input type="text" class="text_field" name="service_id" inputName="入职服务名称" value="" maxLength="9.5" />            </td>
		</tr>
		
		<tr>
			<td class="td_1" >组类别</td>
			<td class="td_2" >
			<%=RmJspHelper.getSelectField("group_type_bd", -1,"GROUP_TYPE_BD",isModify ? resultVo.getGroup_type_bd() : "1","",false) %>			</td>
			<td class="td_1" >年度调整月</td>
			<td class="td_2 "><input type="text" class="text_field" name="adjust_month" inputName="年度调整月" value="" maxLength="50" />            </td>
			<td class="td_1" >停办方式</td>
			<td class="td_2" ><%=RmJspHelper.getSelectField("stop_month_type_bd", -1,"STOP_MONTH_TYPE_BD",isModify ? resultVo.getStop_month_type_bd() : "1","",false) %> </td>
		</tr>
		
		<tr>
			<td class="td_1" >每月办理截止日</td>
			<td class="td_2">
				<input type="text" class="text_field_reference_readonly" name="transact_day" id="transact_day" inputName="每月办理截止日" /><img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('transact_day','<venus:base/>/');"/>			</td>
			<td class="td_1" >每月停办截止日</td>
			<td class="td_2"><input type="text" class="text_field_reference_readonly" name="stop_day" id="stop_day" inputName="每月停办截止日" />
			    <img class="refButtonClass"	src="<venus:base/>/images/icon/reference.gif" onClick="javascript:getYearMonthDay('stop_day','<venus:base/>/');"/> </td>
			<td class="td_1" >补缴月类型</td>
			<td class="td_2" ><%=RmJspHelper.getSelectField("supply_month_type_bd", -1,"SUPPLY_MONTH_TYPE_BD",isModify ? resultVo.getSupply_month_type_bd() : "1","",false) %> </td>
		</tr>
		
		<tr>
			<td class="td_1" >保险托收</td>
			<td class="td_2" >
			<%=RmJspHelper.getSelectField("ss_collection_type_bd", -1,"SS_COLLECTION_TYPE",isModify ? resultVo.getSs_collection_type_bd() : "1","",false) %>			</td>
			<td class="td_1" >保险托收方式</td>
			<td class="td_2" ><%=RmJspHelper.getSelectField("collection_type_bd", -1,"COLLECTION_TYPE_BD",isModify ? resultVo.getCollection_type_bd() : "1","",false) %> </td>
			<td class="td_1" >默认显示</td>
			<td class="td_2 "><%=RmJspHelper.getSelectField("is_default_show", -1,"TrueOrFalse",isModify ? resultVo.getBind_radix_bd() : "1","",false) %> </td>
		</tr>
		
		<tr>
			<td class="td_1" >绑定基数</td>
			<td class="td_2" >
			<%=RmJspHelper.getSelectField("bind_radix_bd", -1,"TrueOrFalse",isModify ? resultVo.getBind_radix_bd() : "1","",false) %>			</td>
			<td class="td_1" >使用账号/序号</td>
			<td class="td_2" ><%=RmJspHelper.getSelectField("use_account_or_num_bd", -1,"USE_ACCOUNT_OR_NUM",isModify ? resultVo.getUse_account_or_num_bd(): "1","",false) %> </td>
			<td class="td_1" >企业支付方式</td>
			<td class="td_2" ><%=RmJspHelper.getSelectField("e_pay_policy_bd", -1,"E_PAY_POLICY_BD",isModify ? resultVo.getE_pay_policy_bd() : "1","",false) %> </td>
		</tr>
		<tr>
		  <td class="td_1" >个人支付方式</td>
		  <td class="td_2" ><%=RmJspHelper.getSelectField("p_pay_policy_bd", -1,"P_PAY_POLICY_BD",isModify ? resultVo.getP_pay_policy_bd() : "1","",false) %> </td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
			<td class="td_2" ></td>
		</tr>
		<tr>
			<td class="td_1">说明</td>
			<td colspan="5" class="td_2" >
				<textarea class="textarea_limit_words" rows="3" class="xText_d" id="text22" style="width:99%" name="explanation" inputName="说明" maxLength="1000"></textarea>
				</td>
		</tr>
	</table>
	
<div style="margin-top:10px;">
	  <div class="box" id="div" style="width:40%; float:left;" style="margin-left:0px;">
	      <div class="button" style="margin:0 0 0 0 px;"> 
                  <div class="button_right">
                        <ul>
                            <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                            <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                        </ul>
                 </div><div class="box_title" style="margin-top:5px;">下属产品比例</div>
                   <div class="clear"></div>            
        </div>
       <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th width="8%"  > <input type="checkbox" name="checkbox6" value="checkbox" onClick="CheckAll()">          </th>
          <th width="33%"  >产品</th>
          <th width="18%">每月支付</th>
          <th width="14%">可补收</th>
          <th width="27%">排序</th>
          </tr>
        <tr>
          <td ><input type="checkbox" name="checkbox222" value="checkbox">          </td>
          <td ><select name="select15" class="sSelect" id="select15" style="width:120px">
            <option value="">请选择</option>
            <option value="ro">生育保险</option>
            <option value="fr">大病附加保险</option>
            <option value="ro">失业保险</option>
            <option>.....</option>
                    </select></td>
          <td><select name="select16" class="sSelect" id="select16" style="width:60px">
            <option value="">请选择</option>
            <option>是</option>
            <option>否</option>
          </select></td>
          <td><select name="select17" class="sSelect" id="select17" style="width:60px">
            <option value="">请选择</option>
            <option>是</option>
            <option>否</option>
          </select></td>
          <td><input name="text422" type="text" class="sText" id="text422" style="width:60px;"/></td>
          </tr>
      </table>
    </div>
    

    <div class="box" id="div2" style="width:28%; float:left;">
      <div class="button" style="margin:0 0 0 0 px;"> 
                  <div class="button_right">
                        <ul>
                            <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                            <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                        </ul>
                 </div><div class="box_title" style="margin-top:5px;">新开类别</div>
                   <div class="clear"></div>            
        </div>
      <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th width="15%"  > <input type="checkbox" name="checkbox62" value="checkbox" onClick="CheckAll()">          </th>
          <th width="22%"  >编号</th>
          <th width="28%">名称</th>
          <th width="35%">一次性补缴</th>
        </tr>
        <tr>
          <td ><input type="checkbox" name="checkbox2222" value="checkbox">          </td>
          <td ><input name="text4222" type="text" class="sText" id="text4222" style="width:60px;"/></td>
          <td><input name="text4223" type="text" class="sText" id="text4223" style="width:60px;"/></td>
          <td><select name="select18" class="sSelect" id="select18" style="width:60px">
            <option value="">请选择</option>
            <option>是</option>
            <option>否</option>
          </select></td>
        </tr>
      </table>
    </div>
    <div class="box" id="div3" style="width:27%; float:left;">
       <div class="button" style="margin:0 0 0 0 px;"> 
                  <div class="button_right">
                        <ul>
                            <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                            <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                        </ul>
                 </div><div class="box_title" style="margin-top:5px;">停办类别</div>
                   <div class="clear"></div>            
        </div>
        <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th width="15%"  > <input type="checkbox" name="checkbox63" value="checkbox" onClick="CheckAll()">          </th>
          <th width="32%"  >编号</th>
          <th width="53%">名称</th>
        </tr>
        <tr>
          <td ><input type="checkbox" name="checkbox2223" value="checkbox">          </td>
          <td ><input name="text4224" type="text" class="sText" id="text4224" style="width:60px;"/></td>
          <td><input name="text4225" type="text" class="sText" id="text4225" style="width:60px;"/></td>
        </tr>
      </table>
    </div>
</div>
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
