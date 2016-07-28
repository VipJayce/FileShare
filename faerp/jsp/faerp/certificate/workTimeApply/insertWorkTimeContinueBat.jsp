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
    <title><fmt:message key="continueTran" /></title>
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
        //解决多选框刷新，原状态消失
        $id("datacell2").beforeRefreshCell = function(cell,field){
            //alert(field.fieldId.indexOf("id_index"));
            if(field && field.fieldId && field.fieldId.indexOf("id")>= 0){
                return false;
            }
            return true;
        } 
        findType();//办证大类与小类初始化联动
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
           window.location.href="<%=request.getContextPath()%>/WorkTimeApplyAction.do?cmd=downLoad&infoid="+infoId+"&companyRegArear="+companyRegArear+"&downLoadType=1";
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
         var row = jQuery(arg).closest("tr")[0];
        var datasettr = datacell.getEntity(row);
        datacell.refreshRow(row,datasettr);
        if(arg.checked)
        {
            $id("datacell2").isModefied=true;
            datasettr.setProperty("materiaCommitDate",(myDate.getFullYear()+"-"+((myDate.getMonth()+1)<10?("0"+(myDate.getMonth()+1)):(myDate.getMonth()+1))+"-"+((myDate.getDate())<10?("0"+(myDate.getDate())):(myDate.getDate()))));
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
        if(processMark==1)
        {
             if(jQuery("[name=\"remark\"]").val()!=undefined&&jQuery("[name=\"remark\"]").val().length>0)
            {   
                var cArr = jQuery("[name=\"remark\"]").val().match(/[^\x00-\xff]/ig);
                var length= jQuery("[name=\"remark\"]").val().length + (cArr == null ? 0 : cArr.length);
                if(length>510)
                {
                    alert("您输入的备注，大于255个汉字长度，请重新输入，谢谢！");
                    return false;
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
	                                            $id("datacell2").addParam("formId",data.formId);
	                                            if(!$id("datacell2").submit())
	                                            {
	                                                       returnValue = ["2"];
	                                                       window.close();
	                                                       window.opener.insertcallBack(returnValue);
	                                            }
	                                            else
	                                            {
	                                               returnValue = ["0"];
                                                   window.close();
                                                   window.opener.insertcallBack(returnValue);
	                                            }
	                                    }
	                                    else{
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
             jQuery("#tranType").find("option:contains(\"续办\"):eq(0)").prop("selected",true);
                $id("datacell2").clear();
                var companyRegArear=jQuery("[name='companyRegArear']").val();
                if(companyRegArear!="null"&&companyRegArear!=null&companyRegArear!=""){
                     findMaterial();
             }          
        });  
    }
    </script>
    </head>
    <body>
    <form name="form" method="post" id="datacell_formid">
    <input      type="hidden" name="id" id="edit_id" value=""/> 
        <input type="hidden" name="statusCellValues" id="statusCellValues"/>
         <input type="hidden" name="materiaCellValues" id="materiaCellValues">
    <div id="right" style="height: 140px;"><script language="javascript">
        writeTableTopFesco("<fmt:message key='continueTran'/>",'<%=request.getContextPath()%>/');  //显示本页的页眉
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
    <input type="hidden"  name="processMark" id="processMark"  value="1"/>
    <input type="hidden" name="companyName" id="companyName"    value="<%=beanVo.getCompanyName() %>"/>
    <input type="hidden" name="companyNumber"  value="<%=beanVo.getCompanyNumber() %>"/>
     <input type="hidden" id="init"/>
     <input type="hidden" id="applyTypeTemp" value="<%=beanVo.getApplyType() %>"/>
     <input type="hidden" id="companyRegArearTemp" value="<%=beanVo.getCompanyRegArear()%>"/>
     
    <div class="ringht_x" style="height: 300px;">
    <div id="ccChild1" class="box_xinzeng" style="height: 230px;">
    <table width="100%" height="150" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1" width="25%"><span class="style_required_red">*</span><fmt:message  key='companyName' /></td>
                <td class="td_2 "  width="25%">
                <w:lookup name="companyID" allowInput="false"
                    onReturnFunc="rtnFuncCustomer" id="companyID"
                    lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1"
                    messagekey="choose_company" height="440" width="580"
                    style="width:270px" value="${bean.companyID}" displayValue="${bean.companyName}" />
            </td>
            <td class="td_1" width="25%"><fmt:message  key='companyNumber' /></td>
                <td class="td_2 "  width="25%"  id="companyNumber">${bean.companyNumber}
            </td>
        </tr>
        <tr>
             <td class="td_1" width="25%"><span class="style_required_red">*</span><fmt:message   key='applyType' /></td>
            <td class="td_2 " width="25%" >
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("applyType",-1,"WORK_TIME_SELECT",beanVo.getApplyType()," id='applyType' onchange=\"findType()\"",false)%>
            </td>
            <td class="td_1" width="25%"><span class="style_required_red">*</span><fmt:message key='tranType' /></td>
            <td class="td_2 " width="25%">
                  <select name="tranType" id="tranType" onchange="findMaterial()" value="">
                        <option value=""><fmt:message key="please_choose" /></option>
                        <option value="新办">新办</option>
                        <option value="续办">续办</option>
                    </select>
            </td>
        </tr>
        <tr>
            <td class="td_1" width="25%"><span class="style_required_red">*</span><fmt:message   key='companyRegArear' /></td>
                <td class="td_2 " width="25%">
                  <%=gap.rm.tools.helper.RmJspHelper.getSelectField("companyRegArear",-1,"ACCEPTANCE",beanVo.getCompanyRegArear()," id='companyRegArear' onchange=\"findMaterial()\"",false)%>
                </td>
            <td class="td_1" width="25%" ><fmt:message key='oldApproveDate' /></td>
            <td class="td_2 " width="25%">
                <w:date format="yyyy-MM-dd"   name="oldApproveDate" id="oldApproveDate" style="width: 125px;" property="bean/approveDateLimtedTo"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" width="25%" ><span class="style_required_red">*</span><fmt:message key='isOpenSecurityAccount' /></td>
            <td class="td_2 " width="25%">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("isOpenSecurityAccount",-1,"TrueOrFalse",beanVo.getIsOpenSecurityAccount()," id='isOpenSecurityAccount'",true)%>
            </td>
             <td class="td_1" width="25%" ><span class="style_required_red">*</span><fmt:message key='isAwardContract' /></td>
            <td class="td_2 " width="25%">
                <%=gap.rm.tools.helper.RmJspHelper.getSelectField("isAwardContract",-1,"TrueOrFalse",beanVo.getIsAwardContract()," id='isAwardContract'",true)%>
            </td>
        </tr>
        <tr>
        <td class="td_1" width="25%"><fmt:message   key='remark' /></td>
            <td class="td_2 " width="25%" colspan="3">
                <textarea  name="remark" maxlength="50" style="height: 65px;width:100%;"/>${bean.remark}</textarea>
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
                  queryAction="/"
                  submitAction="/FAERP/WorkTimeApplyAction.do?cmd=insertCredentialsMaterialRel"   
                  width="94%" height="200px" 
                  xpath="ReCredentialsMateriaVo" 
                  paramFormId="credentialsTypeForm" 
                  readonly="false" pageSize="100" >
        <r:field fieldName="id" label="" width="0"></r:field>
        <r:field fieldName="credentials_materia_id" label="" width="30" onRefreshFunc="showCheckbox" align="center" allowResize="false"></r:field>
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
            <w:date  format="yyyy-MM-dd"  />
        </r:field>
         <r:field fieldName="remark" messagekey="remark" width="135px">
        </r:field>
        <r:field fieldName="explain" messagekey="explain" width="135px">        
        </r:field>
         <r:field fieldName="proof" messagekey="proof" width="45px" onRefreshFunc="showLink" allowModify="false">        
        </r:field>
      </r:datacell>
    </div>
    <div class="mx_button" style="text-align: center; margin-left: 0px;margin-top: 80px">
        <input type="button" class="icon_2" value='<fmt:message key="commit"/>' onClick="javascript:vailform(1)" />
        <input type="button"    class="icon_2" value='<fmt:message key="go_back"/>' onClick="javascript:cancel_onClick()" />
    </div>
    </form>
</fmt:bundle>
</body>
</html>
