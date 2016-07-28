<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="rayoo.employeepost.eppartyact.eppartyact_resource" prefix="rayoo.employeepost.eppartyact.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    jQuery(function(){
        $id("datacell2").isQueryFirst = false;
    });
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
    
    function ClickRow(reg){
        $id("act_id").value = reg;
        if(reg!=null && reg!=""){
	        $id("datacell2").addParam("act_id",reg);
	        $id("datacell2").loadData();
	        $id("datacell2").refresh();
        }
    }
    
    function simpleQuery(){  //简单的模糊查询
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
    function toAdd_onClick() {  //到增加记录页面
           $id("datacell1").addRow(); 
    }
    
    function deleteMulti_onClick(){ 
        $id("datacell1").deleteRow();
        checkAll();
        var element = document.getElementsByName("checkbox_template");
        var l = element.length;
        for(var i=0;i< l;i++){
            $id("datacell2").deleteRow(0);
        } 
    }
    
    function toSave_onClick() {
        $id("datacell1").isModefied = true;
        $id("datacell2").isModefied = true;
        
        var v_datacell = $id("datacell1").dataset;
        var len1 = v_datacell.getLength();
        for(var i =0 ; i < len1 ; i++){
            var act_date=v_datacell.get(i).getProperty("act_date");
            var act_type=v_datacell.get(i).getProperty("act_type");
            if(act_date==null||act_date==""){
                alert("<fmt:message key="act_date_not_null"/>");
                return;
            }
            if(act_type==null||act_type==""){
                alert("<fmt:message key="act_type_not_null"/>");
                return;
            }
        }
         if($id("datacell1").submit()&&$id("datacell2").submit()){
           alert("<fmt:message key="save_succese"/>");
           $id("datacell1").loadData();
           $id("datacell1").refresh();
           $id("datacell2").loadData();
           $id("datacell2").refresh();
        }
    }
    
    function setCheckboxStatus1(value,entity,rowNo,cellNo){
       return "<input type='checkbox' value='"+ entity.getProperty("id")+"' rowNo='"+ rowNo+"' name='checkbox_template' >";
    }
    
    function toAddMemer_onClick(){
        var entity = $id("datacell1").activeEntity;
        if(entity == undefined){
            alert("<fmt:message key="please_choose_one_party_act"/>");
            return;
        }
        if(entity.getProperty("id")==null || entity.getProperty("id")==""){
            alert("<fmt:message key="please_save_add_party_act"/>");
            return;
        }
        var act_id = document.getElementById("act_id").value;
        if(act_id!=null && act_id!=""){
            var url="<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyact/partymem.jsp?act_id="+act_id;
            window.open(url,'','height=477px,width=700px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=添加参加人员');
            //showModalCenter(url, window,toFindMemer,800,447,"添加参加人员");
        }else{
            alert("<fmt:message key="please_choose_one_party_act"/>");
            return;
        }
    }
    
    function toFindMemer(reg){
        $id("datacell2").addParam("act_id",reg);
        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
    
    function findSelections(checkboxName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName("checkbox_template");  //通过name取出所有的checkbox
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
    
    function deleteMultiMemer_onClick(){
         var ids = findSelections("checkbox_template");
          if(ids == null || ids == ""){
            alert("<fmt:message key="please_choose_need_delete_emp"/>");
            return;
          }
          for (var j=0;j<ids.length;j++){
            var ent1 = $id("datacell2").dataset.findEntity("id", ids[j]);
            $id("datacell2").dataset.removeEntity(ent1);
          }
          $id("datacell2").isModefied = true;
          if($id("datacell2").submit()){
            alert("<fmt:message key="delete_seccuse"/>");
          }
    }
    
   function checkAll(){
        var element = document.getElementsByTagName("input");
        for(var i=0;i<element.length;i++){
           if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
               element[i].checked= !element[i].checked ? true : false;
           }
       } 
    }
    
    function returnFunc(args){
        var datacell = $id("datacell1");
        var row = datacell.getActiveRow();
        var entity = datacell.getEntity(row);
        var lookup = $id("host");
        lookup.value = args[0];
        lookup.displayValue = args[1];
        entity.setProperty("host_user_id", args[0]);
        entity.setProperty("countact_way", args[2]);
        datacell.refreshRow(row);
        return false;
    }
    
    function exportToExcel(){
        var entity = $id("datacell1").activeEntity;
        if(entity == undefined){
            alert("<fmt:message key="please_choose_one_party_act"/>");
            return;
        }
        var act_id = document.getElementById("act_id").value;
        if(act_id!=null && act_id!=""){
	        $id("datacell_formid").action="<%=request.getContextPath()%>/EppartyactitemAction.do?cmd=eppartyactitemExport&act_id="+act_id;
	        $id("datacell_formid").submit();
        }else{ 
            alert("<fmt:message key="please_choose_one_party_act"/>");
            return;
        }
    }
    
    function importToExcel() {  
        var entity = $id("datacell1").activeEntity;
        if(entity == undefined){
            alert("<fmt:message key="please_choose_one_need_imp_act"/>");
            return;
        }
        var act_id = document.getElementById("act_id").value;
        if(act_id!=null && act_id!=""){
            var url="<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyact/importExcel.jsp?act_id="+act_id;
            showModalCenter(url, window,toFindMemer,750,200,"从excel导入参加人员");
        }else{ 
            alert("<fmt:message key="please_choose_one_need_imp_act"/>");
            return;
        }
  }
    

</script>
</head>
<body>

<form id="datacell_formid" name="form" method="post" action="<%=request.getContextPath()%>/EppartyactAction.do">
<input type="hidden" id="act_id" name="act_id" value="" /> 
 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="lectures_party_maintenance_act"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="174" rowspan="10" style="padding-top: 0;">
            <div class="search_title"><fmt:message key="query_condition"/></div>
        </tr>
        <tr>
            <td align="right"><fmt:message key="act_name"/>&nbsp;&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" id="act_name1" name="act_name1" inputName="活动名称" maxLength="50"/>
             </td>
             <td align="right"><fmt:message key="act_type"/>&nbsp;&nbsp;</td>
             <td align="left">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("party_act_type1", -1,"PARTY_ACT_TYPE", "", "", false) %>
            </td>
             <td align="right">
             </td>
             <td align="left">
                  <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery();">
                  <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
            </td>
             <td align="right"></td>
             <td align="left"></td>
             <td align="right"></td>
             <td align="left"></td>
        </tr>
</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="c">      <a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="bc">      <a  onClick="javascript:toSave_onClick();">保存</a> </li>
                </ul>
         -->
           <input type="button" class="c" value='<fmt:message key="insert"/>'   <au:authorityBtn code="dkhd_add1" type="1"/>  onClick="toAdd_onClick();" />
             <input type="button" class="d" value='<fmt:message key="delete"/>'   <au:authorityBtn code="dkhd_del1" type="1"/>  onClick="deleteMulti_onClick();" />
               <input type="button" class="bc_1" value='<fmt:message key="save"/>'   <au:authorityBtn code="dkhd_save1" type="1"/>  onClick="toSave_onClick();" />
               <span style="color: red;"><fmt:message key="notice"/></span>
         </div>
         
           <div class="clear"></div>            
           
</div>

 <div style="padding: 8 5 8 8;">
      <r:datacell 
        id="datacell1"
       queryAction="/FAERP/EppartyactAction.do?cmd=queryAll"
       submitAction="/FAERP/EppartyactAction.do?cmd=insert"
        width="98%"
        xpath="EppartyactVo"
        submitXpath="EppartyactVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
      <r:field fieldName="act_name" width="200px" messagekey="act_name" >
       <h:text validateAttr="allowNull=false;"/>
       </r:field>    
      <r:field fieldName="act_type" width="120px" messagekey="act_type" >
       <d:select dictTypeId="PARTY_ACT_TYPE"/>
      </r:field>
      <r:field fieldName="act_date" width="120px" messagekey="act_time">
        <w:date format="yyyy-MM-dd" allowNull="false"/>
      </r:field>
      <r:field fieldName="act_address" width="120px" messagekey="act_address">
       <h:text/>
      </r:field>
      <r:field fieldName="host_user" width="120px" messagekey="host_user">
      <h:text/>
      </r:field>
      <r:field fieldName="countact_way" width="150px" messagekey="contact_number">
       <h:text/>
      </r:field>
      <r:field fieldName="remarks" width="265px" messagekey="re_desc">
       <h:text/>
      </r:field>
    </r:datacell>
</div>

<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="c">      <a onClick="javascript:toAddMemer_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d">      <a  onClick="javascript:deleteMultiMemer_onClick();"><fmt:message key="delete"/> </a> </li>
                    <li class="e">    <a  onClick="javascript:exportToExcel();">导出</a> </li>
                    <li class="e_1">    <a  onClick="javascript:importToExcel();">导入</a> </li>
                </ul>
         -->
             <input type="button" class="c" value='<fmt:message key="insert"/>'   <au:authorityBtn code="dkhd_add2" type="1"/>  onClick="toAddMemer_onClick();" />
             <input type="button" class="d" value='<fmt:message key="delete"/>'   <au:authorityBtn code="dkhd_del2" type="1"/>  onClick="deleteMultiMemer_onClick();" />
             <input type="button" class="e" value='<fmt:message key="export"/>'   <au:authorityBtn code="dkhd_exp" type="1"/>  onClick="exportToExcel();" />
             <input type="button" class="e_1" value='<fmt:message key="import"/>'   <au:authorityBtn code="dkhd_imp" type="1"/>  onClick="importToExcel();" />
         </div>
         
           <div class="clear"></div>            
           
</div>

<div>
 <div style="padding: 8 5 8 8;">
    <r:datacell 
        id="datacell2"
       queryAction="/FAERP/EppartyactitemAction.do?cmd=getActItemPartyMember"
       submitAction="/FAERP/EppartyactitemAction.do?cmd=update"
        width="98%"
        height="320px"
        xpath="EppartyactitemVo"
        submitXpath="EppartyactitemVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id"  label="<input type='checkbox' name='checkall' value='' onclick='checkAll(this);' />" width="50px" onRefreshFunc="setCheckboxStatus1" align="center">
       </r:field>   
       <h:hidden id="party_comp_code" />
       <r:field fieldName="party_name" width="200px" messagekey="party_name2">
       </r:field> 
       <r:field fieldName="party_comp_name" width="200px" messagekey="party_comp_name2">
       </r:field> 
       <r:field fieldName="emp_name" width="100px" messagekey="emp_name">
       </r:field>   
       <r:field fieldName="emp_sex" width="40px" messagekey="sex" allowModify="false">
        <d:select dictTypeId="EMP_SEX" />
       </r:field>   
       <r:field fieldName="nationality" width="40px" messagekey="nationality">
       </r:field>   
       <r:field fieldName="birth_date" width="100px" messagekey="birth_day" allowModify="false">
         <w:date format="yyyy-MM-dd" />
       </r:field>   
       <r:field fieldName="education_bd" width="70px" messagekey="education_bd" allowModify="false">
        <d:select dictTypeId="EDUCATION_BD" />
       </r:field>   
       <r:field fieldName="in_date" width="100px" messagekey="in_date" allowModify="false">
        <w:date format="yyyy-MM-dd" />
       </r:field>   
       <r:field fieldName="address" width="250px" messagekey="address">
       </r:field>   
       <r:field fieldName="email" width="100px" messagekey="email">
       </r:field>   
       <r:field fieldName="tel" width="100px" messagekey="tel">
       </r:field>    

    </r:datacell>
 
</div>
</div>
</div>
</form>

</fmt:bundle>

</body>
</html>
<script type="text/javascript">
//初始化不加载页面信息<siqp添加>
jQuery(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>
