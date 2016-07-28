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
     //显示多选框
     function showCheckbox(value,entity,rowNo,cellNo){
     var string;
          var commitDate=entity.getProperty("materiaCommitDate");
        if(commitDate!=null&&commitDate!="")
        {
            string="checked=\"checked\"";
        }
        else
        {
            string="";
        }
       return "<input type='checkbox' name='checkbox_template' value='"+value+"'onclick=\"checkCheckBox("+rowNo+",this)\" onkeydown=\"checkFocus("+rowNo+")\" "+string+">";
    }
     //多选框联动
    function checkCheckBox(rowNo,arg)
    {
        var myDate = new Date();
        var datacell = $id("datacell2");
         var row = jQuery(arg).closest("tr")[0];
        var datasettr = datacell.getEntity(row);
        datacell.refreshRow(row,datasettr);
        if(arg.checked)
        {
            $id("datacell2").isModefied=true;
            datasettr.setProperty("materiaCommitDate",(myDate.getFullYear()+"-"+((myDate.getMonth()+1)<10?("0"+(myDate.getMonth()+1)):(myDate.getMonth()+1))+"-"+myDate.getDate()));
            datasettr.status=2;
        }
        else
        {
            $id("datacell2").isModefied=true;
           datasettr.setProperty("materiaCommitDate","");
           datasettr.status=2;
        } 
              datacell.refreshRow(row,datasettr);
    }
    //材料定义联动
    function findMaterial()
    {   
        var dataset=   $id("datacell3").dataset;
        var emps = dataset.values;
        if(emps[0].getProperty("employeeEntryTypeID")==jQuery("#employeeEntryTypeID").val())
        {
	          $id("datacell2").queryAction="/FAERP/CertificateTransactionAction.do?cmd=queryMateria1";
	          $id("datacell2").addParam("credentials_type_id",document.getElementById("credentials_type_id").value);
	          $id("datacell2").addParam("employeeEntryType",document.getElementById("employeeEntryTypeID").value);
	          $id("datacell2").loadData();
	          $id("datacell2").refresh();
	          var dataset=   $id("datacell2").dataset;
	          var emps = dataset.values;
	          var datasettr; 
	          for(var i=0;i<dataset.getLength();i++)
	          {
	            datasettr = emps[i];
	            datasettr.status=2;
	          }
	          $id("datacell2").isModefied = true;
        }
    }
    //保存
    function save_onClick(){  //保存
	      var dataset=    $id("datacell3").dataset;
          var emps = dataset.values;
          var datasettr; 
          if(emps[0].getProperty("employeeLiveTogether")!=""&&emps[0].getProperty("employeeLiveTogether")!=null&&emps[0].getProperty("employeeLiveTogether")!=undefined)
          {
	           for(var i=1;i<dataset.getLength();i++)
	           {
	             datasettr = emps[i];
	             if(datasettr.getProperty("employeeLiveTogether")==""||datasettr.getProperty("employeeLiveTogether")==null||datasettr.getProperty("employeeLiveTogether")==undefined)
	             {
	                 alert("请输入同住人，谢谢。");
	                 return false;
	             }
	           }
           }
           else
           {
               for(var i=1;i<dataset.getLength();i++)
               {
                 datasettr = emps[i];
                 if(datasettr.getProperty("employeeLiveTogether")!=""&&datasettr.getProperty("employeeLiveTogether")!=null&&datasettr.getProperty("employeeLiveTogether")!=undefined)
                 {
                     alert("请输入同住人，谢谢。");
                     return false;
                 }
               }
           }
           dataset=    $id("datacell2").dataset;
           emps = dataset.values;
           if(dataset.getLength()==0)
           {
                alert("该类型未定义相关材料，请联系系统管理员");
                return false;
           }
           for(var i=0;i<dataset.getLength();i++)
           {
             datasettr = emps[i];
             if(datasettr.getProperty("isMust")=="0"&&(datasettr.getProperty("materiaCommitDate")==""||datasettr.getProperty("materiaCommitDate")==null))
             {
                 alert(datasettr.getProperty("material_name")+"是必选项，请确认是否递交");
                 return false;
             }
           }
            var  code = jQuery("#edit_id").val();
            var dc1 = $id("datacell2");
            var dc2 = $id("datacell3");
            var action = "<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=insertCardContinueBat";
            //将两个datacell的xml内容合并
            var xmlSubmit = dc1.dataset.toString();
            xmlSubmit+=dc2.dataset.toString();
            var myAjax = new Ajax(action);
            var form = document.getElementById("datacell_formid");
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }
             myAjax.submitXML(xmlSubmit, 'UTF-8');
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == "true" ) {
                      returnValue = ["0"];
                }
                  else {
                       returnValue = ["2"];
                  }
             }
            
            window.close();
            window.opener.insertcallBack(returnValue);
    }
    
     //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
    
    function add_materia_row(){
        var url="<%=request.getContextPath()%>/jsp/faerp/certificate/certificateTransaction/searchEmployee.jsp";
        showModalCenter(url, window,toaddItemlistrollback,980,455,"<fmt:message key='choose_employee'/>"); 
    }
    
      //显示一般的链接
    function showLink(value,entity,rowNo,cellNo){
            return "<a onclick=\"downLoad('"+entity.getProperty("material_name")+"')\"  style='color: #0033CC; font-weight: bold; text-decoration: underline;cursor: pointer;'>"+"样张"+"</a>";
    }
    function downLoad(arg)
    {
               jQuery.ajax({
                     url:"<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=downLoad",
                     type: 'POST',
                     dataType: 'html',
                     data:{"infoid":arg,"downLoadType":0,"vail":"true"},
                     async: false,
                     cache:false,
                     timeout: 10000,
                          success: function(data){
                              data= eval("("+data+")");
                              if(data.status=="false")
                              {
                                alert("该材料无样张提供");
                                return false;
                              }
                              else
                              {
                                window.location.href="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=downLoad&infoid="+arg+"&downLoadType=0";
                              }
                            }
                      });
    }
      function zipDownload()
    {
        var infoId;
        var dataset=   $id("datacell3").dataset;
        var emps = dataset.values;
        var employeeEntryType;
        if(emps.length!=0){
        employeeEntryType=emps[0].getProperty("employeeEntryTypeID");
        }
         infoId= emps[0].getProperty("cardTranTypeID");
         if(infoId==undefined||infoId==null||infoId=="")
           {
               alert("请选择证件办理小类");
               return false;
           }
           if(employeeEntryType==undefined||employeeEntryType==null||employeeEntryType=="")
           {
                alert("请选择员工");
               return false;
           }
         window.location.href="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=downLoad&infoid="+infoId+"&employeeEntryType="+employeeEntryType+"&downLoadType=1";
    }
    function initPage()
    {         
                 //解决多选框刷新，原状态消失
            $id("datacell2").beforeRefreshCell = function(cell,field){
                //alert(field.fieldId.indexOf("id_index"));
                if(field && field.fieldId && field.fieldId.indexOf("id")>= 0){
                    return false;
                }
                return true;
            }
              var ids=jQuery("#ids").val();
              $id("datacell3").queryAction="/FAERP/CertificateTransactionAction.do?cmd=cardContinueGetDetail&ids="+ids;
              $id("datacell3").loadData();
              $id("datacell3").refresh();
              var dataset=   $id("datacell3").dataset;
              var emps = dataset.values;
              jQuery("[mark=\"tranType\"]").text(emps[0].getProperty("cardTranTypeName"));
              jQuery("[mark=\"cardTranTypeBD\"]").text(emps[0].getProperty("credentialsTypeBdName"));
              $id("datacell2").queryAction="/FAERP/CertificateTransactionAction.do?cmd=queryMateria1";
	          $id("datacell2").addParam("credentials_type_id",emps[0].getProperty("cardTranTypeID"));
	          $id("datacell2").addParam("employeeEntryType",emps[0].getProperty("employeeEntryTypeID"));
	          $id("datacell2").loadData();
	          $id("datacell2").refresh();
    }
