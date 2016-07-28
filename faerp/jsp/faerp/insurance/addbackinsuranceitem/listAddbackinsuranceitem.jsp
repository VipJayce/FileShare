<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>

<script language="javascript">
    function toUpdate_onclick(){
        $id("dc_salaeyitemid").submit() ;
    }
    function toDelete_onclick(){
        $id("dc_salaeyitemid").deleteRow() ;
    }
    function toInsert_onclick() {
    var emp_id = $id("emp_id").value ;
        var url="<%=request.getContextPath()%>/jsp/faerp/insurance/addbackinsuranceitem/listEmpSibling.jsp?emp_id="+emp_id ;
        showModalCenter(url, window,toaddEmpSiblinglistrollback,810,510,"添加付险人");
    }
    
    function toaddEmpSiblinglistrollback(obj)
    {
      if(checkpageEmpSibling(obj)){
        jQuery.getJSON("<venus:base/>/AddbackinsuranceitemAction.do?cmd=addEmpSibling&empsibling_id="+obj[0],function(json){
              if(json.bean!=null&&json.bean!="")
              {              
                       var newEntity =  $id("dc_salaeyitemid").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("chil_name", json.bean.sib_name);
                       newEntity.setProperty("chil_sex_bd", json.bean.sib_sex_bd);
                       newEntity.setProperty("chil_birthday", json.bean.sib_birthday);
                       newEntity.setProperty("chil_applicant_date", json.bean.newdate);
                       
                       $id("dc_salaeyitemid").addRow(newEntity);
              }
        });
      }
    }
     function checkpageEmpSibling(obj)
    {
       var datacell1 =  $id("dc_salaeyitemid") ;
        var num = 0 ;       
        for(var i = 0;i<datacell1.dataset.getLength();i++)
        { 
          var entity=datacell1.dataset.get(i);   
          if(entity.getProperty("chil_name") == obj[1]){
                 num++  ; 
          }
        }
        if(num >0){
            alert(obj[1]+"  已经添加，只能删除后才能添加！") ;
            return false ;
        }
        else{
            return true ;
        }
    }
    
    
</script>
</head>
<body>

<form name="datacell_formid" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/AddbackinsuranceitemAction.do">
<input name="apply_insurance_id" id="apply_insurance_id" type="hidden" value="<%=request.getParameter("apply_insurance_id") %>"/>
<input name="emp_id" id="emp_id" type="hidden" value="<%=request.getParameter("emp_id") %>"/>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">附险人</div></div>
    <div class="ringht_s">
    <!--查询 -->
  <div class="search">
    <!--<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="150" style="padding-top:0;"><div class="search_title">查询条件</div></td>
    <td width="98">子女姓名</td>
    <td width="235">
                <input name="chil_name" type="hidden" id="sc_id" />
    </td>
    <td width="71">&nbsp;</td>
    <td width="116"></td>
    <td width="432" >&nbsp;</td>
  </tr>
</table>
  --></div>
        <div class="button">
            <div class="button_right">
                <ul>
                    <li class="c"><a onclick="javascript:toInsert_onclick() ;">新增</a></li>
                    <li class="b"><a href="javascript:toUpdate_onclick() ;">保存</a></li>
                    <li class="d"><a onClick="javascript:toDelete_onclick()">作废</a></li>  
                </ul>
             </div>
            <div class="clear"></div>
        </div>
     <div style="padding: 8 10 8 8;">
        <r:datacell id="dc_salaeyitemid"
            queryAction="/FAERP/AddbackinsuranceitemAction.do?cmd=seachAddbackinsuranceitem"
            submitAction="/FAERP/AddbackinsuranceitemAction.do?cmd=insertAddbackinsuranceitem"
            width="98%" xpath="AddbackinsuranceitemVo" submitXpath="AddbackinsuranceitemVo"
            pageSize="100"
            paramFormId="datacell_formid" height="340px">

            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="chil_name" label="子女姓名" width="160px">
            </r:field>
            <r:field fieldName="chil_sex_bd" label="子女性别" width="160px">
                <h:select property="chil_sex_bd" disabled="true">
                         <h:option value="1" label="男"/>
                         <h:option value="0" label="女"/>
                  </h:select>
            </r:field>
            <r:field fieldName="chil_birthday" label="子女出生日期" width="160px">
                <w:date format="yyyy-MM-dd"  disabled="true"/> 
            </r:field>
            <r:field fieldName="chil_applicant_date" label="子女投保日期" width="160px">
                <w:date format="yyyy-MM-dd"  /> 
            </r:field>
            <!--<r:field fieldName="chil_append_item" label="子女福利附加项" width="160px">
            <h:text/>
            </r:field>-->
            <r:field fieldName="start_date" label="在保开始时间" width="160px">
                <w:date format="yyyy-MM-dd"  /> 
            </r:field>
            <r:field fieldName="end_date" label="在保结束时间" width="160px">
                <w:date format="yyyy-MM-dd"  /> 
            </r:field>
            <r:field fieldName="chil_insurance_status_bd" label="子女在保状态" width="160px">
                <h:select property="chil_insurance_status_bd" >
                         <h:option value="1" label="已在保"/>
                         <h:option value="0" label="已退保"/>
                         <h:option value="2" label="已过期"/>
                  </h:select>
            </r:field>
            <r:field fieldName="remark" label="备注" width="160px">
            <h:text/>
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
