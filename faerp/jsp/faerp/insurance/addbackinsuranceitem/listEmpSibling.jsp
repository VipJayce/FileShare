<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>

<script language="javascript">
  //执行查询
function qry(){
    $id("dc_empsiblingid").reload();
}
//
function doChoose(){
    dc = $id("dc_empsiblingid");
    clz = dc.getActiveEntity();
    clzid = clz.getValue("id");
    clzname = clz.getValue("sib_name");
    var rtn = new Array();
    rtn[0] = clzid;
    rtn[1] = clzname;
    window.returnValue = rtn;
    window.close();
}  
</script>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/AddbackinsuranceitemAction.do">
<input name="emp_id_s" id="emp_id_s" type="hidden" value="<%=request.getParameter("emp_id") %>"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">附险人选择</div></div>
    <div class="ringht_s">
    <div class="button_salary">
            <div class="button_right">
              <ul>
                <li class="bc"><a onclick="doChoose()">选择</a></li>
              </ul>
            </div>
            <div class="clear"></div>
          </div>  
    <!--查询 -->
  <div class="search">
  </div>
     <div style="padding: 8 10 8 8;">
        <r:datacell id="dc_empsiblingid"
            queryAction="/FAERP/AddbackinsuranceitemAction.do?cmd=seachEmpSibling"
            submitAction="/FAERP/AddbackinsuranceitemAction.do?cmd=update"
            width="98%" xpath="EmpSiblingVo" submitXpath="EmpSiblingVo"
            pageSize="100"
            paramFormId="datacell_formid" height="340px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="sib_name" label="亲属姓名" width="160px">
            </r:field>
            <r:field fieldName="sib_relation" label="亲属关系" width="160px">
            <d:select dictTypeId="SIB_RELATION" disabled="true"/>
            </r:field>
            <r:field fieldName="sib_id_card_num" label="证件号码" width="160px">
            </r:field>
            <r:field fieldName="sib_id_card_type_bd" label="证件类型" width="160px">
               <d:select dictTypeId="ID_CARD_TYPE_BD" disabled="true"/>
            </r:field>
            <r:field fieldName="sib_sex_bd" label="性别" width="160px">
            <h:select property="sib_sex_bd" disabled="true">
                         <h:option value="1" label="男"/>
                         <h:option value="0" label="女"/>
                  </h:select>
            </r:field>
            <r:field fieldName="sib_birthday" label="出生日期" width="160px">
            <w:date format="yyyy-MM-dd" name="" disabled="true"/> 
            </r:field>
            <r:field fieldName="sib_desc" label="备注" width="160px">
            </r:field>
        </r:datacell>
</div>
    </div>
</div>
</form>
</fmt:bundle>
</body>
</html>

<script language="javascript">
</script>	
