<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.contract.vo.ContractVo" %>
<%@ page import="rayoo.sales.contract.util.IContractConstants" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>



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

<%    String contract_template_id= (String)request.getParameter("contract_template_id")  ;
String ids= (String)request.getParameter("ids")  ;
System.out.print("contract_template_id="+ids);
%>

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
    
    <%   if(null!=ids&&!ids.equals("")){%>
        beanId="ISalcontractitemBs";
    <%
    }
    %>
    
    
    var nowData;

    //显示当前节点的信息
    function displayNode(nodeId,divid){
        //隐藏新增信息
        divExtend("newTreeNodeDiv","none");
        //显示修改信息
        divExtend("treeNodeDiv","block");
        //隐藏用户页面
        divExtend('treeNodeMessageDiv',"block");
        //载入修改页面
        includeEditPage(nodeId,divid);
        
    }
    //保存修改后的节点信息
    function updateNode(){
        if(confirm(i18n4ajaxList.confirm_to_update_node)) {
            var nodeid=form_treebasic.id.value;
            var divid=form_treebasic.divid.value;
            var nodeName=form_treeNode.contract_template_item_name.value.trim();
            var contract_template_item_content=form_treeNode.contract_template_item_content.value.trim();
            var english_name=form_treeNode.english_name.value.trim();
            var english_content=form_treeNode.english_content.value.trim();
           var serial_no=form_treeNode.serial_no.value.trim();
             if(nodeName==""||nodeName.length==0){
                      alert("名称不能为空！");
                      return ;
          }
          
           if(contract_template_item_content==""||contract_template_item_content.length==0){
                      alert("名称不能为空！");
                      return ;
          }
          
                if(english_name==""||english_name.length==0){
                      alert("英文名称不能为空！");
                      return ;
          }
          
              if(english_content==""||english_content.length==0){
                      alert("英文内容不能为空！");
                      return ;
            }
          
          
          
                 var ids=form_treebasic.ids.value;
                 
                 if(nodeid==ids){
                 alert("根结点不能修改！");
                 return;
                 
                 }
                 
   
               
            if(isNaN(serial_no)){
                  alert("显示顺序为空或非数字！");
                  return ;
            }
               
               
          
      
            if(checkFormsForName("form_treeNode")==true){
                DWREngine.setErrorHandler(eh); 
               var map={"id":nodeid,"divid":divid,"name":nodeName,"contract_template_item_content":contract_template_item_content,"english_name":english_name,"english_content":english_content,"serial_no":serial_no};//属性值id,divid是map中必须有的值。
        
                TreeAjax.updateNode(map,beanId,function(data){
                    populateSpan(data);
                    nowData=data;
                    alert(i18n4ajaxList.update_success);
                });
                
            }
        }
    }
    //删除选中的节点
    function deleteNode(){
            var nodeid=form_treebasic.id.value;
            var divid=form_treebasic.divid.value;
            var parentId=form_treebasic.parentId.value;
            var nodeName=form_treeNode.contract_template_item_name.value.trim();
            DWREngine.setErrorHandler(eh); 
            var map={"id":nodeid,"divid":divid,"parentId":parentId};//属性值id,divid和parentId是map中必须有的值。
            
            TreeAjax.deleteNode(map,beanId,function(data){
                setUlOrLiForDisabled(data);//删除节点时，使树节点隐藏
                changeNodeAttribute(data);
            });
            setButtonForNoDisabled("addButton", "addButtonTd", null, true);//设置新增按钮disabled,同时修改该按钮所在td的样式
            setButtonForNoDisabled("deleteButton", "deleteButtonTd", null, true);//设置删除按钮disabled,同时修改该按钮所在td的样式
    }
    //在选中的节点下增加子节点
    function addNode(){
          
        var nodeid=form_treebasic.id.value;
        var divid=form_treebasic.divid.value;
        var newNodeName=form_treeNode.contract_template_item_name.value.trim();
        var contract_template_item_content=form_treeNode.contract_template_item_content.value.trim();
        var english_name=form_treeNode.english_name.value.trim();
        var english_content=form_treeNode.english_content.value.trim();
        
        if(newNodeName==""||newNodeName.length==0){
           alert("名称不能为空！");
           return ;
        }
        
              if(contract_template_item_content==""||contract_template_item_content.length==0){
                      alert("名称内容不能为空！");
                      return ;
          }
          
                if(english_name==""||english_name.length==0){
                      alert("英文名称不能为空！");
                      return ;
          }
          
              if(english_content==""||english_content.length==0){
                      alert("英文内容不能为空！");
                      return ;
            }
    
            

       var serial_no=form_treeNode.serial_no.value.trim();
              if(isNaN(serial_no)){
                  alert("显示顺序为空或非数字！");
                  return ;
            }
       
        var ids=form_treebasic.ids.value;
        if(checkFormsForName("form_treeNode")==true){
            DWREngine.setErrorHandler(eh); 
            //    var map={"parentId":nodeid,"divid":divid,"name":newNodeName,"locations":locations.value,"location_query":location_query.value};//属性值parentId和divid是map中必须有的值。
            var map={"parentId":nodeid,"divid":divid,"name":newNodeName,"contract_template_item_content":contract_template_item_content,"english_name":english_name,"english_content":english_content,"serial_no":serial_no,"ids":ids};//属性值parentId和divid是map中必须有的值。
            TreeAjax.addNode(map,beanId,function(data){      
            if(data.treevalue!=""){
                populateDiv(data);
                changeNodeAttribute(data);
                setForms(nowData);
            }});
            //隐藏新增信息
            divExtend('newTreeNodeDiv',"none");
            //隐藏修改信息
            divExtend('treeNodeDiv',"block");
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
        var pageobj="/jsp/faerp/sales/salcontract/treeContract.jsp?flag=insert";//新增页面，用户修改
        TreeAjax.getInclude(pageobj,function(data) {
            dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
            });
    }
    
    //载入新增根节点页面
    function includeAddRootPage(){
            var pageobj="/jsp/faerp/sales/salcontract/treeContract.jsp?flag=add";//新增页面，用户修改
        TreeAjax.getInclude(pageobj,function(data) {
            dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
            });
    }
    
    //载入修改页面
    function includeEditPage(nodeId,divid){
   
          var pageobj="/jsp/faerp/sales/salcontract/treeContract.jsp?flag=update";//新增页面，用户修改
        TreeAjax.getInclude(pageobj,function(data) {
            dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
             DWREngine.setErrorHandler(eh); 
            form_treebasic.id.value=nodeId;
            form_treebasic.divid.value=divid;
            TreeAjax.getNodeMessage(nodeId,beanId,function(data){
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
    setButtonForNoDisabled("addButton", "addButtonTd", null, true);//新增按钮失效
    setButtonForNoDisabled("deleteButton", "deleteButtonTd", null, true);//删除按钮失效
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
      var locations=document.getElementById("contract_template_id").value;
   var ids=document.getElementById("ids").value;
     if(null!=ids&&ids!=""){
        locations=ids;
   }
       if(locations!=""){
        //用户自定义的过滤条件
        paramsMap["ids"]=locations;
     }
    initTree('root','tree',paramsMap);
}

--></script>

<%  //判断是否为修改页面
    ContractVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(IContractConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (ContractVo)request.getAttribute(IContractConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
            ids=resultVo.getId();
        }
    }
%>


<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>




<script language="javascript">
</script>
</head>
<body onload="javascript:onLoadTree();">
<form name="form_treebasic" method="post">

<input id="ids" name="ids" type="hidden" class="text_field" inputName="节点id" value="<%  out.print(ids); %>"   readonly="true">
<input id="contract_template_id" name="contract_template_id" type="hidden" class="text_field" inputName="节点id" value="<%  out.print(contract_template_id); %>"   readonly="true">

<input id="divid" name="divid" type="hidden" class="text_field" inputName="节点层id" value="" readonly="true">
<input id="rootFlag" name="rootFlag" type="hidden" class="text_field" inputName="是否有根节点" value="" readonly="true">
<input id="id" name="id" type="hidden" class="text_field" inputName="节点id" value="" readonly="true">    
<input id="parentId" name="parentId" type="hidden" class="text_field" inputName="父节点id" value="" readonly="true">
<input id="webModel" name="webModel" type="hidden" class="text_field" inputName="发布目录" value="<%=request.getContextPath()%>" readonly="true">
</form>


<input   id="location_query"   type="hidden" name="location_query" value="">
<input type="hidden" name="create_date" />



<div id="right">


 

 


 

       
 



<div id="msg">
</div>
 <div id="ccChild1"> 
<table  class="table_div_content">
    <tr>
        <td valign="top">

            <div id="tree" style="height:350;overflow:auto;">
            </div>
        </td>
        <td valign="top" >
            <form name="form_treeNode" method="get">
                <div id="treeNodeMessageDiv" > 
                </div> 
            </form>
        </td>
    </tr>
    

</table>

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
        out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
%>
</script>
