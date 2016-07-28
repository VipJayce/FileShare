<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.sales.salcontract.vo.SalcontractVo" %>
<%@ page import="rayoo.sales.salcontract.util.ISalcontractConstants" %>

<%@include file="/common/common.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo" %>

<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>

<% 
String f = request.getParameter("f");//f=zp为招聘模块
System.out.println("f:"+f);
String  create_type_bd=(String)request.getParameter("create_type_bd"); 
		if(null==create_type_bd||"".equals(create_type_bd)||create_type_bd=="null"){
		    create_type_bd=(String)request.getAttribute("create_type_bd");
		}
System.out.print("create_type_bd="+create_type_bd);
String contract_template_id= (String)request.getParameter("contract_template_id")  ;
String ids= (String)request.getParameter("ids")  ;
System.out.println("ids:"+ids);
String detail=(String)request.getAttribute("detail");
if(null==detail){
    detail=(String)request.getParameter("detail");
}
String  contract_type_bd=(String)request.getParameter("contract_type_bd");
String  id=(String)request.getParameter("id");
String  contract_name=(String)request.getParameter("contract_name");
//System.out.println(contract_type_bd+"aaa");
String  contract_start_date=(String)request.getParameter("contract_start_date");
String  contract_stop_date=String.valueOf(request.getParameter("contract_stop_date"));

String customer_name=(String)request.getParameter("customer_name");
String agent_b_name=(String)request.getParameter("agent_b_name");
if(agent_b_name!=null&&agent_b_name.equals("null")){
    agent_b_name="";
}
String agent_b_id=(String)request.getParameter("agent_b_id");
String cust_a_id=(String)request.getParameter("cust_a_id");
String customer_code=(String)request.getParameter("customer_code");
    SalcontractVo resultVo = null;  //定义一个临时的vo变量
     AttachmentfileVo avo=null;//附件VO
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
  //  if( id != null && !"".equals(id)) {  //如果从request获得参数"isModify"不为空
 if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute("bean") != null) {  //如果request中取出的bean不为空
            resultVo = (SalcontractVo)request.getAttribute(ISalcontractConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
          contract_name=resultVo.getContract_name();
        contract_start_date=String.valueOf(resultVo.getContract_start_date());
        contract_stop_date=String.valueOf(resultVo.getContract_stop_date());
        if(null!=contract_start_date&&!"".equals(contract_start_date)&&contract_start_date!="null"){
            contract_start_date=contract_start_date.substring(0,10);
        }else{
            contract_start_date="";
        }
        if(null!=contract_stop_date&&!"".equals(contract_stop_date)&&contract_stop_date!="null"){
            contract_stop_date=contract_stop_date.substring(0,10);
        }else{
            contract_stop_date="";
        }
        
        ids=resultVo.getId();
      String  service_company=resultVo.getService_company();
        customer_name=resultVo.getCustomer_name().trim();
        agent_b_name=resultVo.getAgent_b_name();
        agent_b_id=resultVo.getAgent_b_id();
        cust_a_id=resultVo.getCust_a_id();
        customer_code=resultVo.getCustomer_code();
        contract_type_bd=resultVo.getContract_type_bd();
        create_type_bd=resultVo.getCreate_type_bd();
        contract_template_id=resultVo.getContract_template_id();
        
        if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
            avo = (AttachmentfileVo)request.getAttribute("AttachmentfileVo");  //从request中取出vo, 赋值给resultVo
        }
        }
    }
    
     String attachName = avo==null?"":avo.getAttachment_file_name().toString();
     String attachAddress = avo==null?"":avo.getAttachment_file_path().toString();
    
%>



<script src="<%=request.getContextPath()%>/dwr/interface/TreeAjax.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/engine.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/dwr/util.js" type="text/javascript"></script> 
 <script language="javascript" src="<venus:base/>/js/ajax/gap-ajax-tree.js"></script>
<script language="javascript">

