<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo" %>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@ page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo" %>
<%//判断是否为修改页面
String detail=(String)request.getAttribute("detail");
detail=(String)request.getParameter("detail");
String  create_type_bd=(String)request.getParameter("create_type_bd");
String  contract_type_bd=(String)request.getParameter("contract_type_bd");
String  id=(String)request.getParameter("id");
String  contract_name=(String)request.getParameter("contract_name");
String  contract_start_date=(String)request.getParameter("contract_start_date");
String  contract_stop_date=String.valueOf(request.getParameter("contract_stop_date")==null?"":request.getParameter("contract_stop_date"));
String customer_name=(String)request.getParameter("customer_name");
String agent_b_name=(String)request.getParameter("agent_b_name");
if(agent_b_name!=null&&!"".equals(agent_b_name)){
    agent_b_name = new String(agent_b_name.getBytes("ISO8859-1"), "gbk").trim();
}
String agent_b_id=(String)request.getParameter("agent_b_id");
String cust_a_id=(String)request.getParameter("cust_a_id");
String customer_code=(String)request.getParameter("customer_code");
SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
String contractstartdate="";
String contractstopdate="";
if(contract_start_date!=null&&!contract_start_date.equals("")&&!contract_start_date.equals("null"))
{
     contractstartdate=df.format(df.parse(contract_start_date));
}
if(contract_stop_date!=null&&!contract_stop_date.equals("")&&!contract_stop_date.equals("null"))
{
     contractstartdate=df.format(df.parse(contract_stop_date));
	 //System.out.print(agent_b_name+"%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
}



	SalcontractVo resultVo = null;  //定义一个临时的vo变量
	 AttachmentfileVo avo=null;//附件VO
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if( id != null && !"".equals(id)) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute("bean") != null) {  //如果request中取出的bean不为空
  		    
        if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
            avo = (AttachmentfileVo)request.getAttribute("AttachmentfileVo");  //从request中取出vo, 赋值给resultVo
        }
        
        
  		}
	}
	
	 String attachName = avo==null?"":avo.getAttachment_file_name().toString();
	 String attachAddress = avo==null?"":avo.getAttachment_file_path().toString();
	
%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
	
 var contract_start_date=document.form.contract_start_date.value.trim();;
 var contract_stop_date=document.form.contract_stop_date.value.trim();;
 
     if(contract_start_date==""&&contract_start_date.length==0){
        alert("合同起始日期不能为空！");
        return;
     }
 
 
      if(contract_stop_date!=""&&contract_stop_date.length!=0){
                            var beginTime = contract_start_date;
                            var endTime = contract_stop_date;
                            var beginTimes=beginTime.substring(0,10).split('-');
                            var endTimes=endTime.substring(0,10).split('-');
                            beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
                            endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
                            if(beginTime>endTime){
                                alert("合同终止日期小于合同起始日期！");
                                return ;
                            }
                       }




	 
        if(checkAllForms()){
				form.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=insert";
				form.submit();
		}
	}

  	function update_onClick(id){  //保存修改后的单条数据
    	if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
  			return false;
		}
		    if(checkAllForms()){
				    form.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=update&backFlag=false";
			    	form.submit();
    	}
	}

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=queryAll";
        form.submit();
    }
        //打开文件上传对话框
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2; 
        var t = (screen.height - h) / 2; 
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
    }
    
        
    function getSupplierList(){
     var ids = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         if(ids==undefined)return;
    document.form.cust_a_id.value=ids[0];
    document.form.cust_a_name.value=ids[2];
     document.form.customer_code.value=ids[1];
    }
   function getSupplierList1(){
     var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    if(ids==undefined)return;
    document.form.agent_b_id.value=ids[0];
    document.form.agent_b_name.value=ids[1];
    }
    
    
</script>
</head>
<body>

<form name="form" method="post">

