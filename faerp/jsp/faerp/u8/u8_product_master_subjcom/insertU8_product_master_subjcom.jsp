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
		var voucher_remark_id = $id("voucher_remark_id").value;
		var subjcode1_jf = $id("subjcode1_jf").value;
		var subjcode1_df = $id("subjcode1_df").value;
		var startend = $id("startend").value;
		var enddate = $id("enddate").value;
		
		if(voucher_remark_id==""||voucher_remark_id==null){
		  alert("请选择凭证！");
		  return;
		}
		
		if(subjcode1_jf==null && subjcode1_df==null){
          alert("借方科目和贷方科目必须填写其中一个！");
          return;
        }
        
        if(startend==""||startend==null){
          alert("请选择生效日期！");
          return;
        }
        
        
        if(enddate==""||enddate==null){
          alert("请选择失效日期！");
          return;
        }
		
		//if(time_node==""){
        //  alert("请选择TIME_NODE！");
        //  return;
        //}
          var param = jQuery("#datacell_formid").serialize();
          var url="<%=request.getContextPath()%>/U8_product_master_subjcomAction.do?cmd=insert&"+param;
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

    
    
    /*
    //凭证与二级科目对照设置
    function insert_onClick1(numb){  //插入单条数据
        var cust_dept = $id("cust_dept").value;
        var subjcode1 = $id("subjcode1").value;
        var startend1 = $id("startend1").value;
        var enddate1 = $id("enddate1").value;
        var mark1 = _$("#mark1").val();
        
        if(cust_dept==""){
          alert("请选择部门！");
          return;
        }
        
        if(subjcode1==""){
          alert("请选择二级科目！");
          return;
        }
        
        if(startend1==""){
          alert("请选择生效日期！");
          return;
        }
        
        if(enddate1==""){
          alert("请选择失效日期！");
          return;
        }
        
        
          var param = jQuery("#datacell_formid").serialize();
          var url="<%=request.getContextPath()%>/U8_product_detail_subjcomAction.do?cmd=insert1&"+param;
            jQuery.post(url,function(data){
                //alert("data="+data);
                if(data){
                        if(data!=""){
                        alert("保存成功！");
                        //_$("#bc").attr("disabled", true);
                                //alert("id="+data);
                                var retstr= new Array();
                                retstr=data.split(",");
                                
                                    if(retstr[1]!=""){
                                        if(numb==2){
                                            _$("#v2_parent_id").val(retstr[0]);
                                        }
                                        
                                        if(numb==3){
                                            _$("#v3_parent_id").val(retstr[0]);
                                        }
                                    }
                                    
                                    if(numb==2){
                                            _$("#bc_2").attr("disabled", true);
                                            document.getElementById("div2").style.display='';
                                        }
                                        
                                     if(numb==3){
                                             _$("#bc_3").attr("disabled", true);
                                     }
                                
                        }else{
                        alert("保存失败！");
                        document.getElementById("div2").style.display='none';
                        }
                 }
             });
    }
    
    */

    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/U8_product_master_subjcomAction.do?cmd=queryAll&backFlag=true";
        //form.submit();
        window.close();
    }
    
        //凭证回调方法
        function rtnFunc (arg){
	        var lookup = $id("voucher_remark_id");
	        lookup.value = arg[0];
	        lookup.displayValue = arg[1];
	        return false;
	    }
	    
	    //选择一级借方科目回调方法
	    function rtnFuncSubjcode1_jf(arg){
            var lookup = $id("subjcode1_jf");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            //一级科目的ID
            //_$("#v1_id_jf").val(arg[0]);
            //一级科目的编码
            _$("#v1_ccode_jf").val(arg[2]);
            return false;
        }
        
        //选择一级贷方科目回调方法
        function rtnFuncSubjcode1_df(arg){
            var lookup = $id("subjcode1_df");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            //一级科目的ID
            ////_$("#v1_id_df").val(arg[0]);
            //一级科目的编码
            _$("#v1_ccode_df").val(arg[2]);
            return false;
        }
        
        //选择二级借方科目回调方法
        function rtnFuncSubjcode2_jf(arg){
            var lookup = $id("subjcode2_jf");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            //二级科目的ID
            //_$("#v2_id_jf").val(arg[0]);
            //二级科目的编码
            _$("#v2_ccode_jf").val(arg[2]);
            return false;
        }
        
        //选择二级贷方科目回调方法
        function rtnFuncSubjcode2_df(arg){
            var lookup = $id("subjcode2_df");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            //二级科目的ID
            //_$("#v2_id").val(arg[0]);
            //二级科目的编码
            _$("#v2_ccode_df").val(arg[2]);
            return false;
        }
        
        //选择三级借方科目回调方法
        function rtnFuncSubjcode3_jf(arg){
            var lookup = $id("subjcode3_jf");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            //三级科目的ID
            //_$("#v2_id_jf").val(arg[0]);
            //三级科目的编码
            _$("#v3_ccode_jf").val(arg[2]);
            return false;
        }
        
        //选择三级贷方科目回调方法
        function rtnFuncSubjcode3_df(arg){
            var lookup = $id("subjcode3_df");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            //三级科目的ID
            //_$("#v3_id").val(arg[0]);
            //三级科目的编码
            _$("#v3_ccode_df").val(arg[2]);
            return false;
        }
        
        //凭证与二级科目对照设置 产品2回调方法
        function rtnFunc_product2(arg){
            var lookup = $id("product_id2");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            return false;
        }
        
        //凭证与三级科目对照设置 产品3回调方法
        function rtnFunc_product3(arg){
            var lookup = $id("product_id3");
            lookup.value = arg[0];
            lookup.displayValue = arg[1];
            return false;
        }
		  
	    function toSave_onClick() {
            if($id("datacell1").submit()){
                alert("保存成功！");
                document.getElementById("div2").style.display='';
            }
        }   
        
        
        
      
        
        
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<!-- 一级科目ID -->
<input type="hidden" id="v1_id_jf" name="v1_id" value="">
<!-- 二级科目ID -->
<input type="hidden" id="v2_id" name="v2_id" value="">
<!-- 三级科目ID -->
<input type="hidden" id="v3_id" name="v3_id" value="">
<!-- 一级科目code    v1_ccode-->
<input type="hidden" id="v1_ccode_jf"   name="v1_ccode_jf" value="">
<input type="hidden" id="v1_ccode_df" name="v1_ccode_df" value="">
<!-- 二级科目code -->
<input type="hidden" id="v2_ccode_jf"   name="v2_ccode_jf" value="">
<input type="hidden" id="v2_ccode_df" name="v2_ccode_df" value="">
<!-- 三级科目code -->
<input type="hidden" id="v3_ccode_jf"   name="v3_ccode_jf" value="">
<input type="hidden" id="v3_ccode_df" name="v3_ccode_df" value="">

