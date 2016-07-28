<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.agent.agentprojectbook.vo.AgentprojectbookVo" %>
<%@ page import="rayoo.agent.agentprojectbook.util.IAgentprojectbookConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
 <%  //判断是否为修改页面
    AgentprojectbookVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(IAgentprojectbookConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (AgentprojectbookVo)request.getAttribute(IAgentprojectbookConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
%> 
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
   function  bianjiCheckbox_onClick(){
       var ids=document.getElementById("projectbookid").value;
           var pj1=$id("datacell1").dataset;
             var price=0;
               var entityAry=pj1.getAlltEntities();
              for( i=0;i<entityAry.length;i++){
                if("服务费"==entityAry[i].getValue("product_name")){
                     price=entityAry[i].getValue("product_price");
                };
              }
                       
            var url="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=detailtemple&id="+ ids+"&price="+price;
                   
                      showModalCenter(url, window,"", 700, 450, "服务条款页面"); 
   }
function cancel_onClick(){
       form.action="<%=request.getContextPath()%>/AgentprojectbookAction.do?cmd=queryAll";
           form.submit();
}
       window.onload=function(){//设置项目书开始时间不能修改
       $id("start_date").setReadOnly(true);
       $id("end_date").setReadOnly(true);
  }
</script>

</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" id="projectbookid" name="projectbookid" value="${bean.id }">
<div id="right">
<script language="javascript">
        writeTableTopFesco('查看项目书','<%=request.getContextPath()%>/');
</script>

 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng" style="height: 230px"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
 
        <tr>
            <td class="td_1" >项目书编号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="projectbook_code"   maxLength="25" value="${bean.projectbook_code }" readonly="readonly"/>
            </td>
             <td class="td_1" >账单收取月</td>
            <td class="td_2 " >
                <d:select id="payment_month" name="payment_month" dictTypeId="PAYMENT_MONTH" value="${bean.payment_month}" disabled="true" ></d:select>           
            </td>
        </tr>
        <tr>
            <td class="td_1" >项目书名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="projectbook_name" name="projectbook_name" inputName="projectbook_name" value="${bean.projectbook_name }" maxLength="50" readonly="readonly" />
            </td>
        <td class="td_1" >城市</td>
            <td class="td_2 ">
             <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       property="bean/city_id"
                       width="200px"
                       nullText="请选择" readonly="true"/>        
            </td>
        </tr>
        <tr>
           <td class="td_1" >客户名称</td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="cust_name" name="cust_name" inputName="cust_code" value="${bean.cust_name }" maxLength="25" readonly="readonly"/>
            </td>
        <td class="td_1" >委派单</td>
      <td align="left" class="td_2"><input name="send_name" id="send_name" value="${bean.send_name }" readonly="readonly" size="28"> </td>
        </tr>
        <tr>
        <td class="td_1" >受托单位</td>
        <td class="td_2 ">
        <input name="cust_receive_customer" id="cust_receive_customer" value="${bean.cust_receive_customer}" readonly="readonly" size="28">
          
            </td>
           <td class="td_1" >委托单位</td>
          <td class="td_2 ">
              <input name="cust_send_customer" id="cust_send_customer" value="${bean.cust_send_customer}" readonly="readonly" size="28">
            </td>
            
                
        </tr>
        <tr>
          <td class="td_1" >开始时间</td>
            <td class="td_2 ">
                   <w:date allowInput="true" id="start_date" name="start_date" format="yyyy-MM-dd" width="185px" property="bean/start_date" readonly="true" />  
            </td>
                    <td class="td_1" >结束时间</td>
            <td class="td_2 ">
                   <w:date allowInput="true" id="end_date" name="end_date" format="yyyy-MM-dd" width="185px" property="bean/end_date" readonly="readonly" />  
            </td>
        </tr>
        <tr>
        <td  class="td_1" nowrap="nowrap">项目书类型</td>
          
            <td class="td_2 " >
          <d:select dictTypeId="PROJECTBOOK_TYPE_BD" id="projectbook_type" name="projectbook_type" nullLabel="请选择" value="${bean.projectbook_type}" disabled="true" />
         
            </td>
        <td class="td_1">服务条款模板</td>
    
      <td class="td_2">
       <div id="ccParent1" class="button">
    <div class="button_right">
            
       <input class="b"  type="button"   value="查看" onClick="bianjiCheckbox_onClick();"></div></div>
       <input type="hidden" id="templete_content" name="templete_content" value="${bean.templete_content }">
       </td>
       
        </tr>
          <tr>
            <td class="td_1">特殊说明</td>
            <td colspan="3" class="td_2"><textarea style="width: 500px" rows="2" name="special_description" inputName="特殊说明" readonly="readonly">${bean.special_description }</textarea></td>
        </tr>
    </table>
   
</div>
 
 <div id="ccParent1" class="button" >
    <div class="xz_title" style="padding-top: 10px">产品配置</div>
    <div class="clear"></div>
    </div>
    <div style="padding: 8 10 8 8;">
    <r:datacell  id="datacell1"
          queryAction="/FAERP/AgentpbserviceproductAction.do?cmd=querypbProduct"      
        width="98%" height="190px" xpath="AgentpbserviceproductVo"  
         paramFormId="datacell_formid" readonly="true" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="big_type_id" label="产品大类" width="75px" >
         <d:select dictTypeId="big_type_id"  disabled="true"></d:select>
        </r:field>
        <r:field fieldName="small_type_id" label="产品小类" width="130px" >
         <d:select dictTypeId="big_type_id"  ></d:select>
        </r:field>
        <r:field fieldName="city_id" label="福利地" width="100px" >
          <r:comboSelect id="cityList" name="cityList " queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name" valueField="id" nullText=""  xpath="PB_CITYVo" readonly="true" ></r:comboSelect>               
        </r:field>
        <r:field fieldName="product_name" label="产品名称" width="150px" >
        </r:field>
        <r:field fieldName="product_price" label="价格" width="70px"  ><h:text/>
        </r:field>
         <r:field fieldName="start_date" label="开始日期" width="85px" >
        <w:date format="yyyy-MM-dd"  />
        </r:field>
        <r:field fieldName="end_date" label="截止日期" width="85px" >
            <w:date format="yyyy-MM-dd"   />
         </r:field>
        <r:field fieldName="description" label="产品说明" width="250px" >
        </r:field>
        <r:field fieldName="remark" label="备注" width="150px" >
        </r:field>
    </r:datacell>
       合计：<input type="text" id="sumprice" name="sumprice" value="" readonly="readonly">
    </div>
    
    
    
     <div id="ccParent1" >
    <div class="xz_title" style="padding-top: 10px">服务配置</div>
    <div class="clear"></div>
    </div>
    <div style="padding: 8 10 8 8;">
    <r:datacell  id="datacell2"
        queryAction="/FAERP/AgentpbserviceitemAction.do?cmd=querypbItem" 
        width="98%" height="190px"  xpath="AgentpbserviceitemVo"  
         paramFormId="datacell_formid" readonly="true" pageSize="-1">
          <r:toolbar location="bottom" tools="nav,pagesize,info" />
           <r:field fieldName="city_id" label="办理城市" width="100px"  >
          <r:comboSelect id="cityList1" name="cityList1 " queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name" valueField="id" nullText=""  xpath="PB_CITYVo" readonly="true"></r:comboSelect>               
        </r:field>
        <r:field fieldName="contact_name" label="手续名称" width="150px" >
        </r:field>
        <r:field fieldName="post_belong" label="入离职归属" width="80px"  >
            <d:select dictTypeId="POST_BELONG_BD" nullLabel="请选择"></d:select>
        </r:field>
        <r:field fieldName="remark" label="备注" width="350px"  >
           
        </r:field>
    </r:datacell>
    </div>
<div class="mx_button" align="center">
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
    function countAllMoney(){
        var allmoney=0;
                 var datacell1 = $id("datacell1");
        var dataset1 = datacell1.dataset;//取得页面的datacell
        for(var i=0; i<dataset1.getLength(); i++){
            var mm = dataset1.get(i).getProperty("product_price");         
                allmoney+= parseFloat(mm);  
       }
       
           document.getElementById("sumprice").value=allmoney.toFixed(2);
    }
    $id("datacell1").afterLoadData=function(){
      countAllMoney();
    }
</script>