<div id="right">



 

 
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
	

		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>合同类型</td>
			<td class="td_2"  nowrap="nowrap">
			 <input type="hidden" class="text_field" name="contract_type_bd"  value="<%=contract_type_bd %>" >
			       <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contract_type_bd", -1,"CONTRACT_TYPE_BD",contract_type_bd," id=contract_type_bd  disabled='disabled'  ",false) %> 
			</td>
			<td class="td_1" ><span class="style_required_red">* </span>合同名称</td>
            <td class="td_2 " nowrap="nowrap">
                <input type="text" class="text_field" name="contract_name" inputName="合同名称"  readonly="true" value="<% if(null!=contract_name&&!"".equals(contract_name))   out.print(contract_name);   %>  " maxLength="50" validate="notNull;"/>
            </td>
		</tr>
	
		<tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同甲方</td>
            <td class="td_2 " nowrap="nowrap">
                <input type="hidden"  value="<% if(null!=customer_code&&!"".equals(customer_code))   out.print(customer_code) ; %>"   class="text_field" name="customer_code" inputName="合同甲方" value="" maxLength="9.5" />
                <input type="hidden"     value="<%  if(null!=cust_a_id&&!"".equals(cust_a_id))    out.print(cust_a_id)  ; %>"          class="text_field" name="cust_a_id" inputName="合同甲方" value="" maxLength="9.5" />
               <input type="text" value="<%=customer_name%>"  class="text_field_reference_readonly" validators="isSearch"   validate="notNull;"   name="cust_a_name" inputName="合同甲方"  maxLength="10" />
                <%   if(!isModify) {%>
               <img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getSupplierList();"/>
               <%} %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>合同乙方</td>
            <td class="td_2 " nowrap="nowrap">
                <input type="hidden"  value="<%  if(null!=agent_b_id&&!"".equals(agent_b_id))     out.print(agent_b_id);  %>"    class="text_field" name="agent_b_id" inputName="合同乙方" value="" maxLength="9.5" /> 
                <input type="text"  value="<%  if(null!=agent_b_name&&!"".equals(agent_b_name)&&!"null".equals(agent_b_name))   out.print(agent_b_name)  ;%>" class="text_field_reference_readonly" validators="isSearch" name="agent_b_name"  validate="notNull;"   inputName="合同乙方"  maxLength="10" />
                 <%   if(!isModify) {%>
                <img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getSupplierList1();"/>
                <%} %>
            </td>
        </tr>
        
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>合同起始日期</td>
            <td class="td_2" nowrap="nowrap">
                <input type="text" value="<%=contractstartdate%>  " class="text_field_reference_readonly" name="contract_start_date" id="contract_start_date" inputName="合同起始日期" validate="notNull;"/>

            </td>
           <td class="td_1" >合同终止日期</td>
            <td class="td_2"  nowrap="nowrap">
                <input type="text"  value="<%=contractstartdate  %>" class="text_field_reference_readonly" name="contract_stop_date" id="contract_stop_date" inputName="合同终止日期"  />

                
            </td>
        </tr>
		
		
		
	
				<input type="hidden" class="text_field" name="create_type_bd" inputName="合同生成方式" value="<%= create_type_bd%>" maxLength="64" validate="notNull;"/>
	
		<tr>
		<% 
		  if("1".equals(create_type_bd)){
		   %>
		      <td class="td_1" >合同模板</td>
            <td class="td_2 "    colspan="2">
            <% 
            String contract_template_id=     request.getParameter("contract_template_id");
            request.setAttribute("contract_template_id",contract_template_id);
            %>
                <input type="hidden" class="text_field" name="contract_template_id"  value="<%=contract_template_id %>" >
                 <faerp:contractTemplateSelectTag  beanname="contract_template_id"   strproperty=" disabled='disabled'  "  />
            </td>
		   <% 
		  }else{
		%>
			<td class="td_1" >合同附件</td>
            <td class="td_2 "  colspan="2"  >
   <!--            <input type="text" class="text_field" name="contract_attachment_id" inputName="合同附件ID" value="" maxLength="9.5" />  --> 
                <%    if(!isModify)     {%>
                   <input type="text"   value=""   id="attachNameInput" class="text_field_reference_readonly" name="attach_name" inputName="附件地址" value="" hiddenInputId="attach_name"   validate="notNull;"/><img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"  />
                  <input type="hidden" id="attackAddressInput" name="attach_address" >
                <%  } else {%>
               <% if(isModify&&avo!=null)out.print("<a href='"+request.getContextPath()+"/ProductAction.do?cmd=downLoad&attachment_id="+avo.getId()+"'><font color=blue>"+avo.getAttachment_file_name()+"</font></a>");
                 }%> 
            </td>
               
        
     
		<%}%>
		
	
       
        <td class="td_2" ></td>
        
		</tr>

		
	
		
		
		
		
		
		
	</table>
 

            
   
   
   
            
<input type="hidden" name="id" value="<%   if(null!=id&&!"".equals(id))    out.print(id)  ;%>">
<input type="hidden" name="create_date" />

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
</script>
