<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.job.job_position.vo.Job_positionVo" %>
<%@ page import="rayoo.job.job_position.util.IJob_positionConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<%  //判断是否为修改页面
	Job_positionVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IJob_positionConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (Job_positionVo)request.getAttribute(IJob_positionConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
	String industry1 = request.getParameter("industry1");
	String industry2 = request.getParameter("industry2");
	String industry3 = request.getParameter("industry3");
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function init(){
		//取得主页面传过来的参数
		if(<%=isModify%>){
			var datacell = window["dialogArguments"];
			var entity = datacell.getActiveEntity();
			//document.getElementById("positiontype").value = entity.getProperty("positiontype")==null?"":entity.getProperty("positiontype");
			document.getElementById("is_invoiced").value = entity.getProperty("is_invoiced")==null?"":entity.getProperty("is_invoiced");
			document.getElementById("position").value = entity.getProperty("position")==null?"":entity.getProperty("position");
			document.getElementById("area").value =( entity.getProperty("area")==null?"":entity.getProperty("area"));
			document.getElementById("salary_range").value = entity.getProperty("salary_range")==null?"":entity.getProperty("salary_range");
			document.getElementById("job_number").value = entity.getProperty("job_number")==null?"":entity.getProperty("job_number");
			document.getElementById("requirement").value = entity.getProperty("requirement")==null?"":entity.getProperty("requirement");
			document.getElementById("position_status").value = entity.getProperty("position_status")==null?"":entity.getProperty("position_status");
			$id("industry1").setValue(entity.getProperty("industry1")==null?"":entity.getProperty("industry1"));
			$id("industry2").setValue(entity.getProperty("industry2")==null?"":entity.getProperty("industry2"));
			$id("industry3").setValue(entity.getProperty("industry3")==null?"":entity.getProperty("industry3"));
			/**
			if(document.getElementById("positiontype").value == 2){
				document.getElementById("position").disabled = true;
    			document.getElementById("area").disabled = true;
    			document.getElementById("salary_range").disabled = true;
    			document.getElementById("job_number").disabled = true;
    			document.getElementById("requirement").disabled = true;
			}
			**/
		}
	}
	
	function insert_onClick(){  //插入单条数据
	   	var is_invoiced1=document.getElementById("is_invoiced").value
        var position1 = document.getElementById("position").value
        var area1=document.getElementById("area").value
     	var salary_range1= document.getElementById("salary_range").value
        var job_number1=document.getElementById("job_number").value
        var requirement1=document.getElementById("requirement").value
             
        if(position1==null||position1==""){
          alert("职位名称不能为空！");
          return;
         }
           if(area1==null||area1==""){
          alert("招聘地区不能为空！");
          return;
         }
           if(salary_range1==null||salary_range1==""){
          alert("薪资范围不能为空！");
          return;
         }
           if(job_number1==null||job_number1==""){
          alert("招聘数量不能为空！");
          return;
         }
           if(requirement1==null||requirement1==""||requirement1.length<30){
          alert("职位要求至少输入30字！");
          return;
         }
         if(is_invoiced1==null||is_invoiced1==""){
          alert("是否预开票不能为空！");
          return;
         }
		if(<%=isModify%>){
	
			var datacell = window["dialogArguments"];
			var entity = datacell.getActiveEntity();
			//entity.setProperty("positiontype",document.getElementById("positiontype").value);
			entity.setProperty("is_invoiced",document.getElementById("is_invoiced").value);
			entity.setProperty("position",document.getElementById("position").value);
			entity.setProperty("area",document.getElementById("area").value);
			entity.setProperty("salary_range",document.getElementById("salary_range").value);
			entity.setProperty("job_number",document.getElementById("job_number").value);
			entity.setProperty("requirement",document.getElementById("requirement").value);
			entity.setProperty("position_status",document.getElementById("position_status").value);
			entity.setProperty("industry1",$id("industry1").getValue());
			entity.setProperty("industry2",$id("industry2").getValue());
			entity.setProperty("industry3",$id("industry3").getValue());
			datacell.endEdit(); 
			window.close();
		}else{
	
			//获传入的datacell对象
	        var datacell=window["dialogArguments"];
	        //增加空行
	        datacell.insertEmptyRow();
	    	    //获得新增的记录
	        var entity=datacell.getActiveEntity();
			//entity.setProperty("positiontype",document.getElementById("positiontype").value);
			entity.setProperty("is_invoiced",document.getElementById("is_invoiced").value);
			entity.setProperty("position",document.getElementById("position").value);
			entity.setProperty("area",document.getElementById("area").value);
			entity.setProperty("salary_range",document.getElementById("salary_range").value);
			entity.setProperty("job_number",document.getElementById("job_number").value);
			entity.setProperty("requirement",document.getElementById("requirement").value);
			entity.setProperty("industry1",$id("industry1").getValue());
			entity.setProperty("industry2",$id("industry2").getValue());
			entity.setProperty("industry3",$id("industry3").getValue());
			entity.setProperty("position_status","1");
	        datacell.endEdit();  
	        window.close();	
        }
       
	}


    function cancel_onClick(){  //取消后返回列表页面
       window.close();
    }
    
    //职位类别改变时
   /* function typeChange(){
    	var position_type = jQuery("#positiontype").val();
    	if(position_type==1){
    		document.getElementById("position").disabled = false;
    		document.getElementById("position").value = "";
    		
    		document.getElementById("area").disabled = false;
    		document.getElementById("area").value = "";
    		
    		document.getElementById("salary_range").disabled = false;
    		document.getElementById("salary_range").value = "";
    		
    		document.getElementById("job_number").disabled = false;
    		document.getElementById("job_number").value = "";
    		
    		document.getElementById("requirement").disabled = false;
    		document.getElementById("requirement").value = "";
    		
    		document.getElementById("industry1").disabled = false;
    		document.getElementById("industry1").value = "";
    		
    		document.getElementById("industry2").disabled = false;
    		document.getElementById("industry2").value = "";
    		
    		document.getElementById("industry3").disabled = false;
    		document.getElementById("industry3").value = "";
    		
    		
    	}
    	if(position_type==2){
    		document.getElementById("position").disabled = true;
    		document.getElementById("position").value = "预开票职位";
    		
    		document.getElementById("area").disabled = true;
    		document.getElementById("area").value = "预开票职位";
    		
    		document.getElementById("salary_range").disabled = true;
    		document.getElementById("salary_range").value = "1";
    		
    		document.getElementById("job_number").disabled = true;
    		document.getElementById("job_number").value = "0";
    		
    		document.getElementById("requirement").disabled = true;
    		document.getElementById("requirement").value = "预开票职位";
    		
    		document.getElementById("industry1").disabled = true;
    		document.getElementById("industry1").value = "";
    		
    		document.getElementById("industry2").disabled = true;
    		document.getElementById("industry2").value = "";
    		
    		document.getElementById("industry3").disabled = true;
    		document.getElementById("industry3").value = "";
    	}
    }
    */
    function loadInit(){
    	alert(1);
    }
</script>
</head>
<body >

<form name="form" method="post" id="datacell_formid">
    <div id="ringht">
    <div class="ringht_s">
    <div id="ccChild1" class="box_3" style="width:90%">
<div class="xz_title" style="width:100%">基本信息</div> 
<table  width="90%" height="90%" border="0"  cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 		<!-- <tr>
            <td class="td_1"  width="28%" nowrap="nowrap" ><span class="style_required_red">* </span>职位类型</td>
            <td class="td_2 " >
               <d:select dictTypeId="POSITIONTYPE_BD" id="positiontype" name="positiontype" value="${bean.positiontype}" onchange="typeChange();" filterOp="in" filterStr="1"></d:select>
       		</td>
       		<td class="td_1"  width="28%" nowrap="nowrap"><span class="style_required_red">* </span>是否预开票</td>
            <td class="td_2 " >
               <d:select dictTypeId="TrueOrFalse" id="is_invoiced" name="is_invoiced" value="${bean.is_invoiced}" nullLabel="请选择"   ></d:select>
            </td>
        </tr>-->
 		<tr>
            <td class="td_1" nowrap="nowrap"><span class="style_required_red">* </span>职位名称</td>
            <td class="td_2 " >
               <input  type="text" class="text_field" name="position" id="position" inputName="职位名称" maxLength="23"   value="${bean.position}"   />
       		</td>
       		<td class="td_1"  nowrap="nowrap"><span class="style_required_red">* </span>招聘地区</td>
            <td class="td_2 " >
               <input type="text" class="text_field" name="area" id="area" inputName="招聘地区" maxLength="23"   value="${bean.area}"  />
       		</td>
        </tr>
		<tr>
            <td class="td_1" ><span class="style_required_red">* </span>薪资范围</td>
            <td class="td_2" >
            	<d:select dictTypeId="SALARY_RANGE_BD" id="salary_range" name="salary_range" nullLabel="--请选择--" value="${bean.salary_range}"></d:select>
            </td>
			<td  class="td_1"  ><span class="style_required_red">* </span>招聘数量</td>
			<td  class="td_2" >
				 <input type="text" class="text_field" name="job_number" id="job_number" inputName="招聘数量" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxLength="23"   value="${bean.job_number}"/>
			</td>
		</tr>
		<tr>
		<td class="td_1" nowrap="nowrap"><span class="style_required_red">* </span>是否预开票</td>
            <td class="td_2" colspan="3">
               <d:select dictTypeId="TrueOrFalse" id="is_invoiced" name="is_invoiced"   value="${bean.is_invoiced==null?0:bean.is_invoiced}" nullLabel="请选择" ></d:select>
            </td>
		</tr>
		<tr>
			<td class="td_1">一级行业</td>
            <td class="td_2">
                <r:comboSelect id="industry1" name="industry1"
                       queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_INDUSTRY&level=2"
                       valueField="code"
                       textField="name"
                       xpath="DictInfoVo"
                       width="200px"
                       nullText="请选择" 
                       value = "<%=industry1 %>" />
            </td>
            <td class="td_1">二级行业</td>
            <td class="td_2">
               <r:comboSelect id="industry2" name="industry2"
                       queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_INDUSTRY&level=3"
                       valueField="code"
                       linkId="industry1"
                       textField="name"
                       xpath="DictInfoVo"
                       width="200px"
                       nullText="请选择" 
                       value="<%=industry2 %>"/>
            </td>
        </tr>
        <tr>
            <td class="td_1">三级行业</td>
            <td class="td_2">
            	 <r:comboSelect id="industry3" name="industry3"
                       queryAction="/FAERP/JOB_PERSONAction.do?cmd=getDictInfo&typecode=YINGRUI_INDUSTRY&level=4"
                       valueField="code"
                       linkId="industry2"
                       textField="name"
                       xpath="DictInfoVo"
                       width="200px"
                       nullText="请选择"
                       value="<%=industry3 %>" />
            </td>
		</tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>职位要求</td>
            <td class="td_2"  colspan="4" >
                 <textarea id="requirement" class="xText_d" rows="8" name="requirement"></textarea>
                 <span class="style_required_red">(至少输入30字)</span>
                 <input type="hidden" name="position_status" id="position_status">
            </td>
        </tr>
    </table>
  </div>
  <div class="clear"></div>
	<div class="foot_button" >
		        <input type="button" class="icon_2" value='保存' onClick="javascript:insert_onClick()"/>
		        <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
    </div>
<input type="hidden" name="id" id="edit_id" value="">
<input type="hidden" name="create_date" id="create_date" value="">
<input type="hidden" name="create_user_id" id="create_user_id" value="">
<input type="hidden" name="company_id" id="company_id" value="">
<input type="hidden" name="create_date" />
</div>
</div>
</form> 
</fmt:bundle>
<script language="javascript">
    writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
init();
</script>
