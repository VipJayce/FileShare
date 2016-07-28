<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.security.socialaccountcust.vo.SocialaccountcustVo" %>
<%@ page import="rayoo.customerservice.security.socialaccountcust.util.ISocialaccountcustConstants" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>

<%  //判断是否为修改页面
    SocialaccountcustVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ISocialaccountcustConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (SocialaccountcustVo)request.getAttribute(ISocialaccountcustConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
    String group_type = request.getParameter("group_type");
    String security_type = request.getParameter("security_type");
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

//城市社保组联动标签1099110100000000050
function citySecurityGroupchange(seletvalue){
    //alert(seletvalue);
      SecurityGroupAjax.getCitySecurityGroup(seletvalue,{callback:function(data){
                    setSelectForBean("social_group_id",data,"id","group_name","");
                    if(<%=isModify%>){
                         document.getElementById("social_group_id").value="<%=resultVo==null?"":resultVo.getSocial_group_id()%>";
                    }
                }
            });
    }
    
    function insert_onClick(){  //插入单条数据
    var frm = $id("datacell_formid");   
      //表单验证
      if( !checkForm(frm) ) {
          
          return;
      }   
      
      var cust_id=jQuery("#cust_id").val();
      var social_group_id=jQuery("input[name='social_group_id']").val();
        if(checkAll()&&checkCust_id(cust_id,social_group_id)){
     
        //form.action="<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=insert";
        //var action = "<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=inTransactionSecurity";
        var action = "<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=insert";
        var myAjax = new Ajax(action);
            var form = $id("datacell_formid");
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }       
             myAjax.submit();
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                  alert(""+myAjax.getProperty("returnValue"));
                  window['returnValue'] = ""+myAjax.getProperty("returnValue");
                  window.close();
                  window.opener.callBack(myAjax.getProperty("returnValue"));
             }
        //form.submit();
        //window.close();
        }
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
         var cust_id=jQuery("#cust_id").val();


        var action ="<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=update";
        var myAjax = new Ajax(action);
            var form = $id("datacell_formid");
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }       
             myAjax.submit();
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                  alert(""+myAjax.getProperty("returnValue"));
                  window['returnValue'] = ""+myAjax.getProperty("returnValue");
                  window.close();
                  //window.opener.callBack(myAjax.getProperty("returnValue"));
                  window.opener.$id("datacell1").loadData();
                  window.opener.$id("datacell1").refresh();
             }

    }
    
    function checkAll(){

       return true;
    }
    
    function checkCust_id(cust_id,social_group_id){
    var flag = true;
     jQuery.ajax({
                url: "<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=custIsExist&custId="+cust_id+"&socialGroupId="+social_group_id+"&date="+new Date()+"",
                type: 'GET',
                dataType: 'html',
                async: false,
                timeout: 10000,
                error: function(){
                    alert('Error loading XML document');
                    return  null;
                },
                success: function(text){
                    if(text=="1"){
                       alert("该客户已经存在，请重新选择客户");
                       flag = false;
                   }else{
                      flag = true;
                   }
                }
            });
       return flag;
    
    }
    

    function cancel_onClick(){  //取消后返回列表页面
<!--        form.action="<%=request.getContextPath()%>/SocialaccountcustAction.do?cmd=queryAll&backFlag=true";-->
<!--        form.submit();-->
        window.close();
    }

 function rtnFuncCustomer(arg){
    var cust_id = $id("cust_id");
    var cust_code=$id("cust_code");
    var cust_name=$id("cust_name");
    //alert(arg[0]+"----"+arg[1]+"----"+arg[2]);
    cust_id.value = arg[0];
    cust_code.displayValue= arg[1];
    cust_name.value = arg[2];
    return false;
}
</script>
</head>
<body>
<h:form  checkType="blur" name="datacell_formid" method="post"  id="datacell_formid"> 
<div id="right">
<!--<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('客户账号修改','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('客户账号新增','<%=request.getContextPath()%>/');
</script>


 

 
 -->
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <input type="hidden" name="group_type" value="${param.group_type}">
        <input type="hidden" name="security_type" value="${param.security_type}">
        <%
                   if(isModify){
                   }else{
                   
                  %>
        <tr>
            <td class="td_1" >城市</td>
            <td class="td_2" colspan="3">
	            <r:comboSelect id="city_idList_search" name="city_id"
	                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
	                       textField="city_name"
	                       valueField="id"
	                       xpath="PB_CITYVo"
	                       width="200px"
	                       value="1099110100000000357"
	                       nullText="请选择" 
	                       />
	        </td>
        </tr>
        <%} %>
        <tr>
            <td class="td_1" >社保/公积金组</td>
            <td class="td_2 ">
            
                  <%
                   if(isModify){
                  %>
                     <input type="text" class="text_field" id="group_name" name="group_name"  inputName="社保/公积金组"  readonly="readonly" value=" ${bean.group_name}" />
                  
                   <input type="hidden" class="text_field" id="social_group_id" name="social_group_id"  inputName="社保/公积金组编号" value=" ${bean.social_group_id}" />
              
                  <%
                   }else{
                  %>
            
               <r:comboSelect id="group_List" name="social_group_id"
                       queryAction="/FAERP/EmppostAction.do?cmd=getGroupListByCity&type=${param.group_type}"
                       valueField="id"
                       textField="group_name"
                       xpath="SecuritygroupVo"
                       width="200px"
                       linkId="city_idList_search"
                       nullText="请选择" />
                        <%
                   }
                        %>
            </td>
            <c:choose>
               <c:when test="${param.group_type=='2'}">
            <td class="td_1" >缴纳银行</td>
            <td class="td_2" ><input type="text" class="text_field" name="paying_bank" inputName="缴纳银行" value="${bean.paying_bank }" maxLength="64" /></td>
               </c:when>
               <c:when test="${param.group_type!='2'}">
            <td class="td_1" ></td>
            <td class="td_2" ></td>
               </c:when>
            </c:choose>
        </tr>
        <tr>
              <td class="td_1" >客户编号</td>
                <td class="td_2 ">
                  <input type="hidden" name="cust_id" id="cust_id" value="${bean.cust_id }" >

                  <%
                   if(isModify){
                  %>
                   <input type="text" class="text_field" id="cust_code" name="cust_code"  inputName="客户编号"  readonly="readonly" value="${bean.customer_code}" />
                 <%
                  }else{
                 %>
                  <w:lookup  validateAttr="allowNull=false;"  onReturnFunc="rtnFuncCustomer" readonly="true" id="cust_code" name="cust_code" displayValue="${bean.customer_code}" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:185px"/>
                    <%
                                       }
                    %>         
  </td>
            <td class="td_1" >客户名称</td>
                <td class="td_2 ">
                    <input type="text" class="text_field" id="cust_name" name=cust_name  inputName="客户名称"  readonly="readonly" value="${bean.customer_name}" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >账号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="accounts" inputName="账号" value="${bean.accounts }" validate="isNum;" maxLength="64" />
            </td>
            <td class="td_1" >开户单位</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="open_unit" inputName="开户单位" value="${bean.open_unit }" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" >开户单位账号</td>
            <td class="td_2 ">
                <input type="text" class="text_field" name="open_unit_accounts" inputName="开户单位账号" value="${bean.open_unit_accounts }" validate="isNum;" maxLength="64" />
            </td>
            <td class="td_1" >是否FESCO支付</td>
            <td class="td_2" >
                 <d:select name="is_fesco_pay" dictTypeId="TrueOrFalse" value="${bean.is_fesco_pay }"  nullLabel="--请选择--" style="width: 205px"/>
            </td>
        </tr>
        <c:choose>
          <c:when test="${param.group_type=='2'}">
              <tr>
                    <td class="td_1" >操作截止日</td>
                    <td class="td_2 ">
                        <input type="text" class="text_field" name="end_date" inputName="操作截止日" value="${bean.end_date }" validate="isValidDay;" maxLength="64" />
                    </td>
                    <td class="td_1" >应进账日</td>
                    <td class="td_2" >
                        <d:select name="get_month" dictTypeId="GET_MONTH" value="${bean.get_month }"  nullLabel="--请选择--" style="width: 85px"/>
                        <h:select id="get_day" name="get_day" property="bean/get_day" style="width: 85px">
                            <h:option value="" label="-请选择-"/>
                            <%for(int i=1;i<31;i++){ 
                                String aa = i+"";
                                %>
                            <h:option value="<%=aa %>" label="<%=aa %>"/>
                            <%} %>
                        </h:select>
                        日
                    </td>
              </tr>
              <tr>
                    <td class="td_1" >盖章方</td>
                    <td class="td_2 ">
                        <input type="text" class="text_field" name="seal_party" inputName="盖章方" value="${bean.seal_party }" maxLength="64" />
                    </td>
                    <td class="td_1" >备注</td>
                    <td class="td_2" >
                        <input type="text" class="text_field" name="remarks" inputName="备注" value="${bean.remarks }" maxLength="64" />
                    </td>
              </tr>
          </c:when>
        </c:choose>
    </table>
    <div align="center">
        <input type="button" class="icon_2" value='保存' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:cancel_onClick()"/>
   </div>
</div>         
            
<input type="hidden" name="acust_id" value="${bean.id }">
<input type="hidden" name="create_date" />

</h:form>



</body>
</html>

<script language="javascript">

    //citySecurityGroupchange("1099110100000000050");
</script>
