<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.customerservice.credentialstype.credentialstype_resource" prefix="rayoo.customerservice.credentialstype.">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
  <title>
  <fmt:message key="credentialsType"/>
  </title>
  <script language="javascript">
  jQuery(document).ready(function(){
      findType();
  });
   //办理证件类别、办理证件小类联动
   function findType(){
        var credentials_type_id = document.getElementById('credentials_type');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
        var type_bd = document.getElementById('credentials_type_bd').value;
        if(type_bd == null || type_bd==''){
            return;
        }
         jQuery.getJSON("<venus:base/>/CredentialsTypeAction.do?cmd=findCredentialsType&date="+new Date()+"",{"type_bd":type_bd},  function(json){
          for(var i = 0; i < json.saia.length; i++){
           var id=json.saia[i].id ;
           var name =json.saia[i].credentialsName;
           addAt(credentials_type_id,name,id,1);
           jQuery("#credentials_type").find("option[value=\""+ jQuery("#credentials_type").next().val()+"\"]").prop("selected",true);
            }
        });  
    }
    //为select添加option
      function addAt(selectCtl,optionValue,optionText,position){
         var userAgent = window.navigator.userAgent;
        if (userAgent.indexOf("MSIE") > 0) {
             var option = document.createElement("option");
             option.innerText = optionValue;
             option.value = optionText;
             selectCtl.insertBefore(option, selectCtl.options[position]);
         }else{
        selectCtl.insertBefore(new Option(optionValue, optionText), selectCtl.options[position]);
        }
    } 
    //校验
    function vailform(){
       // var  credentials_name = jQuery("#credentials_name").val();
       // if(!credentials_name){
      //      alert("<fmt:message key='input_credentials_name'/>");
      //      jQuery("#credentials_name").focus();
      //      return false;
      //  }
        
        return true;
    }
    
    //保存
    function save_onClick(){  //保存
       if(vailform()){
            var  code = jQuery("#edit_id").val();
            if (code){
                form.action="<%=request.getContextPath()%>/CredentialsTypeAction.do?cmd=update&id="+code;
                if ($id("datacell2").isModefied == true){
                    $id("datacell2").submit();
                }
            }else{
                form.action="<%=request.getContextPath()%>/CredentialsTypeAction.do?cmd=insert&id="+code;
                
                //新增时处理证件材料信息
                status_datacell = $id("datacell2");
                statusCount =  status_datacell.getCurrentRowCount();
                status_datacell.selectFirstRow(); 
                datacellValue = "[";
                for(var i=0;i<statusCount;i++){
                    entity=status_datacell.getActiveEntity();
                    if (datacellValue.length > 2){
                        datacellValue += ",";
                    }
                    datacellValue += "{\"credentials_materia_id\":\"" + entity.getProperty("credentials_materia_id") + "\""+",\"explain\":\"" + entity.getProperty("explain") + "\""+",\"isMust\":\"" + entity.getProperty("isMust") + "\""+"}";
                    status_datacell.selectNextRow();
                }
                datacellValue += "]";
                jQuery("#materiaCellValues").val(datacellValue);
            }
            form.submit();
            returnValue = ["0"];
            window.close();
            window.opener.insertcallBack(returnValue);
       }
    }
    
     //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
    
    function add_materia_row(){
        var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/credentialstype/searchMateria.jsp";
        showModalCenter(url, window,toaddItemlistrollback,750,455,"<fmt:message key='add_credentialsMateria'/>"); 
    }
    
    function toaddItemlistrollback(obj){
        var jsObject = eval('('+obj+')');  
        for(var i=0;i<jsObject.length;i++){
            $id("datacell2").addRow(); 
	        var datacell = $id("datacell2");
	        var activeRow = datacell.activeRow;
	        var datasettr = datacell.getEntity(activeRow);
	        
	        var credentialsType_id = jQuery("#edit_id").val();
	        if (credentialsType_id){
	            datasettr.setProperty("credentials_type_id",credentialsType_id);
	        }
            datasettr.setProperty("credentials_materia_id",jsObject[i].id);
            datasettr.setProperty("material_name",jsObject[i].material_name);
            datasettr.setProperty("isMust","1");
	       if ("null" != jsObject[i].remark){
		      datasettr.setProperty("remark",jsObject[i].remark);
	      }
        }  
    }
    
    //删除服务手续项
    function delete_materia_row(){
        $id("datacell2").deleteRow();
    }
    