</script>
	<%
	   String ids=request.getParameter("ids");
	%>
  </head>
  <body onload="initPage();">
  <form name="form" method="post" id="datacell_formid">
    <input type="hidden"  id="ids" value="<%=ids %>">
    <input type="hidden" name="statusCellValues" id="statusCellValues">
    <input type="hidden" name="materiaCellValues" id="materiaCellValues">
    <input type="hidden" id="employeeEntryTypeID"/>
    <div id="right" style="height: 140px;">
    <script language="javascript">
        writeTableTopFesco("<fmt:message key='continueTran'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
    <div class="ringht_x" style="height: 45px;">
    <div id="ccChild1"     class="box_xinzeng" style="height: 45px;">
      <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
          <tr>
            <td class="td_1" width="25%"><fmt:message key='cardTranTypeBD' /></td>
            <td class="td_2 " width="25%" mark="cardTranTypeBD">
            </td>
            <td class="td_1" width="25%"></td>
            <td class="td_2 " width="25%"  mark='tranType'>
            </td>
        </tr>
      </table>
    </div>
    <div>
    <div class="xz_title">
      <fmt:message key='choose_employee'/>
    </div>
    <div style="padding: 8 10 8 8;">
      <r:datacell id="datacell3" 
                  queryAction="#"
                  width="94%" height="200px" 
                  xpath="CredentialsTranExcelSimpleVo" 
                  paramFormId="datacell_formid"
                  readonly="false" pageSize="100">
        <r:field fieldName="employeeID" label="" width="0" ></r:field>
        <r:field fieldName="employeeName" messagekey="employeeName" width="65px" allowModify="false">
        </r:field>
        <r:field fieldName="employeeNumber" messagekey="identity" width="65px" allowModify="false">
        </r:field>
         <r:field fieldName="employeeCardNumber" messagekey="employeeCardNumber" width="135px" allowModify="false">
        </r:field>
          <r:field fieldName="companyNumber" messagekey="companyNumber" width="65px" allowModify="false">
        </r:field>
        <r:field fieldName="companyName" messagekey="companyName" width="240px" allowModify="false">
        </r:field>
        <r:field fieldName="employeeEntryType" messagekey="employeeEntryType" width="135px" allowModify="false">
        </r:field>
        <r:field fieldName="employeeLiveTogether" messagekey="employeeLiveTogether" width="135px" allowModify="true">
        <h:text name="employeeLiveTogether"/>
        </r:field>
         <r:field fieldName="acceptance" messagekey="acceptance" width="135px" allowModify="true">
             <d:select dictTypeId="ACCEPTANCE" name="acceptance"/>
        </r:field>
         <r:field fieldName="companyLinkman" messagekey="companyLinkman" width="135px" allowModify="true">
        <h:text name="companyLinkman"/>
        </r:field>
      </r:datacell>
    </div>
    <div class="xz_title">
      <fmt:message key='credentialsMateria'/>
    </div>
     <div id="productCCParent" class="button">
      <div class="button_right">
        <ul>
          <li class="c"><a onClick="javascript:zipDownload();">
           打包下载
            </a></li>
        </ul>
      </div>
      <div class="clear"></div>
    </div>
    <div style="padding: 8 10 8 8;">
      <r:datacell id="datacell2" 
                  queryAction="#"
                  submitAction="/FAERP/CertificateTransactionAction.do?cmd=insertCredentialsMaterialRel"   
                  width="94%" height="200px" 
                  xpath="ReCredentialsMateriaVo" 
                   paramFormId="datacell_formid"
                  readonly="false" pageSize="100" >
        <r:field fieldName="id" label="" width="0"></r:field>
        <r:field fieldName="credentials_materia_id" label="" width="30" onRefreshFunc="showCheckbox" align="center" allowResize="false"></r:field>
        <r:field fieldName="material_name" messagekey="material_name" width="135px">
        </r:field>
         <r:field fieldName="isMust" messagekey="material_isMust" width="135px" allowModify="false" >
          <h:select name="isMust" property="isMust">
            <h:option value="0" label="必选"></h:option>
            <h:option value="1" label="非必选"></h:option>
            <h:option value="2" label="不定项"></h:option>
       </h:select>
        </r:field>
        <r:field fieldName="materiaCommitDate" messagekey="materiaCommitDate" width="135px" allowModify="false">
            <w:date  format="yyyy-MM-dd"  />
        </r:field>
         <r:field fieldName="remark" messagekey="remark" width="135px">
        </r:field>
        <r:field fieldName="explain" messagekey="explain" width="135px">        
        </r:field>
         <r:field fieldName="proof" messagekey="proof" width="135px" onRefreshFunc="showLink" allowModify="false">        
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
