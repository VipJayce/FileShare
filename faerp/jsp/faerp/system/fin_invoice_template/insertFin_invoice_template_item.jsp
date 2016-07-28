<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.u8.u8_product_master_subjcom.vo.U8_product_master_subjcomVo" %>
<%@ page import="rayoo.u8.u8_product_master_subjcom.util.IU8_product_master_subjcomConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	U8_product_master_subjcomVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IU8_product_master_subjcomConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (U8_product_master_subjcomVo)request.getAttribute(IU8_product_master_subjcomConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
        var product_id = $id("product_id_hidden").value; //产品ID
        var fin_subjects_code = $id("fin_subjects_code").getValue(); //财务科目

        if(product_id==null || product_id==""){
	           alert("请选择产品！");
	           return;
         }
                    
        if(fin_subjects_code== null || fin_subjects_code==""){
          alert("请选择财务科目！");
          return;
        }
        
          var param = jQuery("#datacell_formid").serialize();
          var url="<%=request.getContextPath()%>/Fin_invoice_template_itemAction.do?cmd=insertData&"+param;
            jQuery.post(url,function(data){
                if(data){
                        if(data!=""){
	                        alert("保存成功！");
	                        window.close();  
                        }else{
	                        alert("保存失败！");
	                        window.close();  
                        }
                 }else{
                            alert("保存失败！");
                            window.close();  
                        }
             });
    }

    function cancel_onClick(){  //取消后返回列表页面
        window.close();
    }
    
        function rtnFunc_product(arg){
            var lookup = $id("product_id");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            return false;
        }
		   
        
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<input id="fin_invoice_template_id" name="fin_invoice_template_id" type="hidden"  value="${param.id}" />
<input id="t_id" name="t_id" type="hidden"  value="${param.t_id}" />
<div id="right">
<div class="box_xinzeng" style="height: 140px;"> 
<div class="xz_title">产品与财务科目对照设置</div><!--  queryAllProduct      queryAllProductVoucher  -->
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>选择产品</td>
            <td class="td_2 ">
                <w:lookup onReturnFunc="rtnFunc_product" readonly="true"  id="product_id" name="product_id"
                lookupUrl="/ProductAction.do?cmd=queryAllProductVoucher"
                dialogTitle="选择产品" height="450" width="850" style="width:185px" value="${param.product_id}" displayValue="${param.product_name}"/>
            </td>
            <td class="td_1" >&nbsp;</td>
            <td class="td_2" >&nbsp;
            </td>
        </tr>
        
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>开票项目</td>
            <td class="td_2 ">
                        <r:comboSelect id="fin_subjects_code" name="fin_subjects_code" value="${param.fin_subjects_code}" queryAction="/FAERP/FIN_INVOICE_CODEAction.do?cmd=getFinSubjectsListData&dd_base=FIN_SUBJECTS_BD"
                       textField="name" valueField="code" xpath="DDBasedataVO" width="200px" nullText="--请选择--" />   
            </td>
            <td class="td_1" >辅助科目</td>
            <td class="td_2" >
                       <r:comboSelect id="fin_small_subjects_bd" name="fin_small_subjects_bd"  value="${param.fin_small_subjects_bd}"  queryAction="/FAERP/FIN_INVOICE_CODEAction.do?cmd=getFinSubjectsListData&dd_base=FIN_SMALL_SUBJECTS_BD"
                       textField="name" valueField="code" xpath="DDBasedataVO" width="200px" nullText="--请选择--" />   
            </td>
        </tr>
        <!--
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>财务科目</td>
            <td class="td_2 ">
                <d:select dictTypeId="FIN_BIG_SUBJECTS_BD" id="fin_big_subjects_bd" name="fin_big_subjects_bd" nullLabel="--请选择--" ></d:select>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>财务明细科目</td>
            <td class="td_2 ">
                <d:select dictTypeId="FIN_SUBJECTS_BD" id="fin_small_subjects_bd" name="fin_small_subjects_bd" nullLabel="--请选择--" ></d:select>
            </td>
        </tr>
          -->
          
    </table>
        <div  align="center" style="padding-top: 10px;">
            <input type="button" id="bc" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:insert_onClick()" />
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

function ruletype_onClick(val,igrade) {

		            var strval=val.value;
		            var v_td_1="#v"+strval+"_td"+igrade+"_1";
		            var v_td_2="#v"+strval+"_td"+igrade+"_2";
		            for(var k=0;k<5;k++){
		                var v1_td_1="#v"+ k +"_td"+igrade+"_1";
		                var v1_td_2="#v"+ k +"_td"+igrade+"_2";
			                if(strval!=""){
				                _$(v1_td_1).css("display", "none");
				                _$(v1_td_2).css("display", "none");
			                }
		            }
		            
		          _$(v_td_1).css("display", "block");
		          _$(v_td_2).css("display", "block");
		          
		          if(strval!=null&&strval!=""&&strval!="0"){
		          _$("#v_tr_1").css("display", "block");
		          }else{
		          _$("#v_tr_1").css("display", "none");
		          
		          }
		          
}   
</script>