</script>
  </head>
  <body>
  <form name="form" method="post" id="datacell_formid">
    <input type="hidden" name="id" id="edit_id" value="${bean.id}">
    <input type="hidden" name="statusCellValues" id="statusCellValues">
    <input type="hidden" name="materiaCellValues" id="materiaCellValues">
    <div id="right" style="height: 140px;">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='credentialsType_maintenance'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="ringht_x" style="height: 150px;">
    <div id="ccChild1"     class="box_xinzeng" style="height: 150px;">
      <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
         <tr>
	          <td class="td_1"  width="25%"><fmt:message key='credentials_type_bd'/></td>
	          <td class="td_2 " width="25%"><%
	                 rayoo.customerservice.credentialstype.vo.CredentialsTypeVo beanVo = (rayoo.customerservice.credentialstype.vo.CredentialsTypeVo)request.getAttribute("bean");
	                 String credentials_type_bd = "";
	                 String emp_post_type_bd = "";
	                 String  acceptance= "";
	                 if (beanVo != null){
	                     credentials_type_bd = String.valueOf(beanVo.getCredentials_type_bd());
	                     emp_post_type_bd = String.valueOf(beanVo.getEmp_bd());
	                     acceptance=String.valueOf(beanVo.getAcceptance());
	                 }
	                 %>
	            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("credentials_type_bd", -1, "MATERIALS_DEFINE", credentials_type_bd, "id='credentials_type_bd' onchange='findType();'", false) %> </td>
	          <td class="td_1"  width="25%"><fmt:message key='credentials_name'/></td>
	          <td class="td_2 " width="25%"><select name="credentials_type" id="credentials_type">
                        <option value=""><fmt:message key="please_choose" /></option>
                    </select>
                    <input type="hidden" value="${bean.credentials_type}">
	          </td> 
          </tr>
          <tr>
	           <td class="td_1"  width="25%"><fmt:message key='emp_bd'/></td>
	          <td class="td_2 " width="25%">
	            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_bd",-1,"EMP_POST_TYPE_BD",emp_post_type_bd," id='emp_bd'",false)%> </td>
	            <td class="td_1"  width="25%"><fmt:message key='acceptance'/></td>
	          <td class="td_2 " width="25%">
	            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("acceptance",-1,"ACCEPTANCE",acceptance," id='acceptance'",false)%> </td>
           </tr>
	        <tr>
	          <td class="td_1"  width="23%"><fmt:message key='remark'/></td>
	          <td class="td_2 " colspan="3"><textarea rows="5" cols="60" name="remark">${bean.remark}</textarea>
	          </td>
	        </tr>
      </table>
    </div>
    <div>
    
    <div class="xz_title">
      <fmt:message key='credentialsMateria'/>
    </div>
    <div id="productCCParent" class="button">
      <div class="button_right">
        <ul>
          <li class="c"><a onClick="javascript:add_materia_row();">
            <fmt:message key='insert'/>
            </a></li>
          <li class="d"><a onClick="javascript:delete_materia_row();">
            <fmt:message key='delete'/>
            </a></li>
        </ul>
      </div>
      <div class="clear"></div>
    </div>
    <div style="padding: 8 10 8 8;">
      <r:datacell id="datacell2" 
                  queryAction="/FAERP/CredentialsTypeAction.do?cmd=queryMateria&credentials_type_id=${bean.id}"
                  submitAction="/FAERP/CredentialsTypeAction.do?cmd=updateMateria"   
                  width="94%" height="200px" 
                  xpath="ReCredentialsMateriaVo" 
                  paramFormId="credentialsTypeForm" 
                  readonly="false" pageSize="100">
        <r:field fieldName="id" label="" width="0" ></r:field>
        <r:field fieldName="credentials_materia_id" label="" width="0" ></r:field>
        <r:field fieldName="material_name" messagekey="material_name" width="135px">
        </r:field>
        <r:field fieldName="isMust" messagekey="material_isMust" width="135px">
	        <h:select name="isMust" property="isMust">
	           <h:option value="0" label="必选"></h:option>
                <h:option value="1" label="非必选"></h:option>
                <h:option value="2" label="不定项"></h:option>
	       </h:select>
        </r:field>
         <r:field fieldName="remark" messagekey="remark" width="135px">
        </r:field>
        <r:field fieldName="explain" messagekey="explain" width="135px">
            <h:text/>    
        </r:field>
      </r:datacell>
    </div>
    
    </div>
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
      <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:save_onClick()" />
      <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
    </div>
  </form>

</body>
</fmt:bundle>
</html>
