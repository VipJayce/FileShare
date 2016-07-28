<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo" %>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script src="<%=request.getContextPath()%>/dwr/util.js" type="text/javascript"></script> 
 <script language="javascript" src="<venus:base/>/js/ajax/gap-ajax-tree.js"></script>
 <script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<%  //判断是否为修改页面
String agent_b_id=(String)request.getAttribute("agent_b_id");
String agent_b_name=(String)request.getAttribute("agent_b_name");
String detail =request.getParameter("detail");
    SalcontractVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ISalcontractConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (SalcontractVo)request.getAttribute(ISalcontractConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
    
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
        form.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=insert";
        form.submit();
    }

    function update_onClick(){  //保存修改后的单条数据
      var contract_type_bd=document.form.contract_type_bd.value;
      var create_type_bd=document.form.create_type_bd.value;
      var business_type_bd=document.form.business_type_bd.value;
        if(business_type_bd==""||business_type_bd==null){
          alert("合同业务类型不能为空");
            document.form.business_type_bd.focus();
        return;
        }
        
          if(create_type_bd==""||create_type_bd==null){
          alert("合同生成方式不能为空");
            document.form.create_type_bd.focus();
          return;
        }
     
    if(create_type_bd==1){
        var contract_template_id=document.form.contract_template_id.value;
          if(contract_template_id==""||contract_template_id==null){
          alert("合同模板不能为空");
            document.form.contract_template_id.focus();
          return;
          }
         form.action="<%=request.getContextPath()%>/jsp/faerp/finout/finoutsalcontract/finoutsaltab_list.jsp?create_type_bd="+create_type_bd+"&contract_type_bd=10&business_type_bd="+business_type_bd+"&contract_template_id="+contract_template_id+"&agent_b_id=<%=agent_b_id%>"+"&agent_b_name=<%=agent_b_name%>"+"&detail="+"<%=detail%>";
    }else{
        form.action="<%=request.getContextPath()%>/jsp/faerp/finout/finoutsalcontract/finoutsaltab_list.jsp?create_type_bd="+create_type_bd+"&contract_type_bd=10&business_type_bd="+business_type_bd+"&detail="+"<%=detail%>"+"&agent_b_id=<%=agent_b_id%>"+"&agent_b_name=<%=agent_b_name%>";
        }
        form.submit();
    }

    function cancel_onClick(){  //取消后返回列表页面
       form.action="<%=request.getContextPath()%>/Finout_contract_productAction.do?cmd=queryAll_tolistsal";
       form.submit();
    }
    
    function listchange(){
    var create_type_bd = document.getElementById("create_type_bd").value; 
    if(create_type_bd==1){
       document.getElementById( "divid").style.display= "";
       getContract_template(this,"contract_template","code","name",10);
    }else{
       document.getElementById( "divid").style.display= "none";
    }

}
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">
<div id="ccChild1"     class="box_xinzeng" style="height:200px "> 
<input  type="hidden" id="contract_type_bd" name="contract_type_bd"  value="10"><!-- 财务外包合同类型 -->
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
        <!--  
             <td class="td_1" ><span class="style_required_red">* </span>合同类型</td>
            <td class="td_2" >
            <d:select dictTypeId="CONTRACT_TYPE_BD" name="contract_type_bd" id="contract_type_bd" nullLabel="--请选择--"  value="10" disabled="true" />
            </td>
            -->
            <td class="td_1" ><span class="style_required_red">* </span>财务外包业务类型</td>
            <td class="td_2" >
            <d:select dictTypeId="FINOUT_TYPE_BD" name="business_type_bd" id="business_type_bd" nullLabel="--请选择--"   onchange="javascript:getContract_template(this,'contract_template','code','name','${bean.contract_type_bd}')"/>
            </td>
               <td class="td_1" ><span class="style_required_red">* </span>合同生成方式</td>
            <td class="td_2 ">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("create_type_bd", -1,"CREATE_TYPE_BD",""," onchange='listchange();'  id=create_type_bd",false) %>
            </td>
              </tr>
            <tr id="divid" style="display:none;">
                <div> 
                 <td class="td_1" ><span class="style_required_red">* </span>合同模板</td>
                <td class="td_2 ">
                     <select id="contract_template_id" name="contract_template">
                          <option value="">--请选择--</option>
                    </select>
                 </td>
                   <td class="td_1" >  </td>
                    <td class="td_2 "></td>
               </div> 
         </tr>

    </table>

        <div class="mx_button" style="text-align: center;padding-top:0px;">
        <input type="button" class="icon_2" value='<fmt:message key="confirm"/>' onClick="javascript:update_onClick();" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="window.close();"/>
        </div> 
</div>         
</form>
</fmt:bundle>
<script language="javascript">
    //writeTableBottomFesco('<%//=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript" type="text/javascript">
function getContract_template(selectObject,targetId,key,value,selectvalue){
        var contract_type_bd = "10";//财务外包合同类型
       AjaxControl.getContract_template(contract_type_bd,{callback:function(data){
               if (data != null && typeof(data) == 'object' && data != 'null') 
               {
                DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
                DWRUtil.addOptions(targetId,{000:'--请选择--'});
                setSelectForBean(targetId,data,key,value,selectvalue);
               }
           }
       });
    }
</script>
