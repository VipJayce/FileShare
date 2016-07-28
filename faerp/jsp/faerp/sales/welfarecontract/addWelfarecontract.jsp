<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.welfarecontract.vo.WelfarecontractVo" %>
<%@ page import="rayoo.sales.welfarecontract.util.IWelfarecontractConstants" %>
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
System.out.print("agent_b_id="+agent_b_id);
String agent_b_name=(String)request.getAttribute("agent_b_name");
//System.out.print("agent_b_name="+agent_b_name);
String detail =request.getParameter("detail");
   
   String f = request.getParameter("f");//f=zp为招聘模块
   System.out.println("f:"+f);
   //isQA标识，来判定是否走分配经办人[true 则直接按照固定人员来生成权限等数据，不走流程]
   String isQA=request.getAttribute("isQA")==null?"false":request.getAttribute("isQA").toString();
   
    WelfarecontractVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(IWelfarecontractConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (WelfarecontractVo)request.getAttribute(IWelfarecontractConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
    
%>
<html>
<fmt:bundle basename="rayoo.salse.welfarecontract.welfarecontract_resource" prefix="rayoo.salse.welfarecontract.">
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
        
        if(contract_type_bd==""||contract_type_bd==null){
          alert("<fmt:message key="contract_type_not_null"/>");
            document.form.contract_type_bd.focus();
        return;
        }
        
          if(create_type_bd==""||create_type_bd==null){
          alert("<fmt:message key="create_type_not_null"/>");
            document.form.create_type_bd.focus();
          return;
        }
     
    if(create_type_bd==1){
        var contract_template_id=document.form.contract_template_id.value;
          if(contract_template_id==""||contract_template_id==null){
          alert("<fmt:message key="contract_template_not_null"/>");
            document.form.contract_template_id.focus();
          return;
          }
          
          if(contract_type_bd=="9"){
          form.action="<%=request.getContextPath()%>/jsp/faerp/sales/welfarecontract/zpinserttab_list.jsp?create_type_bd="+create_type_bd+"&contract_type_bd="+contract_type_bd+"&contract_template_id="+contract_template_id+"&agent_b_id=<%=agent_b_id%>"+"&agent_b_name=<%=agent_b_name%>"+"&detail="+"<%=detail%>"+"&f="+"<%=f%>";
          }else{
         form.action="<%=request.getContextPath()%>/jsp/faerp/sales/welfarecontract/tab_list.jsp?create_type_bd="+create_type_bd+"&contract_type_bd="+contract_type_bd+"&contract_template_id="+contract_template_id+"&agent_b_id=<%=agent_b_id%>"+"&agent_b_name=<%=agent_b_name%>"+"&detail="+"<%=detail%>"+"&f="+"<%=f%>"+"&isQA=<%=isQA%>";
         }
    }else{
      if(contract_type_bd=="9"){
          form.action="<%=request.getContextPath()%>/jsp/faerp/sales/welfarecontract/zpinserttab_list.jsp?create_type_bd="+create_type_bd+"&contract_type_bd="+contract_type_bd+"&detail="+"<%=detail%>"+"&agent_b_id=<%=agent_b_id%>"+"&agent_b_name=<%=agent_b_name%>"+"&f="+"<%=f%>";
          }else{
        form.action="<%=request.getContextPath()%>/jsp/faerp/sales/welfarecontract/tab_list.jsp?create_type_bd="+create_type_bd+"&contract_type_bd="+contract_type_bd+"&detail="+"<%=detail%>"+"&agent_b_id=<%=agent_b_id%>"+"&agent_b_name=<%=agent_b_name%>"+"&f="+"<%=f%>"+"&isQA=<%=isQA%>";
     }
     //        form.action="<%=request.getContextPath()%>/jsp/faerp/sales/welfarecontract/insertSalcontract.jsp?create_type_bd="+create_type_bd+"&contract_type_bd="+contract_type_bd+"&agent_b_id=<%=agent_b_id%>"+"&agent_b_name=<%=agent_b_name%>";
     
     
        }
        form.submit();
    }

    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=queryAll&backFlag=true";
        //form.submit();
        window.close();
    }
    
    function listchange(){
    var create_type_bd = document.getElementById("create_type_bd").value; 
    if(create_type_bd==1){
       document.getElementById( "divid").style.display= "";
       getContract_template(this,"contract_template","code","name",document.getElementById("contract_type_bd").value);
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
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_type"/></td>
            <td class="td_2" >
                <d:select dictTypeId="CONTRACT_TYPE_BD" name="contract_type_bd" id="contract_type_bd" nullLabel="请选择" value="5" disabled="true"/>
            </td>
             <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_create_type"/></td>
            <td class="td_2 ">
                 <%=gap.rm.tools.helper.RmJspHelper.getSelectField("create_type_bd", -1,"CREATE_TYPE_BD",""," onchange='listchange();'  id=create_type_bd",false) %>
               <!--
               onChange="javascript:getAllSmallType(this,'small_type_id','code','name','<%//=isModify ? resultVo.getSmall_type_id() : "" %>')"
                    <select id="create_type_bd" name="create_type_bd" style="width:200px"  onchange="listchange();">
                            <option value="" >请选择</option>
                            <option value="1" >合同模板</option>
                            <option value="2" >上传附件</option>
             </select>
              -->
            </td>

        </tr>
 
            <tr id="divid" style="display:none;">
                <div> 
                 <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_template"/></td>
                <td class="td_2 ">
                 <!--   <faerp:contractTemplateSelectTag style=" width:205px "/> -->
                     <select id="contract_template_id" name="contract_template">
                          <option value=""><fmt:message key="please_choose"/></option>
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
            
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
    //writeTableBottomFesco('<%//=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript" type="text/javascript">
<%  //取出要修改的那条记录，并且回写表单
    if(isModify) {  //如果本页面是修改页面
        //out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
%>
function getContract_template(selectObject,targetId,key,value,selectvalue){
        //var contract_type_bd=jQuery("#contract_type_bd").val();
        var contract_type_bd = document.getElementById("contract_type_bd").value;
        if(contract_type_bd==""){
            alert("<fmt:message key="choose_contract_type"/>");
            return;
        }
        
       AjaxControl.getContract_template(contract_type_bd,{callback:function(data){
               if (data != null && typeof(data) == 'object' && data != 'null') 
               {
                DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
                DWRUtil.addOptions(targetId,{000:'<fmt:message key="please_choose"/>'});
                setSelectForBean(targetId,data,key,value,selectvalue);
               }
           }
       });
    }
</script>
