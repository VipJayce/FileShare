<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.job_person.vo.JOB_PERSONVo" %>
<%@ page import="rayoo.job.job_person.util.IJOB_PERSONConstants" %>
<%
    //取出List
    List lResult = null; //定义结果列表的List变量
    if (request.getAttribute(IJOB_PERSONConstants.REQUEST_BEANS) != null) { //如果request中的beans不为空
        lResult = (List) request
                .getAttribute(IJOB_PERSONConstants.REQUEST_BEANS); //赋值给resultList
    }
    Iterator itLResult = null; //定义访问List变量的迭代器
    if (lResult != null) { //如果List变量不为空
        itLResult = lResult.iterator(); //赋值迭代器
    }
    JOB_PERSONVo resultVo = null; //定义一个临时的vo变量
    String user_id = request.getParameter("user_id");
%>

<%
    String position_id = request.getParameter("position_id");//职位ID
    String adviser_id = request.getParameter("user_id");//顾问ID
    String warranty = request.getParameter("warranty");//担保期
%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
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
		form.action="<%=request.getContextPath()%>/JOB_PERSONAction.do?id=" + ids;
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
	    	form.action="<%=request.getContextPath()%>/JOB_PERSONAction.do?ids=" + ids;
	    	form.cmd.value = "deleteMulti";
	    	form.submit();
		}
	}
	function simpleQuery_onClick(){  //简单的模糊查询
	    if(!checkForm($id("datacell_formid"))){
            return;
        }
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
		form.action="<%=request.getContextPath()%>/jsp/faerp/job/job_person/insertJOB_PERSON.jsp";
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
		//form.action="<%=request.getContextPath()%>/JOB_PERSONAction.do?id=" + ids;
		//form.cmd.value = "detail";
		//form.submit();
		var url = "<%=request.getContextPath()%>/JOB_PERSONAction.do?id=" + ids + "&cmd=detail";
		window.open(url,'','height=600px,width=830px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=简历详情');
		//showModalCenter(url,window,null,800,400,"查看简历信息");
	}
	
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    
    function choose()
    {
    var ids=choose_row_public("ids");
         var entities=new Array();
       dc=$id("datacell1").dataset;
       for(i=0;i<ids.length;i++){    
            entities.push(dc.findEntity("id",ids[i]));
                    }

         var datacell=window["dialogArguments"]; 
                     var dd=  datacell.dataset;
                     var insertentities=dd.getAlltEntities();
    
               if(insertentities.length!=0){
                      for(i=0;i<ids.length;i++){
                       for(j=0;j<insertentities.length;j++){
       
                       if(ids[i]==insertentities[j].getProperty("person_id")){
                              alert("不能重复添加！");
                              return;
                       }
                   
                      }

                     }
     }
     
        _jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/JobcandidateAction.do?cmd=checkCandidate&position_id=<%=position_id%>&person_id="+ids,
            dataType : "html",
            success : function(data) {
                   if(data==""){
                         //获传入的datacell对象       
                         
                        //增加空行 
                   
                         
                   for(i=0;i<entities.length;i++){
                          
                        datacell.insertEmptyRow();
                        var entity=datacell.getActiveEntity();
                        entity.setProperty("person_id",entities[i].getProperty("id"));
                        entity.setProperty("person_name",entities[i].getProperty("sname"));
                        entity.setProperty("idegree",entities[i].getProperty("IDEGREE"));
                        entity.setProperty("startwork",entities[i].getProperty("STARTWORK"));
                        entity.setProperty("sex",entities[i].getProperty("isex"));
                        entity.setProperty("ifuturewage",entities[i].getProperty("ifuturewage"));
                       entity.setProperty("position_id","<%=position_id%>");//职位ID
                        entity.setProperty("adviser_id","<%=adviser_id%>");//顾问ID
                        entity.setProperty("warranty","<%=warranty%>");//担保期
                        datacell.endEdit();  
                        //datacell.reload();
                        //datacell.refresh();
                   }
                   window.close();  
                   }else{
                        alert(data);
                        return ;
                   }
              }
            });
    
         //window.close();  
   }
   
   
    function choose_row_public(){
  
    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项 
        if(!ids){
           alert("请选择一条记录！");
           return;
        }
   return ids;
    }
        function winclose(){
     
        window.close();
    }
    //简历同步
    function syn_onClick(){
    	showProgressBar('syn_progBarId','<h1>请等待……</h1>');
    	var action = "<%=request.getContextPath()%>/JOB_PERSONAction.do?cmd=synResume";
    	var myAjax = new Ajax(action);
    	myAjax.submit("UTF-8");
    	var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue")) {
                      alert( '保存成功！\n' +myAjax.getValue("root/data/returnValue"));
                  	  hideProgressBar('syn_progBarId');
                  } 
                  else {
                      alert( '保存失败！' ); 
                      hideProgressBar('syn_progBarId');
                  }
         }
    }
    
