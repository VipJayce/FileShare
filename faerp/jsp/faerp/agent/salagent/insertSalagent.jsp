<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp"%>
<h:script src="/js/common/backspace_forbid.js"/>
<%  //判断是否为修改页面
    SalagentVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(ISalagentConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (SalagentVo)request.getAttribute(ISalagentConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
    
    String seq_AgentCode = request.getAttribute("code")==null ? "" : request.getAttribute("code").toString();
%>
<%@page import="rayoo.agent.salagent.vo.SalagentVo"%>
<%@page import="rayoo.agent.salagent.util.ISalagentConstants"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><%=isModify?"供应商修改":"供应商增加" %></title>
    <script type="text/javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
    <script language="javascript">

   
        function insert_onClick(){  //插入单条数据   
       var agent_code=document.form.agent_code.value;
        var cooperation_start_date=document.form.cooperation_start_date
         var agent_name=document.form.agent_name.value;
        var agent_type=document.form.agent_type.value;
        var city_id=document.form.city_id.value;
        var  registered_capital=document.form.registered_capital.value;
           var bank_account1=document.form.bank_account1.value;
      
             var contact_email1=document.form.contact_email1.value;
            var contact_email2=document.form.contact_email2.value;
            
          var cooperation_start_date=document.form.cooperation_start_date.value;
          var bank1=document.form.bank1.value;
         var month_pay_date=document.form.month_pay_date.value;
         var bank_address1=document.form.bank_address1.value;
           if(agent_code==""||agent_code==null){
            alert(" 供应商编号不能为空！");
            return;
        }
        if(agent_type==""||agent_type==null){
            alert(" 供应商类型不能为空！");
            document.form.agent_type.focus();
            return;
        }
        if(agent_name==""||agent_name==null){
            alert(" 供应商名称不能为空！");
            document.form.agent_name.focus();
            return;
        }
        
        if(city_id==""||city_id==null){
            alert(" 城市不能为空！");
          
            return;
        }
            if( registered_capital!=null&& registered_capital!=""){
            if(!checkNum1( registered_capital)){
                alert("注册资本只能为数字（包括小数）");
                document.form.registered_capital.focus();
                return;
            }
        }
          if(bank1==""||bank1==null){
            alert(" 开户行不能为空！");
            return;
        }
               if(bank_address1==""||bank_address1==null){
            alert(" 开户行单位名称不能为空！");
            return;
        }
            if(bank_account1!=null&&bank_account1!=""){
            if(!checkNum(bank_account1)){
                alert("账户号为12~20位数字！");
                document.form.bank_account1.focus();
                return;
            }
        }
             if(month_pay_date==""||month_pay_date==null){
            alert("每月付款时间不能为空！");
            return;
        }
            if(!isNumber(month_pay_date)){
         alert('每月付款日期必须为数字。');
         return;
        }
         if (month_pay_date < 1 ||month_pay_date> 31) {
                alert('日期有效值为1-31。');
                return;
                }
          if(cooperation_start_date!=null&&cooperation_start_date!=""){
            if(!checkNum2(cooperation_start_date)){
                alert("合同起始年月格式有误,正确格式如:2013/02");
                document.form.cooperation_start_date.focus();
                return;
            }
        }
            if(contact_email1!=null&&contact_email1!=""){
            if(!checkEmail(contact_email1)){
                alert("请输入正确的邮箱地址!");
                document.form.contact_email1.focus();
                return;
            }
        }
                 if(contact_email2!=null&&contact_email2!=""){
            if(!checkEmail(contact_email2)){
                alert("请输入正确的邮箱地址!");
                document.form.contact_email2.focus();
                return;
            }
        }
       jQuery("#save1").attr("disable",true);

       
        var param = jQuery("#datacell_formid").serialize();
        var url="<%=request.getContextPath()%>/SalagentAction.do?cmd=insert&code="+agent_code+"&"+param;
       jQuery.post(url,function(data){
             if(data){
                 if(data==""){
                      alert('保存失败');
                   jQuery("#save1").attr("disable",false);
                      return;
                      }else if(data=="false"){
                       alert('数据库中供应商编号相同，请重新生成');
                             jQuery("#save1").attr("disable",false);
                      return;            
                }else{
                 alert("保存成功");
                window.close();
                 window.opener.simpleQuery_onClick();
             }
            
             }else{
                 alert("保存失败");
                jQuery("#save1").attr("disable",false);
               return;
                    }
       });
    }

    function update_onClick(id){  //保存修改后的单条数据

      var agent_code=document.form.agent_code.value;
          var agent_name=document.form.agent_name.value;
        var agent_type=document.form.agent_type.value;
        var city_id=document.form.city_id.value;
        var  registered_capital=document.form.registered_capital.value;
           var bank_account1=document.form.bank_account1.value;
      
             var contact_email1=document.form.contact_email1.value;
            var contact_email2=document.form.contact_email2.value;
             var cooperation_start_date=document.form.cooperation_start_date.value;
          var bank1=document.form.bank1.value;
         var month_pay_date=document.form.month_pay_date.value;
         var bank_address1=document.form.bank_address1.value;
           if(agent_code==""||agent_code==null){
            alert(" 供应商编号不能为空！");
            return;
        }
        if(agent_type==""||agent_type==null){
            alert(" 供应商类型不能为空！");
            document.form.agent_type.focus();
            return;
        }
        if(agent_name==""||agent_name==null){
            alert(" 供应商名称不能为空！");
            document.form.agent_name.focus();
            return;
        }
        
        if(city_id==""||city_id==null){
            alert(" 城市不能为空！");
        
            return;
        }
            if( registered_capital!=null&& registered_capital!=""){
            if(!checkNum1( registered_capital)){
                alert("注册资本只能为数字（包括小数）");
                document.form.registered_capital.focus();
                return;
            }
        }
          if(bank1==""||bank1==null){
            alert(" 开户行不能为空！");
            return;
        }
               if(bank_address1==""||bank_address1==null){
            alert(" 开户行单位名称不能为空！");
            return;
        }
            if(bank_account1!=null&&bank_account1!=""){
            if(!checkNum(bank_account1)){
                alert("账户号为12~20位数字！");
                document.form.bank_account1.focus();
                return;
            }
        }
      
             if(month_pay_date==""||month_pay_date==null){
            alert("每月付款日期不能为空！");
            return;
        }
        if(!isNumber(month_pay_date)){
         alert('每月付款日期必须为数字。');
         return;
        }
         if (month_pay_date < 1 ||month_pay_date> 31) {
                alert('日期有效值为1-31。');
                return;
                }
          if(cooperation_start_date!=null&&cooperation_start_date!=""){
            if(!checkNum2(cooperation_start_date)){
                alert("合同起始年月格式有误,正确格式如:2013/02");
                document.form.cooperation_start_date.focus();
                return;
            }
        }
            if(contact_email1!=null&&contact_email1!=""){
            if(!checkEmail(contact_email1)){
                alert("请输入正确的邮箱地址!");
                document.form.contact_email1.focus();
                return;
            }
        }
                 if(contact_email2!=null&&contact_email2!=""){
            if(!checkEmail(contact_email2)){
                alert("请输入正确的邮箱地址!");
                document.form.contact_email2.focus();
                return;
            }
        }
           jQuery("#save1").attr("disable",true);
   
        var param = jQuery("#datacell_formid").serialize();
var url="<%=request.getContextPath()%>/SalagentAction.do?cmd=update&"+param;
        jQuery.post(url,function(data){
    
             if(data){
                 if(data==0){
                      alert('修改失败!');
                       jQuery("#save1").attr("disable",false);
                      return;
                 }else{
                    alert("修改成功");
                    window.close();
                    window.opener.simpleQuery_onClick();
                 }
                 
             }else{
                      alert('修改失败!');
                            jQuery("#save1").attr("disable",false);
           return;
                    }
       });
                  
   
    }
    
    function cancel_onClick(){  //取消后返回列表页面
    window.close();
       
    }
   
    function checkNum(num){
        if(isNaN(num)) {
            return false;
        }
        if(num.match(/\d/g).length<12||num.match(/\d/g).length>20){
            return false;
        }
        return true;
    } 
   function checkNum1(num){
 
           var pattern =/^[0-9]{1,}\.?[0-9]{1,}$/;
        if(!pattern.exec(num)){
          return false;
        }
        return true;
   }
      function checkNum2(num){

  var pattern =/^[0-9]{4,4}\/[0-1]{1,1}[0-9]{1,1}$/;
        if(!pattern.exec(num)){
          return false;
        }
        return true;    
    } 
    function checkEmail(s){ 
        var pattern =/^[a-zA-Z0-9_\-]{1,}@[a-zA-Z0-9_\-]{1,}\.[a-zA-Z0-9_\-.]{1,}$/;
        if(!pattern.exec(s)){
          return false;
        }
        return true;    
    }

</script>
    </head>
    <body>

    <form name="form" method="post" id="datacell_formid" >

    <div id="right">
    <div class="ringht_x">
    <div id="ccChild0" class="box_3">
        <div class="xz_title" style="padding-top: 10px">基本信息</div>
    <table width="100%" height="313" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
    
        <tr>
            <td class="td_1"   nowrap="nowrap"><span class="style_required_red">* </span>供应商编号</td>
         
            <td  class="td_2 "  ><input type="text"
                class="text_field" name="agent_code" inputName="供应商编号"  value="<%=seq_AgentCode %>" maxLength="25" readonly="readonly" /></td>
            
            <td class="td_1"><span class="style_required_red">* </span>供应商类型</td>
            <td class="td_2"><d:select dictTypeId="AGENT_TYPE" name="agent_type" property="bean/agent_type" nullLabel="请选择"></d:select>
            </td>
            <td  class="td_1" nowrap="nowrap"><span class="style_required_red">* </span>供应商名称</td>
          
            <td class="td_2 " ><input type="text" class="text_field" name="agent_name" inputName="供应商名称" value="${bean.agent_name }"
                maxLength="100"/></td>

        </tr>
        <tr>
          
                  <td class="td_1"><span class="style_required_red">* </span>注册城市</td>
            <td class="td_2">
                 <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       property="bean/city_id"
                       nullText="请选择" />        
            </td>
            <td class="td_1">法人</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="corporation" inputName="法人" value="" maxLength="50" /></td>
                  <td class="td_1">注册资本</td>
            <td class="td_2 "><input type="text" class="text_field" name="registered_capital" inputName="注册资本" value="" maxLength="18" /></td>
        </tr>
                <tr>
          
               <td class="td_1"><span class="style_required_red">* </span>开户行</td>
            <td class="td_2 "><input type="text" class="text_field" name="bank1" inputName="开户银行1" value="" maxLength="50" /></td><!--  <d:select dictTypeId="BANK" name="bank1" nullLabel="请选择"></d:select> --></td>    
              <td class="td_1"><span class="style_required_red">* </span>开户单位名称</td>
            <td class="td_2 "><input type="text" class="text_field" name="bank_address1" inputName="开户单位名称" value="" maxLength="50" /></td>
              <td class="td_1">帐户号</td>
            <td class="td_2 "><input type="text" class="text_field" name="bank_account1" inputName="帐户号" value="" maxLength="50" /></td>  
                </tr> 
        <tr>
         
          <td class="td_1"><span class="style_required_red">* </span>每月付款日期</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="month_pay_date" inputName="每月付款日期" value="" maxLength="10" /></td>
       
              <td class="td_1" nowrap="nowrap">合作合同起始年月</td>
            <td class="td_2 "><input type="text" class="text_field" name="cooperation_start_date" inputName="合作合同起始年月" value="" maxLength="10" /></td>      
        <td class="td_1">组织机构代码证号</td>
            <td class="td_2 "><input type="text" class="text_field" name="organization_code" inputName="组织机构代码证号" value="" maxLength="50" /></td>
              
        </tr>
         <tr>
           <td class="td_1">公司地址</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_address" inputName="公司地址" value="" maxLength="100" />  </td>
                    <td class="td_1">营业执照编号</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="business_license" inputName="营业执照编号" value="" maxLength="50" /></td>
            <td class="td_1">税务登记号</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="tax_registration_number" inputName="税务登记号" value=""
                maxLength="40" /></td>       
        </tr>
      <tr>
           <td class="td_1">总经理</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_name1" inputName="总经理" value="" maxLength="50" /></td>
       <td class="td_1">总经理联系电话</td>
            <td class="td_2 "><input type="te3xt" class="text_field"
                name="acontact_tel1" inputName="总经理联系电话" value="" maxLength="13" /></td>
                 <td class="td_1">总经理邮箱</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_email1" inputName="总经理邮箱" value="" maxLength="100" /></td>
      </tr>
      <tr>
        <td class="td_1">业务负责人一</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_name2" inputName="业务负责人一" value="" maxLength="50" /></td>
          <td class="td_1">负责人一联系电话</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="acontact_tel2" inputName="负责人一联系电话" value="" maxLength="13" /></td>
                     <td class="td_1">负责人一邮箱</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_email2" inputName="负责人一邮箱" value="" maxLength="100" /></td>
      </tr>
           <tr>
        <td class="td_1">业务负责人二</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_name3" inputName="业务负责人二" value="" maxLength="50" /></td>
          <td class="td_1">负责人二联系电话</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="acontact_tel3" inputName="负责人二联系电话" value="" maxLength="13" /></td>
                     <td class="td_1">负责人二邮箱</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_email3" inputName="负责人二邮箱" value="" maxLength="100" /></td>
      </tr>
       
        <tr>
            <td class="td_1" >备注</td>
            <td colspan="5" class="td_2" ><textarea style="width: 742px" rows="4" name="remark" inputName="备注"></textarea></td>
        </tr>
    </table>

    <div class="foot_button"><input type="button" class="foot_icon_1" id="save1"
        value='<fmt:message key="save"/>'
        onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
    <input type="button" class="foot_icon_1"
        value='关闭'
        onClick="javascript:cancel_onClick()" /></div>
    </div>

    <input type="hidden" name="id" value=""> <input type="hidden"
        name="create_date" />
        <input type="hidden" name="company_id" value="">
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