<input id="product_master_subjcom_id" name="product_master_subjcom_id" type="hidden"  value="" />

<!-- 明细主健 -->
<input id="v2_parent_id" name="v2_parent_id" type="hidden"  value="" />
<input id="v3_parent_id" name="v3_parent_id" type="hidden"  value="" />

 
<div id="right">
<div id="ccChild1"     class="box_xinzeng" style="height: 190px">
<div class="xz_title" style="padding-top: 5px">凭证与一级科目对照设置</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td  class="td_1" ><span class="style_required_red">* </span>选择凭证</td>
			<td  class="td_2 ">
				<w:lookup onReturnFunc="rtnFunc" readonly="true"  id="voucher_remark_id" name="voucher_remark_id"
            lookupUrl="/U8_voucher_remarkAction.do?cmd=queryAllVoucherPage"
            dialogTitle="选择凭证" height="450" width="850" style="width:188px" />		  </td>
			<td  class="td_1" >选择借方科目</td>
			<td  class="td_2" >
			<w:lookup onReturnFunc="rtnFuncSubjcode1_jf" readonly="true"  id="subjcode1_jf" name="subjcode1_jf"
            displayProperty="subjcode_jf"  lookupUrl="/U8_subjectAction.do?cmd=getQueryPage"
            dialogTitle="选择科目" height="450" width="850" style="width:188px" />		  </td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>对照生效日期</td>
			<td class="td_2">	
				<w:date  format="yyyy-MM-dd" id="startend" name="startend" width="188px"  />				</td>
			<td class="td_1" >选择贷方科目</td>
			<td class="td_2">
			    <w:lookup onReturnFunc="rtnFuncSubjcode1_df" readonly="true"  id="subjcode1_df" name="subjcode1_df"
            displayProperty="subjcode_df"  lookupUrl="/U8_subjectAction.do?cmd=getQueryPage"
            dialogTitle="选择科目" height="450" width="850" style="width:188px" />      		 </td>
		</tr>
		<tr>
			<td class="td_1" ><span class="style_required_red">* </span>对照失效日期</td>
			<td class="td_2 " colspan="3">
				<w:date  format="yyyy-MM-dd" id="enddate" name="enddate" width="188px"  />  </td>
		</tr>
		<tr>
            <td class="td_1" >备注</td>
            <td class="td_2 " colspan="2">
                <textarea id="mark" style="width:400px; height:40px;" class="xText_d" rows="3" name="mark"></textarea>
            </td>
            <td colspan="2" class="td_2" align="center">
            <input type="button" id="bc" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:insert_onClick()" />
            <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
            </td>
        </tr>
	</table>
 
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

$id("subjcode2_jf").beforeOpenDialog= function(lookup){
        lookup.params = [];
        var v1_ccode=_$("#v1_ccode_jf").val();
        lookup.addParam("v1_ccode",v1_ccode);
        return true;
}

$id("subjcode2_df").beforeOpenDialog= function(lookup){
        lookup.params = [];
        var v1_ccode=_$("#v1_ccode_df").val();
        lookup.addParam("v1_ccode",v1_ccode);
        return true;
}


/*
$id("subjcode3_jf").beforeOpenDialog= function(lookup){
        lookup.params = [];
        var v2_ccode=_$("#v2_ccode_jf").val();
        lookup.addParam("v2_ccode",v2_ccode);
        return true;
}

$id("subjcode3_df").beforeOpenDialog= function(lookup){
        lookup.params = [];
        var v2_ccode=_$("#v2_ccode_df").val();
        lookup.addParam("v2_ccode",v2_ccode);
        return true;
}
*/

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
		          
}   
</script>
