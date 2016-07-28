<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.salary.salaryitem.salaryitem_resource" prefix="rayoo.salary.salaryitem.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
</head>
<body>
<form name="form" action="" method="post"> 
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title"><fmt:message key='view_salaryitem'/></div></div>
    <div class="ringht_s">
    <div class="box_3">
        <div class="xz_title"><fmt:message key='base_info'/></div>
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='sa_item_name'/></td>
            <td class="td_2"><input name="sa_item_name" type="text" class="sText" id="sa_item_name" disabled="disabled" value="${bean.sa_item_name}"/></td>
            <td class="td_1"><fmt:message key='sa_item_ename'/></td>
            <td class="td_2"><input name="sa_item_ename" type="text" class="sText" id="sa_item_ename" disabled="disabled" value="${bean.sa_item_ename}"/></td>
            <td class="td_1"><fmt:message key='is_tax'/></td>
            <td class="td_2">
           <h:select property="bean/is_tax" id="is_tax" name="is_tax" disabled="true" style="width:150px">
                         <h:option value="1" label="税前"/>
                         <h:option value="0" label="税后"/>
                  </h:select>
            </td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='property'/></td>
            <td class="td_2"><h:select property="bean/property" id="property" disabled="true" name="property" style="width:150px">
                         <h:option value="0" label="增项"/>
                         <h:option value="1" label="减项"/>
                         <h:option value="2" label="其他"/>
                  </h:select></td>
            <td class="td_1"><fmt:message key='decimal_num'/></td>
            <td class="td_2">
            <h:select property="bean/decimal_num" id="decimal_num" disabled="true" name="decimal_num" style="width:150px">
                         <h:option value="1" label="1"/>
                         <h:option value="2" label="2"/>
                         <h:option value="3" label="3"/>
                         <h:option value="4" label="4"/>
                         <h:option value="5" label="5"/>
                  </h:select>
                  </td>
            <td class="td_2">&nbsp;</td>
            <td class="td_2">&nbsp;</td>
          </tr>
        </table>
        <p></p>
        <div class="xz_title"><fmt:message key='data_source'/></div>
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='select_data_source'/></td>
            <td class="td_2">
                <h:select property="bean/data_source" id="data_source" name="data_source" disabled="true" style="width:150px">
                         <h:option value="1" label="公式"/>
                         <h:option value="2" label="固定值"/>
                         <h:option value="3" label="输入"/>
                         <h:option value="4" label="上月项目"/>
                         <h:option value="5" label="合同数据"/>
                  </h:select>
            </td>
            <td class="td_1"><fmt:message key='source_item'/></td>
            <td class="td_2"><input name="source_item" type="text" class="sText" disabled="disabled" id="source_item" value="${bean.source_item}"/></td>
            <td class="td_1"><fmt:message key='before_month_data'/></td>
            <td class="td_2"><r:comboSelect id="source_item_updata" 
                       queryAction="SaleryitemAction.do?cmd=findAllSaleryItem"
                       textField="sa_item_name"
                       valueField="id"
                       xpath="SaleryitemVo"
                       width="150px"
                       messagekey="please_select"  value="${bean.source_item_updata}" disabled="true"/>
                       </td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='show_formula'/></td>
            <td colspan="5" class="td_2"><textarea name="formula" rows="3" disabled="disabled" class="xText_d" id="formula">${bean.formula}</textarea></td>
          </tr>
        </table>
        <p></p>
        <div class="xz_title"><fmt:message key='before_month_data'/><fmt:message key='other_options'/></div>
      <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1"><fmt:message key='is_bonus'/></td>
            <td width="15%" class="td_2"><span >
             <c:choose>
                 <c:when test="${bean.is_bonus=='1'}">
                     <input type="checkbox" name="is_bonus" id="is_bonus" checked="checked" value="1">
                </c:when>
                 <c:otherwise><input type="checkbox" name="is_bonus" id="is_bonus"  value="1"></c:otherwise>
            </c:choose>
            </span></td>
            <td class="td_1"><fmt:message key='bonus_months_bd'/></td>
            <td class="td_2">
            <c:choose>
                 <c:when test="${bean.is_bonus=='1'}">
                     <d:select dictTypeId="BONUS_MONTHS_BD" name="bonus_months_bd" disabled="true"  property="bean/bonus_months_bd" id="bonus_months_bd"  style="width:190px" />
                </c:when>
                 <c:otherwise>
                        <d:select dictTypeId="BONUS_MONTHS_BD" name="bonus_months_bd" disabled="true"  property="bean/bonus_months_bd" id="bonus_months_bd" nullLabel="--请选择--"  style="width:190px" />
                </c:otherwise>
            </c:choose>
            </td>
            <td class="td_1"><fmt:message key='is_labor'/></td>
            <td width="15%" class="td_2"><span >
               <c:choose>
                    <c:when test="${bean.is_labor == '1'}"> <input type="checkbox" name="is_labor" id="is_labor" checked="checked" value="1"></c:when>
                    <c:otherwise> <input type="checkbox" name="is_labor" id="is_labor" value="1"></c:otherwise>
                </c:choose>
            </span></td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='is_display'/></td>
            <td class="td_2"><span >
              <c:choose>
                    <c:when test="${bean.is_display == '1'}"><input name="is_display" id="is_display" type="checkbox"  value="1" checked="checked"></c:when>
                    <c:otherwise><input name="is_display" id="is_display" type="checkbox" value="1" ></c:otherwise>
                </c:choose>
            </span></td>
            <td class="td_1"><fmt:message key='is_valid'/></td>
            <td class="td_2"><span >
              <c:choose>
                <c:when test="${bean.is_valid == '1'}"><input type="checkbox" name="is_valid" id="is_valid" checked="checked" value="1"></c:when>
                <c:otherwise><input type="checkbox" name="is_valid" id="is_valid" value="1"></c:otherwise>
            </c:choose>
            </span></td>
            <td class="td_1"><fmt:message key='item_cost_group'/></td>
            <td class="td_2">
                <d:select id="dselect1" dictTypeId="ITEM_COST_GROUP" nullLabel="-请选择-" value="${bean.item_cost_group}" disabled="true"/>
            </td>
          </tr>
          <tr>
            <td class="td_1"><fmt:message key='compute_level'/></td>
            <td class="td_2"><span >
                <h:select property="bean/compute_level" id="compute_level" disabled="true" name="compute_level" style="width:150px">
                         <h:option value="" label="未设置"/>
                         <h:option value="1" label="一级"/>
                         <h:option value="2" label="二级"/>
                         <h:option value="3" label="三级"/>
                         <h:option value="4" label="四级"/>
                         <h:option value="5" label="五级"/>
                  </h:select>
            </span></td>
           
            <td class="td_1">&nbsp;</td>
            <td class="td_2" colspan="3">&nbsp;</td>
          </tr>
        </table>
        <p></p>
          <div class="foot_button">
          <input type="button" class="foot_icon_1" value="<fmt:message key='button_back'/>" onclick="location.href='javascript:history.go(-1);'"/> 
        </div>
    </div>
</div>
</form>
</fmt:bundle>
</body>
</html>