function insert_onClick(gapwf){  //插入单条数据
 var contract_start_date=document.form_treebasic.contract_start_date.value.trim();;
 var contract_stop_date=document.form_treebasic.contract_stop_date.value.trim();;
                 if(document.form_treebasic.create_type_bd.value=='1' || document.form_treebasic.create_type_bd.value==1){
                 }else{
					var attach_name=document.form_treebasic.attach_name.value.trim();
					     if(attach_name==""&&attach_name.length==0){
					        alert("合同附件不能为空！");
					        return;
					     }
                 }
      if(document.getElementById("cust_a_id").value==null || document.getElementById("cust_a_id").value==""){
        alert("合同甲方不能为空！");
        return;
      }
 
     if(contract_start_date==""&&contract_start_date.length==0){
        alert("合同起始日期不能为空！");
        return;
     }
     
    <%if(contract_type_bd!=null&&!contract_type_bd.trim().equals("1")){%>
            if(contract_stop_date==""&&contract_stop_date.length==0){
		        alert("合同终止日期不能为空！");
		        return;
		     }
       <%}%>
                     //add by sqp 服务单位改为必选
               var   service_company=document.getElementById("service_company").value;
               if(service_company==null || service_company==""){
               alert("请选择服务单位！");
               return;
               }
               var servicefeeratio1=document.getElementById("servicefeeratio").value;
               var lowestcharge1=document.getElementById("lowestcharge").value;
                var warrantyperiod1=document.getElementById("warrantyperiod").value;
                 var initialcharge1=document.getElementById("initialcharge").value;
               if(!checkNum1(servicefeeratio1)){
                   alert("服务费收费比例必须为数字！");
                   return;
               }
                      if(!checkNum1(lowestcharge1)){
                   alert("最低收费必须为数字！");
                   return;
               }
                      if(!checkNum(warrantyperiod1)){
                   alert("担保期限必须为整数！");
                   return;
               }
                      if(!checkNum1(initialcharge1)){
                   alert("首期服务费必须为数字！");
                   return;
               }
      if(contract_stop_date!=""&&contract_stop_date.length!=0){
                            var beginTime = contract_start_date;
                            var endTime = contract_stop_date;
                            var beginTimes=beginTime.substring(0,10).split('-');
                            var endTimes=endTime.substring(0,10).split('-');
                            beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
                            endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
                            if(beginTime>endTime){
                                alert("合同终止日期小于合同起始日期！");
                                return ;
                            }
       }
       
 	        //add by sqp 服务单位改为必选
               var   service_company=document.getElementById("service_company").value;
               if(service_company==null || service_company==""){
               alert("请选择服务单位！");
               return;
               }
       
        if(checkAllForms()){
                var action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=insert&f=<%=f%>";
                var myAjax = new Ajax(action);
                myAjax.addParam('gapwf', gapwf);
                 myAjax.addParam('agent_b_id', document.form_treebasic.agent_b_id.value);
                 myAjax.addParam('agent_b_name', document.form_treebasic.agent_b_name.value);
                 myAjax.addParam('contract_name', document.form_treebasic.contract_name.value);
                 myAjax.addParam('contract_start_date', document.form_treebasic.contract_start_date.value);
                 myAjax.addParam('contract_stop_date', document.form_treebasic.contract_stop_date.value);
                 myAjax.addParam('create_type_bd', document.form_treebasic.create_type_bd.value);
                 
                   myAjax.addParam('servicefeeratio', document.form_treebasic.servicefeeratio.value);
                     myAjax.addParam('lowestcharge', document.form_treebasic.lowestcharge.value);
                       myAjax.addParam('warrantyperiod', document.form_treebasic.warrantyperiod.value);
                         myAjax.addParam('initialcharge', document.form_treebasic.initialcharge.value);
                   myAjax.addParam('zbid', document.form_treebasic.zbid.value);
                 if(document.form_treebasic.create_type_bd.value=='1' || document.form_treebasic.create_type_bd.value==1){
                    myAjax.addParam('contract_template_id', document.getElementById('contract_template_id').value);
                 }else{
                    myAjax.addParam('attach_name', document.form_treebasic.attach_name.value);
                    myAjax.addParam('attach_address', document.form_treebasic.attach_address.value);
                 }
                 //服务单位
                 myAjax.addParam('service_company', document.form_treebasic.service_company.value);
                 myAjax.addParam('contract_type_bd', document.getElementById('contract_type_bd').value);
                 myAjax.addParam('cust_a_id', document.form_treebasic.cust_a_id.value);
                 myAjax.addParam('cust_a_name', document.form_treebasic.cust_a_name.value);
                 myAjax.addParam('customer_code', document.form_treebasic.customer_code.value);
           
                 myAjax.submit();
                 var returnNode = myAjax.getResponseXMLDom();
                 if( returnNode ) {
                      alert(""+myAjax.getProperty("returnValue"));
                      window['returnValue'] = ""+myAjax.getProperty("returnValue");
                      
                    
                       
                      var oid = myAjax.getProperty("returnMessage");
                      document.getElementById("ids").value=oid;
                      document.getElementById("zbid").value=oid;
                      beanId = "ISalcontractitemBs";
                      _$("#btnsave").hide();  
                      if(gapwf=="yes_nogapwf"){
                         _$("#btesave").hide();  
                      }        
                      
                 }
        }
    }


    function update_onClick(gapwf){  //保存修改后的单条数据
             var contract_start_date=document.form_treebasic.contract_start_date.value.trim();;
			 var contract_stop_date=document.form_treebasic.contract_stop_date.value.trim();;
   	if(document.getElementById("cust_a_id").value==null || document.getElementById("cust_a_id").value==""){
       	alert("合同甲方不能为空！");
        return;
      }
     if(contract_start_date==""&&contract_start_date.length==0){
        alert("合同起始日期不能为空！");
        return;
     }
     
         <%if(contract_type_bd!=null&&!contract_type_bd.trim().equals("1")){%>
            if(contract_stop_date==""&&contract_stop_date.length==0){
                alert("合同终止日期不能为空！");
                return;
             }
       <%}%>
       
      if(contract_stop_date!=""&&contract_stop_date.length!=0){
                            var beginTime = contract_start_date;
                            var endTime = contract_stop_date;
                            var beginTimes=beginTime.substring(0,10).split('-');
                            var endTimes=endTime.substring(0,10).split('-');
                            beginTime=beginTimes[0]+''+beginTimes[1]+''+beginTimes[2];
                            endTime=endTimes[0]+''+endTimes[1]+''+endTimes[2];
                            if(beginTime>endTime){
                                alert("合同终止日期小于合同起始日期！");
                                return ;
                            }
                       }
                   //add by sqp 服务单位改为必选
               var   service_company=document.getElementById("service_company").value;
               if(service_company==null || service_company==""){
               alert("请选择服务单位！");
               return;
               }
                  var servicefeeratio1=document.getElementById("servicefeeratio").value;
               var lowestcharge1=document.getElementById("lowestcharge").value;
                var warrantyperiod1=document.getElementById("warrantyperiod").value;
                 var initialcharge1=document.getElementById("initialcharge").value;
               if(!checkNum1(servicefeeratio1)){
                   alert("服务费收费比例必须为数字！");
                   return;
               }
                      if(!checkNum1(lowestcharge1)){
                   alert("最低收费必须为数字！");
                   return;
               }
                      if(!checkNum(warrantyperiod1)){
                   alert("担保期限必须为整数！");
                   return;
               }
                      if(!checkNum1(initialcharge1)){
                   alert("首期服务费必须为数字！");
                   return;
               }
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
            if(checkAllForms()){
                 var action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=update";
                 var myAjax = new Ajax(action);
                 myAjax.addParam('gapwf', gapwf);
                 myAjax.addParam('contract_name', document.form_treebasic.contract_name.value);
                 myAjax.addParam('contract_start_date', document.form_treebasic.contract_start_date.value);
                 myAjax.addParam('contract_stop_date', document.form_treebasic.contract_stop_date.value);
                myAjax.addParam('create_type_bd', document.form_treebasic.create_type_bd.value);
                       myAjax.addParam('customer_code', document.form_treebasic.customer_code.value);
                     myAjax.addParam('servicefeeratio', document.form_treebasic.servicefeeratio.value);
                     myAjax.addParam('lowestcharge', document.form_treebasic.lowestcharge.value);
                       myAjax.addParam('warrantyperiod', document.form_treebasic.warrantyperiod.value);
                         myAjax.addParam('initialcharge', document.form_treebasic.initialcharge.value);
                           myAjax.addParam('zbid', document.form_treebasic.zbid.value);
                if(document.form_treebasic.create_type_bd.value=='1' || document.form_treebasic.create_type_bd.value==1){
                 }else{
                    myAjax.addParam('attach_name', document.form_treebasic.attach_name.value);
                    myAjax.addParam('attach_address', document.form_treebasic.attach_address.value);
                 }
                  //服务单位
                 myAjax.addParam('service_company', document.form_treebasic.service_company.value);
                   myAjax.addParam('contract_type_bd', document.getElementById('contract_type_bd').value);
                 myAjax.addParam('cust_a_id', document.form_treebasic.cust_a_id.value);
                 myAjax.addParam('cust_a_name', document.form_treebasic.cust_a_name.value);
                 
                 myAjax.addParam('agent_b_id', document.form_treebasic.agent_b_id.value);
                 myAjax.addParam('agent_b_name', document.form_treebasic.agent_b_name.value);
             
                 
                 myAjax.addParam('id', document.form_treebasic.ids.value);
                 myAjax.submit();
                 var returnNode = myAjax.getResponseXMLDom();
                 if( returnNode ) {
                      alert(""+myAjax.getProperty("returnValue"));
                      window['returnValue'] = ""+myAjax.getProperty("returnValue");
                           
                      if(gapwf=="yes_nogapwf"){
                         window.close();
                      window.opener.showListData();//回调父页面函数
                      }      
                   
                 }
        }
    }
   function yulan_onClick(){
    var reportFileName = "VIEW_SALCONTRACT.raq";
   var ids=form_treebasic.ids.value;
   if(ids == "" || null == ids || "null" == ids){
    alert("请先保存后再预览合同！");
    return ;
   }
      url= "<%=request.getContextPath()%>/jsp/faerp/reportJsp/showzhaopingReport.jsp?reportFileName=" +
    reportFileName + 
    "&contract_id=" +ids;
       window.open(url,'','height=425px,width=1140px,top =100,left=180,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=供应商增加');
   }
        function checkNum(num){
       var pattern =/^[1-9]{1,}[0-9]{0,}$/;
        if(!pattern.exec(num)){
          return false;
        }
        return true;
    } 
   function checkNum1(num){
 
        var pattern =/^[0-9]{1,}\.?[0-9]{0,}$/;
        if(!pattern.exec(num)){
          return false;
        }
        return true;
   }


    function setTab03Syn ( i )
    {
        selectTab03Syn(i);
    }
    
    function selectTab03Syn ( i )
    {
       var str=<%=create_type_bd%>;    
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
        if(str=="1")
        {
        document.getElementById('bg').className='xixi2';
                document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            onLoadTree();
        }else{
             document.getElementById('bg').className='xixi1';
           document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
        
        }
            break;
        }
    }

