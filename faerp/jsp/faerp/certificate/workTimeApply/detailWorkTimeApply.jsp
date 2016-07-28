<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@page import="rayoo.certificate.workTimeApply.vo.WorkTimeApplyVO"%>
<html>
<fmt:bundle basename="rayoo.certificate.workTimeApply.workTimeApply_resource_zh"    prefix="rayoo.certificate.workTimeApply.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">
	<title><fmt:message key="workTimeApply" /></title>
	<script type="text/javascript" src="<venus:base/>/jsp/faerp/certificate/certificateTransaction/insertCredentialsTran.js"></script>
	<script>
	    function rtnFuncCustomer(arg){
        var lookup = $id("companyID");
        //alert(arg[0]);    id
        //alert(arg[1]);    code
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#companyNumber").text(arg[1]);
        jQuery("#companyName").val(arg[2]);
        jQuery("[name=\"companyNumber\"]").val(arg[1]);
        return false;
    }
	    jQuery(document).ready(function()
    {
       if(jQuery("#tranState").val()=="001")
       {   
             $id("datacell2").queryAction="/FAERP/WorkTimeApplyAction.do?cmd=queryMateria";
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
            datasettr.setProperty("finishDate",(myDate.getFullYear()+"-"+((myDate.getMonth()+1)<10?("0"+(myDate.getMonth()+1)):(myDate.getMonth()+1))+"-"+((myDate.getDate())<10?("0"+(myDate.getDate())):(myDate.getDate()))));
       }
    }
    //问题数据表行新增
     function add_materia_row(){
            var myDate = new Date();
            $id("datacell3").addRow(); 
            var datacell = $id("datacell3");
            var activeRow = datacell.activeRow;
            var datasettr = datacell.getEntity(activeRow);
            datasettr.setProperty("commitDate",(myDate.getFullYear()+"-"+((myDate.getMonth()+1)<10?("0"+(myDate.getMonth()+1)):(myDate.getMonth()+1))+"-"+((myDate.getDate())<10?("0"+(myDate.getDate())):(myDate.getDate()))));
            datasettr.setProperty("commitPersonName",jQuery("#loginName").val());
            datasettr.setProperty("questionStatus","000");
    }
          //显示一般的链接
    function showLink(value,entity,rowNo,cellNo){
            return "<a onclick=\"downLoad('"+entity.getProperty("material_name")+"')\"  style='color: #0033CC; font-weight: bold; text-decoration: underline;cursor: pointer;'>"+"样张"+"</a>";
    }
    function downLoad(arg)
    {
               jQuery.ajax({
                     url:"<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=downLoad",
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
                                window.location.href="<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=downLoad&infoid="+arg+"&downLoadType=0";
                              }
                            }
                      });
    }
      function zipDownload()
    {
       var infoId;
       var companyRegArear=jQuery("[name='companyRegArear']").val();
       if(jQuery("#tranState").val()=="000"||jQuery("#tranState").val()=="001"&&jQuery("#init").val()!="0")
       {
         infoId= document.getElementById("tranType").value;
         if(infoId==undefined||infoId==null||infoId=="")
           {
               alert("请选择办理类型");
               return false;
           }
           if(companyRegArear==undefined||companyRegArear==null||companyRegArear=="")
           {
                alert("公司注册区县");
               return false;
           }
           window.location.href="<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=downLoad&infoid="+infoId+"&companyRegArear="+employeeEntryType+"&downLoadType=1";
       }
       else
       {
          infoId= document.getElementById("edit_id").value;
          window.location.href="<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=downLoad&infoid="+infoId+"&downLoadType=1";
       }
       if(infoId==undefined||infoId==null||infoId=="")
       {
           alert("请选择办理类型");
           return false;
       }
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
        var row;
       for(var i=0;i<$id("datacell3").getAllRows().length;i++)
       {
         row=$id("datacell3").getAllRows()[i];
        row.cells[1].innerHTML='<DIV class="eos-inner eos-dc-col-datacell3-1">'+(i+1)+'</DIV>';
       }
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
                datasettr.setProperty("materiaCommitDate",(myDate.getFullYear()+"-"+((myDate.getMonth()+1)<10?("0"+(myDate.getMonth()+1)):(myDate.getMonth()+1))+"-"+((myDate.getDate())<10?("0"+(myDate.getDate())):(myDate.getDate()))));
            }
            else  if(jQuery("#tranState").val()=="002"||jQuery("#tranState").val()=="004"||jQuery("#tranState").val()=="005")
            {
                datasettr.setProperty("handoverPersonName",jQuery("#loginName").val());
                datasettr.setProperty("handoverDate",(myDate.getFullYear()+"-"+((myDate.getMonth()+1)<10?("0"+(myDate.getMonth()+1)):(myDate.getMonth()+1))+"-"+((myDate.getDate())<10?("0"+(myDate.getDate())):(myDate.getDate()))));
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
	                    jQuery("#tranType").val(jQuery("#tranTypeTemp").val());
	                    return;
	           }
	           else{
	                  jQuery("#init").val("1");
	           }
	        }
          $id("datacell2").queryAction="/FAERP/WorkTimeApplyAction.do?cmd=queryMateria1";
          $id("datacell2").addParam("tranType",document.getElementById("tranType").value);
          $id("datacell2").addParam("applyType",document.getElementById("applyType").value);
          $id("datacell2").addParam("companyRegArear",document.getElementById("companyRegArear").value);
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
    
    function checkRadio(arg)
    {
       alert(arg.value);
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
        var processMark=document.getElementById("processMark").value;
        if (arg==5)
        {
          var  noTranReason =document.getElementById("noTranReason").value;
             if(noTranReason==null || noTranReason==""){
                 alert("请输入取消办理原因");
                 return false;
               }
        }
        else if(processMark==1)
        {
             if(jQuery("[name=\"remark\"]").val()!=undefined&&jQuery("[name=\"remark\"]").val().length>0)
            {   
                var cArr = jQuery("[name=\"remark\"]").val().match(/[^\x00-\xff]/ig);
                var length= jQuery("[name=\"remark\"]").val().length + (cArr == null ? 0 : cArr.length);
                if(length>510)
                {
                    alert("您输入的备注，大于255个汉字长度，请重新输入，谢谢！");
                }
            }
             var  companyID =document.getElementById("companyID").value;
             if(companyID==null || companyID==""){
                 alert("请选择公司");
                 return false;
               }
               var  applyType = document.getElementById("applyType").value;
                if(applyType==null || applyType==""){
                    alert("请选择申请类型");
                    return false;
                  }
             var  tranType =document.getElementById("tranType").value;
             if(tranType==null || tranType==""){
                 alert("请选择办理类型");
                 return false;
               }
              var  companyRegArear = document.getElementById("companyRegArear").value;
             if(companyRegArear==null || companyRegArear==""){
                 alert("请选择公司注册区县");
                 return false;
               }
             if(tranType=="新办"){
	             var  oldApproveDate =document.getElementById("oldApproveDate").value;
	             if(oldApproveDate==null || oldApproveDate==""){
	                 alert("请选择原批复日期");
	                 return false;
	               }
           }
            var isOpenSecurityAccount=document.getElementById("isOpenSecurityAccount").value;
             if(isOpenSecurityAccount==null || isOpenSecurityAccount==""){
                 alert("请选择是否已开社保账号");
                 return false;
               }
            var isAwardContract=document.getElementById("isAwardContract").value;
             if(isAwardContract==null || isAwardContract==""){
                 alert("请选择是否与我司签订商务合同");
                 return false;
               }
        }
        else if(processMark=="2")
        {
            var acceptance=document.getElementById("acceptance").value;
             if(acceptance==null || acceptance==""){
                 alert("请选择受理点");
                 return false;
               }
             var deliveryDate=document.getElementById("deliveryDate").value;
             if(deliveryDate==null || deliveryDate==""){
                 alert("请选择外送日期");
                 return false;
               }
        }
        else if(arg==10)
        {
            var approveDate=document.getElementById("approveDate").value;
             if(approveDate==null || approveDate==""){
                 alert("请选择批复日期");
                 return false;
               }
             var approveDateLimtedFrom=document.getElementById("approveDateLimtedFrom").value;
             var approveDateLimtedTo=document.getElementById("approveDateLimtedTo").value;
             if(approveDateLimtedFrom==null || approveDateLimtedFrom==""||approveDateLimtedTo==null || approveDateLimtedTo==""){
                 alert("请选择批复有效期限");
                 return false;
               }
        var dateFrom = approveDateLimtedFrom.replace(/-/g, "/");  
        var dateTo = approveDateLimtedTo.replace(/-/g, "/");   
        dateFrom=new Date(Date.parse(dateFrom));
        dateFrom.setSeconds(0);
        dateTo=new Date(Date.parse(dateTo));
        dateTo.setSeconds(0);
         if(dateTo<=dateFrom){
        alert("批复有效期限，起始日期不能大于截至日期");
         return false;
        }
        }
        if(arg==1)
        {
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
        else if(arg==2)
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
        if(arg==2||arg==10)
        {
            var questionCount=0;
            dataset=   $id("datacell3").dataset;
            emps = dataset.values;
            for(var i=0;i<dataset.getLength();i++)
              {
              datasettr = emps[i];
               if(datasettr.status!=4&&datasettr.status!=3){
	                if(datasettr.getProperty("questionStatus")=="000")
	                {
	                 alert("当前有未处理的问题，请确认问题列表");
	                    return false;
	                }
                }
             }
        }
         if(arg==2||arg==3||arg==4||arg==11||arg==10)
        {
           dataset=   $id("datacell3").dataset;
           emps = dataset.values;
            for(var i=0;i<dataset.getLength();i++)
              {
                datasettr = emps[i];
                if(datasettr.status!=4&&datasettr.status!=3){
	                if(datasettr.getProperty("question")==undefined||(datasettr.getProperty("question")==null||datasettr.getProperty("question")==""))
	                {
	                      alert("存在空问题，请您确认，谢谢");
	                    return false;
	                }
	                if(datasettr.getProperty("questionStatus")==undefined||(datasettr.getProperty("questionStatus")==null||datasettr.getProperty("questionStatus")==""))
	                {
	                    alert("请您确认问题："+datasettr.getProperty("question")+"的处理状态，谢谢");
	                    return false;
	                }
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
               if(datasettr.status!=4&&datasettr.status!=3){
	                if(datasettr.getProperty("questionStatus")=="000")
	                {
	                 questionCount++;
	                }
                }
              }
              if(questionCount==0)
              {
                alert("当前没有待处理的问题，请确认问题列表");
                    return false;
              }
        } 
        save_onClick(arg);           
        return true;
    }
    //保存
    function save_onClick(arg){  //保存
            var  code = jQuery("#edit_id").val();
            var url;
            if(code){
                  url= "<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=updateCredentialsTran&operateType="+arg;
            }
            else
            {
                   url="<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=insertWorkTimeApply&operateType="+arg;
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
                                    if(parseInt(arg)==11||parseInt(arg)==3||parseInt(arg)==4||parseInt(arg)==10||parseInt(arg)==2||parseInt(arg)==8||parseInt(arg)==5)
                                    {
                                        jQuery.ajax({
									                           url:"<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=sendEmail&operateType="+arg+"&formId="+code,
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
                                                                                   alert("很抱歉，邮件发送失败。");
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
                    jQuery("#applyType").val(jQuery("#applyTypeTemp").val());
                    return;
           }
           else{
                  jQuery("#init").val("1");
           }
        }
        var credentials_type_id = document.getElementById('tranType');
        var   j=credentials_type_id.options.length;     
          for(var   i=j-1;i>0;i--)  
          {    
             credentials_type_id.remove(i);
          }  
        var type_bd = document.getElementById('applyType').value;
        if(type_bd == null || type_bd==''){
            return;
        }
         jQuery.getJSON("<venus:base/>/CertificateTransactionAction.do?cmd=findCredentialsType&date="+new Date()+"",{"type_bd":type_bd},  function(json){
          for(var i = 0; i < json.saia.length; i++){
           var id=json.saia[i].id ;
           var name =json.saia[i].credentialsName;
           addAt(credentials_type_id,name,id,1);
            }
             jQuery("#tranType").find("option[value=\""+ jQuery("#tranTypeTemp").val()+"\"]").prop("selected",true);
             if(jQuery("#init").val()!="0")
             {
                $id("datacell2").clear();
                var companyRegArear=jQuery("[name='companyRegArear']").val();
                if(companyRegArear!="null"&&companyRegArear!=null&companyRegArear!=""){
                     findMaterial();
                }
             }          
        });  
    }
    </script>
	</head>
	<body>
	<form name="form" method="post" id="datacell_formid">
	<input		type="hidden" name="id" id="edit_id" value="${bean.id}"/> 
		<input type="hidden" name="statusCellValues" id="statusCellValues"/>
		 <input type="hidden" name="materiaCellValues" id="materiaCellValues">
	<div id="right" style="height: 140px;"><script language="javascript">
        writeTableTopFesco("<fmt:message key='workTimeApply'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
    </script> <%
    String name = LoginHelper.getLoginName(request);//获得用户姓名
    WorkTimeApplyVO beanVo = (WorkTimeApplyVO) request.getAttribute("bean");
    DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
    if(beanVo==null)
    {
        beanVo=new WorkTimeApplyVO();
        beanVo.setTranState("000");
        beanVo.setProcessMark("1");
    }
 %>
    <input type="hidden" id="loginName" value="<%=name %>"/>
    <input type="hidden" id="tranState" name="tranState" value="<%=beanVo.getTranState() %>"/>
    <input type="hidden"  name="processMark" id="processMark"  value="<%=beanVo.getProcessMark() %>"/>
    <input type="hidden" name="companyName" id="companyName"    value="<%=beanVo.getCompanyName() %>"/>
    <input type="hidden" name="companyNumber"  value="<%=beanVo.getCompanyNumber() %>"/>
     <input type="hidden" id="init"/>
     <input type="hidden" id="tranTypeTemp" value="<%=beanVo.getTranType() %>"/>
     <input type="hidden" id="applyTypeTemp" value="<%=beanVo.getApplyType() %>"/>
     <input type="hidden" id="companyRegArearTemp" value="<%=beanVo.getCompanyRegArear()%>"/>
     
	<div class="ringht_x" style="height: 300px;">
	<div id="ccChild1" class="box_xinzeng" style="height: 420px;">
	<table width="100%" height="150" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
		  <td class="td_1" width="25%"><fmt:message  key='companyName' /></td>
                <td class="td_2 "  width="25%">
                    ${bean.companyName}
            </td>
            <td class="td_1" width="25%"><fmt:message  key='companyNumber' /></td>
                <td class="td_2 "  width="25%"  id="companyNumber">${bean.companyNumber}
            </td>
		</tr>
		<tr>
             <td class="td_1" width="25%"><fmt:message   key='applyType' /></td>
            <td class="td_2 " width="25%" >
                <%=beanVo.getApplyType()==null?"":BaseDataHelper.getNameByCode("WORK_TIME_SELECT",beanVo.getApplyType()) %>
            </td>
            <td class="td_1" width="25%"><fmt:message key='tranType' /></td>
            <td class="td_2 " width="25%">
                    ${bean.cardTranTypeName}
            </td>
        </tr>
		<tr>
            <td class="td_1" width="25%"><fmt:message   key='companyRegArear' /></td>
                <td class="td_2 " width="25%">
                    <%=beanVo.getCompanyRegArear()==null?"":BaseDataHelper.getNameByCode("ACCEPTANCE",beanVo.getCompanyRegArear()) %>
                </td>
            <td class="td_1" width="25%" ><fmt:message key='oldApproveDate' /></td>
            <td class="td_2 " width="25%">
                <%=beanVo.getOldApproveDate()==null?"":df.format(beanVo.getOldApproveDate()) %>
            </td>
        </tr>
        <tr>
            <td class="td_1" width="25%" ><fmt:message key='isOpenSecurityAccount' /></td>
            <td class="td_2 " width="25%">
                <%=BaseDataHelper.getNameByCode("TrueOrFalse",beanVo.getIsOpenSecurityAccount()) %>
            </td>
             <td class="td_1" width="25%" ><fmt:message key='isAwardContract' /></td>
            <td class="td_2 " width="25%">
                <%=BaseDataHelper.getNameByCode("TrueOrFalse",beanVo.getIsAwardContract()) %>
            </td>
        </tr>
        <tr>
        <td class="td_1" width="25%"><fmt:message   key='explain' /></td>
            <td class="td_2 " colspan="3" >
                    ${bean.explain}
            </td>
        </tr>
        <tr>
			<td class="td_1" width="25%"><fmt:message key='acceptance' /></td>
			<td class="td_2 "  colspan="3">
                    <%=beanVo.getAcceptance()== null?"":BaseDataHelper.getNameByCode("ACCEPTANCE",beanVo.getAcceptance()) %>
			</td>
			</td>
		</tr>
		<tr>
            <td class="td_1" width="25%"><fmt:message   key='receivePerson' /></td>
            <td class="td_2 " width="25%">${bean.receivePersonName}  
            </td>
             <td class="td_1" width="25%"><fmt:message   key='receiveDate' /></td>
            <td class="td_2 " width="25%"><%=beanVo.getReceiveDate()==null?"":df.format(beanVo.getReceiveDate()) %>
            </td>
        </tr>
        <tr>
           <td class="td_1" width="25%"><fmt:message   key='commitDate' /></td>
            <td class="td_2 " width="25%"><%=beanVo.getAcceptDate()==null?"":df.format(beanVo.getAcceptDate()) %>
            </td>
            <td class="td_1" width="25%"><fmt:message   key='approveFile' /></td>
             <td class="td_2 " width="25%">
             <c:if test="${bean.approveName!=null}">
                      <a href='<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=downLoad&infoid=<%=beanVo.getId()%>&downLoadType=3'  style='color: #0033CC; font-weight: bold; text-decoration: underline;'><%=beanVo.getApproveName() %></a>
              </c:if>
              </td>
        </tr>
         <tr>
            <td class="td_1" width="25%"><fmt:message   key='deliveryDate' /></td>
            <td class="td_2 ">
                    <%=beanVo.getDeliveryDate()==null?"":df.format(beanVo.getDeliveryDate()) %>
            </td>
            <td class="td_1" width="25%"><fmt:message    key='tranState' /></td>
            <td class="td_2 " width="25%">
                     <%=BaseDataHelper.getNameByCode("WORKTIME_STATUS", beanVo.getTranState())%>
            </td>
        </tr>
         <tr>
           <td class="td_1" width="25%"><fmt:message   key='approveDate' /></td>
            <td class="td_2 " width="25%">
                    <%=beanVo.getApproveDate()==null?"":df.format(beanVo.getApproveDate()) %>
            </td>
             <td class="td_1" width="25%"><fmt:message   key='approveDateLimted' /></td>
            <td class="td_2 " width="25%">
                    <%=beanVo.getApproveDateLimtedFrom()==null?"":df.format(beanVo.getApproveDateLimtedFrom()) %>至<%=beanVo.getApproveDateLimtedTo()==null?"":df.format(beanVo.getApproveDateLimtedTo()) %>
            </td>
        </tr>
        <tr>
        <td class="td_1" width="25%"><fmt:message   key='noTranReason' /></td>
            <td class="td_2 " colspan="3">
                    ${bean.noTranReason}
            </td>
        </tr>
        <tr>
        <td class="td_1" width="25%"><fmt:message   key='remark' /></td>
            <td class="td_2 " width="25%" colspan="3">
                <textarea  name="remark" maxlength="50" style="height: 65px;width:100%;" readonly="readonly"/>${bean.remark}</textarea>
            </td>
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
                  queryAction="/FAERP/WorkTimeApplyAction.do?cmd=queryMateria&formId=${bean.id}"
                  submitAction="/FAERP/WorkTimeApplyAction.do?cmd=updateWorkTimeApplyMaterialRe"   
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
         <r:field fieldName="remark" messagekey="remark" width="135px">
        </r:field>
        <r:field fieldName="explain" messagekey="explain" width="135px">        
        </r:field>
        <r:field fieldName="handoverPersonName" messagekey="handoverPerson" width="132px">
        </r:field>
        <r:field fieldName="handoverDate" messagekey="handoverDate" width="105px" allowModify="false">
            <w:date format="yyyy-MM-dd"/>        
        </r:field>
         <r:field fieldName="proof" messagekey="proof" width="45px" onRefreshFunc="showLink" allowModify="false">        
        </r:field>
      </r:datacell>
    </div>
    <div class="xz_title">
      <fmt:message key='tranQuestion'/>
    </div>
    <div style="padding: 8 10 8 8;">
	      <r:datacell id="datacell3" 
	                  queryAction="/FAERP/WorkTimeApplyAction.do?cmd=queryProblem&formId=${bean.id}"
	                  width="94%" height="200px" 
	                  xpath="WorkTimeApplyProblemVO" 
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
	<div class="mx_button" style="text-align: center; margin-left: 0px;">
		<input type="button"	class="icon_2" value='<fmt:message key="close"/>'	onClick="javascript:cancel_onClick()" />
	</div>
	</form>
</fmt:bundle>
</body>
</html>
