<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.contract.vo.ContractVo" %>
<%@ page import="rayoo.sales.contract.util.IContractConstants" %>
<%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<%@ page import="gap.rm.tools.helper.RmUploadHelper" %>
<%@page import="gap.dd.basedata.util.BaseDataHelper"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>

<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<script src="<%=request.getContextPath()%>/dwr/interface/TreeAjax.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/engine.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/util.js" type="text/javascript"></script> 
 <script language="javascript" src="<venus:base/>/js/ajax/gap-ajax-tree.js"></script>
 <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>


<STYLE TYPE="text/css" MEDIA=screen>
.tree_node_onfocus{
  TEXT-DECORATION: none;
  background-color: highlight;
  color:white;
}

ul.rootNode{
    CURSOR: default; MARGIN-LEFT: 5px; MARGIN-RIGHT: 5px; MARGIN-TOP: 5px;padding-top:0px; padding-left:0px;
}
ul.baseNode{
    MARGIN-LEFT: 0px; MARGIN-RIGHT: 0px; MARGIN-TOP: 0px;MARGIN-BOTTOM: 0px;padding-top:0px; padding-left:0px;
}
LI {
    MARGIN-LEFT: 15px;LIST-STYLE: none; MARGIN-BOTTOM: 0px; MARGIN-TOP: 0px; VERTICAL-ALIGN: middle;
}
</STYLE>

<%  String ids=""; %>

