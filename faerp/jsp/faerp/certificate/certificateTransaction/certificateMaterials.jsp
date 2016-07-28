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
<fmt:bundle basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh" prefix="rayoo.certificate.certificateTransaction.">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
  <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
  <META HTTP-EQUIV="Expires" CONTENT="0">
  <title>
  <fmt:message key="credentialsType"/>
  </title>
  <script language="javascript">
  //办理证件类别、办理证件小类联动
   function findType(){
        var credentials_type_id = document.getElementById('credentials_type_id');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
        var type_bd = document.getElementById('credentials_type_bd').value;
        if(type_bd == null || type_bd==''){
            return;
        }
        
         jQuery.getJSON("<venus:base/>/CertificateTransactionAction.do?cmd=findCredentialsType&date="+new Date()+"",{"type_bd":type_bd},  function(json){
          for(var i = 0; i < json.saia.length; i++){
           var id=json.saia[i].id ;
           var name =json.saia[i].credentials_name;
           addAt(credentials_type_id,name,id,1);
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
        var  credentials_name = jQuery("#credentials_type_bd").val();
        if(!credentials_name){
            alert("<fmt:message key='select_credentials_type_bd'/>");
            jQuery("#credentials_type_bd").focus();
            return false;
        }
         var  credentials_type_id = jQuery("#credentials_type_id").val();
        if(!credentials_type_id){
            alert("<fmt:message key='select_credentials_type'/>");
            jQuery("#credentials_type_id").focus();
            return false;
        }
         var  emp_post_type_bd = jQuery("#emp_post_type_bd").val();
        if(!emp_post_type_bd){
            alert("<fmt:message key='select_emp_post_type_bd'/>");
            jQuery("#emp_post_type_bd").focus();
            return false;
        }
       var datacell = $id("datacell2");
       var dataset= datacell.dataset;//取得页面的datacell
        if(dataset.getLength()==0){
            alert("<fmt:message key='input_credentials_name'/>");
           add_materia_row();
            return false;
        }
        
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
                    datacellValue += "{\"credentials_materia_id\":\"" + entity.getProperty("credentials_materia_id") + "\"}";
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
  //材料表格添加行  
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
            datasettr.setProperty("material_isMust",'0');
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
    <div class="ringht_x" style="height: 140px;">
    <div id="ccChild1"     class="box_xinzeng" style="height: 140px;">
      <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1"  width="25%"><fmt:message key='credentials_type_big'/></td>
          <td class="td_2 " width="25%">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("credentials_type_bd",-1,"CREDENTIALS_TYPE_BD",""," id='credentials_type_bd' onclick='findType();'",false)%> </td>
          <td class="td_1"  width="25%"><fmt:message key='credentials_type_small'/></td>
          <td class="td_2 " width="25%"><select name="credentials_type_id" id="credentials_type_id" >
                <option value=""><fmt:message key="please_choose"/></option>
            </select>
          </td>
          </tr>
          <tr>
          <td class="td_1"  width="25%"><fmt:message key='emp_bd'/></td>
          <td class="td_2 " width="25%">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("emp_post_type_bd",-1,"EMP_POST_TYPE_BD",""," id='emp_post_type_bd'",false)%> </td>
          <td class="td_1"  width="25%"></td>
          <td class="td_2 " width="25%"></td>
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
        </r:field><!--
        <r:field fieldName="material_number" messagekey="material_number" width="135px">
        </r:field>
        --><r:field fieldName="material_isMust" messagekey="material_isMust" width="135px">
         <d:select dictTypeId="TrueOrFalse"  />
        </r:field>
        <r:field fieldName="remark" messagekey="remark" width="135px">
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
</fmt:bundle>
</body>
</html>