//关联职位
function relevance_position(){
    var ids=choose_row_public("ids");
     var entities=new Array();
       dc=$id("datacell1").dataset;
       for(i=0;i<ids.length;i++){    
            entities.push(dc.findEntity("id",ids[i]));
       }
    var url = "<%=request.getContextPath()%>/JobcandidateAction.do?cmd=queryAll&source=relevance_position";
    //window.open(url,'','height=400px,width=750px,top=100,left=200,help=no,toolbar=no,menubar=no,resizable=yes,scrollbars=no,location=no,status=not,title=关联职位');
    showModalCenter(url,entities,rtnRelevance_position,980,660,"关联职位");
}

//关联职位的回调函数
function rtnRelevance_position(position_id){
    var ids=choose_row_public("ids");
     var entities=new Array();
     dc=$id("datacell1").dataset;
     for(i=0;i<ids.length;i++){    
        entities.push(dc.findEntity("id",ids[i]));
     }
        _jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/JobcandidateAction.do?cmd=relevance_position&position_id="+position_id+"&person_id="+ids,
            dataType : "html",
            success : function(data) {
                   if(data==""){
                    alert("候选人添加成功！");
                   window.close();  
                   }else{
                        alert(data);
                        return ;
                   }
              }
            });
}

//设置查询条件
function condition_setup(){

/*
	var ids=choose_row_public("ids");
     var entities=new Array();
       dc=$id("datacell1").dataset;
       for(i=0;i<ids.length;i++){    
            entities.push(dc.findEntity("id",ids[i]));
       }
    var url = "<%=request.getContextPath()%>/JobcandidateAction.do?cmd=queryAll&source=relevance_position";
    //window.open(url,'','height=400px,width=750px,top=100,left=200,help=no,toolbar=no,menubar=no,resizable=yes,scrollbars=no,location=no,status=not,title=关联职位');
    showModalCenter(url,entities,rtnRelevance_position,980,660,"关联职位");
    */
    var entities=new Array();
    
    
    var url = "<%=request.getContextPath()%>/Job_ps_search_condition_setupAction.do?cmd=tosearch_condition_setup";
    showModalCenter(url,entities,condition_setup_over,700,500,"设置查询条件");
    
    
}

function condition_setup_over(returnVal){
	if(returnVal == 'cancel'){
		return;
	}
	_jQuery("#selected_conditions_code").val(returnVal);
	
	hide_search_condition();
	
	show_search_condition();

}
var show_all = false;
_jQuery(document).ready(function(){
	if(show_all==true){
		show_search_condition();
		_jQuery("#setup_button").show();
	}else {
		_jQuery(".float_left").show();
		_jQuery("#setup_button").hide();
	}
	
});

function show_search_condition(){
	var conditions = _jQuery("#selected_conditions_code").val();
	//alert(conditions);
	var condition_codes = conditions.split(",");
	for(var i = 0 ; i< condition_codes.length; i++){
		var code = condition_codes[i];
		_jQuery("[name=sc_show_"+ code +"]").show();
	}
	
}
function hide_search_condition(){
	var conditions = _jQuery("#all_conditions_code").val();
	//alert(conditions);
	var condition_codes = conditions.split(",");
	for(var i = 0 ; i< condition_codes.length; i++){
		var code = condition_codes[i];
		_jQuery("[name=sc_show_"+ code +"]").hide();
	}
	
}
</script>