<script><!--
String.prototype.trim   =   function()
{
         //   用正则表达式将前后空格
         //   用空字符串替代。
         return   this.replace(/(^\s*)|(\s*$)/g,   "");
}
    
    //用户调用的beanID
    var beanId="IContracttemitemBs";//以数据库为数据源的树
    //新增根节点和新增节点时，记住根节点信息或者父节点信息
    var nowData;

    //显示当前节点的信息
    function displayNode(nodeId,divid){
        //隐藏新增信息
         divExtend("newTreeNodeDiv","none");
        //显示修改信息
          divExtend("treeNodeDiv","none");
        //隐藏用户页面
        divExtend('treeNodeMessageDiv',"none");
        //载入修改页面
     //     includeEditPage(nodeId,divid);
             if(null!=divid&&divid!='div_root'){
              viewPage(nodeId,divid);
             }else{
              form_treebasic.id.value=nodeId;
                form_treebasic.divid.value=divid;
             }        
    }
    
    
     function  viewPage(nodeId,divid){   
          var pageobj="/jsp/faerp/sales/contract/treeContract.jsp";//新增页面，用户修改
          TreeAjax.getInclude(pageobj,function(data) {
            dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
             DWREngine.setErrorHandler(eh); 
             form_treebasic.id.value=nodeId;
              form_treebasic.divid.value=divid;
            TreeAjax.getNodeMessage(nodeId,beanId,function(data){
              divExtend('treeNodeMessageDiv',"");
           //      divExtend("treeNodeDiv","");
                setForms(data);
                nowData=data;
            });
        });
    }
    
    //保存修改后的节点信息
    function updateNode(){
        if(confirm(i18n4ajaxList.confirm_to_update_node)) {
            var nodeid=form_treebasic.id.value;
            var divid=form_treebasic.divid.value;
                if(null==nodeid||nodeid.length==0){
                      alert("请选择节点！");
                      return ;
                 }
               if(null==divid||divid.length==0){
                      alert("请选择节点！");
                      return ;
                 }
            var nodeName=form_treeNode.contract_template_item_name.value.trim();
            var contract_template_item_content=form_treeNode.contract_template_item_content.value.trim();
            var english_name=form_treeNode.english_name.value.trim();
            var english_content=form_treeNode.english_content.value.trim();
            var is_can_modify="0";
           var serial_no=form_treeNode.serial_no.value.trim();
            var ids=form_treebasic.ids.value;
                 
                 if(nodeid==ids){
                    alert("根节点不能修改！");
                 return;
                 }
             if(nodeName==""||nodeName.length==0){
                      alert("名称不能为空！");
                      return ;
          }
           if(contract_template_item_content==""||contract_template_item_content.length==0){
                      alert("内容不能为空！");
                      return ;
          }
                 if(serial_no!=""&&serial_no.length!=0){
                                       if(isNaN(serial_no)){
                              alert("显示顺序为空或非数字！");
                              return ;
                        }
               }
            if(checkFormsForName("form_treeNode")==true){
                DWREngine.setErrorHandler(eh); 
               var map={"id":nodeid,"divid":divid,"name":nodeName,"contract_template_item_content":contract_template_item_content,"english_name":english_name,"english_content":english_content,"is_can_modify":is_can_modify,"serial_no":serial_no};//属性值id,divid是map中必须有的值。
        
                TreeAjax.updateNode(map,beanId,function(data){
                    populateSpan(data);
                    nowData=data;
                    divExtend('treeNodeMessageDiv',"none");
                    divExtend('treeNodeDiv',"none");
                    
                    alert(i18n4ajaxList.update_success);
                        //隐藏用户页面
              //      onLoadTree();
                });                
            }
        }
    }
    //删除选中的节点
    function deleteNode(){
            var nodeid=form_treebasic.id.value;
            var divid=form_treebasic.divid.value;
                if(null==nodeid||nodeid.length==0){
                      alert("请选择节点！");
                      return ;
                 }
               if(null==divid||divid.length==0){
                      alert("请选择节点！");
                      return ;
                 }
            var parentId=form_treebasic.parentId.value;
       //       var nodeName=form_treeNode.contract_template_item_name.value.trim();
             DWREngine.setErrorHandler(eh); 
            var map={"id":nodeid,"divid":divid,"parentId":parentId};//属性值id,divid和parentId是map中必须有的值。
            
            TreeAjax.deleteNode(map,beanId,function(data){
                setUlOrLiForDisabled(data);//删除节点时，使树节点隐藏
                changeNodeAttribute(data);
            });
                divExtend('treeNodeMessageDiv',"none");
             setButtonForNoDisabled("addButton", "addButtonTd", null, true);//设置新增按钮disabled,同时修改该按钮所在td的样式
            setButtonForNoDisabled("deleteButton", "deleteButtonTd", null, true);//设置删除按钮disabled,同时修改该按钮所在td的样式
    }
    //在选中的节点下增加子节点
    function addNode(){          
        var nodeid=form_treebasic.id.value;
        var divid=form_treebasic.divid.value;
                if(null==nodeid||nodeid.length==0){
                      alert("请选择节点！");
                      return ;
                 }
               if(null==divid||divid.length==0){
                      alert("请选择节点！");
                      return ;
                 }
        var newNodeName=form_treeNode.contract_template_item_name.value.trim();
        var contract_template_item_content=form_treeNode.contract_template_item_content.value.trim();
        var english_name=form_treeNode.english_name.value.trim();
        var english_content=form_treeNode.english_content.value.trim();
        var is_can_modify="0";
        
        if(newNodeName==""||newNodeName.length==0){
           alert("名称不能为空！");
           return ;
        }
              if(contract_template_item_content==""||contract_template_item_content.length==0){
                      alert("名称内容不能为空！");
                      return ;
          }
       var serial_no=form_treeNode.serial_no.value.trim();
               if(serial_no!=""||serial_no.length!=0){
                                if(isNaN(serial_no)){
                                  alert("显示顺序为空或非数字！");
                                  return ;
                            }
               }
        var ids=form_treebasic.ids.value;
        if(checkFormsForName("form_treeNode")==true){
            DWREngine.setErrorHandler(eh); 
            var map={"parentId":nodeid,"divid":divid,"name":newNodeName,"contract_template_item_content":contract_template_item_content,"english_name":english_name,"english_content":english_content,"is_can_modify":is_can_modify,"serial_no":serial_no,"ids":ids};//属性值parentId和divid是map中必须有的值。
            TreeAjax.addNode(map,beanId,function(data){      
            if(data.treevalue!=""){
                populateDiv(data);
                changeNodeAttribute(data);
                setForms(nowData);
            }});
            //隐藏新增信息
            divExtend('newTreeNodeDiv',"none");
            //隐藏修改信息
            divExtend('treeNodeDiv',"none");
            //隐藏用户页面
           divExtend('treeNodeMessageDiv',"none");
         //     onLoadTree();
        }
    }
    //增加根节点,方法名称+S是为了避免关键字。
    function addRoots(){
            var newNodeName=form_treeNode.contract_template_item_name.value.trim();
            if(checkFormsForName("form_treeNode")==true){
                DWREngine.setErrorHandler(eh); 
                var map={"name":newNodeName};//属性值name是map中必须有的值。
                TreeAjax.addRoot(map,beanId,function(data){  
                if(data.treevalue!=""){
                    populateDiv(data);
                    setForms(nowData);
                }});
            }
            //隐藏新增根节点按钮信息
            divExtend('newTreeRootDiv',"none");
            //隐藏修改节点按钮信息
            divExtend('treeNodeDiv',"none");
            //隐藏用户修改信息
            divExtend('treeNodeMessageDiv',"none");
    }
    
    //载入新增节点页面
    function includeAddPage(){
             var nodeId=form_treebasic.id.value;
             var divid=form_treebasic.divid.value;
                if(null==nodeId||nodeId.length==0){
                      alert("请选择节点！");
                      return ;
                 }
               if(null==divid||divid.length==0){
                      alert("请选择节点！");
                      return ;
                 }
    
        var pageobj="/jsp/faerp/sales/contract/treeContract.jsp?flag=insert";//新增页面，用户修改
        TreeAjax.getInclude(pageobj,function(data) {
            dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
            });
              divExtend('treeNodeMessageDiv',"");
    }
    
    //载入新增根节点页面
    function includeAddRootPage(){
            var pageobj="/jsp/faerp/sales/contract/treeContract.jsp?flag=add";//新增页面，用户修改
        TreeAjax.getInclude(pageobj,function(data) {
            dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
            });
    }
    
    //载入修改页面
    function includeEditPage(){
         var nodeId=form_treebasic.id.value;
         var divid=form_treebasic.divid.value;
                if(null==nodeId||nodeId.length==0){
                      alert("请选择！");
                      return ;
                 }
               if(null==divid||divid.length==0){
                      alert("请选择！");
                      return ;
                 }
          var pageobj="/jsp/faerp/sales/contract/treeContract.jsp?flag=update";//新增页面，用户修改
          TreeAjax.getInclude(pageobj,function(data) {
            dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
             DWREngine.setErrorHandler(eh); 
     //        form_treebasic.id.value=nodeId;
       //       form_treebasic.divid.value=divid;
            TreeAjax.getNodeMessage(nodeId,beanId,function(data){
              divExtend('treeNodeMessageDiv',"");
                divExtend("treeNodeDiv","");
                setForms(data);
                nowData=data;
            });
        });
    }

    
    /*
     *往页面填充值
     *@param data 后台往前台传的vo
     */
    function setForms(data){
        for(var property in data){ 
        
     //    alert(property+"="+data[property]);
        
           dwr.util.setValue(property, data[property], { escapeHtml:false });
        }
    }

    function checkFormsForName(formName){//校验名称为formName值的form 中的控件
        var checkResult = true;
        rmTempStatusIsAlert = false;
        rmTempStatusIsFocus = false;
        
        setAllVenusInputsDefault();
        for (var i=0;i<document.forms.length;i++) {
            if(formName!=document.forms[i].name){continue;}
                for (var j=0;j<document.forms[i].elements.length;j++) {
                var thisInput = document.forms[i].elements[j];
                if ( thisInput.type!="hidden" && thisInput.type!="button" && !( thisInput.id.indexOf("TF_")>=0 && thisInput.id.indexOf("_TF")>0 ) ){
                    var rtValue = check(thisInput);
                    if(checkResult && rtValue == false) {
                        checkResult = false;
                    }
                }
            }
        }
        return checkResult;
    }
