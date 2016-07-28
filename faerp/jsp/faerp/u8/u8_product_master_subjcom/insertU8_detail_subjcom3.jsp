<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
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
U8_product_detail_subjcomVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IU8_product_detail_subjcomConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (U8_product_detail_subjcomVo)request.getAttribute(IU8_product_detail_subjcomConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<%@page import="rayoo.u8.u8_product_detail_subjcom.vo.U8_product_detail_subjcomVo"%>
<%@page import="rayoo.u8.u8_product_detail_subjcom.util.IU8_product_detail_subjcomConstants"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

    //凭证与二级科目对照设置
    function insert_onClick1(){  //插入单条数据
        var ruletype = $id("ruletype").value;//规则类型  0 固定  1 部门 2 银行  3 产品 4业务类型;
        var dept_id = $id("dept_id").getValue(); //部门编码
        var banktype = $id("banktype").value; //银行类型
        var product_id = $id("product_id").value; //产品ID
        var bustype = $id("bustype").value; //业务类型
        
        var subjcode = $id("subjcode").value;
        var startend = $id("startend").value;
        var enddate = $id("enddate").value;
        //var mark = _$("#mark").val();

        if(subjcode== null || subjcode==""){
          alert("请选择三级科目！");
          return;
        }
        
        if(startend== null || startend==""){
          alert("请选择生效日期！");
          return;
        }
        
        if(enddate== null || enddate==""){
          alert("请选择失效日期！");
          return;
        }
        
         if(ruletype!=null && ruletype!="" && ruletype!="0"){
            if(ruletype=="1"){
                    if(dept_id== null || dept_id==""){
                      alert("请选择部门！");
                      return;
                    }
             }else if(ruletype=="2"){
                    if(banktype==null || banktype==""){
                      alert("请选择银行！");
                      return;
                    }
             }else if(ruletype=="3"){
                    if(product_id==null || product_id==""){
                      alert("请选择产品！");
                      return;
                    }
             }else if(ruletype=="4"){
                    if(bustype==null || bustype==""){
                      alert("请选择业务类型！");
                      return;
                    }
             }   
        }

          var param = jQuery("#datacell_formid").serialize();
          var url="<%=request.getContextPath()%>/U8_product_detail_subjcomAction.do?cmd=insert1&"+param;
            jQuery.post(url,function(data){
                if(data){
                        if(data!=""){
	                        alert("保存成功！");
	                        window.close();  
                        }else{
	                        alert("保存失败！");
	                        window.close();  
                        }
                 }
             });
    }
    
    //凭证与二级科目对照设置
    function update_onClick1(){  //插入单条数据
        var ruletype = $id("ruletype").value;//规则类型  0 固定  1 部门 2 银行  3 产品 4业务类型;
        var dept_id = $id("dept_id").getValue(); //部门编码
        var banktype = $id("banktype").value; //银行类型
        var product_id = document.getElementById("product_id").value; //产品ID
        var bustype = $id("bustype").value; //业务类型
        
        var subjcode = document.getElementById("subjcode").value;
        var startend = $id("startend").value;
        var enddate = $id("enddate").value;
        //var mark = _$("#mark").val();

        if(subjcode== null || subjcode==""){
          alert("请选择三级科目！");
          return;
        }
        
        if(startend== null || startend==""){
          alert("请选择生效日期！");
          return;
        }
        
        if(enddate== null || enddate==""){
          alert("请选择失效日期！");
          return;
        }
        
        if(ruletype!=null && ruletype!=""){
        	if(ruletype=="0"){
         		$id("banktype").value = "";
                document.getElementById("product_id").value= "";
                $id("bustype").value= "";
                document.getElementById("dept_id_hidden").value="";
         	}
            if(ruletype=="1"){
                    if(dept_id== null || dept_id==""){
                      alert("请选择部门！");
                      return;
                    }
                    $id("banktype").value = "";
                    document.getElementById("product_id").value= "";
                    $id("bustype").value= "";
             }else if(ruletype=="2"){
                    if(banktype==null || banktype==""){
                      alert("请选择银行！");
                      return;
                    }
                    document.getElementById("dept_id_hidden").value="";
                    document.getElementById("product_id").value= "";
                    $id("bustype").value= "";
             }else if(ruletype=="3"){
                    if(product_id==null || product_id==""){
                      alert("请选择产品！");
                      return;
                    }
                    $id("banktype").value = "";
                    document.getElementById("dept_id_hidden").value="";
                    $id("bustype").value= "";
             }else if(ruletype=="4"){
                    if(bustype==null || bustype==""){
                      alert("请选择业务类型！");
                      return;
                    }
                    document.getElementById("dept_id_hidden").value="";
                    document.getElementById("product_id").value= "";
                    $id("banktype").value= "";
             }   
        }

          var param = jQuery("#datacell_formid").serialize();
          var url="<%=request.getContextPath()%>/U8_product_detail_subjcomAction.do?cmd=update1Date&"+param;
            jQuery.post(url,function(data){
                if(data){
                        if(data!=""){
	                        alert("保存成功！");
	                        window.close();  
                        }else{
	                        alert("保存失败！");
	                        window.close();  
                        }
                 }
             });
    }

	    function cancel_onClick(){  //取消后返回列表页面
	        window.close();
	    }
    
        //凭证回调方法
        function rtnFunc (arg){
	        var lookup = $id("voucher_remark_id");
	        lookup.value = arg[0];
	        lookup.displayValue = arg[1];
	        return false;
	    }

        //选择二级借方科目回调方法
        function rtnFuncSubjcode3(arg){
            var lookup = $id("subjcode");
            lookup.value = arg[2];
            lookup.displayValue = arg[1];
            _$("#v3_ccode").val(arg[2]);
            return false;
        }

        //凭证与二级科目对照设置 产品2回调方法
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
<input type="hidden" id="v3_ccode"   name="v3_ccode" value="">
<!-- 0 借方 1贷方-->
<input type="hidden" id="classtype"   name="classtype" value="${param.classtype}">
<input type="hidden" id="v_bustype"   name="v_bustype" value="${param.v_bustype}">
<input type="hidden" id="v_product_id"   name="v_product_id" value="${param.v_product_id}">
<input id="product_master_subjcom_id" name="product_master_subjcom_id" type="hidden"  value="${param.id}" />
<input type="hidden" id="parent_id"   name="parent_id" value="${param.parent_id}">
<input type="hidden" id="parent_dept_id" name="parent_dept_id" value="${param.parent_dept_id }">
<input id="id" name="id" type="hidden"  value="${bean.id}" />
<!-- 明细主健 -->
<div id="right">
<div class="box_xinzeng" style="height: 180px;"> 
<div class="xz_title">凭证与三级科目对照设置</div>
<%if(isModify){ %>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>规则类型</td>
            <td class="td_2 ">
                <d:select dictTypeId="RULETYPE_DB" id="ruletype" name="ruletype" property="bean/ruletype" nullLabel="--请选择--"  onchange="ruletype_onClick(this,2)"></d:select>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>选择三级科目</td>
            <td class="td_2" >
            <w:lookup onReturnFunc="rtnFuncSubjcode3" readonly="true"  id="subjcode" name="subjcode"
            lookupUrl="/U8_subjectAction.do?cmd=getQueryPage&v2_ccode=${subjcode}"
            dialogTitle="选择科目" height="450" width="850" style="width:188px" value="${bean.subjcode}" displayValue="${ccode_name}" />        </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>对照生效日期</td>
            <td class="td_2">   
                <w:date  format="yyyy-MM-dd" id="startend" property="bean/startend" name="startend" width="188px"  />                </td>
            <td class="td_1" ><span class="style_required_red">* </span>对照失效日期</td>
            <td class="td_2">
                <w:date  format="yyyy-MM-dd" id="enddate" property="bean/enddate" name="enddate" width="188px"  />
             </td>
        </tr>
        
        <tr id="v_tr_1" style="display: none">
             <td class="td_1" id="v0_td2_1" style="display:">&nbsp;</td>
             <td class="td_2" id="v0_td2_2" style="display:">&nbsp;</td>
             

            <td class="td_1" id="v1_td2_1" style="display:none">
            <span class="style_required_red">* </span>选择部门</td>
                <td class="td_2" id="v1_td2_2" style="display:none">
                <r:comboSelect id="dept_id" name="dept_id" queryAction="/FAERP/FinbillAction.do?cmd=getCustDeptListData&dept=all"
                       textField="name" valueField="id" xpath="AupartyVO" width="205px" nullText="--请选择--" value="${bean.dept_id}" />    
                </td>



            <td class="td_1"  id="v2_td2_1" style="display:none">
            <span class="style_required_red">* </span>选择银行</td>
            <td class="td_2" id="v2_td2_2" style="display:none">
                <d:select dictTypeId="BANK" id="banktype" name="banktype" property="bean/banktype" filterOp="in" filterStr="1,2,4" nullLabel="--请选择--"></d:select>
                </td>

             

            <td class="td_1" id="v3_td2_1" style="display:none">
            <span class="style_required_red">* </span>选择产品</td>
            <td class="td_2" id="v3_td2_2" style="display:none">
                <w:lookup onReturnFunc="rtnFunc_product" readonly="true"  id="product_id" name="product_id"
                lookupUrl="/ProductAction.do?cmd=queryAllProductVoucher"
                dialogTitle="选择产品" height="450" width="850" style="width:188px" value="${bean.product_id}" displayValue="${product_name}" />  
                </td>

             
            <td class="td_1" id="v4_td2_1" style="display:none">
            <span class="style_required_red">* </span>业务类型</td>
            <td class="td_2" id="v4_td2_2" style="display:none">
                <d:select dictTypeId="BUSTYPE_DB" id="bustype" name="bustype" property="bean/bustype" nullLabel="--请选择--"></d:select>
                </td>
        <td class="td_2" >&nbsp;</td>
        <td class="td_2">&nbsp;</td>      
        </tr>
        
        <tr>
            <td class="td_1" >备注</td>
            <td class="td_2 " colspan="2">
                <textarea id="mark" style="width:400px; height:40px;" class="xText_d" rows="3" name="mark">${bean.mark }</textarea>
            </td>
            <td class="td_2" align="left">
            <input type="button" id="bc_2" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:update_onClick1()" />
            <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
            </td>
        </tr>
    </table>
<%}else{ %>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>规则类型</td>
            <td class="td_2 ">
                <d:select dictTypeId="RULETYPE_DB" id="ruletype" name="ruletype" value="0" nullLabel="--请选择--"  onchange="ruletype_onClick(this,2)"></d:select>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span>选择三级科目</td>
            <td class="td_2" >
            <w:lookup onReturnFunc="rtnFuncSubjcode3" readonly="true"  id="subjcode" name="subjcode"
            lookupUrl="/U8_subjectAction.do?cmd=getQueryPage&v2_ccode=${param.subjcode}"
            dialogTitle="选择科目" height="450" width="850" style="width:188px" />        </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span>对照生效日期</td>
            <td class="td_2">   
                <w:date  format="yyyy-MM-dd" id="startend" name="startend" width="188px"  />                </td>
            <td class="td_1" ><span class="style_required_red">* </span>对照失效日期</td>
            <td class="td_2">
                <w:date  format="yyyy-MM-dd" id="enddate" name="enddate" width="188px"  />
             </td>
        </tr>
        
        <tr id="v_tr_1" style="display: none">
             <td class="td_1" id="v0_td2_1" style="display:">&nbsp;</td>
             <td class="td_2" id="v0_td2_2" style="display:">&nbsp;</td>
             

            <td class="td_1" id="v1_td2_1" style="display:none">
            <span class="style_required_red">* </span>选择部门</td>
                <td class="td_2" id="v1_td2_2" style="display:none">
                <r:comboSelect id="dept_id" name="dept_id" queryAction="/FAERP/FinbillAction.do?cmd=getCustDeptListData&dept=all"
                       textField="name" valueField="id" xpath="AupartyVO" width="205px" nullText="--请选择--" />    
                </td>



            <td class="td_1"  id="v2_td2_1" style="display:none">
            <span class="style_required_red">* </span>选择银行</td>
            <td class="td_2" id="v2_td2_2" style="display:none">
                <d:select dictTypeId="BANK" id="banktype" name="banktype" filterOp="in" filterStr="1,2,4" nullLabel="--请选择--"></d:select>
                </td>

             

            <td class="td_1" id="v3_td2_1" style="display:none">
            <span class="style_required_red">* </span>选择产品</td>
            <td class="td_2" id="v3_td2_2" style="display:none">
                <w:lookup onReturnFunc="rtnFunc_product" readonly="true"  id="product_id" name="product_id"
                lookupUrl="/ProductAction.do?cmd=queryAllProductVoucher"
                dialogTitle="选择产品" height="450" width="850" style="width:188px" />  
                </td>

             
            <td class="td_1" id="v4_td2_1" style="display:none">
            <span class="style_required_red">* </span>业务类型</td>
            <td class="td_2" id="v4_td2_2" style="display:none">
                <d:select dictTypeId="BUSTYPE_DB" id="bustype" name="bustype" nullLabel="--请选择--"></d:select>
                </td>
        <td class="td_2" >&nbsp;</td>
        <td class="td_2">&nbsp;</td>      
        </tr>
        
        <tr>
            <td class="td_1" >备注</td>
            <td class="td_2 " colspan="2">
                <textarea id="mark" style="width:400px; height:40px;" class="xText_d" rows="3" name="mark"></textarea>
            </td>
            <td class="td_2" align="left">
            <input type="button" id="bc_2" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:insert_onClick1()" />
            <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
            </td>
        </tr>
    </table>
    <%} %>
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