/***************招聘模块使用************************/
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
    
        var pageobj="/jsp/faerp/sales/salcontract/treeContract.jsp?flag=insert";//新增页面，用户修改
        TreeAjax.getInclude(pageobj,function(data) {
            dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
            });
              divExtend('treeNodeMessageDiv',"");
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
        var newNodeName=dwr.util.getValue("contract_template_item_name");//form_treeNode.contract_template_item_name.value.trim();
        var contract_template_item_content=dwr.util.getValue("contract_template_item_content");//form_treeNode.contract_template_item_content.value.trim();
        var english_name=dwr.util.getValue("english_name");//form_treeNode.english_name.value.trim();
        var english_content=dwr.util.getValue("english_content");//form_treeNode.english_content.value.trim();
         var serial_no=dwr.util.getValue("serial_no");//form_treeNode.serial_no.value.trim();
        var is_can_modify="0";
        
        if(newNodeName==""||newNodeName.length==0){
           alert("名称不能为空！");
           return ;
        }
              if(contract_template_item_content==""||contract_template_item_content.length==0){
                      alert("名称内容不能为空！");
                      return ;
          }
      
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
         setTab03Syn(2);
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
    
//修改
 function includeEditPage1(){
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
          var pageobj="/jsp/faerp/sales/salcontract/treeContract.jsp?flag=update";//新增页面，用户修改
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
            var nodeName=document.getElementsByName("contract_template_item_name")[0].value;//form_treeNode.contract_template_item_name.value.trim();
            var contract_template_item_content=document.getElementsByName("contract_template_item_content")[0].value;//form_treeNode.contract_template_item_content.value.trim();
            var english_name=document.getElementsByName("english_name")[0].value;//form_treeNode.english_name.value.trim();
            var english_content=document.getElementsByName("english_content")[0].value;//form_treeNode.english_content.value.trim();
            var is_can_modify="0";
           var serial_no=document.getElementsByName("serial_no")[0].value;//form_treeNode.serial_no.value.trim();
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
                    setTab03Syn(2);
                        //隐藏用户页面
              //      onLoadTree();
                });                
            }
        }
    }