<style> 
/**div{ display:inline} */

.float_left{
	float:left;
	/*display:inline;*/
	width:110px;
	padding-left: 5px;
	padding-top: 5px;
	display: none;
	}
.search_title_name{
	
}
</style> 

</head>
<body>
<h:form checkType="blur" name="form" method="post" id="datacell_formid" >
<input type="hidden"  id="selected_conditions_code" name="selected_conditions_code"  value="${selected_conditions_code }"/>
<input type="hidden"  id="all_conditions_code" name="all_conditions_code" value="${all_conditions_code }"/>
<input type="hidden"  name="cmd" value="queryAll"/>
<input type="hidden" name="backFlag" id="backFlag" value="true" />
<div id="right">
<script language="javascript">
	writeTableTopFesco('简历管理','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="100px;" rowspan="9" style="padding-top:0;"><div class="search_title">查询条件</div> 
			</td>
		</tr>
		<tr>
			<td width="1000px" height="" rowspan="9" >
				
				
				
				
				
				
				
				
				
				<div   name="sc_show_key_word" class="float_left"  align="right" >关键字</div>
				<div   name="sc_show_key_word" class="float_left"  align="left">
					<h:text id="key_word" style="width=200px" name="key_word" value="" />
				</div>
				<div   name="sc_show_sex" class="float_left"  align="right">性别</div>
				<div   name="sc_show_sex" class="float_left"  align="left">
					<%=gap.rm.tools.helper.RmJspHelper.getSelectField("sex", -1,
								"YINGRUI_SEX", "", "", false)%> 
				</div>
				<div   name="sc_show_person_name" class="float_left"  align="right">姓名</div>
				<div   name="sc_show_person_name" class="float_left"  align="left">
					<h:text style="width=200px"  id="person_name"  name="person_name" value="" />
				</div>
			
			
				<div   name="sc_show_age" class="float_left"  align="right">年龄</div>
				<div   name="sc_show_age" class="float_left"  align="left">
					<h:text id="age" style="width=200px" name="age" value="" validateAttr="type=naturalNumber;message=必须输入数字;allowNull=true" />
				</div>
				<div   name="sc_show_postion_now" class="float_left"  align="right">现任职务</div>
				<div   name="sc_show_postion_now" class="float_left"  align="left">
					 <h:text style="width=200px"  id="postion_now"  name="postion_now" value="" />
				</div>
				<div   name="sc_show_salary" class="float_left"  align="right">目前月薪</div>
				<div   name="sc_show_salary" class="float_left"  align="left">
					<h:text style="width=200px"  id="salary"  name="salary" value="" />
				</div>
			
			   
				
				<div   name="sc_show_school" class="float_left"  align="right">学校名称</div>
				<div   name="sc_show_school" class="float_left"  align="left">
					<h:text style="width=200px"  id="school"  name="school" value="" />
				</div>
				<div   name="sc_show_major" class="float_left"  align="right">专业名称</div>
				<div   name="sc_show_major" class="float_left"  align="left">
					<h:text style="width=200px"  id="major"  name="major" value="" />
				</div>
			
			<%
				if (position_id == "null" || position_id == null
						|| position_id == "") {
			%>
			<script type="text/javascript">
				show_all = true;
			</script>
				<div   name="sc_show_work_year" class="float_left"  align="right">工作年限</div>
				<div   name="sc_show_work_year" class="float_left"  align="left">
					<h:text style="width=200px"  id="work_year"  name="work_year" value="" validateAttr="type=naturalNumber;message=必须输入数字;allowNull=true" />
				</div>
				<div   name="sc_show_degree" class="float_left"  align="right">学历</div>
				<div   name="sc_show_degree" class="float_left"  align="left">
					<%=gap.rm.tools.helper.RmJspHelper.getSelectField(
									"degree", -1, "YINGRUI_DEGREE", "", "", false)%>
				</div>
				<div   name="sc_show_mobile" class="float_left"  align="right">手机号</div>
				<div   name="sc_show_mobile" class="float_left"  align="left">
					<h:text style="width=200px"  id="mobile"  name="mobile" value="" validateAttr="type=naturalNumber;message=请输入正确的手机号码;allowNull=true"/>
				</div>
			
			
				<div   name="sc_show_country_List" class="float_left"  align="right">户口所在国家</div>
				<div   name="sc_show_country_List" class="float_left"  align="left">
						<r:comboSelect id="country_List" name="country_List"
						   queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_AREA&level=2"
						   valueField="code"
						   textField="name"
						   xpath="DictInfoVo"
						   width="200px"
						   nullText="请选择" />
				</div>
				</div>
				<div   name="sc_show_province_List" class="float_left"  align="right">户口所在省份</div>
				<div   name="sc_show_province_List" class="float_left"  align="left">
					<r:comboSelect id="province_List" name="province_List"
						   queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_AREA&level=3"
						   valueField="code"
						   linkId="country_List"
						   textField="name"
						   xpath="DictInfoVo"
						   width="200px"
						   nullText="请选择" />
				</div>
				<div   name="sc_show_city_list" class="float_left"  align="right">户口所在城市</div>
				<div   name="sc_show_city_list" class="float_left"  align="left">
					 <r:comboSelect id="city_list" name="city_list"
						   queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_AREA&level=4"
						   valueField="code"
						   linkId="province_List"
						   textField="name"
						   xpath="DictInfoVo"
						   width="200px"
						   nullText="请选择" />
				</div>
			
			
				<div   name="sc_show_country_List_now" class="float_left"  align="right">目前所在国家</div>
				<div   name="sc_show_country_List_now" class="float_left"  align="left">
						<r:comboSelect id="country_List_now" name="country_List_now"
						   queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_AREA&level=2"
						   valueField="code"
						   textField="name"
						   xpath="DictInfoVo"
						   width="200px"
						   nullText="请选择" />
				</div>
				</div>
				<div   name="sc_show_province_List_now" class="float_left"  align="right">目前所在省份</div>
				<div   name="sc_show_province_List_now" class="float_left"  align="left">
					<r:comboSelect id="province_List_now" name="province_List_now"
						   queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_AREA&level=3"
						   valueField="code"
						   linkId="country_List_now"
						   textField="name"
						   xpath="DictInfoVo"
						   width="200px"
						   nullText="请选择" />
				</div>
				<div   name="sc_show_city_list_now" class="float_left"  align="right">目前所在城市</div>
				<div   name="sc_show_city_list_now" class="float_left"  align="left">
					 <r:comboSelect id="city_list_now" name="city_list_now"
						   queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_AREA&level=4"
						   valueField="code"
						   linkId="province_List_now"
						   textField="name"
						   xpath="DictInfoVo"
						   width="200px"
						   nullText="请选择" />
				</div>
			
			
				<div   name="sc_show_industry1" class="float_left"  align="right">所属一级行业</div>
				<div   name="sc_show_industry1" class="float_left"  align="left">
						<r:comboSelect id="industry1" name="industry1"
						   queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_INDUSTRY&level=2"
						   valueField="code"
						   textField="name"
						   xpath="DictInfoVo"
						   width="200px"
						   nullText="请选择" />
				</div>
				</div>
				<div   name="sc_show_industry2" class="float_left"  align="right">所属二级行业</div>
				<div   name="sc_show_industry2" class="float_left"  align="left">
					<r:comboSelect id="industry2" name="industry2"
						   queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_INDUSTRY&level=3"
						   valueField="code"
						   linkId="industry1"
						   textField="name"
						   xpath="DictInfoVo"
						   width="200px"
						   nullText="请选择" />
				</div>
				<div   name="sc_show_industry3" class="float_left"  align="right">所属三级行业</div>
				<div   name="sc_show_industry3" class="float_left"  align="left">
					 <r:comboSelect id="industry3" name="industry3"
						   queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_INDUSTRY&level=4"
						   valueField="code"
						   linkId="industry2"
						   textField="name"
						   xpath="DictInfoVo"
						   width="200px"
						   nullText="请选择" />
				</div>
			
			
				<div   name="sc_show_unit_now" class="float_left"  align="right">现任职单位</div>
				<div   name="sc_show_unit_now" class="float_left"  align="left">
					 <h:text style="width=200px"  id="unit_now"  name="unit_now" value="" />
				</div>
				
			
			<%
				}
			%>
			
				<%--  --%>
				<div   name="sc_show_update_date" class="float_left"  align="right">更新日期</div>
				<div   name="sc_show_update_date" class="float_left"  align="left">
					
					<w:date id="update_date" size="8" name="update_date" format="YYYY-MM-DD"  />
				</div>
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				<div   name="" class="float_left"  align="right" style="width: 1000px;display: block">
				
					<input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
	                <input type="reset" class="icon_1"  />
	                <input type="button" id="setup_button" class="icon_1" style="display: none"  value="设置条件" onclick="condition_setup();"/>
				</div>
				
				
			</td>
		</tr>
		
<!--        <tr valign="bottom">-->
<!--            <td align="left"></td>-->
<!--            <td align="left"></td>            -->
<!--            <td align="left"></td>-->
<!--            <td align="left"></td>-->
<!--            <td align="left"></td>-->
<!--            <td align="left">-->
<!--            	<input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">-->
<!--                <input type="reset" class="icon_1"  />-->
<!--                <input type="button" class="icon_1"  value="测试" onclick="test();"/>-->
<!--            </td>-->
<!--        </tr>-->
</table>
</div>
 

 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
		 <input class="a" type="button"   value="<fmt:message key="view"/>"  onClick="detail_onClick();">
		 <%
		     if (position_id != null && position_id != "") {
		 %>
		 <input class="g" type="button"   value="选择" onClick="choose();">
		 <%
		     } else {
		 %>
		 <input class="b" type="button"   value="简历同步"   onClick="syn_onClick();">
		 <input class="g" type="button"   value="关联职位" style="background-image:url(../images/fesco/button_g_1.gif) repeat-x;width: 80px;"  onClick="javascript:relevance_position();">
		 <%
		     }
		 %>
</div>
           <div class="clear"></div>			
</div>
 
<div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/JOB_PERSONAction.do?cmd=simpleQuery" width="98%" height="318px" xpath="JOB_PERSONVo" paramFormId="datacell_formid">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
 <r:field fieldName="sname" label="姓名" allowModify="false" width="110px"></r:field>
 <r:field fieldName="company_name" label="工作经历" allowModify="false" width="110px"></r:field>
 <r:field fieldName="isex" label="性别" allowModify="false" width="110px">
    <d:select dictTypeId="YINGRUI_SEX"></d:select>
 </r:field>
 <r:field fieldName="sindustry" label="行业" allowModify="false" width="110px">
    <d:select dictTypeId="YINGRUI_INDUSTRY"></d:select>
 </r:field>
 <r:field fieldName="mobile" label="手机" width="110px"></r:field>
 <r:field fieldName="sbirthdate" label="出生日期" allowModify="false" width="110px">
    <w:date format="YYYY-MM-DD"/>
 </r:field>
 
 </r:datacell>
</div>
<%
    if (user_id != null && user_id != "") {
%>
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key="go_back"/>'  onclick="javascript:winclose();" />
</div>
 <%
     }
 %>
</div>
</div>
</h:form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
	if(request.getAttribute(IJOB_PERSONConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
		out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IJOB_PERSONConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
	}
%>
</script>	
<script language="javascript">
    $id("datacell1").onDblClickRow=function(rowTR, rowNo ,entity,datacell){
        if("<%=position_id%>" != "null" && "<%=position_id%>" != "")
            choose();
    }
</script>
