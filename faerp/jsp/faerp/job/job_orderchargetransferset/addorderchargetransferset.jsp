<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">


    function update_onClick(){  //保存修改后的单条数据
      var settype=document.form.settype.value;
      var order_id=document.getElementById("order_id").value;
     var order_code=document.getElementById("order_code").value;
    
             if(order_id==""||order_id==null){
          alert("招聘订单不能为空");
        
          return;
        }
        if(settype==""||settype==null){
          alert("新增方式不能为空");
            document.form.contract_type_bd.focus();
        return;
        }
        
     
     var param="&order_id="+order_id+"&settype="+settype+"&order_code="+order_code;
    if(settype==1){
        var template_id=document.form.list_template.value;
          if(template_id==""||template_id==null){
          alert("费用划转单模版不能为空");
          return;
          }
          param=param+"&template_id="+template_id;
        }
        var url="<%=request.getContextPath()%>/Job_orderchargetransfersetAction.do?cmd=isJob_Order&orderid="+order_id;
         url=url+'&_ts='+(new Date()).getTime(); 
         jQuery.post(url,function(data){
           if(data){
           
           if(data>0){
               alert("该订单已存在费用划转设置，请重新选择招聘订单！");
               return;
           }else{
              form.action="<%=request.getContextPath()%>/Job_orderchargetransfersetAction.do?cmd=insertorderchargetransfersetAction"+param;    
        form.submit();
              } 
           }else{
              alert("程序错误，请重试");
              window.close();
           }
           
           });
        
        
    }

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
    function listchange(){
    var create_type_bd = document.getElementById("settype").value; 
    if(create_type_bd==1){
       document.getElementById( "divid").style.display= "block";
     
          $id("list_template").setWidth("200px");
      
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
            <td class="td_1" ><span class="style_required_red">* </span>招聘订单</td>
            <td class="td_2" >
            
           <w:lookup readonly="true" id="select_name"  name="select_name"
                 lookupUrl="/FAERP/Job_orderchargetransfersetAction.do?cmd=getAllOrder" style="width:180px" dialogTitle="选择招聘订单"
                 height="450" width="745" 
                ></w:lookup>
            <input type="hidden" id="order_id" name="order_id" value="">
                     <input type="hidden" id="order_code" name="order_code" value="">
            </td>
             <td class="td_1" ><span class="style_required_red">* </span>新增方式</td>
            <td class="td_2 ">
                <d:select dictTypeId="SETTYPE_BD" name="settype" id="settype" nullLabel="请选择" onchange="listchange();"/>

            </td>

        </tr>
 
            <tr id="divid" style="display:none;">
                <div> 
                 <td class="td_1"  nowrap="nowrap"><span class="style_required_red">* </span>选择费用划转单模板</td>
                <td class="td_2 ">
               <r:comboSelect id="list_template" name="list_template"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListTemplateData" width="200px"
                       textField="name"
                       valueField="id"
                       xpath=" Job_chargeetransfertemplateVo"
                       nullText="请选择"  />
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

</body>
</html>

<script language="javascript" type="text/javascript">
$id("select_name").onReturnFunc = function (returnValue){
    var lookup = $id("select_name");
    lookup.value = returnValue[0];
    lookup.displayValue = returnValue[1];
    _$("#order_id").val(returnValue[0]);
       _$("#order_code").val(returnValue[2]);
    return false;
}

</script>