/**************************end************************/




</script>
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
<script>
String.prototype.trim   =   function()
{
         //   用正则表达式将前后空格
         //   用空字符串替代。
         return   this.replace(/(^\s*)|(\s*$)/g,   "");
}
    
    //用户调用的beanID
    var beanId="IContracttemitemBs";//以数据库为数据源的树
    //新增根节点和新增节点时，记住根节点信息或者父节点信息
    
    <%  
    if(null!=ids&&!ids.equals("")){%>
        beanId="ISalcontractitemBs";
    <%
    }
    %>
    
    
    var nowData;

    //显示当前节点的信息
    function displayNode(nodeId,divid){
        divExtend('treeNodeMessageDiv',"block");
        //载入修改页面
        includeEditPage(nodeId,divid);
    }
    function includeEditPage(nodeId,divid){
          var pageobj="/jsp/faerp/sales/salcontract/treeContract.jsp?flag=detail";//浏览页面
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
    initTree('root','tree',paramsMap);
}



function onLoadTree(){//用户自定义初始化树
    //获取用户的过滤条件
     var paramsMap={};
    //   var locations=document.getElementById("contract_template_id1").value;
    var locations =  "<%=contract_template_id%>";
   var ids=document.getElementById("ids").value;
     if(null!=ids&&ids!=""&&ids!="null"){
        locations=ids;
   }
       if(locations!=""){
        //用户自定义的过滤条件
        paramsMap["ids"]=locations;
     }
    initTree('root','tree',paramsMap);
    
    //判断功能按钮是否显示
    if("zp"==_$("#f").val() && "" != _$("#ids").val() && null != _$("#ids").val() && "null" != _$("#ids").val()){
        _$("#treeOtherDiv").show();
    }else{
        _$("#treeOtherDiv").hide();
    }
}

