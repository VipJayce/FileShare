<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>


<fmt:bundle basename="rayoo.employeepost.eppartycomponent.eppartycomponent_resource" prefix="rayoo.employeepost.eppartycomponent.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    jQuery(function(){
        $id("datacell2").isQueryFirst = false;
    });
    
	function simpleQuery_onClick(){  //简单的模糊查询
       $id("datacell1").loadData();
       $id("datacell1").refresh();
  	}
  	
  	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio' name='checkbox_template' onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
    
    function ClickRow(id){
        $id("comp_id").value = id;
        $id("datacell2").addParam("ids",id);

        $id("datacell2").loadData();
        $id("datacell2").refresh();
    }
  	
  	 function findCheckbox_onClick() {  //到修改记录页面
  	     var comp_id = document.getElementById("comp_id").value;
  	     if(comp_id==null || comp_id==""){
  	         alert("<fmt:message key="select_one_record"/>");
  	         return;
  	     }
         var url="<%=request.getContextPath()%>/EppartycomponentAction.do?cmd=find&id=" +comp_id;
         window.open(url,'','height=400px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改党支部信息');
        //showModalCenter(url, window,toaddrollback,750,350,"修改党部信息");
    }
    
	function toAdd_onClick() {  //到增加记录页面
            var url="<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartycomponent/insertEppartycomponent.jsp";
             window.open(url,'','height=400px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=添加党支部');
             //showModalCenter(url, window,toaddrollback,750,350,"添加党支部");
	}
	
	function toaddrollback(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
	
	function deleteMulti_onClick(){
	    var comp_id = document.getElementById("comp_id").value;
         if(comp_id==null || comp_id==""){
             alert("<fmt:message key="select_one_record"/>");
             return;
         }
	   if(!getConfirm("<fmt:message key="sure_to_delete"/>")) {  //如果用户在确认对话框中点"取消"
            return false;
        }
         jQuery.getJSON("<venus:base/>/EppartymemerAction.do?cmd=findemp&date="+new Date()+"",{"ids":comp_id},function(json){
	          if(json.count==0){
                  $id("datacell_formid").action="<%=request.getContextPath()%>/EppartycomponentAction.do?cmd=deleteMulti&ids=" + comp_id;
                  $id("datacell_formid").submit();
	          }else{
	              alert("<fmt:message key="can_not_delete"/>");
	              return;
	          }
	      });
	}
	
     function exportExcel_onClick(){  //导出Excel
        var comp_id = document.getElementById("comp_id").value;
         if(comp_id==null || comp_id==""){
             alert("<fmt:message key="select_one_record"/>");
             return;
         }
        $id("datacell_formid").action="<%=request.getContextPath()%>/EppartycomponentAction.do?cmd=exportExcel&ids="+comp_id ;
        $id("datacell_formid").submit();
    }  
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
 <input type="hidden" id ="comp_id" name="comp_id" value=""/>
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('<fmt:message key="branch_info_maintain"/>','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
            <td width="175" rowspan="10" style="padding-top: 0;">
            <div class="search_title"><fmt:message key="query_condition"/></div>
            </td>
        </tr>
	  <tr>
			<td align="right"><fmt:message key="party_name1"/></td>
			<td align="left">
				<input type="text" class="text_field" name="party_name1" inputName="党总支名称" maxLength="50"/>
			</td>
			<td align="right"><fmt:message key="party_comp_name1"/></td>
			<td align="left">
				<input type="text" class="text_field" name="party_comp_name1" inputName="党支部名称" maxLength="50"/>
			</td>
	   </tr>
	   <tr>
			<td align="right"><fmt:message key="party_comp_code1"/></td>
			<td align="left">
				<input type="text" class="text_field" name="party_comp_code1" inputName="编号" maxLength="50"/>
			</td>
			<td align="right"></td>
            <td align="left">
				<input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
			    <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
            </td>
        </tr>
</table>
</div>
					
<div id="ccParent1" class="button"> 
    <div class="button_right">
				<!--<ul>
					<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b">  	<a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
				</ul>
		 -->
		  <input type="button" class="c" value='<fmt:message key="insert"/>'   <au:authorityBtn code="dzbxxwh_add" type="1"/>  onClick="toAdd_onClick();" />
		   <input type="button" class="d" value='<fmt:message key="delete"/>'   <au:authorityBtn code="dzbxxwh_del" type="1"/>  onClick="deleteMulti_onClick();" />
		    <input type="button" class="b" value='<fmt:message key="modify"/>'   <au:authorityBtn code="dzbxxwh_modify" type="1"/>  onClick="findCheckbox_onClick();" />
		 </div>
         <div class="clear"></div>			
</div>
 <div style="padding: 8 10 8 8;">
 <r:datacell 
        id="datacell1"
       queryAction="/FAERP/EppartycomponentAction.do?cmd=simpleQuery"
        width="98%"
        height="305px"
        xpath="EppartycomponentVo"
        paramFormId="datacell_formid"
        readonly="true"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="cid"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
       <r:field fieldName="party_comp_code" width="150px" messagekey="party_comp_code1">
        <h:text/>
       </r:field>    
       <r:field fieldName="party_name" width="180px" messagekey="party_name1" >
        <h:text/>
       </r:field>    
       <r:field fieldName="party_comp_name" width="180px" messagekey="party_comp_name1" >
        <h:text/>
       </r:field>    
      <r:field fieldName="contact" width="180px" messagekey="contact" >
        <h:text/>
       </r:field>    
       <r:field fieldName="contact_number" width="180px" messagekey="contact_number" >
        <h:text/>
       </r:field>    
       <r:field fieldName="re_desc" width="225px" messagekey="re_desc" >
        <h:text/>
       </r:field>   
     
    </r:datacell>
    </div>
 <!-- 党支部成员列表 -->
 <div id="ccParent1" class="button"> 
 <div class="button_right"><!--
                <ul>
                    <li class="e">      <a  onClick="javascript:exportExcel_onClick();"><fmt:message key="export"/> </a> </li>
                </ul>
         -->
          <input type="button" class="e" value='<fmt:message key="export"/>'   <au:authorityBtn code="dzbxxwh_exp" type="1"/>  onClick="exportExcel_onClick();" />
         </div>
           <div class="clear"></div>            
</div>
 <div style="padding: 8 5 8 8;">
 <r:datacell 
        id="datacell2"
       queryAction="/FAERP/EppartycomponentAction.do?cmd=findemp"
        width="98%"
        height="305px"
        xpath="EppartyEmployeeVo"
        paramFormId="datacell_formid"
        readonly="true"
        pageSize="-1"
        >
       <r:field fieldName="party_comp_name" width="200px" messagekey="">
        <h:text/>
       </r:field>    
       <r:field fieldName="emp_name" width="100px" messagekey="emp_name">
        <h:text/>
       </r:field>        
       <r:field fieldName="emp_sex" width="50px" messagekey="sex">
        <d:select dictTypeId="EMP_SEX" />
       </r:field>    
       <r:field fieldName="nationality" width="50px" messagekey="nationality" >
        <h:text/>
       </r:field>    
       <r:field fieldName="birth_date" width="100px" messagekey="birth_day">
           <w:date format="yyyy-MM-dd" />
       </r:field>    
      <r:field fieldName="education_bd" width="100px" messagekey="education_bd" >
        <d:select dictTypeId="EDUCATION_BD" />
       </r:field>    
        <r:field fieldName="in_date" width="100px" messagekey="in_date">
            <w:date format="yyyy-MM-dd" />
       </r:field> 
        <r:field fieldName="end_date" width="100px" messagekey="end_date">
            <h:text/>
       </r:field> 
       <r:field fieldName="address" width="200px" messagekey="address" >
        <h:text/>
       </r:field> 
       <r:field fieldName="email" width="100px" messagekey="email" >
        <h:text/>
       </r:field>   
       <r:field fieldName="tel" width="100px" messagekey="tel" >
        <h:text/>
       </r:field>   
    </r:datacell>
 <!-- 党支部成员列表完成 -->
 </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>