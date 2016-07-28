<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.authority.helper.LoginHelper"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@page import="rayoo.certificate.certificateTransaction.vo.CredentialsTranVO"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<fmt:bundle basename="rayoo.certificate.certificateTransaction.certificateMaterials_resource_zh" prefix="rayoo.certificate.certificateTransaction.">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="0">
    <title><fmt:message key="cardTran" /></title>
    <script type="text/javascript" src="<venus:base/>/jsp/faerp/certificate/certificateTransaction/insertCredentialsTran.js"></script>
    <script>
        jQuery(document).ready(function()
    {
       if(jQuery("#tranState").val()=="001")
       {   
             $id("datacell2").queryAction="/FAERP/CertificateTransactionAction.do?cmd=queryMateria";
             $id("datacell2").addParam("formId",jQuery("#edit_id").val());
             $id("datacell2").loadData();
             $id("datacell2").refresh();
       }
        //解决多选框刷新，原状态消失
        $id("datacell2").beforeRefreshCell = function(cell,field){
            //alert(field.fieldId.indexOf("id_index"));
            if(field && field.fieldId && field.fieldId.indexOf("id")>= 0){
                return false;
            }
            return true;
        } 
        if(jQuery("#tranState").val()=="001")
        {
            findType();//办证大类与小类初始化联动
        }
        initPage();
        //IE7单选框onchange事件BUG，只有当失去焦点时才会触发事件（FIX）
        jQuery(":radio[name=\"employeeFrom\"]").change(function(){
        if(confirm("更改员工归属，将会清空员工相关数据，需要您重新填写，您确定更改员工归属吗？")){
                   jQuery("input[mark=\"employeeOutside\"],#employeeEntryType,#companyLinkman").val("");
                   $id("employeeId").value="";
                   $id("employeeId").displayValue="";
                   $id("employeeId_input").value="";
                   $id("certificateTranSpecialist").value="";
                   $id("certificateTranSpecialist").displayValue="";
                   $id("certificateTranSpecialist_input").value="";
                   if(this.value=="0")
                   {
                      employeeOutside();
                   }
                   else
                   {
                       employeeInside();
                   }
           }
           else
           {
                  if(this.value=="0")
                   {
                     jQuery(":radio[name=\"employeeFrom\"][value=\"1\"]").prop("checked",true);
                   }
                   else
                   {
                     jQuery(":radio[name=\"employeeFrom\"][value=\"0\"]").prop("checked",true);
                   }
           }
        });
         if(jQuery("#tranState").val()!="000"){
        jQuery("#init").val("0");      
        }  
    });
    //问题状态联动
    function changeFinishDate(arg)
    {
       var myDate = new Date();
       var datacell = $id("datacell3");
       var activeRow = datacell.activeRow;
       var datasettr = datacell.getEntity(activeRow);
       if(arg.value=="000"){
       datasettr.setProperty("finishDate","");
       }
       else
       {
            datasettr.setProperty("finishDate",(myDate.getFullYear()+"-"+(myDate.getMonth()+1)+"-"+myDate.getDate()));
       }
    }
    //问题数据表行新增
     function add_materia_row(){
            var myDate = new Date();
            $id("datacell3").addRow(); 
            var datacell = $id("datacell3");
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);
            datasettr.setProperty("commitDate",(myDate.getFullYear()+"-"+(myDate.getMonth()+1)+"-"+myDate.getDate()));
            datasettr.setProperty("commitPersonName",jQuery("#loginName").val());
    }
    //页面初始化
    function initPage()
    {
        if(jQuery("#employeeFrom").val()==""||jQuery("#employeeFrom").val()=="0")
        {
         jQuery(":radio[name=\"employeeFrom\"][value=\"0\"]").prop("checked",true);
         employeeOutside();
        }
        else
        {
               jQuery(":radio[name=\"employeeFrom\"][value=\"1\"]").prop("checked",true);
               employeeInside();
        }
        if(jQuery("#tranState").val()=="007"||jQuery("#tranState").val()=="008"||jQuery("#tranState").val()=="011")
        {
            $id("validDate").readOnly=false;
            $id("approvalDate").readOnly=false;
        }
    }
    //员工归属为外部联动
    function employeeOutside()
    {
        jQuery("#employeeIdTd,#employeeEntryType").show();
        jQuery("td[mark=\"employeeInside\"]").attr("colspan",1);
        jQuery("td[mark=\"employeeOutside\"]").show();
        jQuery("#employeeNameTd").hide();
        jQuery("input[mark=\"employeeOutside\"],#companyLinkman").prop("readonly",true);              
    }
    //员工归属为内部联动
    function employeeInside()
    {  
        if(jQuery("#tranState").val()=="000"||jQuery("#tranState").val()=="001"){
         $id("certificateTranSpecialist").setDisplayValue(jQuery("#loginName").val());
        }
        jQuery("#employeeIdTd,#employeeEntryType").hide();
        jQuery("td[mark=\"employeeOutside\"]").hide();
        jQuery("td[mark=\"employeeInside\"]").attr("colspan",3);
        jQuery("#employeeNameTd").show();       
        jQuery("input[mark=\"employeeOutside\"],#companyLinkman").prop("readonly",false);      
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
          infoId= document.getElementById("edit_id").value;
          window.location.href="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=downLoad&infoid="+infoId+"&downLoadType=1";
    }
   //显示多选框
     function showCheckbox(value,entity,rowNo,cellNo){
     var string;
     if(jQuery("#tranState").val()=="001")
     {
          var commitDate=entity.getProperty("materiaCommitDate");
        if(commitDate!=null&&commitDate!="")
        {
            string="checked=\"checked\"";
        }
        else
        {
            string="";
        }
     }
     if(jQuery("#tranState").val()=="002"||jQuery("#tranState").val()=="004"||jQuery("#tranState").val()=="005")
     {
          var handoverDate=entity.getProperty("handoverDate");
            if(handoverDate!=null&&handoverDate!="")
        {
            string="checked=\"checked\"";
        }
        else
        {
            string="";
        }
     }
       return "<input type='checkbox' name='checkbox_template' value='"+value+"'onclick=\"checkCheckBox("+rowNo+",this)\" onkeydown=\"checkFocus("+rowNo+")\" "+string+">";
    }
    function showRowNo(value,entity,rowNo,cellNo)
    {
        return rowNo+1;
    }
    function check(rowNo)
   {
    var datacell = $id("datacell2");
     var row = datacell.getRow(rowNo);
     selectRow(row);
   }
    //删除服务手续项
    function delete_materia_row(){
        $id("datacell3").deleteRow();
    }
    //多选框联动
    function checkCheckBox(rowNo,arg)
    {
        var myDate = new Date();
        var datacell = $id("datacell2");
        var row = datacell.getRow(rowNo);
        var datasettr = datacell.getEntity(row);
        datacell.refreshRow(row,datasettr);
        if(arg.checked)
        {
            $id("datacell2").isModefied=true;
            if(jQuery("#tranState").val()=="000"||jQuery("#tranState").val()=="001")
            {
                datasettr.setProperty("materiaCommitDate",(myDate.getFullYear()+"-"+(myDate.getMonth()+1)+"-"+myDate.getDate()));
            }
            else  if(jQuery("#tranState").val()=="002"||jQuery("#tranState").val()=="004"||jQuery("#tranState").val()=="005")
            {
                datasettr.setProperty("handoverPersonName",jQuery("#loginName").val());
                datasettr.setProperty("handoverDate",(myDate.getFullYear()+"-"+(myDate.getMonth()+1)+"-"+myDate.getDate()));
            }
            datasettr.status=2;
        }
        else
        {
            $id("datacell2").isModefied=true;
            if(jQuery("#tranState").val()=="000"||jQuery("#tranState").val()=="001")
            {
                datasettr.setProperty("materiaCommitDate","");
            }
            else  if(jQuery("#tranState").val()=="002"||jQuery("#tranState").val()=="004"||jQuery("#tranState").val()=="005")
            {
               datasettr.setProperty("handoverPersonName","");
               datasettr.setProperty("handoverDate","");
           }
           datasettr.status=2;
        } 
              datacell.refreshRow(row,datasettr);
    }
    //材料定义联动
    function findMaterial()
    {
            if(jQuery("#init").val()=="0")
            {
               if(!confirm("更改办理类别会重置证件材料，您确定要更改办理类别吗？"))
               {
                        jQuery("#credentials_type_id").val(jQuery("#credentialsTypeId").val());
                        return;
               }
               else{
                      jQuery("#init").val("1");
               }
            }
          $id("datacell2").queryAction="/FAERP/CredentialsTypeAction.do?cmd=queryMateria";
          $id("datacell2").addParam("credentials_type_id",document.getElementById("credentials_type_id").value);
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
    }
    
    function checkRadio(arg)
    {
       alert(arg.value);
    }
    
    //员工弹出框后续方法
    function rtnFuncEmployee(arg)
    {
       var lookup = $id("employeeId");
       lookup.value = arg[0];
        lookup.displayValue = arg[1];
       jQuery("#employeeCardNumber").val(arg[3]);
       jQuery("#employeeName").val(arg[1]);
       jQuery.ajax({
                           url: '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=getEmployeeDetail',
                           type: 'POST',
                           dataType: 'html',
                           data:{id:arg[0]},
                           async: false,
                           timeout: 10000,
                                success: function(data){
                                    data=eval("("+data+")");
                                   jQuery("#companyName").val(data.companyName);
                                   $id("certificateTranSpecialist").setValue(data.certificateTranSpecialist);
                                   $id("certificateTranSpecialist").setDisplayValue(data.certificateTranSpecialistName);
                                   jQuery("#acceptance").val(data.acceptance);
                                   jQuery("#employeeEntryType").val(data.employeeEntryType);
                                   jQuery("#companyLinkman").val(data.companyLinkman);
                                   jQuery("#companyID").val(data.companyID);
                                   if(data.certificateTranSpecialist==null||data.certificateTranSpecialist=="")
                                   {
                                         $id("certificateTranSpecialist").readOnly=false;
                                   }
                                   else
                                   {
                                        $id("certificateTranSpecialist").readOnly=true;
                                   }
                               }
                           });      
    }
    function rtnFuncCertificateTranSpecialist(arg)
    {
      var lookup = $id("certificateTranSpecialist");
       lookup.value = arg[0];
       lookup.displayValue = arg[1];
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
    function vailform(arg){
     var  code = jQuery("#edit_id").val();
     var dataset;
     var emps ;
     var datasettr; 
       if(arg==0||arg==1)
       {
            if(jQuery(":radio[name='employeeFrom']:checked").val()=="0")
            {
                 var employeeId = document.getElementById("employeeId").value;
                 if(employeeId==null || employeeId==""){
                 alert("请选择员工");
                 return false;
               }
            }
            else
            {
                 var  employeeName = document.getElementById("employeeName").value;
                 if(employeeName==null || employeeName==""){
                 alert("请输入员工姓名");
                 return false;
               }
            }
             var  employeeCardNumber =document.getElementById("employeeCardNumber").value;
             if(employeeCardNumber==null || employeeCardNumber==""){
                 alert("请输入员工证件号");
                 return false;
               }
               var  employeeLiveTogether = document.getElementById("employeeLiveTogether").value;
             if(employeeLiveTogether==null || employeeLiveTogether==""){
                 alert("请输入同住人");
                 return false;
               }
             var  companyName =document.getElementById("companyName").value;
             if(companyName==null || companyName==""){
                 alert("请输入公司名称");
                 return false;
               }
                var  credentials_type_bd = document.getElementById("credentials_type_bd").value;
                if(credentials_type_bd==null || credentials_type_bd==""){
                    alert("请选择办理类别");
                    return false;
                  }
              var  credentials_type_id = document.getElementById("credentials_type_id").value;
             if(credentials_type_id==null || credentials_type_id==""){
                 alert("请选择办理小类");
                 return false;
               }
                var  acceptance =document.getElementById("acceptance").value;
             if(acceptance==null || acceptance==""){
                 alert("请选择受理点");
                 return false;
               }
                var  companyLinkman =document.getElementById("companyLinkman").value;
             if(companyLinkman==null || companyLinkman==""){
                 alert("请输入公司联系人");
                 return false;
               }
                 var  certificateTranSpecialist =document.getElementById("certificateTranSpecialist").value;
             if(certificateTranSpecialist==null || certificateTranSpecialist==""){
                 alert("请选择证件专员");
                 return false;
               }
              dataset=   $id("datacell2").dataset;
              emps = dataset.values;
              for(var i=0;i<dataset.getLength();i++)
              {
                datasettr = emps[i];
                if(datasettr.getProperty("isMust")=="0"&&(datasettr.getProperty("materiaCommitDate")==""||datasettr.getProperty("materiaCommitDate")==null))
                {
                    alert(datasettr.getProperty("material_name")+"是必选项，请确认是否递交");
                    return false;
                }
              }
        }
        if(arg==2)
        {
            dataset=   $id("datacell2").dataset;
            emps = dataset.values;
            for(var i=0;i<dataset.getLength();i++)
              {
                datasettr = emps[i];
                if(datasettr.getProperty("isMust")=="0"&&(datasettr.getProperty("handoverDate")==""||datasettr.getProperty("handoverDate")==null))
                {
                    alert(datasettr.getProperty("material_name")+"是必选项，请确认是否交接");
                    return false;
                }
              }
        }
         if(arg==2)
        {
           dataset=   $id("datacell2").dataset;
           emps = dataset.values;
            for(var i=0;i<dataset.getLength();i++)
              {
                datasettr = emps[i];
                if(datasettr.getProperty("isMust")=="0"&&(datasettr.getProperty("handoverDate")==""||datasettr.getProperty("handoverDate")==null))
                {
                    alert(datasettr.getProperty("material_name")+"是必选项，请确认是否交接");
                    return false;
                }
              }
        }
         if(arg==3||arg==11)
        {
            var questionCount=0;
            dataset=   $id("datacell3").dataset;
            emps = dataset.values;
            for(var i=0;i<dataset.getLength();i++)
              {
                datasettr = emps[i];
                if(datasettr.getProperty("questionStatus")=="0")
                {
                 questionCount++;
                }
              }
              if(questionCount==0)
              {
                alert("当前没有待处理的问题，请确认问题列表");
                    return false;
              }
        }            
        if(arg==10)
        {
                  var  acceptProgress =document.getElementById("acceptProgress").value;
                 if(acceptProgress==null || acceptProgress==""){
                     alert("请选择受理进展");
                     return false;
                   }
                var  approvalDate =document.getElementById("approvalDate").value;
                 if(approvalDate==null || approvalDate==""){
                     alert("请选择批复日期");
                     return false;
                   }
                 var  validDate =document.getElementById("validDate").value;
                 if(validDate==null || validDate==""){
                     alert("请选择有效日期");
                     return false;
                   }
        }
     if(arg==1)
     {     
           
           jQuery.ajax({
                           url: '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=vailDataCredentialsTran&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize()),true),
                           type: 'POST',
                           dataType: 'html',
                           async: false,
                           timeout: 10000,
                                success: function(data)
                                {
                                 data= eval("("+data+")");
                                    if(data.status=="false")
                                    {
                                            if(confirm("目前"+$id("certificateTranSpecialist").displayValue+"外出，是否转至"+data.backUpPersonName+"处理"))
                                                {
                                                    $id("certificateTranSpecialist").setValue(data.backUpPersonID);
                                                    $id("certificateTranSpecialist").setDisplayValue(data.backUpPersonName);
                                                }
                                            else
                                                {
                                                  save_onClick(arg);
                                                  return;
                                                }
                                    }
                                    else
                                    {
                                          save_onClick(arg);
                                          return;
                                    }
                                }
                              });
     }
            jQuery.ajax({
                           url: '<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=vailDataTranDef&'+encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize()),true),
                           type: 'POST',
                           dataType: 'html',
                           async: false,
                           timeout: 10000,
                                success: function(data){
                                    if(data=='true'){
                                         save_onClick(arg);
                                      }
                                   else
                                   {
                                     alert("该类证件定义已存在");
                                   }
                               }
                           });        
        return true;
    }
    //保存
    function save_onClick(arg){  //保存
            var  code = jQuery("#edit_id").val();
            var url;
            if(code){
                  url= "<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=updateCredentialsTran&operateType="+arg;
            }
            else
            {
                   url="<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=insertCredentialsTran&operateType="+arg;
            }
                jQuery.ajax({
                           url:url,
                           type: 'POST',
                           dataType: 'html',
                           data:encodeURI(decodeURIComponent(jQuery("#datacell_formid").serialize(),true)),
                           async: false,
                           cache:false,
                           timeout: 10000,
                                success: function(data){
                                    data= eval("("+data+")");
                                    if(data.status=='true'){
                                    if ($id("datacell2").isModefied == true)
                                    {       
                                            if(jQuery("#tranState").val()=="001")
                                           {   
                                                  var dataset=   $id("datacell2").dataset;
                                                  var emps = dataset.values;
                                                  var datasettr; 
                                                  for(var i=0;i<dataset.getLength();i++)
                                                  {
                                                    datasettr = emps[i];
                                                    datasettr.status=2;
                                                  }
                                           }
                                            $id("datacell2").addParam("formId",data.formId);
                                            if(!$id("datacell2").submit())
                                            {
                                                       returnValue = ["2"];
                                                       window.close();
                                                       window.opener.insertcallBack(returnValue);
                                            }
                                    }
                                    if(jQuery("#tranState").val()=="002"||jQuery("#tranState").val()=="004"||jQuery("#tranState").val()=="005"||jQuery("#tranState").val()=="007"||jQuery("#tranState").val()=="008"||jQuery("#tranState").val()=="011")
                                    {
                                        if ($id("datacell3").isModefied == true)
                                        {       
                                                $id("datacell3").addParam("formId",data.formId);
                                                if(!$id("datacell3").submit())
                                                {
                                                           returnValue = ["2"];
                                                           window.close();
                                                           window.opener.insertcallBack(returnValue);
                                                }
                                        }
                                    }
                                    if(parseInt(arg)==11||parseInt(arg)==3|parseInt(arg)==4)
                                    {
                                        jQuery.ajax({
                                                               url:"<%=request.getContextPath()%>/CertificateTransactionAction.do?cmd=sendEmail&operateType="+arg+"&formId="+code,
                                                               type: 'POST',
                                                               dataType: 'html',
                                                               async: false,
                                                               cache:false,
                                                               timeout: 10000,
                                                               success: function(data)
                                                                   {
                                                                             data= eval("("+data+")");
                                                                             if(data.status=='true')
                                                                             {
                                                                                    returnValue = ["0"];
                                                                                     window.close();
                                                                                     window.opener.insertcallBack(returnValue);
                                                                             }
                                                                             else
                                                                             {
                                                                                   returnValue = ["2"];
                                                                                   window.close();
                                                                                   window.opener.insertcallBack(returnValue);
                                                                             }
                                                                   }
                                                               });
                                    }
                                    else
                                    {
                                         returnValue = ["0"];
                                         window.close();
                                         window.opener.insertcallBack(returnValue);
                                         }
                                   }
                                   else{
                                               returnValue = ["2"];
                                               window.close();
                                               window.opener.insertcallBack(returnValue);
                                   }
                               }
                           });      
    }
    
     //返回
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
    //办理证件类别、办理证件小类联动
   function findType(){
        if(jQuery("#init").val()=="0")
        {
           if(!confirm("更改办理类别会重置证件材料，您确定要更改办理类别吗？"))
           {
                    jQuery("#credentials_type_bd").val(jQuery("#credentialsTypeBdID").val());
                    return;
           }
           else{
                  jQuery("#init").val("1");
           }
        }
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
           var name =json.saia[i].credentialsName;
           addAt(credentials_type_id,name,id,1);
            }
             jQuery("#credentials_type_id").find("option[value=\""+ jQuery("#credentialsTypeId").val()+"\"]").prop("selected",true);
             if(jQuery("#init").val()!="0")
             {
                $id("datacell2").clear();
                findMaterial();
             }          
        });  
    }
    </script>
    </head>
    <body>
    <form name="form" method="post" id="datacell_formid">
    <input      type="hidden" name="id" id="edit_id" value="${bean.id}"/> 
        <input type="hidden" name="statusCellValues" id="statusCellValues"/>
         <input type="hidden" name="materiaCellValues" id="materiaCellValues">
        <input type="hidden" id="credentialsTypeId" value="${bean.cardTranType}"/>
    <div id="right" style="height: 140px;"><script
        language="javascript">
        writeTableTopFesco("<fmt:message key='cardTran'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script> <%   
    String name = LoginHelper.getLoginName(request);//获得用户姓名
    rayoo.certificate.certificateTransaction.vo.CredentialsTranVO beanVo = (rayoo.certificate.certificateTransaction.vo.CredentialsTranVO) request.getAttribute("bean");
    rayoo.certificate.certificateTransaction.vo.PersonSimpleVo simpleVo = (rayoo.certificate.certificateTransaction.vo.PersonSimpleVo) request.getAttribute("simpleVo");
    DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
    if(beanVo==null)
    {
        beanVo=new CredentialsTranVO();
        beanVo.setTranState("000");
        beanVo.setEmployeeFrom("0");
        }
 %>
    <input type="hidden" id="loginName" value="<%=name %>"/>
    <input type="hidden" id="tranState" name="tranState" value="<%=beanVo.getTranState()%>"/>
     <input type="hidden" id="companyID" name="companyID"/>
     <input type="hidden" id="employeeFrom" value="<%=beanVo.getEmployeeFrom()%>"/> 
     <input type="hidden" id="init"/>
     <input type="hidden" id="credentialsTypeBdID" value="<%=beanVo.getCredentialsTypeBdID() %>"/>
    <div class="ringht_x" style="height: 350px;">
    <div id="ccChild1" class="box_xinzeng" style="height: 550px;">
    <table width="100%" height="150" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr style="display: <%=simpleVo.isCertificateSpecialist()?"block":"none" %>">
          <td class="td_1" width="25%"><fmt:message  key='employeeFrom' /></td>
                <td class="td_2 " colspan="3">
                    <c:if test="${bean.employeeFrom=='0'}">外部</c:if>
                     <c:if test="${bean.employeeFrom=='1'}">内部</c:if>
            </td>
        </tr>
        <tr>
            <td class="td_1" width="25%"><fmt:message   key='employeeName' /></td>
             
                <td class="td_2 " width="25%" id="employeeIdTd">
                   ${bean.employeeName}
                </td>
                <td class="td_2 " width="25%" style="display: none;" id="employeeNameTd">
                   ${bean.employeeName}
                </td>
          
            <td class="td_1" width="25%"><fmt:message key='employeeCardNumber' /></td>
            <td class="td_2 " width="25%">
                   ${bean.employeeCardNumber}
            </td>
           </tr>
        <tr>
            <td class="td_1" width="25%"><fmt:message   key='employeeLiveTogether' /></td>
            <td class="td_2 " width="25%" mark="employeeInside">
                   ${bean.employeeLiveTogether}
            </td>
            <td class="td_1" width="25%" mark="employeeOutside"><fmt:message key='employeeEntryType' /></td>
            <td class="td_2 " width="25%" mark="employeeOutside">
                    <%=BaseDataHelper.getNameByCode( "EMP_POST_TYPE_BD", beanVo.getEmployeeEntryType())%>
            </td>
        </tr>
        <tr>
          <td class="td_1" width="25%"><fmt:message  key='companyName' /></td>
                <td class="td_2 " colspan="3">
                   ${bean.companyName}
            </td>
        </tr>
        <tr>
            <td class="td_1" width="25%"><fmt:message
                key='tranTypeBD' /></td>
            <td class="td_2 " width="25%">
                  <%=BaseDataHelper.getNameByCode( "CREDENTIALS_TYPE", beanVo.getCredentialsTypeBdID())%>
            </td>
            <td class="td_1" width="25%"><fmt:message key='tranType' /></td>
            <td class="td_2 " width="25%">
                  ${bean.cardTranTypeName}
                        <input type="hidden" name="cardTranType" value="${bean.cardTranType}"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" width="25%"><fmt:message
                key='acceptance' /></td>
            <td class="td_2 " colspan="3">
                  <%=BaseDataHelper.getNameByCode( "ACCEPTANCE", beanVo.getAcceptance()==null?"":beanVo.getAcceptance())%>
            </td>
        </tr>
         <tr>
            <td class="td_1" width="25%"><fmt:message   key='commitPerson' /></td>
            <td class="td_2 " width="25%">
                     ${bean.commitPersonName}
            </td>
            <td class="td_1" width="25%"><fmt:message key='commitDate' /></td>
            <td class="td_2 " width="25%">
                     <%=beanVo.getCommitDate()==null?"": df.format(beanVo.getCommitDate())%>
  </td>
        </tr>
         <tr>
            <td class="td_1" width="25%"><fmt:message   key='certificateTranSpecialist' /></td>
            <td class="td_2 " width="25%">
                 ${bean.certificateTranSpecialistName}
            </td>
            <td class="td_1" width="25%" ><fmt:message key='companyLinkman' /></td>
            <td class="td_2 " width="25%" >
                 ${bean.companyLinkman}
            </td>
        </tr>
         <tr>
            <td class="td_1" width="25%"><fmt:message   key='remark' /></td>
            <td class="td_2 " colspan="3">
                 ${bean.remark}
            </td>
        </tr>
         <tr>
            <td class="td_1" width="25%"><fmt:message key='validDate' /></td>
            <td class="td_2 " width="25%">
                     <%= beanVo.getValidDate()==null?"":df.format(beanVo.getValidDate())%>
            </td>
            <td class="td_1" width="25%"><div style="visibility: hidden"><fmt:message   key='approvalDate' /></div></td>
            <td class="td_2 " width="25%">
                   <div style="visibility: hidden"> <w:date format="yyyy-MM-dd"   name="approvalDate" id="approvalDate" style="width: 125px"  property="bean/approvalDate" readOnly="true"/></div>
            </td>
        </tr>
         <tr>
            <td class="td_1" width="25%"><fmt:message    key='tranState' /></td>
            <td class="td_2 " width="25%">
                     <%=BaseDataHelper.getNameByCode("BILLS_STATUS", beanVo.getTranState())%>
            </td>
            <td class="td_1" width="25%"><fmt:message    key='acceptProgress' /></td>
            <td class="td_2 " width="25%">
                    <c:if test="${bean.acceptProgress=='0'}">审批通过</c:if>
                     <c:if test="${bean.acceptProgress=='1'}">审批通过，请来领取</c:if>
            </td>
              <tr>  <td class="td_1" width="25%"><fmt:message    key='explain' /></td>
            <td class="td_2 " width="25%" colspan="3" height="500" style="height: ">
                <textarea name="explain" readonly="readonly" style="height: 180px;width:100%;">${bean.explain}</textarea>
            </td></tr>
        </tr>
    </table>
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
                  queryAction="/FAERP/CertificateTransactionAction.do?cmd=queryMateria&formId=${bean.id}"
                  submitAction="/FAERP/CertificateTransactionAction.do?cmd=updateCredentialsMaterialRel"   
                  width="94%" height="200px" 
                  xpath="ReCredentialsMateriaVo" 
                  paramFormId="credentialsTypeForm" 
                  readonly="false" pageSize="100" >
        <r:field fieldName="id" label="" width="0"></r:field>
        <r:field fieldName="credentials_materia_id" label="" width="0" align="center" allowResize="false"></r:field>
        <r:field fieldName="material_name" messagekey="material_name" width="135px">
        </r:field>
         <r:field fieldName="isMust" messagekey="material_isMust" width="60px" allowModify="false" >
           <h:select name="isMust" property="isMust">
                <h:option value="0" label="必选"></h:option>
                <h:option value="1" label="非必选"></h:option>
                <h:option value="2" label="不定项"></h:option>
           </h:select>
        </r:field>
        <r:field fieldName="materiaCommitDate" messagekey="materiaCommitDate" width="75px" allowModify="false">
            <w:date format="yyyy-MM-dd"/>
        </r:field>
         <r:field fieldName="remark" messagekey="remark" width="135px" allowModify="false">
        </r:field>
        <r:field fieldName="explain" messagekey="explain" width="135px" allowModify="false">        
        </r:field>
        <r:field fieldName="handoverPersonName" messagekey="handoverPerson" width="132px" allowModify="false">
        </r:field>
        <r:field fieldName="handoverDate" messagekey="handoverDate" width="135px" allowModify="false">
            <w:date format="yyyy-MM-dd"/>        
        </r:field>
         <r:field fieldName="proof" messagekey="proof" width="45px" onRefreshFunc="showLink" allowModify="false">        
        </r:field>
      </r:datacell>
    </div>
    <div class="xz_title">
      <fmt:message key='tranQuestion'/>
    </div>
          <r:datacell id="datacell3" 
                      queryAction="/FAERP/CertificateTransactionAction.do?cmd=queryProblem&formId=${bean.id}"
                      width="94%" height="200px" 
                      xpath="CredentialsTranProblemVO" 
                      paramFormId="credentialsTypeForm" 
                      readonly="false" pageSize="100" >
             <r:field fieldName="id" label="" width="0"></r:field>
            <r:field fieldName="serialNo" label="" width="35" onRefreshFunc="showRowNo" align="center" allowResize="false" messagekey="serialNo"></r:field>
            <r:field fieldName="question" messagekey="question" width="135px" allowModify="false">
            <h:text/>
            </r:field>
             <r:field fieldName="questionStatus" messagekey="questionStatus" width="135px" allowModify="false" >
                 <h:select name="questionStatus">
                    <h:option value="000" label="待处理"></h:option>
                    <h:option value="001" label="完成"></h:option>
                    <h:option value="002" label="员工自带"></h:option>
                 </h:select>
             </r:field>
            <r:field fieldName="commitPersonName" messagekey="commitPerson" width="135px" allowModify="false"></r:field>
            <r:field fieldName="commitDate" messagekey="commitDate" width="135px" allowModify="false">
               <w:date format="yyyy-MM-dd"/>
            </r:field>
             <r:field fieldName="finishDate" messagekey="finishDate" width="135px" allowModify="false">
               <w:date format="yyyy-MM-dd"/>
             </r:field>
          </r:datacell>
    </div>
    <div id="ccChild2" class="box_xinzeng" style="height: 75px;">
    <table width="100%" height="75" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
                <td class="td_1" width="25%"><fmt:message    key='auditOption' /></td>
                <td class="td_2 " colspan="3">
                 ${bean.auditOption}
                 <input type="hidden" name="auditOption" value="${bean.auditOption}"/>
                </td>
        </tr>
        <tr>
            <td class="td_1" width="25%"><fmt:message   key='auditPerson' /></td>
            <td class="td_2 " width="25%" >
                 ${bean.auditPersonName}
                 <input type="hidden" name="auditPersonName" value="${bean.auditPersonName}"/>
            </td>
            <td class="td_1" width="25%"><fmt:message key='auditDate' /></td>
            <td class="td_2 " width="25%">
                   <%= beanVo.getAuditDate()==null?"":df.format(beanVo.getAuditDate())%>
                     <input type="hidden" name="auditDate" value="${bean.auditDate}"/>
            </td>
        </tr>
    </table>
    </div>
    <div class="mx_button" style="text-align: center; margin-left: 0px;">
        <input type="button"    class="icon_2" value='<fmt:message key="go_back"/>' onClick="javascript:cancel_onClick()" />
    </div>
    </form>
</fmt:bundle>
</body>
</html>