function extendsParamsMap(paramsMap){//用户扩展过滤条件
            //获取用户的过滤条件
            var locations=document.getElementById("ids");
             if(locations.value!=""){
                //用户自定义的过滤条件
                paramsMap["ids"]=locations.value;
            }
}
//===========================================用户自定义方法
function simpleQuery_onClick(){
    nodeDivHide();//隐藏节点信息 
  //   setButtonForNoDisabled("addButton", "addButtonTd", null, true);//新增按钮失效
 //    setButtonForNoDisabled("deleteButton", "deleteButtonTd", null, true);//删除按钮失效
    var paramsMap={};
    //获取用户的过滤条件
  //  var locations=document.getElementById("location_query");
  //  if(locations.value!=""){
        //用户自定义的过滤条件
     //   paramsMap["location_query"]=locations.value;
  //   }
    initTree('root','tree',paramsMap);
}

function onLoadTree(){//用户自定义初始化树
    //获取用户的过滤条件
     var paramsMap={};
   var locations=document.getElementById("ids").value;
       if(locations!=""){
        //用户自定义的过滤条件
        paramsMap["ids"]=locations;
     }
    initTree('root','tree',paramsMap);
}

--></script>

<%  //判断是否为修改页面
String  effect_date="";
String lapse_date="";
String contract_template_name="";
String contract_template_version="";
    ContractVo resultVo = null;  //t/定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(IContractConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (ContractVo)request.getAttribute(IContractConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
            ids=resultVo.getId();
            effect_date  =String.valueOf(resultVo.getEffect_date() );
            if(null!= effect_date&&!"".equals( effect_date)&&!"null".equals(effect_date)){
                effect_date=   effect_date.substring(0,10);
            }else{
                effect_date="";
            }
            lapse_date=String.valueOf(resultVo.getLapse_date());
            if(null!= lapse_date&&!"".equals( lapse_date)&&!lapse_date.equals("null")){
                lapse_date=   lapse_date.substring(0,10);
            }else{
                lapse_date="";
            }
            contract_template_name=resultVo.getContract_template_name();
            if(null==contract_template_name||"".equals(contract_template_name)||contract_template_name.equals("null")){
                contract_template_name="";
            }
            contract_template_version=resultVo.getContract_template_version();
            if(null==contract_template_version||contract_template_version.equals("")||contract_template_version.equals("null")){
                contract_template_version="";
            }
          
        }
    }
