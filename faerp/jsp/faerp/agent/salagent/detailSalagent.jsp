<html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/common/backspace_forbid.js"/>

<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>供应商的基本信息</title>
    <script type="text/javascript" src="<venus:base/>/js/jquery/jquery-1.3.min.js"></script>
    <script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
         window.close();
    }
</script>
    </head>
    <body>
    <form name="form" method="post" id="datacell_formid" >
     <input type="hidden" name="agentId" value="${bean.id }"> 
    <div id="right">

    <div class="ringht_x">
    <div id="ccChild0" class="box_3">
    <div class="xz_title" style="padding-top: 10px">基本信息</div>
    <table width="100%" height="313" border="0" cellpadding="0"
        cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" >供应商编号</td>
         
            <td  class="td_2 "  > 
            <input type="text"
                class="text_field" name="agent_code" inputName="供应商编号"  value="${bean.agent_code }"  readonly="readonly" /></td>
            
            <td class="td_1">供应商类型</td>
            <td class="td_2"><d:select dictTypeId="AGENT_TYPE" name="agent_type" property="bean/agent_type" disabled="true"></d:select>
            </td>
            <td  class="td_1" >供应商名称</td>
          
            <td class="td_2 " ><input type="text" class="text_field" name="agent_name" inputName="供应商名称" value="${bean.agent_name }"
                readonly="readonly"/></td>

        </tr>
        <tr>
          
                  <td class="td_1">注册城市</td>
            <td class="td_2">
                 <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       property="bean/city_id"
                       nullText=""  readonly="true"/>        
            </td>
            <td class="td_1">法人</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="corporation" inputName="法人" value="${bean.corporation }" readonly="readonly"/></td>
                  <td class="td_1">注册资本</td>
            <td class="td_2 "><input type="text" class="text_field" name="registered_capital" inputName="注册资本" value="${bean.registered_capital }"  readonly="readonly" /></td>
        </tr>
                <tr>
            
               <td class="td_1">开户行</td>
            <td class="td_2 "><input type="text" class="text_field" name="bank1" inputName="开户单位名称" value="${bean.bank1 }"  readonly="readonly" /><!-- <d:select dictTypeId="BANK" name="bank1" disabled="true" property="bean/bank1"></d:select>  --></td>      
              <td class="td_1">开户单位名称</td>
            <td class="td_2 "><input type="text" class="text_field" name="bank_address1" inputName="开户单位名称" value="${bean.bank_address1 }"  readonly="readonly" /></td>
             <td class="td_1">帐户号</td>
            <td class="td_2 "><input type="text" class="text_field" name="bank_account1" inputName="帐户号" value="${bean.bank_account1 }"  readonly="readonly" /></td>
                </tr> 
        <tr>
                 
          <td class="td_1">每月付款日期</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="month_pay_date" inputName="每月付款日期" value="${bean.month_pay_date }"  readonly="readonly"/></td>
       
              <td class="td_1" nowrap="nowrap">合作合同起始年月</td>
            <td class="td_2 "><input type="text" class="text_field" name="cooperation_start_date" inputName="合作合同起始年月" value="${bean.cooperation_start_date }"  readonly="readonly"/></td>      
        <td class="td_1">组织机构代码证号</td>
            <td class="td_2 "><input type="text" class="text_field" name="organization_code" inputName="组织机构代码证号" value="${bean.organization_code }" readonly="readonly" /></td>
        </tr>
      <tr>
           <td class="td_1">总经理</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_name1" inputName="总经理" value="${bean.contact_name1 }"  readonly="readonly" /></td>
       <td class="td_1">总经理联系电话</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="acontact_tel1" inputName="总经理联系电话" value="${bean.acontact_tel1}"   readonly="readonly"/></td>
                 <td class="td_1">总经理邮箱</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_email1" inputName="总经理邮箱" value="${bean.contact_email1 }"  readonly="readonly" /></td>
      </tr>
      <tr>
        <td class="td_1">业务负责人一</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_name2" inputName="业务负责人一" value="${bean.contact_name2 }"  readonly="readonly" /></td>
          <td class="td_1">负责人一联系电话</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="acontact_tel2" inputName="负责人一联系电话" value="${bean.acontact_tel2 }"  readonly="readonly" /></td>
                     <td class="td_1">负责人一邮箱</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_email2" inputName="负责人一邮箱" value="${bean.contact_email2 }"  readonly="readonly" /></td>
      </tr>
           <tr>
        <td class="td_1">业务负责人二</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_name3" inputName="业务负责人二" value="${bean.contact_name3 }"  readonly="readonly"/></td>
          <td class="td_1">负责人二联系电话</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="acontact_tel3" inputName="负责人二联系电话" value="${bean.acontact_tel3 }"  readonly="readonly"/></td>
                     <td class="td_1">负责人二邮箱</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_email3" inputName="负责人二邮箱" value="${bean.contact_email3 }"  readonly="readonly"/></td>
      </tr>
        <tr>
           <td class="td_1">公司地址</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="contact_address" inputName="公司地址" value="${bean.contact_address }"  readonly="readonly" />  </td>
                    <td class="td_1">营业执照编号</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="business_license" inputName="营业执照编号" value="${bean.business_license}"  readonly="readonly"/></td>
            <td class="td_1">税务登记号</td>
            <td class="td_2 "><input type="text" class="text_field"
                name="tax_registration_number" inputName="税务登记号" value="${bean.tax_registration_number }"
                readonly="readonly" /></td>       
        </tr>
        <tr>
            <td class="td_1">备注</td>
            <td colspan="5" class="td_2" ><textarea style="width: 742px" rows="2" name="remark" inputName="备注" readonly="readonly">${bean.remark }</textarea></td>
        </tr>
    </table>
    </div> 
   
   <div id="ccParent1" class="button">
    <div class="xz_title" style="padding-top: 10px">社保公积金产品</div>
    </div>
    <div style="padding: 8 10 8 8;">
    <r:datacell  id="datacellproduct"      
        queryAction="/FAERP/AgentsecurityproductAction.do?cmd=queryProductData"
        width="98%" height="190px" xpath="AgentsecurityproductVo"
         paramFormId="datacell_formid" readonly="true"  pageSize="-1">
    <r:toolbar location="bottom" tools="nav,pagesize,info" />  
    <r:field fieldName="city_id" label="城市" width="80px"  >
            <r:comboSelect id="countryList2" name="city_id2"
                queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name"
                valueField="id" xpath="PB_CITYVo" width="150px" nullText="请选择" disabled="true"/>
        </r:field>         
        <r:field fieldName="product_id" width="100px" label="社保公积金产品" >
            <r:comboSelect id="product_id2" name="product_id2"
                       queryAction="/FAERP/ProductAction.do?cmd=getListData&big_type_id=999"
                       textField="product_name"
                       valueField="id"
                       xpath="ProductVo"
                       width="200px"
                       nullText="请选择" disabled="true" />
        </r:field>
        <r:field fieldName="product_name" label="社保产品比例名称" width="150px" >
         
        </r:field>
        <r:field fieldName="e_ratio" label="公司比例" width="120px" >  
        </r:field>
              <r:field fieldName="p_ratio" label="个人比例" width="120px" >  
        </r:field>
          <r:field fieldName="e_add_ratio" label="公司附加金额" width="120px" >  
        </r:field>
         <r:field fieldName="p_add_ratio" label="个人附加金额" width="120px" >  
        </r:field>
      
        <r:field fieldName="charge_frequency_bd" label="收费频率" width="80px" >
            <d:select dictTypeId="CHARGE_FREQUENCY_BD" disabled="true"/>
        </r:field>
    <r:field fieldName="is_outstrip_limit_bd" label="是否超上下限" >
            <d:select dictTypeId="TrueOrFalse" disabled="true"/>
        </r:field>
      <r:field fieldName="remark" label="备注" >
        </r:field>   
    </r:datacell></div>
   
    <div id="ccParent1" class="button">
    <div class="xz_title" style="padding-top: 10px">产品配置</div>
    </div>
    <div style="padding: 8 10 8 8;">
    <r:datacell  id="datacell2"      
        queryAction="/FAERP/AgentServiceProductAction.do?cmd=queryProductData2"
        width="98%" height="180px" xpath="AgentServiceProductVo" 
         paramFormId="datacell_formid" readonly="true" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="big_type_id" label="产品大类" width="150px">
         <d:select dictTypeId="big_type_id"></d:select>
        </r:field>
        <r:field fieldName="small_type_id" label="产品小类" width="130px">
         <d:select dictTypeId="big_type_id"></d:select>
        </r:field>
        <r:field fieldName="city_id" label="福利地" width="100px">
          <r:comboSelect id="cityList" name="cityList " queryAction="PB_CITYAction.do?cmd=getListData" textField="city_name" valueField="id" nullText=""  xpath="PB_CITYVo"></r:comboSelect>               
        </r:field>
        <r:field fieldName="product_name" label="产品名称" width="150px">
        </r:field>
        <r:field fieldName="product_price" label="价格" width="100px">
        </r:field>
    
        <r:field fieldName="description" label="产品说明" width="250px">
        </r:field>
        <r:field fieldName="remark" label="备注" width="190px">
        </r:field>
    </r:datacell></div>
        <div id="ccParent1" class="button">
    <div class="xz_title" style="padding-top: 10px">服务手续</div>
    </div>
    <div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
        queryAction="/FAERP/AgentServiceItemAction.do?cmd=searchItemData"
      
        width="98%" height="180px" xpath="AgentServiceItemVo"
         paramFormId="datacell_formid" readonly="true" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="city_id" label="办理城市" width="100px" >
          <r:comboSelect id="cityList1" name="cityList1 " queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name" valueField="id" nullText=""  xpath="PB_CITYVo" ></r:comboSelect>               
        </r:field>
        <r:field fieldName="contact_name" label="手续名称" width="150px">
            <h:text />
        </r:field>
        <r:field fieldName="post_belong" label="服务类型" width="80px">
            <d:select dictTypeId="POST_BELONG_BD" ></d:select>
        </r:field>
        <r:field fieldName="remark" label="备注" width="350px">
            <h:text />
        </r:field>
    </r:datacell></div>
                  <div class="mx_button" align="center">
        <input type="button" class="icon_2" value="关闭"  onClick="javascript:cancel_onClick()"/>
        </div>

    
        </div>
        </div>
    </form>

<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>