</script>
<html>
<fmt:bundle basename="rayoo.salse.salcontract.salcontract_resource" prefix="rayoo.salse.salcontract.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>
<script language="javascript">
    function cancel_onClick(){  //取消后返回列表页面
        //form_treebasic.action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=queryAll";
        //form_treebasic.submit();
        window.close();
    }
        //打开文件上传对话框
    function UploadFileWindow(){
        //w为窗口宽度，h为高度
        var w = 400;
        var h = 150;
        var l = (screen.width - w) / 2; 
        var t = (screen.height - h) / 2; 
        var s = 'width=' + w + ', height=' + h + ', top=' + t + ', left=' + l; 
        s += ', toolbar=no,scrollbars=no,menubar=no,location=no,resizable=no,scrollbars=no,resizable=no,location=no,status=no'; 
        window.open('<%=request.getContextPath() %>/jsp/faerp/common/system/attachUploadFrame.jsp','newwindow', s);
    }
    
        
    function getSupplierList(){
     var ids = window.showModalDialog('<venus:base/>/CustomersimpleAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:480px;dialogWidth:800px;center:yes;help:no;resizable:no;scroll:no;status:no;');       
         if(ids==undefined)return;
    document.form_treebasic.cust_a_id.value=ids[0];
    document.form_treebasic.cust_a_name.value=ids[2];
     document.form_treebasic.customer_code.value=ids[1];
    }
   function getSupplierList1(){
     var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    if(ids==undefined)return;
    document.form_treebasic.agent_b_id.value=ids[0];
    document.form_treebasic.agent_b_name.value=ids[1];
    }

    
</script>
</head>
<body >
<div id="right">
    <div class="tab">
