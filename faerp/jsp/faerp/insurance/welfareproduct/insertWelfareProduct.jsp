<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.insurance.welfareproduct.vo.WelfareProductVo" %>
<%@ page import="rayoo.insurance.welfareproduct.util.IWelfareProductConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //判断是否为修改页面
	WelfareProductVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IWelfareProductConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (WelfareProductVo)request.getAttribute(IWelfareProductConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
  	function update_onClick(id){  //保存修改后的单条数据
  	   var isMonery=/^[0-9]+\.{0,1}[0-9]{0,2}$/;
  	   var isNum=/^-?\d+$/;
  	   var coverage_type = document.getElementById("coverage_type").value;
  	   var coverage_limit = document.form.coverage_limit.value;
  	   var relief_limit = document.form.relief_limit.value;
  	   var day_franchise = document.form.day_franchise.value;
       var year_franchise = document.form.year_franchise.value;
       var sub_franchise = document.form.sub_franchise.value;
       var day_fde = document.form.day_fde.value;
       var year_fde = document.form.year_fde.value;
       var sub_fde = document.form.sub_fde.value;
       var jbzymzq = document.form.jbzymzq.value;
       var ywzymzq = document.form.ywzymzq.value;
       var sfyfxr = document.form.sfyfxr.value;
       if(coverage_type==""||coverage_type==null){
             alert("请选择保额类型！");
             return;    
       }
  	   if(coverage_type != "4" && coverage_type != "2"){
            if((!isMonery.test(coverage_limit)) || (coverage_limit=="0")){
               alert("请输入有效的保额额度！");
               document.form.coverage_limit.focus();
               return;
            }
        }else if(coverage_type == "2"){            
            if(coverage_limit != null && coverage_limit != ""){
                if(!isMonery.test(coverage_limit)){
	               alert("请输入正确的保额额度！");
	               document.form.coverage_limit.focus();
	               return;
	            }
            }
        }else{
            if(document.form.m_salary_multiple.value==""||document.form.m_salary_multiple.value==null){
                alert("请选择月薪倍数！");
                return;
            }
        }
  	   if(!isNum.test(relief_limit)&&relief_limit!=""&&relief_limit!=null){
           alert("请输入正确的免责期！");
           document.form.relief_limit.focus();
           return;
        }
        if(!isMonery.test(day_franchise)&&day_franchise!=""&&day_franchise!=null){
           alert("请输入正确的日免赔额！");
           document.form.day_franchise.focus();
           return;
        }
        if(!isMonery.test(year_franchise)&&year_franchise!=""&&year_franchise!=null){
           alert("请输入正确的年免赔额！");
           document.form.year_franchise.focus();
           return;
        }
        if(!isMonery.test(sub_franchise)&&sub_franchise!=""&&sub_franchise!=null){
           alert("请输入正确的次免赔额！");
           document.form.sub_franchise.focus();
           return;
        }
        if(!isMonery.test(day_fde)&&day_fde!=""&&day_fde!=null){
           alert("请输入正确的日封顶额！");
           document.form.day_fde.focus();
           return;
        }
        if(!isMonery.test(year_fde)&&year_fde!=""&&year_fde!=null){
           alert("请输入正确的年封顶额！");
           document.form.year_fde.focus();
           return;
        }
        if(!isMonery.test(sub_fde)&&sub_fde!=""&&sub_fde!=null){
           alert("请输入正确的次封顶额！");
           document.form.sub_fde.focus();
           return;
        }
        if(!isNum.test(jbzymzq)&&jbzymzq!=""&&jbzymzq!=null){
           alert("请输入正确的疾病住院免责期！");
           document.form.jbzymzq.focus();
           return;
        }
        if(!isNum.test(ywzymzq)&&ywzymzq!=""&&ywzymzq!=null){
           alert("请输入正确的意外住院免责期！");
           document.form.ywzymzq.focus();
           return;
        }
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		if(checkAllForms()){		    
		    if(coverage_type == "4"){
                document.form.coverage_limit.value="";
            }else{                
                document.form.m_salary_multiple.value="";
            }
		    //form.action="<%=request.getContextPath()%>/WelfareProductAction.do?cmd=update";
	    	//form.submit();
	    	var action="<%=request.getContextPath()%>/WelfareProductAction.do?cmd=update";
	        var myAjax = new Ajax(action);
	        myAjax.addParam('coverage_type', coverage_type);
	        if(coverage_type=='4'){
	           myAjax.addParam('m_salary_multiple', document.form.m_salary_multiple.value);
	        }else{
	           myAjax.addParam('coverage_limit', coverage_limit);
	        }
	        myAjax.addParam('compensation_proportion', document.form.compensation_proportion.value);
	        myAjax.addParam('day_franchise', day_franchise);
	        myAjax.addParam('relief_limit', relief_limit);
	        myAjax.addParam('year_franchise', year_franchise);
	        myAjax.addParam('sub_franchise', sub_franchise);
	        myAjax.addParam('day_fde', day_fde);
	        myAjax.addParam('year_fde', year_fde);
	        myAjax.addParam('sub_fde', sub_fde);
	        myAjax.addParam('sfkcsyjt', document.form.sfkcsyjt.value);
	        myAjax.addParam('jbzymzq', jbzymzq);
	        myAjax.addParam('ywzymzq', ywzymzq);
	        myAjax.addParam('product_simple_desc', document.form.product_simple_desc.value);
	        myAjax.addParam('product_detail_desc', document.form.product_detail_desc.value);
	        myAjax.addParam('ids', document.form.id.value);
	        myAjax.addParam('sfyfxr',sfyfxr);
	         myAjax.submit();
	         var returnNode = myAjax.getResponseXMLDom();
	         if( returnNode ) {
	              alert(""+myAjax.getProperty("returnValue"));
	              window['returnValue'] = ""+myAjax.getProperty("returnValue");
	              window.close();
	         }
        }
	}

    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/WelfareProductAction.do?cmd=queryAll&backFlag=false";
       //form.submit();
       window.close();
    }
    
    function change_type(obj){    
        if(obj.value=="4"){
	        document.getElementById("coverId").style.display="none";
	        document.getElementById("coverSub").style.display="none";
	        document.getElementById("salaryId").style.display="block";
	        document.getElementById("salarySub").style.display="block";
	    }else if(obj.value=="2"){
	        document.getElementById("coverTitle").style.display="none";
	    }else {
	        document.getElementById("coverTitle").style.display="inline";
	        document.getElementById("coverId").style.display="block";
            document.getElementById("coverSub").style.display="block";
            document.getElementById("salaryId").style.display="none";
            document.getElementById("salarySub").style.display="none";
	    }
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<div id="right">
<!--<script language="javascript">
        writeTableTopFesco('修改福利产品','<%=request.getContextPath()%>/');
</script>
 --><div class="ringht_s">
<div id="ccChild0"     class="box_3"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="10%">产品大类</td>
            <td class="td_2 " width="20%">
                <d:select dictTypeId="big_type_id" property="bean/big_type_id" disabled="true" style="width:100px;"/>
            </td>
            <td class="td_1" width="10%">产品小类</td>
            <td class="td_2 " width="20%">
                <d:select dictTypeId="big_type_id" property="bean/small_type_id" disabled="true" style="width:100px;"/>
            </td>
            <td class="td_1" width="10%">三级分类</td>
            <td class="td_2 " width="30%">
                <d:select dictTypeId="big_type_id" property="bean/three_type_id" disabled="true" style="width:100px;"/>
            </td>
        </tr>
         <tr>
            <td class="td_1" >产品名称</td>
            <td class="td_2 ">
                <input type="text"  name="product_name" inputName="产品名称" style="width: 100px;" disabled="disabled" />
            </td>
            <td class="td_1" >是否定方案产品</td>
            <td class="td_2 ">
                <d:select dictTypeId="TrueOrFalse" nullLabel="" property="bean/is_scheme"  style="width:100px;" disabled="true"/>
            </td>
            <td class="td_1" >方案类型</td>
            <td class="td_2 ">
                <d:select dictTypeId="scheme_type" nullLabel="" style="width:100px;" property="bean/scheme_type" disabled="true"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span style="color: red;">*</span>保额类型</td>
            <td class="td_2 ">
                <d:select dictTypeId="COVERAGE_TYPE" style="width:100px;" property="bean/coverage_type" name="coverage_type" id="coverage_type" onchange="javascrpt:change_type(this)"/>
            </td>
            <!-- 最好是，保额类型选择“月薪倍数”时，“保额额度” 这里能动态变化为下拉选择框，选项值为：24倍月薪，36倍月薪，48倍月薪 -->
            <td class="td_1" id="coverId" ><span style="color: red;" id="coverTitle">*</span>保额额度</td>
            <td class="td_2" id="coverSub" ><input type="text" class="text_field" name="coverage_limit" inputName="保额额度" style="width:100px;" maxLength="50" /></td>
            <td class="td_1" id="salaryId"  style="display:none"><span style="color: red;">*</span>月薪倍数</td>
            <td class="td_2" id="salarySub"  style="display:none" >
                <d:select dictTypeId="M_SALARY_MULTIPLE" style="width:100px;" property="bean/m_salary_multiple" id="m_salary_multiple" name="m_salary_multiple"/>
            </td>
            <td class="td_1" >免责期</td>
            <td class="td_2" ><input type="text" class="text_field" name="relief_limit" style="width:100px;" inputName="免责期" maxLength="50" /></td>
        </tr>       
        <tr>
            <td class="td_1" >赔付比例</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width:100px;" name="compensation_proportion" inputName="赔付比例" maxLength="50" />
            </td>
            <td class="td_1" >日免赔额</td>
            <td class="td_2" ><input type="text" style="width:100px;" class="text_field" name="day_franchise" inputName="日免赔额" maxLength="50" /></td>
            <td class="td_1" >年免赔额</td>
            <td class="td_2" ><input type="text" style="width:100px;" class="text_field" name="year_franchise" inputName="年免赔额" maxLength="50" /></td>
        </tr>       
        <tr>
            <td class="td_1" >次免赔额</td>
            <td class="td_2 ">
                <input type="text" class="text_field" style="width:100px;" name="sub_franchise" inputName="次免赔额" maxLength="50" />
            </td>
            <td class="td_1" >日封顶额</td>
            <td class="td_2" > <input type="text" style="width:100px;" class="text_field" name="day_fde" inputName="日封顶额" maxLength="50" /></td>
            <td class="td_1" >年封顶额</td>
            <td class="td_2" > <input type="text" class="text_field" style="width:100px;" name="year_fde" inputName="年封顶额" maxLength="50" /></td>
        </tr>       
        <tr>
            <td class="td_1" >次封顶额</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="sub_fde" style="width:100px;" inputName="次封顶额"  maxLength="50" />
            </td>
            <td class="td_1" >是否扣除生育津贴</td>
            <td class="td_2" ><input type="text" class="text_field" name="sfkcsyjt" style="width:100px;" inputName="是否扣除生育津贴" maxLength="50" /></td>
            <td class="td_1" >疾病住院免责期</td>
            <td class="td_2" ><input type="text" class="text_field" name="jbzymzq" style="width:100px;" inputName="疾病住院免责期" maxLength="50" /></td>
        </tr>       
        <tr>
            <td class="td_1" >意外住院免责期</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="ywzymzq" style="width:100px;" inputName="意外住院免责期" maxLength="50" />
            </td>
            <td class="td_1" >是否有附险人</td>
            <td class="td_2" ><d:select dictTypeId="TrueOrFalse" name="sfyfxr" id="sfyfxr" property="bean/sfyfxr"  style="width:100px;"/></td>
            <td class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>       
        <tr>
            <td class="td_1" >简介</td>
            <td class="td_2 " colspan="5">
                <textarea name="product_simple_desc" rows="1" class="xText_d" id="product_simple_desc" style="width:96%"></textarea>
            </td>
        </tr>       
        <tr>
            <td class="td_1" >详述</td>
            <td class="td_2 " colspan="5">
                <textarea name="product_detail_desc" rows="1" class="xText_d" id="product_detail_desc" style="width:96%"></textarea>
            </td>
        </tr> 	
	</table>
   </div>
    <div class="mx_button" align="center">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:update_onClick();" />
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
        </div>
</div></div>    
<input type="hidden" name="id">
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
var coverage_type = document.getElementById("coverage_type").value;
if(coverage_type == "4"){
    document.getElementById("coverId").style.display="none";
    document.getElementById("coverSub").style.display="none";
    document.getElementById("salaryId").style.display="block";
    document.getElementById("salarySub").style.display="block";
}else if(coverage_type=="2"){
    document.getElementById("coverTitle").style.display="none";
}else {
    document.getElementById("coverTitle").style.display="inline";
    document.getElementById("coverId").style.display="block";
    document.getElementById("coverSub").style.display="block";
    document.getElementById("salaryId").style.display="none";
    document.getElementById("salarySub").style.display="none";
}
</script>