%>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<html>
<fmt:bundle basename="rayoo.salse.contract.contract_resource" prefix="rayoo.salse.contract.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">

function  existCheck(){
 var id = document.getElementById("ids").value;
 var contract_template_name = document.getElementById("contract_template_name").value.trim();
     jQuery.ajax({
        url: "<%=request.getContextPath()%>/ContractAction.do?cmd=existCheck&contract_template_name="+encodeURI(contract_template_name)+"&id="+id,
        type: 'GET',
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
        success: function(text){ 
           if(text==2){
               alert("<fmt:message key='contract_template_exise'/>");  
              document.getElementById("contract_template_name").value = "";
               return;
           }
        }
        });
}
    function insert_onClick(){  //插入单条数据
    var contract_template_name = document.getElementById("contract_template_name").value;
    var contract_template_version = document.getElementById("contract_template_version").value;
    var effect_date = document.getElementById("effect_date").value;
    var lapse_date = document.getElementById("lapse_date").value;
    var contract_type_bd = document.getElementById("contract_type_bd").value;
    var id = document.getElementById("ids").value;
         if(contract_template_name==""||contract_template_name.trim().length==0){
           alert("<fmt:message key='contract_template_not_null'/>");
           return ;
        }
        if(contract_type_bd==""||contract_type_bd.length==0){
            alert("<fmt:message key='contract_template_type_not_null'/>");
            return;
        }
    var flags=true;
    if(null != id &&id.trim().length != 0){
          jQuery.ajax({
        url: "<%=request.getContextPath()%>/ContractAction.do?cmd=update&contract_template_name="+encodeURI(contract_template_name)+"&contract_template_version="+encodeURI(contract_template_version)+"&effect_date="+effect_date+"&lapse_date="+lapse_date+"&id="+id+"&contract_type_bd="+contract_type_bd,
        type: 'post',                
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
        success: function(text){ 
        alert("<fmt:message key='renewal_success'/>");  
        }
        });
    
    }else{
    
          jQuery.ajax({
        url: "<%=request.getContextPath()%>/ContractAction.do?cmd=insert&contract_template_name="+encodeURI(contract_template_name)+"&contract_template_version="+encodeURI(contract_template_version)+"&effect_date="+effect_date+"&lapse_date="+lapse_date+"&contract_type_bd="+contract_type_bd,
        type: 'post',
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
        success: function(text){ 
          document.getElementById("ids").value = text;
          if(null!=text&&text.trim().length>0){
              onLoadTree();
          }
        }
        });
  
  } 
  return flags;
  
    }

    function update_onClick(id){  //保存修改后的单条数据
     var contract_template_name = document.getElementById("contract_template_name").value;
    var contract_template_version = document.getElementById("contract_template_version").value;
    var effect_date = document.getElementById("effect_date").value;
    var lapse_date = document.getElementById("lapse_date").value;
    var contract_type_bd = document.getElementById("contract_type_bd").value;
        if(contract_template_name==""||contract_template_name.trim().length==0){
           alert("<fmt:message key='contract_template_not_null'/>");
           return ;
        }
        if(contract_type_bd==""||contract_type_bd.length==0){
            alert("<fmt:message key='contract_template_type_not_null'/>");
            return;
        }
          if(effect_date!=""||effect_date.trim().length!=0&&lapse_date!=""||lapse_date.trim().length!=0){
              var beginTime = effect_date;
                            var endTime = lapse_date;
                            var beginTimes=beginTime.substring(0,10).split('-');
                            var endTimes=endTime.substring(0,10).split('-');
                            beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
                            endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
                            if(beginTime>endTime){
                                alert("<fmt:message key='lapse_less_effect'/>");
                                return ;
                            }
        }
      var id = document.getElementById("ids").value;
         jQuery.ajax({
        url: "<%=request.getContextPath()%>/ContractAction.do?cmd=update&contract_template_name="+encodeURI(contract_template_name)+"&contract_template_version="+encodeURI(contract_template_version)+"&effect_date="+effect_date+"&lapse_date="+lapse_date+"&id="+id+"&contract_type_bd="+contract_type_bd,
        type: 'post',
        dataType: 'html',
        timeout: 10000,
        error: function(){
            alert('Error loading XML document');
            return  null;
        },
        success: function(text){ 
           alert("<fmt:message key='renewal_success'/>");  
        }
        });
    }

    function cancel_onClick(){  //取消后返回列表页面
        //form.action="<%=request.getContextPath()%>/ContractAction.do?cmd=queryAll&backFlag=true";
        //form.submit();
        window.close();
    }