<form name="form_treebasic" id="form_treebasic" method="post"  >
<div id="bg" class="xixi1">
    <div id="font1" class="tab1" onmousedown="setTab03Syn(1);document.getElementById('bg').className='xixi1'"><fmt:message key="contract_basic_info"/></div>
    <div id="font2" class="tab2" onmousedown="setTab03Syn(2);"><fmt:message key="recode_info"/></div>
 </div>
 <div id="TabCon1">
 <div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
  <input type="hidden" id="zbid" name="zbid" value="${bean.id }">
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_type"/></td>
            <td class="td_2"  nowrap="nowrap">
             <input type="hidden" class="text_field" name="contract_type_bd"  id  =  "contract_type_bd"   value="<%=contract_type_bd %>" >
                   <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contract_type_bd", -1,"CONTRACT_TYPE_BD",contract_type_bd," id=contract_type_bd  disabled='disabled'  ",false) %> 
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_name"/></td>
            <td class="td_2 " nowrap="nowrap">  
                    
                
        <%  if(null!=detail&&!"detail".equals(detail)) {%>
               <input type="text" class="text_field"  id="contract_name"  name="contract_name" inputName="合同名称" value="<% if(null!=contract_name&&!"".equals(contract_name))   out.print(contract_name);   %>" maxLength="50" validate="notNull;"/>
        
                <%}else{ %>
              <input type="text" class="text_field"  id="contract_name"  name="contract_name" inputName="合同名称" value="<% if(null!=contract_name&&!"".equals(contract_name))   out.print(contract_name);   %>" maxLength="50" validate="notNull;"   readonly="readonly"/>
        
                <%} %>
        
        
        
            </td>
        </tr>
    
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_jiafang"/></td>
            <td class="td_2 " nowrap="nowrap">
               <%  if(null!=detail&&!"detail".equals(detail)) {%>
               
                <w:lookup onReturnFunc="rtnFunc"  lookupWidth="189px" readonly="true" displayValue="<%=customer_name %>" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1&f=${param.f}" messagekey="choose_contract_jiafang" height="440" width="710"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name" value="<%=customer_name %>"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id" value="${bean.cust_a_id }"/>
                <input type="hidden" name="customer_code" id="customer_code" <%=customer_code %>/>
              
                <%}else{ %>
                <w:lookup onReturnFunc="rtnFunc"  displayValue="<%=customer_name %>" lookupWidth="189px"  readOnly="true" readonly="false" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" messagekey="choose_contract_jiafang" height="440" width="710" />
                <input type="hidden" name="cust_a_name" id="cust_a_name" value="<%=customer_name %>"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id" value="${bean.cust_a_id }"/>
                <input type="hidden" name="customer_code" id="customer_code" <%=customer_code %>/>
                <%} %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_yifang"/></td>
            <td class="td_2 " nowrap="nowrap">                
               <%  if(null!=detail&&!"detail".equals(detail)) {%>
                <w:lookup onReturnFunc="rtnFunc1" lookupWidth="189px" displayValue="<%=agent_b_name %>" readonly="true" id="lk_cust1" lookupUrl="/AgentAction.do?cmd=getAllagentByCondition" messagekey="choose_contract_yifang" height="430" width="680"/>
                <input type="hidden" name="agent_b_id" id="agent_b_id" value="<%=agent_b_id %>" />
                <input type="hidden" name="agent_b_name" id="agent_b_name" value="<%=agent_b_name %>"/>
                <%}else{ %>
                <w:lookup onReturnFunc="rtnFunc1" displayValue="<%=agent_b_name %>" lookupWidth="189px"  readOnly="true" id="lk_cust1" lookupUrl="/AgentAction.do?cmd=getAllagentByCondition" messagekey="choose_contract_yifang" height="430" width="680"/>
                <input type="hidden" name="agent_b_id" id="agent_b_id" value="<%=agent_b_id %>"/>
                <input type="hidden" name="agent_b_name" id="agent_b_name"  value="<%=agent_b_name %>"/>
                <%} %>
            </td>
        </tr>
        
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_start_date"/></td>
            <td class="td_2" nowrap="nowrap">
            <%  if(null!=detail&&!"detail".equals(detail)) {%>
                 <w:date format="yyyy-MM-dd" id="contract_start_date" name="contract_start_date" property="bean/contract_start_date" width="189px"/>
                 <%}else{ %>
                 <w:date format="yyyy-MM-dd" id="contract_start_date" name="contract_start_date" property="bean/contract_start_date" readOnly="true" width="189px"/>
                 <%} %>
            </td>
           <td class="td_1" ><%if(contract_type_bd!=null&&!contract_type_bd.trim().equals("1")){%><span class="style_required_red">* </span><%} %><fmt:message key="contract_stop_date"/></td>
            <td class="td_2"  nowrap="nowrap">
                <%  if(null!=detail&&!"detail".equals(detail)) {%>
                <w:date format="yyyy-MM-dd" id="contract_stop_date" name="contract_stop_date" property="bean/contract_stop_date" width="189px"/>
                <%}else{ %>
                <w:date format="yyyy-MM-dd" id="contract_stop_date" name="contract_stop_date" property="bean/contract_stop_date" width="189px" readOnly="true"/>
                <%} %>
            </td>
        </tr>
                <input type="hidden" class="text_field"   id="create_type_bd"  name="create_type_bd" inputName="合同生成方式" value="<%= create_type_bd%>" maxLength="64" validate="notNull;"/>
    
        <tr>
        <% 
          if("1".equals(create_type_bd)){
           %>
              <td class="td_1" ><fmt:message key="contract_template"/></td>
            <td class="td_2 "    >
            <% 
            request.setAttribute("contract_template_id",contract_template_id);
            %>
                <input type="hidden"  id="contract_template_id"  class="text_field" name="contract_template_id"  value="<%=contract_template_id %>" >
                 <faerp:contractTemplateSelectTag  beanname="contract_template_id"   strproperty=" disabled='disabled'  "  style="width:205px"/>
            </td>
             <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="service_company"/></td>
            <% if(null!=detail&&!"detail".equals(detail)){%>
               <td class="td_2"  ><d:select dictTypeId="SERVICE_COMPANY"   name="service_company" id="service_company" nullLabel="请选择" value="${bean.service_company}" /></td>
                 <%   }else{%> 
                  <td class="td_2"  ><d:select dictTypeId="SERVICE_COMPANY"   name="service_company" id="service_company" nullLabel="请选择" value="${bean.service_company}" disabled="true"/></td>
           <% 
               }
            }else{
        %>
                 <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_attachments"/></td>
            <td class="td_2 "    >
   <!--            <input type="text" class="text_field" name="contract_attachment_id" inputName="合同附件ID" value="" maxLength="9.5" />  --> 
                 <%  if(null!=detail&&!"detail".equals(detail)) {%>
                   <input type="text"   id="attachNameInput" class="text_field_reference_readonly" name="attach_name" inputName="附件地址" value="${AttachmentfileVo. attachment_file_name}" hiddenInputId="attach_name"  /><img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"  />
                  <input type="hidden" id="attackAddressInput" name="attach_address" value="${AttachmentfileVo.attachment_file_path }">
                  </td>
             <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="service_company"/></td>
               <td class="td_2"  ><d:select dictTypeId="SERVICE_COMPANY"   name="service_company" id="service_company" nullLabel="请选择" value="${bean.service_company}"/></td>
                <%  } else   {%>
                
               <% if(isModify&&avo!=null)out.print("<a href='"+request.getContextPath()+"/ProductAction.do?cmd=downLoad&attachment_id="+avo.getId()+"'><font color=blue>"+avo.getAttachment_file_name()+"</font></a>");
               {%>
            </td>
             <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="service_company"/></td>
               <td class="td_2"  ><d:select dictTypeId="SERVICE_COMPANY"  disabled="true" name="service_company" id="service_company" nullLabel="请选择" value="${bean.service_company}" /></td>
        <%}%>
         <%}%>
         <%}%>
        </tr>
         <tr>
              <td class="td_1" ><span class="style_required_red">* </span>服务费收费比例</td>
               <td class="td_2">
              <%  if(null!=detail&&!"detail".equals(detail)) {%>
               <input type="text" class="text_field"  id="servicefeeratio"  name="servicefeeratio" inputName="服务费收费比例" value="${bean.servicefeeratio }" maxLength="50" validate="notNull;"/>
                   <%}else{ %>
                <input type="text" class="text_field"  id="servicefeeratio"  name="servicefeeratio" inputName="服务费收费比例" value="${bean.servicefeeratio }" maxLength="50" validate="notNull;" readonly="readonly"/>   
                     <%} %>
               </td>
           
                <td class="td_1" ><span class="style_required_red">* </span>最低收费</td>
                  
               <td class="td_2">
                   <%  if(null!=detail&&!"detail".equals(detail)) {%>
               <input type="text" class="text_field"  id="lowestcharge"  name="lowestcharge" inputName="最低收费" value="${bean.lowestcharge }" maxLength="50" validate="notNull;"/>
                   <%}else{ %>
                   <input type="text" class="text_field"  id="lowestcharge"  name="lowestcharge" inputName="最低收费" value="${bean.lowestcharge }" maxLength="50" validate="notNull;" readonly="readonly"/>
                     <%} %>
               </td>
                    
          </tr>
             <tr>
                <td class="td_1" ><span class="style_required_red">* </span>担保期限</td>
            
               <td class="td_2">
                   <%  if(null!=detail&&!"detail".equals(detail)) {%>
               <input type="text" class="text_field"  id="warrantyperiod"  name="warrantyperiod" inputName="担保期限" value="${bean.warrantyperiod }" maxLength="50" />
                   <%}else{ %>
                    <input type="text" class="text_field"  id="warrantyperiod"  name="warrantyperiod" inputName="担保期限" value="${bean.warrantyperiod }" maxLength="50"  readonly="readonly"/>
                     <%} %>
               </td>
               
                <td class="td_1" ><span class="style_required_red">* </span>首期服务费</td>
              
               <td class="td_2">
                   <%  if(null!=detail&&!"detail".equals(detail)) {%>
               <input type="text" class="text_field"  id="initialcharge"  name="initialcharge" inputName="首期服务费" value="${bean.initialcharge }" maxLength="50" validate="notNull;"/>
                   <%}else{ %>
                   <input type="text" class="text_field"  id="initialcharge"  name="initialcharge" inputName="首期服务费" value="${bean.initialcharge }" maxLength="50" validate="notNull;" readonly="readonly"/>
                     <%} %>
               </td>
              
          </tr>
    </table>
     
   
    <div class="foot_button">
    
     <%  if(null!=detail&&!"detail".equals(detail)) {%>
          <input type="button" class="icon_4"  id="btesave" value='<fmt:message key="save_submit_examine"/>' onClick="javascript:<%=isModify?"update_onClick('yes_nogapwf')":"insert_onClick('yes_nogapwf')"%>" />
          <input type="button" class="icon_2" id="btnsave" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick('no_gapwf')":"insert_onClick('no_gapwf')"%>" />  
       <%} %>
           <% 
          if("1".equals(create_type_bd)){
           %>
          <input type="button" class="icon_2" id="btnview" value='预览'  onClick="javascript:yulan_onClick()"/>
         
         <%}%>
         <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
        </div>
