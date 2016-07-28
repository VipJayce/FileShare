<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<jsp:useBean id="agentaction" class="rayoo.sales.agent.action.AgentAction" scope="page" />
<%  //判断是否为修改页面

   AgentServiceProductVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
      
        if(request.getAttribute(IAgentServiceProductConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (AgentServiceProductVo)request.getAttribute(IAgentServiceProductConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
%>
<%@page import="rayoo.agent.agentserviceproduct.vo.AgentServiceProductVo"%>
<%@page import="rayoo.agent.agentserviceproduct.util.IAgentServiceProductConstants"%>
<html>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">


    /**
     * 功能描述：动态生成产品大类下拉菜单的内容
     * 参数：  selectId --下拉框id;
     *              key -- 填充时作为option value的对象属性
     *              value -- 填充时作为option展示的对象属性
     */    
    function getAllBigType(selectObject,key,value,selectvalue){
        if(selectObject.length==1) {
            AjaxControl.getBigTypeId("big_type_id",{callback:function(data){
                 //alert('getAllBigType data:'+data+" 长度:" +data.length);
                    if (data != null && typeof data == 'object') 
                    {
                        setSelectForBean(selectObject.id,data,key,value,selectvalue);
                    }
                      <%
                    if(isModify){
                    %>
                    getAllSmallType(document.form.big_type_id,'small_type_id','code','name','<%=isModify ? resultVo.getSmall_type_id() : "" %>');
                    <%}%> 
                }
             
            });
        }else{
            return;
        }
    }


    /**
     * 功能描述：动态生成产品小类下拉菜单的内容
     * 参数：selectObject --下拉框对象;
                    targetId         -- 下拉框目标对象;
     *              key -- 填充时作为option value的对象属性
     *              value -- 填充时作为option展示的对象属性
     */    
    function getAllSmallType(selectObject,targetId,key,value,selectvalue){
    
       var big_type_id=document.form.big_type_id.value;

        AjaxControl.getSmallTypeId(selectObject.value,{callback:function(data){
                if (data != null && typeof data == 'object') 
                {
                    DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
                    DWRUtil.addOptions(targetId,{000:'--请选择--'});
                    setSelectForBean(targetId,data,key,value,selectvalue);
                  
                }
                   <%
                    if(isModify){
                    %>
                    getProdtctName(document.form.small_type_id,'product_id','code','name','<%=isModify ? resultVo.getProduct_name() : "" %>');
                    <%}%> 
                
            }
        });
    }
   /**
     * 功能描述：动态生成产品小类下拉菜单的内容
     * 参数：productId--下拉框对象;
                    targetId         -- 下拉框目标对象;
     *              key -- 填充时作为option value的对象属性
     *              value -- 填充时作为option展示的对象属性
     */    
    function getProdtctName(selectObject,targetId,key,value,selectvalue){
        var big_type_id=document.form.big_type_id.value;
        AjaxControl.getProdtctName(big_type_id,selectObject.value,{callback:function(data){
                if (data != null && typeof data == 'object') 
                {
                    DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
                    DWRUtil.addOptions(targetId,{000:'--请选择--'});
                    setSelectForBean(targetId,data,key,value,selectvalue);
                }
            }
        });
    }
    
    function insert_onClick(){
     var big_type_id=document.form.big_type_id.value;
      var small_type_id=document.form.small_type_id.value;
      var product_id=document.form.product_id.value;
        if(big_type_id==""||big_type_id==null){
            alert(" 产品大类不能为空！");
            return;
        }
         if(small_type_id==""||small_type_id==null){
            alert(" 产品小类不能为空！");
            return;
        }
                 if(product_id==""||product_id==null){
            alert(" 产品名称不能为空！");
            return;
        }
    var param=jQuery("form").serialize();
    var url="<%=request.getContextPath()%>/AgentServiceProductAction.do?cmd=insertProduct&"+param;
    jQuery.post(url,function(data){
    if(data){
           if(data==""){
                      alert('保存失败');
                      return;
              
                 } else{               
                 alert("保存成功");
              window.close();
             }
    
    }else{
       alert("增加失败");
       window.close();
    }
    });
    }
    function update_onClick(){
     var param=jQuery("form").serialize();
    var url="<%=request.getContextPath()%>/AgentServiceProductAction.do?cmd=updateProduct&"+param;
    jQuery.post(url,function(data){
    if(data){
           if(data==0){
                      alert('修改失败');
                      return;
              
                 } else{
                 alert("修改成功");
              window.close();
             }
    
    }else{
       alert("修改失败");
       window.close();
    }
    });
    
    
    }
    
    function getname(){
     var productname=document.getElementById("product_id");
     var product_name=productname[productname.selectedIndex].text;
        document.getElementById("product_name").value=product_name;
    }
    function cancel_onClick(){
     window.close();
    }
</script>
</head>
<body>
<form name="form"  id="form">
<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('修改产品','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('添加产品','<%=request.getContextPath()%>/');
</script>
<input type="hidden" id="product_name" name="product_name" value="">
<input type="text" id="agent_id" name="agent_id" value="${param.agent_id }">
<input type="hidden" name="id" value="">
<input type="hidden" name="company_id" value="">
<div id="ccChild1"     class="box_xinzeng" style="height: 440px"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td width="12%" class="td_1" ><span class="style_required_red">* </span>产品大类</td>
            <td width="19%" class="td_2" >
            <select id="big_type_id" name="big_type_id" onChange="javascript:getAllSmallType(this,'small_type_id','code','name','<%=isModify ? resultVo.getSmall_type_id() : "" %>')">
            <option value="">--请选择--</option>
            </select>            </td>
            <td width="17%" class="td_1" ><span class="style_required_red">* </span>产品小类</td>
            <td width="24%" class="td_2" >
            <select id="small_type_id" name="small_type_id"  onChange="javascript:getProdtctName(this,'product_id','code','name','<%=isModify ? resultVo.getProduct_name() : "" %>')">
            <option value="">--请选择--</option>
            </select>        </td>
        </tr>
        <tr>
        <td class="td_1">城市</td>
        <td align="left" class="td_2">  <r:comboSelect id="countryList"  name="city_id"
                     queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                     textField="city_name"
                     valueField="id"
                     xpath="PB_CITYVo"
                     width="150px" nullText="请选择" property="bean/city_id"/></td>
          <td class="td_1" ><span class="style_required_red">* </span>产品名称</td>
          <td class="td_2 ">
            <select id="product_id" name="product_id" onchange="getname();" >
              <option value="">--请选择--</option>
               
                           
              </select>
          </td>
        </tr>

<tr>
<td class="td_1">享受地</td>
                <td align="left" class="td_2">  <r:comboSelect id="enjoyList"  name="enjoy_city_id"
                     queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                     textField="city_name"
                     valueField="id"
                     xpath="PB_CITYVo"
                     width="150px" nullText="请选择" property="bean/enjoy_city_id"/></td>
  
          <td class="td_1">执行地</td>
        <td align="left" class="td_2">  <r:comboSelect id="executeList"  name="execute_city_id"
                     queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                     textField="city_name"
                     valueField="id"
                     xpath="PB_CITYVo"
                     width="150px" nullText="请选择" property="bean/execute_city_id"/></td>
</tr>
<tr>
<td class="td_1">价格</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="product_price" inputName="价格" value="" maxLength="75" />
            </td>
<td class="td_1">收费频率</td>
<td class="td_2 ">
                         <d:select dictTypeId="FREQUENCY_BD" name="frequency_bd" value="${bean.frequency_bd}"></d:select>
            </td>
            
</tr>
<tr>

            <td class="td_1">有效期</td>
            <td class="td_2 ">
                         <w:date format="yyyy-MM-dd" name="start_date"  property="bean/start_date"/>
            </td>

            <td class="td_1">失效期</td>
            <td class="td_2 ">
                         <w:date format="yyyy-MM-dd" name="end_date"  property="bean/end_date"/>
            </td>
</tr>
      <tr>
            <td class="td_1">产品说明</td>
            <td colspan="3" class="td_2"><textarea style="width: 500px" rows="2" name="description" inputName="产品说明">${bean.remark }</textarea></td>
        </tr>
            <tr>
            <td class="td_1">备注</td>
            <td colspan="3" class="td_2"><textarea style="width: 500px" rows="2" name="remark" inputName="备注">${bean.remark }</textarea></td>
        </tr>
    </table>

    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
      </div>
</div>         

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
   //页面加载后产品大类下拉框填充
 getAllBigType(document.form.big_type_id,'code','name','<%=isModify ? resultVo.getBig_type_id() : "" %>');

</script>