</script>
</head>
<body onload="javascript:onLoadTree();">
<form name="form_treebasic" method="post">

<input id="ids" name="ids" type="hidden" class="text_field" inputName="节点id" value="<%  out.print(ids); %>"   readonly="true">

<input id="divid" name="divid" type="hidden" class="text_field" inputName="节点层id" value="" readonly="true">
<input id="rootFlag" name="rootFlag" type="hidden" class="text_field" inputName="是否有根节点" value="" readonly="true">
<input id="id" name="id" type="hidden" class="text_field" inputName="节点id" value="" readonly="true">    
<input id="parentId" name="parentId" type="hidden" class="text_field" inputName="父节点id" value="" readonly="true">
<input id="webModel" name="webModel" type="hidden" class="text_field" inputName="发布目录" value="<%=request.getContextPath()%>" readonly="true">
</form>
<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('<fmt:message key='modify_contract_template'/>','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('<fmt:message key='add_contract_template'/>','<%=request.getContextPath()%>/');
</script>
 <div class="ringht_x">
<form name="form" method="post">
<input   id="location_query"   type="hidden" name="location_query" value="">
<input type="hidden" name="create_date" />
 
<div id="ccChild1"     class="box_xinzeng" style="height:100px; "> 
                    <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                            <tr>
                                <td class="td_1" ><span class="style_required_red">* </span><fmt:message key='contract_template_name'/></td>
                                <td class="td_2 ">
                                    <input type="text" class="text_field"  id = "contract_template_name" name="contract_template_name" inputName="合同模板名称" value="<% out.print(contract_template_name); %>" maxLength="50" validate="notNull;"  onkeyup="existCheck();"/>
                                </td>
                                 <td class="td_1" ><fmt:message key='contract_template_version'/></td>
                                <td class="td_2 ">
                                    <input type="text" class="text_field" id="contract_template_version"    name="contract_template_version" inputName="合同模板版本号" value="<% out.print(contract_template_version);%>" maxLength="64" />
                                </td>
                            </tr>                   
                            <tr>
                                <td class="td_1" ><fmt:message key='contract_effect_date'/></td>                                                                                                             
                                <td class="td_2">
                                    <w:date format="yyyy-MM-dd" id="effect_date" name="effect_date" property="bean/effect_date" width="189px"/>
                                </td>
                                 <td class="td_1" ><fmt:message key='contract_lapse_date'/></td>
                                <td class="td_2">
                                    <w:date format="yyyy-MM-dd" id="lapse_date" name="lapse_date" property="bean/lapse_date" width="189px"/>
                                </td>
                            </tr>    
                            <tr>
                                <td class="td_1" ><fmt:message key='contract_template_type'/></td>                                                                
                                <td class="td_2">
                                    <d:select dictTypeId="CONTRACT_TYPE_BD" name="contract_type_bd" id="contract_type_bd" property="bean/contract_type_bd" style="width:208px"/>
                                </td>
                                 <td class="td_1" >&nbsp;</td>
                                <td class="td_2">
                                    &nbsp;
                                </td>
                            </tr>                     
                    </table>
        </div>  
         <div class="mx_button"  align="center">
                                <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
                                <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>      
     </form> 
    <div id="treeOtherDiv"  style="display:block"   style="height:25px; ">                                              
          <table align="right">
              <tr> 
                      <td id="addButtonTd" >
                        <input type="button" id="addButton"   class="icon_3" value='<fmt:message key='add_terms'/>' onClick="javascript:includeAddPage();"   />
                      </td>
                        <td id="modifyButtonTd">
                        <input type="button" id="modifyButton" class="icon_2" value='<fmt:message key="modify"/>' onClick="javascript:includeEditPage();"  />
                        </td>
                      <td id="deleteButtonTd">
                        <input type="button" id="deleteButton" class="icon_2" value='<fmt:message key="delete"/>' onClick="javascript:deleteNode();"  />
                      </td>
                           <td>
                            <div id="treeNodeDiv" style="display:none"> 
                                  <input  type="button" id="updateNodes" class="icon_2"   value='<fmt:message  key="save"/>' onClick="javascript:updateNode();" />      
                              </div>
                              
                           <div id="newTreeNodeDiv"  style="display:none">
                                                           <input type="button" name="addNodes" class="icon_2"    value="<fmt:message   key="save"/>" onClick="javascript:addNode();">      
                                                       </div>
                    </td>
              </tr>
          </table>
    </div>
    <div id="ccChild1"  style="height:150px; "> 
        <table  class="table_div_content">
            <tr>
                <td valign="top">
                        <div id="tree" style="width:350; height:250;overflow:auto;">
                    </div><br>
                </td>
                <td rowspan="2" style="padding-left:0" valign="top">
                    <form name="form_treeNode" method="get">
                        <div id="treeNodeMessageDiv" style="display:block"> 
                        </div> 
                    </form>
                </td>
            </tr>
        </table>
    </div>
</div>
</div>
<script language="javascript">
    writeTableBottom('<venus:base/>/');
</script>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
    if(isModify) {  //如果本页面是修改页面
     //   out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
%>
</script>