</div>     
</div>
 <!--表格1 end-->
</div>    





<div id="TabCon2" style="display:none;">
            
<input type="hidden" name="create_date" />

<input id="ids" name="ids" type="hidden" class="text_field" inputName="节点id" value="<%  out.print(ids); %>"   readonly="true">
<input id="detail" name="detail" type="hidden" value="<%=detail %>" />
<input id="f" name="f" type="hidden" value="<%=f %>" />

<input id="contract_template_id1" name="contract_template_id1" type="hidden" class="text_field" inputName="节点id" value="<%  out.print(contract_template_id); %>"   readonly="true">

<input id="divid" name="divid" type="hidden" class="text_field" inputName="节点层id" value="" readonly="true">
<input id="rootFlag" name="rootFlag" type="hidden" class="text_field" inputName="是否有根节点" value="" readonly="true">
<input id="id" name="id" type="hidden" class="text_field" inputName="节点id" value="" readonly="true">    
<input id="parentId" name="parentId" type="hidden" class="text_field" inputName="父节点id" value="" readonly="true">
<input id="webModel" name="webModel" type="hidden" class="text_field" inputName="发布目录" value="<%=request.getContextPath()%>" readonly="true">


<%if("zp".equals(f) && ("modify".equals(detail) ) ) {%>
<div id="treeOtherDiv"  style="display:none"   style="height:25px; "> 
          <table align="right">
              <tr> 
                      <td id="addButtonTd" >
                        <input type="button" id="addButton"   class="icon_3" value='<fmt:message key="add_sub_clause"/>' onClick="javascript:includeAddPage();"   />
                      </td>
                        <td id="modifyButtonTd">
                        <input type="button" id="modifyButton" class="icon_2" value='<fmt:message key="modify"/>' onClick="javascript:includeEditPage1();"  />
                        </td>
                      <td id="deleteButtonTd">
                        <input type="button" id="deleteButton" class="icon_2" value='<fmt:message key="delete"/>' onClick="javascript:deleteNode();"  />
                      </td>
                           <td>
                            <div id="treeNodeDiv"   style="display:none"> 
                                  <input  type="button" id="updateNodes" class="icon_2"   value='<fmt:message  key="save"/>' onClick="javascript:updateNode();" />      
                              </div>
                              
                           <div id="newTreeNodeDiv"  style="display:none">
                                                           <input type="button" name="addNodes" class="icon_2"    value="<fmt:message   key="save"/>" onClick="javascript:addNode();">      
                                                       </div>
                    </td>
              </tr>
          </table>
    </div>
    <%}%>

            <!--表格2-->
<div class="ringht_x">
<div id="ccChild1"     class="box_xinzeng"> 
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
</div>
</div>







</form>
    

    





<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</div>
</div>
</body>
</fmt:bundle>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
    if(isModify) {  //如果本页面是修改页面
    //  out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
%>


        //选择合同甲方
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    jQuery("#cust_a_id").val(arg[0]);       
    jQuery("#cust_a_name").val(arg[2]);     
    jQuery("#customer_code").val(arg[1]);   
    return false;
}
        //选择合同乙方
function rtnFunc1(arg){
    var lookup = $id("lk_cust1");
    lookup.value = arg[0];
    lookup.displayValue = arg[1];
    jQuery("#agent_b_id").val(arg[0]);    
    jQuery("#agent_b_name").val(arg[1]);    
    return false;
}

</script>



