<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
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
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
    
    function ClickRow(reg){
        $id("city_id").value = reg;
    }
    
    function simpleQuery_onClick(){  //简单的模糊查询
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
    function toAdd_onClick() {  //到增加记录页面
           $id("datacell1").addRow(); 
    }
    
    function deleteMulti_onClick(){ 
        $id("datacell1").deleteRow();
    }
    
    function toSave_onClick() {
        $id("datacell1").isModefied = true;
        var v_datacell = $id("datacell1").dataset;
        var len1 = v_datacell.getLength();
        for(var i =0 ; i < len1 ; i++){
            var city_code=v_datacell.get(i).getProperty("city_code");
            var city_name=v_datacell.get(i).getProperty("city_name");
            if(city_code==null||city_code==""){
                alert("城市编码不能为空！");
                return;
            }
            if(city_name==null||city_name==""){
                alert("城市名称不能为空！");
                return;
            }
        }
         if($id("datacell1").submit()){
           alert("保存成功！");
           $id("datacell1").loadData();
           $id("datacell1").refresh();
        }
    }
    
    function detail_onClick(){
        var city_id = document.getElementById("city_id").value;
        if(city_id == null || city_id == ""){
            alert("请选择一条记录！");
            return;
        }
        showModalCenter('<%=request.getContextPath()%>/PB_CITYAction.do?cmd=detail&id='+city_id,window,'',850,300,"城市详细页面");
    }
    
</script>
</head>
<body>

<form name="form" method="post" id="cityFormId">
<input type="hidden" id="city_id" name="city_id" value="" /> 
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('城市管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
            <td width="175" rowspan="10" style="padding-top: 0;">
            <div class="search_title">查询条件</div>
            </td>
        </tr>
		<tr>
			<td align="right">城市编码</td>
			<td align="left">
				 <input type="text" class="text_field" name="city_code1" inputName="城市编码" value="" maxLength="20"/>
			</td>
			<td align="right">城市</td>
			<td align="left">
			     <r:comboSelect id="city_idList_search" name="city_id1"
                       queryAction="PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择" />
			</td>
		</tr>
		<tr>
			<td align="right">英文名</td>
			<td align="left">
				<input type="text" class="text_field" name="city_english_name1" inputName="英文名" maxLength="50"/>
			</td>
			<td align="right"></td>
			<td align="left">
			     <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                 <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
			</td>
			<td align="right"></td>
		</tr>
    </table>
</div>
					
<div id="ccParent1" class="button"> 
    <div class="button_right">
		<ul>
			<li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
			<li class="c">  	<a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
			<li class="d">  	<a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
			<li class="bc">  	<a  onClick="javascript:toSave_onClick();">保存 </a> </li>
		</ul>
	 </div>
     <div class="clear"></div>			
</div>

<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/PB_CITYAction.do?cmd=searchCityData"
        submitAction="/FAERP/PB_CITYAction.do?cmd=updateCityData"
        width="98%"
        height="302px"
        xpath="PB_CITYVo"
        submitXpath="PB_CITYVo"
        paramFormId="cityFormId"
        >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
          </r:field>
          <r:field fieldName="city_code" label="城市编码" width="150px">
            <h:text/>
          </r:field>
          <r:field fieldName="city_name" label="城市名称" width="150px">
               <h:text/>   
           </r:field>    
          <r:field fieldName="city_english_name" label="英文名" width="150px">
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
