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

//add by sqp2013年11月14日 14:09:41
String isQA= request.getParameter("isQA")==null?"false":request.getParameter("isQA").toString();


System.out.println("ids:"+ids);
String detail=(String)request.getAttribute("detail");
if(null==detail){
    detail=(String)request.getParameter("detail");
}

System.out.println("detail:"+detail);

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
<script type="text/javascript">

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
                      <%if(!"zp".equals(f)){%>
                      window.close();
                      window.opener.showListData();//回调父页面函数
                      <%}else{%>
                      var oid = myAjax.getProperty("returnMessage");
                      document.getElementById("ids").value=oid;
                      beanId = "ISalcontractitemBs";
                      _$("#btnsave").hide();
                      <%}%>
                 }
        }
    }


    function update_onClick(id){  //保存修改后的单条数据
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
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
            if(checkAllForms()){
                 var action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=update";
                 var myAjax = new Ajax(action);
                 myAjax.addParam('contract_name', document.form_treebasic.contract_name.value);
                 myAjax.addParam('contract_start_date', document.form_treebasic.contract_start_date.value);
                 myAjax.addParam('contract_stop_date', document.form_treebasic.contract_stop_date.value);
                myAjax.addParam('create_type_bd', document.form_treebasic.create_type_bd.value);
                if(document.form_treebasic.create_type_bd.value=='1' || document.form_treebasic.create_type_bd.value==1){
                 }else{
                    myAjax.addParam('attach_name', document.form_treebasic.attach_name.value);
                    myAjax.addParam('attach_address', document.form_treebasic.attach_address.value);
                 }
                  //服务单位
                 myAjax.addParam('service_company', document.form_treebasic.service_company.value);
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
                      window.close();
                      window.opener.showListData();//回调父页面函数
                 }
        }
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

//add by sqp QA建合同保存方法,不走分配经办人流程，存储对应经办人各个环节的人员权限  2013年11月15日 11:09:22
function insertByQA_onClick(){
        //获取页面的数据内容从上边保存方法中获取，添加合同类别的变量(北京委托，上海自主),后台调用保存方法不同
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
        var receipt_title;
        //判断选择的甲方是不是新户
        jQuery.ajax({
             type : "post",
             url : "<%=request.getContextPath()%>/SalcontractAction.do?cmd=isNewCust&cust_id=" + document.getElementById("cust_a_id").value,
             dataType : "html",
             success : function(data) {
                         if(data==0){
                            //新户一定要输入发票抬头
                            receipt_title = document.getElementById("receipt_title").value;
					        if(receipt_title==null || receipt_title==""){
					            alert("新户必须输入成本中心发票抬头！");
					            return false;
					        }else{
						       var pattern = new RegExp("^[A-Z0-9a-z\u4e00-\u9fa5()（）.\\-— ——&•·,']+$");
                               if(pattern.test(receipt_title) == false){
	                                 alert("成本中心发票抬头不能包含特殊字符！");
	                                 return false;
                               }
                               else{
                                    //通过字符验证则保存
                            	   if(jQuery("#taxpayer_identity_type").val()=='1'){
                                       if(document.getElementById('taxpayer_identification_number').value==""){
        	                                 //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin 
                                    	     alert("纳税人识别号不能为空！");
                                    	     //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
        	                                 return false;
                                       }
                                     //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                                	   else{
                                    	   var reg =/^[0-9a-zA-Z]*$/g;     
                                           var taxpayer_identification_number = document.getElementById('taxpayer_identification_number').value;
                                           var result="";
                                 		    for (i=0 ; i<taxpayer_identification_number.length; i++)
                                 		   {
                                 		    code = taxpayer_identification_number.charCodeAt(i);             
                                 		    //获取当前字符的unicode编码
                                 		    if (code >= 65281 && code <= 65373)   
                                 		    //unicode编码范围是所有的英文字母以及各种字符
                                 		    {
                                 		    result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 65248);    
                                 		    //把全角字符的unicode编码转换为对应半角字符的unicode码
                                 		    }
                                 		    else if (code == 12288)                                      
                                 		    //空格
                                 		    {
                                 		    	if(String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32)==" "){
                                 		    		 result +="";
                                 		    	}else{
                                 		           result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32);
                                 		    	}
                                 		    //半角空格
                                 		    }else
                                 		    {
                                 		     if(taxpayer_identification_number.charAt(i)==" "){
                                 		    	result +="";
                                 		     }else{
                                 		    	result +=taxpayer_identification_number.charAt(i);
                                 		     }	
                                 			 
                                 		     //原字符返回
                                 		    }
                                 		    }
                                 		   taxpayer_identification_number=result;
                                		   document.getElementById('taxpayer_identification_number').value=taxpayer_identification_number;
                                           var str=taxpayer_identification_number.match(reg);
                                    	   if(str==null){
                                    		   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
                                    		   return false;
                                    	   }else{
                                    		   if(taxpayer_identification_number.length!=15&&taxpayer_identification_number.length!=17&&taxpayer_identification_number.length!=18&&taxpayer_identification_number.length!=20){
                                    			   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
        	                                 return false;
                                       }
                                    	   }
                                       }
                                	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                                       if(document.getElementById('tax_registration_address').value==""){
        	                                 alert("税务登记地址不能为空！");
        	                                 return false;
                                     } //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                                  	   else{
                                 		    var tax_registration_address=document.getElementById('tax_registration_address').value;
                                 		    var result="";
                                 		    for (i=0 ; i<tax_registration_address.length; i++)
                                 		   {
                                 		    code = tax_registration_address.charCodeAt(i);             
                                 		    //获取当前字符的unicode编码
                                 		    if (code >= 65281 && code <= 65373)   
                                 		    //unicode编码范围是所有的英文字母以及各种字符
                                 		    {
                                 		    result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 65248);    
                                 		    //把全角字符的unicode编码转换为对应半角字符的unicode码
                                     }
                                 		    else if (code == 12288)                                      
                                 		    //空格
                                 		    {
                                 		    	if(String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32)==" "){
                               		    		result += "";
                               		    	}else{
                               		    		result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32);
                               		    	}
                                 		    //半角空格
                                 		    }else
                                 		    {
                                 		     if(tax_registration_address.charAt(i)==" "){
                                 		    	result +="";
                                 		     }else{
                                 		    	result +=tax_registration_address.charAt(i);
                                 		     }	
                                 			 
                                 		     //原字符返回
                                 		    }
                                 		    }
                                 		    tax_registration_address=result;
                                 			document.getElementById('tax_registration_address').value=tax_registration_address;
                                        }
                                 	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                                       if(document.getElementById('tax_registration_telnum').value==""){
        	                                 alert("税务登记电话号码不能为空！");
        	                                 return false;
                                     }
                                       //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                                 	   else{
                                           var tax_registration_telnum = document.getElementById('tax_registration_telnum').value;
                                           var result="";
                                 		    for (i=0 ; i<tax_registration_telnum.length; i++)
                                 		   {
                                 		    code = tax_registration_telnum.charCodeAt(i);             
                                 		    //获取当前字符的unicode编码
                                 		    if (code >= 65281 && code <= 65373)   
                                 		    //unicode编码范围是所有的英文字母以及各种字符
                                 		    {
                                 		    result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 65248);    
                                 		    //把全角字符的unicode编码转换为对应半角字符的unicode码
                                 		    }
                                 		    else if (code == 12288)                                      
                                 		    //空格
                                 		    {
                                 		    	if( String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32)==" "){
                                		    		result += "";
                                		    	}else{
                                		    		result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32);
                                		    	}
                                 		    //半角空格
                                 		    }else
                                 		    {
                                 		     if(tax_registration_telnum.charAt(i)==" "){
                                 		    	result +="";
                                 		     }else{
                                 		    	result +=tax_registration_telnum.charAt(i);
                                 		     }	
                                 			 
                                 		     //原字符返回
                                 		    }
                                 		    }
                                 		   tax_registration_telnum=result;
                                 		   var reg =  /^\d[\d\-]*$/;
                                	       if(!reg.test(tax_registration_telnum)){
                                	       alert("纳税人电话格式错误！");	   
                                 	       return;
                                 	      }
                                 		   document.getElementById('tax_registration_telnum').value=tax_registration_telnum;
                                        }
                                 	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                                       if(document.getElementById('tax_registration_bank').value==""){
        	                                 alert("税务登记开户银行不能为空！");
        	                                 return false;
                                     }
                                       //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                                   	   else{
                              		     var tax_registration_bank=document.getElementById('tax_registration_bank').value;
                              		   var result="";
                            		    for (i=0 ; i<tax_registration_bank.length; i++)
                            		   {
                            		    code = tax_registration_bank.charCodeAt(i);             
                            		    //获取当前字符的unicode编码
                            		    if (code >= 65281 && code <= 65373)   
                            		    //unicode编码范围是所有的英文字母以及各种字符
                            		    {
                            		    result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 65248);    
                            		    //把全角字符的unicode编码转换为对应半角字符的unicode码
                            		    }
                            		    else if (code == 12288)                                      
                            		    //空格
                            		    {
                            		    	
                            		    	if(String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32)==" "){
                            		    		result += "";
                            		    	}else{
                            		    		result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32);
                            		    	}
                            		   
                            		    //半角空格
                            		    }else
                            		    {
                            		     if(tax_registration_bank.charAt(i)==" "){
                            		    	result +="";
                            		     }
                            		    else{
                            		    	result +=tax_registration_bank.charAt(i);
                            		     }	
                            			 
                            		     //原字符返回
                            		    }
                            		    }
                            		    tax_registration_bank=result;
                            		    var reg = new RegExp("^[0-9]*$");
                           		        if(reg.test(tax_registration_bank)){
                           			      alert("纳税人开户行不能由纯数字组成！");
                           			      return;
                           		        }
                            			document.getElementById('tax_registration_bank').value=tax_registration_bank;
                                          }
                                   	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                                       if(document.getElementById('tax_registration_bank_account').value==""){
        	                                 alert("税务登记银行账号不能为空！");
        	                                 return false;
                                      }
                                       //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                                 	   else{
                                 		   var reg = new RegExp("^[0-9]*$");  
                                           var tax_registration_bank_account = document.getElementById('tax_registration_bank_account').value;
                                           var result="";
                               		    for (i=0 ; i<tax_registration_bank_account.length; i++)
                               		   {
                               		    code = tax_registration_bank_account.charCodeAt(i);             
                               		    //获取当前字符的unicode编码
                               		    if (code >= 65281 && code <= 65373)   
                               		    //unicode编码范围是所有的英文字母以及各种字符
                               		    {
                               		     result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 65248);
                               		    //把全角字符的unicode编码转换为对应半角字符的unicode码
                               		    }
                               		    else if (code == 12288)                                      
                               		    //空格
                               		    {
                               		    	if(String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32)==" "){
                               		    		result +="";
                               		    	}else{
                               		    		result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32);
                               		    	}
                               		    //半角空格
                               		    }else
                               		    {
                               		     if(tax_registration_bank_account.charAt(i)==" "){
                               		    	result +="";
                               		     }else{
                               		    	result +=tax_registration_bank_account.charAt(i);
                               		     }	
                               			 
                               		     //原字符返回
                               		    }
                               		    }
                               		       tax_registration_bank_account=result;
                               			   document.getElementById('tax_registration_bank_account').value=tax_registration_bank_account;
                                    	   if(!reg.test(tax_registration_bank_account)){
                                    		   alert("纳税人银行账号只能由数字组成！");
                                    		   return false;
                                    	   }
                                        }
                                 	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                            	   }
                            	 //2016-07-14  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                            	   else{
                            		   if(document.getElementById('taxpayer_identification_number').value==""){
                                     }
                                   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                              	   else{
                                  	   var reg =/^[0-9a-zA-Z]*$/g;     
                                         var taxpayer_identification_number = document.getElementById('taxpayer_identification_number').value;
                                         var result="";
                               		    for (i=0 ; i<taxpayer_identification_number.length; i++)
                               		   {
                               		    code = taxpayer_identification_number.charCodeAt(i);             
                               		    //获取当前字符的unicode编码
                               		    if (code >= 65281 && code <= 65373)   
                               		    //unicode编码范围是所有的英文字母以及各种字符
                               		    {
                               		    result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 65248);    
                               		    //把全角字符的unicode编码转换为对应半角字符的unicode码
                               		    }
                               		    else if (code == 12288)                                      
                               		    //空格
                               		    {
                               		    	if(String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32)==" "){
                               		    		 result +="";
                               		    	}else{
                               		           result += String.fromCharCode(taxpayer_identification_number.charCodeAt(i) - 12288 + 32);
                               		    	}
                               		    //半角空格
                               		    }else
                               		    {
                               		     if(taxpayer_identification_number.charAt(i)==" "){
                               		    	result +="";
                               		     }else{
                               		    	result +=taxpayer_identification_number.charAt(i);
                               		     }	
                               			 
                               		     //原字符返回
                               		    }
                               		    }
                               		   taxpayer_identification_number=result;
                              		   document.getElementById('taxpayer_identification_number').value=taxpayer_identification_number;
                                         var str=taxpayer_identification_number.match(reg);
                                  	   if(str==null){
                                  		   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
                                  		   return false;
                                  	   }else{
                                  		   if(taxpayer_identification_number.length!=15&&taxpayer_identification_number.length!=17&&taxpayer_identification_number.length!=18&&taxpayer_identification_number.length!=20){
                                  			   alert("纳税人识别号只能是数字和字母组成，且长度要求是15位、17位、18位或20位！");
      	                                 return false;
                                     }
                                  	   }
                                     }
                              	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                                     if(document.getElementById('tax_registration_address').value==""){
                                   } //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                                	   else{
                               		    var tax_registration_address=document.getElementById('tax_registration_address').value;
                               		    var result="";
                               		    for (i=0 ; i<tax_registration_address.length; i++)
                               		   {
                               		    code = tax_registration_address.charCodeAt(i);             
                               		    //获取当前字符的unicode编码
                               		    if (code >= 65281 && code <= 65373)   
                               		    //unicode编码范围是所有的英文字母以及各种字符
                               		    {
                               		    result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 65248);    
                               		    //把全角字符的unicode编码转换为对应半角字符的unicode码
                                   }
                               		    else if (code == 12288)                                      
                               		    //空格
                               		    {
                               		    	if(String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32)==" "){
                             		    		result += "";
                             		    	}else{
                             		    		result += String.fromCharCode(tax_registration_address.charCodeAt(i) - 12288 + 32);
                             		    	}
                               		    //半角空格
                               		    }else
                               		    {
                               		     if(tax_registration_address.charAt(i)==" "){
                               		    	result +="";
                               		     }else{
                               		    	result +=tax_registration_address.charAt(i);
                               		     }	
                               			 
                               		     //原字符返回
                               		    }
                               		    }
                               		    tax_registration_address=result;
                               			document.getElementById('tax_registration_address').value=tax_registration_address;
                                      }
                               	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                                     if(document.getElementById('tax_registration_telnum').value==""){
                                   }
                                     //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                               	   else{
                                         var tax_registration_telnum = document.getElementById('tax_registration_telnum').value;
                                         var result="";
                               		    for (i=0 ; i<tax_registration_telnum.length; i++)
                               		   {
                               		    code = tax_registration_telnum.charCodeAt(i);             
                               		    //获取当前字符的unicode编码
                               		    if (code >= 65281 && code <= 65373)   
                               		    //unicode编码范围是所有的英文字母以及各种字符
                               		    {
                               		    result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 65248);    
                               		    //把全角字符的unicode编码转换为对应半角字符的unicode码
                               		    }
                               		    else if (code == 12288)                                      
                               		    //空格
                               		    {
                               		    	if( String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32)==" "){
                              		    		result += "";
                              		    	}else{
                              		    		result += String.fromCharCode(tax_registration_telnum.charCodeAt(i) - 12288 + 32);
                              		    	}
                               		    //半角空格
                               		    }else
                               		    {
                               		     if(tax_registration_telnum.charAt(i)==" "){
                               		    	result +="";
                               		     }else{
                               		    	result +=tax_registration_telnum.charAt(i);
                               		     }	
                               			 
                               		     //原字符返回
                               		    }
                               		    }
                               		   tax_registration_telnum=result;
                               		   var reg = /^\d[\d\-]*$/;
                              	       if(!reg.test(tax_registration_telnum)){
                              	       alert("纳税人电话格式错误！");	   
                               	       return;
                               	      }
                               		   document.getElementById('tax_registration_telnum').value=tax_registration_telnum;
                                      }
                               	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                                     if(document.getElementById('tax_registration_bank').value==""){
                                   }
                                     //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                                 	   else{
                            		     var tax_registration_bank=document.getElementById('tax_registration_bank').value;
                            		   var result="";
                          		    for (i=0 ; i<tax_registration_bank.length; i++)
                          		   {
                          		    code = tax_registration_bank.charCodeAt(i);             
                          		    //获取当前字符的unicode编码
                          		    if (code >= 65281 && code <= 65373)   
                          		    //unicode编码范围是所有的英文字母以及各种字符
                          		    {
                          		    result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 65248);    
                          		    //把全角字符的unicode编码转换为对应半角字符的unicode码
                          		    }
                          		    else if (code == 12288)                                      
                          		    //空格
                          		    {
                          		    	
                          		    	if(String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32)==" "){
                          		    		result += "";
                          		    	}else{
                          		    		result += String.fromCharCode(tax_registration_bank.charCodeAt(i) - 12288 + 32);
                          		    	}
                          		   
                          		    //半角空格
                          		    }else
                          		    {
                          		     if(tax_registration_bank.charAt(i)==" "){
                          		    	result +="";
                          		     }
                          		    else{
                          		    	result +=tax_registration_bank.charAt(i);
                          		     }	
                          			 
                          		     //原字符返回
                          		    }
                          		    }
                          		    tax_registration_bank=result;
                          		    var reg = new RegExp("^[0-9]*$");
                     		        if(reg.test(tax_registration_bank)){
                     			      alert("纳税人开户行不能由纯数字组成！");
                     			      return;
                     		        }
                          			document.getElementById('tax_registration_bank').value=tax_registration_bank;
                                        }
                                 	   //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
                                     if(document.getElementById('tax_registration_bank_account').value==""){
                                    }
                                     //2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin
                               	   else{
                               		   var reg = new RegExp("^[0-9]*$");  
                                         var tax_registration_bank_account = document.getElementById('tax_registration_bank_account').value;
                                         var result="";
                             		    for (i=0 ; i<tax_registration_bank_account.length; i++)
                             		   {
                             		    code = tax_registration_bank_account.charCodeAt(i);             
                             		    //获取当前字符的unicode编码
                             		    if (code >= 65281 && code <= 65373)   
                             		    //unicode编码范围是所有的英文字母以及各种字符
                             		    {
                             		     result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 65248);
                             		    //把全角字符的unicode编码转换为对应半角字符的unicode码
                             		    }
                             		    else if (code == 12288)                                      
                             		    //空格
                             		    {
                             		    	if(String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32)==" "){
                             		    		result +="";
                             		    	}else{
                             		    		result += String.fromCharCode(tax_registration_bank_account.charCodeAt(i) - 12288 + 32);
                             		    	}
                             		    //半角空格
                             		    }else
                             		    {
                             		     if(tax_registration_bank_account.charAt(i)==" "){
                             		    	result +="";
                             		     }else{
                             		    	result +=tax_registration_bank_account.charAt(i);
                             		     }	
                             			 
                             		     //原字符返回
                             		    }
                             		    }
                             		       tax_registration_bank_account=result;
                             			   document.getElementById('tax_registration_bank_account').value=tax_registration_bank_account;
                                  	   if(!reg.test(tax_registration_bank_account)){
                                  		   alert("纳税人银行账号只能由数字组成！");
                                  		   return false;
                                  	   }
                                      }
                            	   }
                            	 //2016-07-14  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End
	                                    var action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=insertByQA";
	                                    var myAjax = new Ajax(action);
	                                     myAjax.addParam('agent_b_id', document.form_treebasic.agent_b_id.value);
	                                     myAjax.addParam('agent_b_name', document.form_treebasic.agent_b_name.value);
	                                     myAjax.addParam('contract_name', document.form_treebasic.contract_name.value);
	                                     myAjax.addParam('contract_start_date', document.form_treebasic.contract_start_date.value);
	                                     myAjax.addParam('contract_stop_date', document.form_treebasic.contract_stop_date.value);
	                                     myAjax.addParam('create_type_bd', document.form_treebasic.create_type_bd.value);
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
	                                     myAjax.addParam('contractbd',document.form_treebasic.contractbd.value);
	                                     //发票抬头
	                                     myAjax.addParam('receipt_title',receipt_title);
                                         //2016-04-15  by zhouxiaolong  客户为新户时，新增税务相关字段  begin
                                         myAjax.addParam('taxpayer_identity_type',document.getElementById('taxpayer_identity_type').value);
                                         myAjax.addParam('taxpayer_identification_number',document.getElementById('taxpayer_identification_number').value);
                                         myAjax.addParam('tax_registration_address',document.getElementById('tax_registration_address').value);
                                         myAjax.addParam('tax_registration_telnum',document.getElementById('tax_registration_telnum').value);
                                         myAjax.addParam('tax_registration_bank',document.getElementById('tax_registration_bank').value);
                                         myAjax.addParam('tax_registration_bank_account',document.getElementById('tax_registration_bank_account').value);
                                         //2016-04-15  by zhouxiaolong  客户为新户时，新增税务相关字段  end
	                                    //2016-04-21  by zhouxiaolong  客户为新户时，新增附加税相关字段  begin
                                         myAjax.addParam('increase_ticket_type_bak',"1");
                                         //2016-04-21  by zhouxiaolong  客户为新户时，新增附加税相关字段  end
	                                     myAjax.submit();
                                         
                                         
	                                     var returnNode = myAjax.getResponseXMLDom();
	                                     if( returnNode ) {
	                                    	 alert(""+myAjax.getProperty("returnValue"));
		                                     var xmlSubmit=$id("datacell1").dataset.toString();
		                                     var action="<%=request.getContextPath()%>/CostcenterAction.do?cmd=save";
		                                     var myAjax1 = new Ajax(action);
		                                     myAjax1.submitXML(xmlSubmit);
		                                     $id("datacell1").isModefied = true;
	                                          window['returnValue'] = ""+myAjax.getProperty("returnValue");
	                                          var oid = myAjax.getProperty("returnMessage");
	                                          document.getElementById("ids").value=oid;
	                                          beanId = "ISalcontractitemBs";
	                                          _$("#btnsave").hide();
	                                          window.close();
	                                          window.opener.showListData();//回调父页面函数
	                                          
	                                     }
                               	}				        
					        }
                         }else{
                            //已经有成本中心则不用判断发票抬头  因为代码一定先走myajax  没法前面return 所以这么写
                                    var action="<%=request.getContextPath()%>/SalcontractAction.do?cmd=insertByQA";
                                    var myAjax = new Ajax(action);
                                     myAjax.addParam('agent_b_id', document.form_treebasic.agent_b_id.value);
                                     myAjax.addParam('agent_b_name', document.form_treebasic.agent_b_name.value);
                                     myAjax.addParam('contract_name', document.form_treebasic.contract_name.value);
                                     myAjax.addParam('contract_start_date', document.form_treebasic.contract_start_date.value);
                                     myAjax.addParam('contract_stop_date', document.form_treebasic.contract_stop_date.value);
                                     myAjax.addParam('create_type_bd', document.form_treebasic.create_type_bd.value);
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
                                     myAjax.addParam('contractbd',document.form_treebasic.contractbd.value);
                                     //发票抬头
                                     myAjax.addParam('receipt_title',receipt_title);
                                    
                                     //alert(document.form_treebasic.contractbd.value+"@@@@@@");
                                     //return;
                               
                                     myAjax.submit();
                                     var returnNode = myAjax.getResponseXMLDom();
                                     if( returnNode ) {
                                          alert(""+myAjax.getProperty("returnValue"));
                                          window['returnValue'] = ""+myAjax.getProperty("returnValue");
                                          var oid = myAjax.getProperty("returnMessage");
                                          document.getElementById("ids").value=oid;
                                          beanId = "ISalcontractitemBs";
                                          _$("#btnsave").hide();
                                          window.close();
                                          window.opener.showListData();//回调父页面函数
                                          
                                     }
                         }
               }
        });
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
<style type="text/css">
.datecellCss span{color:#075587;text-align: center;}
</style>
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
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_type"/></td>
            <td class="td_2"  nowrap="nowrap">
             <input type="hidden" class="text_field" name="contract_type_bd"  id  =  "contract_type_bd"   value="<%=contract_type_bd %>" >
                   <%=gap.rm.tools.helper.RmJspHelper.getSelectField("contract_type_bd", -1, "CONTRACT_TYPE_BD", contract_type_bd, " id=contract_type_bd  disabled='disabled'  ", false)%> 
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_name"/></td>
            <td class="td_2 " nowrap="nowrap">  
                    
                
        <%
                                                  if (null != detail && !"detail".equals(detail)) {
                                              %>
               <input type="text" class="text_field"  id="contract_name"  name="contract_name" inputName="合同名称" value="<% if(null!=contract_name&&!"".equals(contract_name))   out.print(contract_name);   %>" maxLength="50" validate="notNull;"/>
        
                <%
                            } else {
                        %>
              <input type="text" class="text_field"  id="contract_name"  name="contract_name" inputName="合同名称" value="<% if(null!=contract_name&&!"".equals(contract_name))   out.print(contract_name);   %>" maxLength="50" validate="notNull;"   readonly="readonly"/>
        
                <%
                            }
                        %>
        
        
        
            </td>
        </tr>
    
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_jiafang"/></td>
            <td class="td_2 " nowrap="nowrap">
               <%
                   if (null != detail && !"detail".equals(detail)) {
               %>
               <%
                   if ("zp".equals(f)) {
               %>
                <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px"   readOnly="true" displayValue="<%=customer_name %>" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1&f=${param.f}" messagekey="choose_contract_jiafang" height="440" width="710"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id"/>
                <input type="hidden" name="customer_code" id="customer_code"/>
                
                <%
                                    } else if ("add".equals(detail)) {
                                %><!-- 2014-7-7 yangyuting  add  新增时 可操作按钮 -->
               <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px"    displayValue="<%=customer_name %>" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" messagekey="choose_contract_jiafang" height="440" width="710"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name" value="${bean.customer_name }"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id"  value="${bean.cust_a_id }"/>
                <input type="hidden" name="customer_code" id="customer_code" value="${bean.customer_code }"/>
                 
                <%
                                     } else {
                                 %>
               <w:lookup onReturnFunc="rtnFunc" lookupWidth="189px"   readOnly="true"  displayValue="<%=customer_name %>" id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" messagekey="choose_contract_jiafang" height="440" width="710"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name" value="${bean.customer_name }"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id"  value="${bean.cust_a_id }"/>
                <input type="hidden" name="customer_code" id="customer_code" value="${bean.customer_code }"/>
                 
                <%
                                     }
                                 %>
                <%
                    } else {
                %>
                <w:lookup onReturnFunc="rtnFunc" displayValue="<%=customer_name %>" lookupWidth="189px"   readOnly="true"  id="lk_cust" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition1" messagekey="choose_contract_jiafang" height="440" width="710"/>
                <input type="hidden" name="cust_a_name" id="cust_a_name" value="${bean.customer_name }"/>
                <input type="hidden" name="cust_a_id" id="cust_a_id" value="${bean.cust_a_id }"/>
                <input type="hidden" name="customer_code" id="customer_code" value="${bean.customer_code }"/>
                
                <%
                                    }
                                %>
            </td>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_yifang"/></td>
            <td class="td_2 " nowrap="nowrap">                
               <%
                                   if (null != detail && !"detail".equals(detail) && !"add".equals(detail)) {
                               %><!--2014-7-7 yangyuting  add  判断 detail！=add  -->
                <w:lookup onReturnFunc="rtnFunc1" lookupWidth="189px" displayValue="<%=agent_b_name %>"  readOnly="true" id="lk_cust1" lookupUrl="/AgentAction.do?cmd=getAllagentByCondition" messagekey="choose_contract_yifang" height="430" width="680"/>
                <input type="hidden" name="agent_b_id" id="agent_b_id" value="<%=agent_b_id %>" />
                <input type="hidden" name="agent_b_name" id="agent_b_name" value="<%=agent_b_name %>"/>
                 <%
                     } else if ("add".equals(detail)) {
                 %><!-- 2014-7-7 yangyuting  add  新增时 可操作按钮 -->
                <w:lookup onReturnFunc="rtnFunc1" displayValue="<%=agent_b_name %>" lookupWidth="189px"  id="lk_cust1" lookupUrl="/AgentAction.do?cmd=getAllagentByCondition" messagekey="choose_contract_yifang" height="430" width="680"/>
                <input type="hidden" name="agent_b_id" id="agent_b_id" value="<%=agent_b_id %>"/>
                <input type="hidden" name="agent_b_name" id="agent_b_name"  value="<%=agent_b_name %>"/>
                <%
                    } else {
                %>
                <w:lookup onReturnFunc="rtnFunc1" displayValue="<%=agent_b_name %>" lookupWidth="189px"  readOnly="true" id="lk_cust1" lookupUrl="/AgentAction.do?cmd=getAllagentByCondition" messagekey="choose_contract_yifang" height="430" width="680"/>
                <input type="hidden" name="agent_b_id" id="agent_b_id" value="<%=agent_b_id %>"/>
                <input type="hidden" name="agent_b_name" id="agent_b_name"  value="<%=agent_b_name %>"/>
                <%
                    }
                %>
           </td>
        </tr>
        
        <tr>
            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_start_date"/></td>
            <td class="td_2" nowrap="nowrap">
            <%
                if (null != detail && !"detail".equals(detail)) {
            %>
                 <w:date format="yyyy-MM-dd" id="contract_start_date" name="contract_start_date" property="bean/contract_start_date" width="189px"/>
                 <%
                     } else {
                 %>
                 <w:date format="yyyy-MM-dd" id="contract_start_date" name="contract_start_date" property="bean/contract_start_date" readOnly="true" width="189px"/>
                 <%
                     }
                 %>
            </td>
           <td class="td_1" ><%
               if (contract_type_bd != null && !contract_type_bd.trim().equals("1")) {
           %><span class="style_required_red">* </span><%
               }
           %><fmt:message key="contract_stop_date"/></td>
            <td class="td_2"  nowrap="nowrap">
                <%
                    if (null != detail && !"detail".equals(detail)) {
                %>
                <w:date format="yyyy-MM-dd" id="contract_stop_date" name="contract_stop_date" property="bean/contract_stop_date" width="189px"/>
                <%
                    } else {
                %>
                <w:date format="yyyy-MM-dd" id="contract_stop_date" name="contract_stop_date" property="bean/contract_stop_date" width="189px" readOnly="true"/>
                <%
                    }
                %>
            </td>
        </tr>
                <input type="hidden" class="text_field"   id="create_type_bd"  name="create_type_bd" inputName="合同生成方式" value="<%= create_type_bd%>" maxLength="64" validate="notNull;"/>
    
        <tr>
        <%
            if ("1".equals(create_type_bd)) {
        %>
              <td class="td_1" ><fmt:message key="contract_template"/></td>
            <td class="td_2 "    >
            <%
                request.setAttribute("contract_template_id", contract_template_id);
            %>
                <input type="hidden"  id="contract_template_id"  class="text_field" name="contract_template_id"  value="<%=contract_template_id %>" >
                 <faerp:contractTemplateSelectTag  beanname="contract_template_id"   strproperty=" disabled='disabled'  "  style="width:205px"/>
            </td>
             <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="service_company"/></td>
               <td class="td_2">
			<%if (null != detail && "add".equals(detail)) {%>
			     <d:select dictTypeId="SERVICE_COMPANY" name="service_company" id="service_company" nullLabel="请选择" value="${bean.service_company}"/></td>
			<%} else {%>
			     <d:select dictTypeId="SERVICE_COMPANY" disabled='true'  name="service_company" id="service_company" nullLabel="请选择" value="${bean.service_company}"/></td>
			<%}%> 
               
           <%
               } else {
           %>
                 <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_attachments"/></td>
            <td class="td_2 "    >
   <!--            <input type="text" class="text_field" name="contract_attachment_id" inputName="合同附件ID" value="" maxLength="9.5" />  --> 
                 <%
                      if (null != detail && !"detail".equals(detail)) {
                  %>
                   <input type="text"   value=""   id="attachNameInput" class="text_field_reference_readonly" name="attach_name" inputName="附件地址" value="" hiddenInputId="attach_name"  /><img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"  />
                  <input type="hidden" id="attackAddressInput" name="attach_address" >
                  </td>
             <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="service_company"/></td>
               <td class="td_2"  ><d:select dictTypeId="SERVICE_COMPANY"    name="service_company" id="service_company" nullLabel="请选择" value="${bean.service_company}"/></td>
                <%
                    } else {
                %>
                
               <%
                                   if (isModify && avo != null)
                                               out.print("<a href='" + request.getContextPath() + "/ProductAction.do?cmd=downLoad&attachment_id=" + avo.getId() + "'><font color=blue>" + avo.getAttachment_file_name()
                                                       + "</font></a>");
                                           {
                               %>
            </td>
             <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="service_company"/></td>
               <td class="td_2"  ><d:select dictTypeId="SERVICE_COMPANY"  disabled='true'  name="service_company" id="service_company" nullLabel="请选择" value="${bean.service_company}"/>
               </td>
        <%
            }
        %>
         <%
             }
         %>
         <%
             }
         %>
        </tr>
        <%
            if (isQA.equals("true")) {
        %><!-- QA建合同，选择合同的类别（北京，上海）  2013年11月15日 11:04:49-->
            <tr>
	            <td class="td_1" ><span class="style_required_red">* </span><fmt:message key="contract_s"/></td>
	            <td class="td_2" ><select name="contractbd" id="contractbd">
	                                                        <option value="shanghai" selected="selected">上海自主</option>
	                                                        <option value="beijing">北京委托</option>
	                                              </select> 
	                                              </td>
	            <td class="td_1" >成本中心发票抬头</td>
	            <td class="td_2" nowrap="nowrap">
	               <div id="receipt_title_container" class="eos-ic-container">
		                <input type="text" style="width:205px" name=receipt_title id="receipt_title" class="eos-lookup-editor-text">
		                <!-- 暂时不能选择成本中心抬头 -->
		                <!--  <img class="eos-ic-button" id="receipt_title_button" src="/FAERP/common/skins/skin0/images/lookup/lookup_button.gif" style="cursor: pointer;margin-left:-3px"  onclick="toSelectReceipt()">-->
	               </div>
	            </td>
            </tr>
    <!--2016-04-15  by zhouxiaolong  如果客户为新户则新增成本中心税务字段  begin-->
    <tr id="centerNew1">
        <td class="td_1" >纳税人身份类型</td>
        <td class="td_2 ">
            <select id="taxpayer_identity_type" name="taxpayer_identity_type" onchange="taxpayeridentitytypeChange()">
                        <option value="1">增值税一般纳税人</option>
                        <option value="2">非增值税一般纳税人</option>
                    </select>
        </td>
          <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin  -->
          <td class="td_1" >纳税人识别号</td>
          <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End  -->
        <td class="td_2 ">
          <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     Begin  -->
            <input type="text" class="text_field" id="taxpayer_identification_number" name="taxpayer_identification_number" inputName="纳税人识别号" maxLength="20" />
          <!--2016-07-05  by zhouxiaolong   成本中心纳税人识别号增加规则验证     End  -->
         </td>
    </tr>
    <tr id="centerNew2">
        <td class="td_1" >税务登记地址</td>
        <td class="td_2 ">
            <input type="text" class="text_field" id="tax_registration_address" name="tax_registration_address" inputName="税务登记地址"  maxLength="50"/>
        </td>
          <td class="td_1" >税务登记电话号码</td>
        <td class="td_2 ">
            <input type="text" class="text_field" id="tax_registration_telnum" name="tax_registration_telnum" inputName="税务登记电话号码"  maxLength="64"/>
        </td>
    </tr>
    <tr id="centerNew3">
        <td class="td_1" >税务登记开户银行</td>
        <td class="td_2 ">
            <input type="text" class="text_field" id="tax_registration_bank" name="tax_registration_bank" inputName="税务登记开户银行"  maxLength="50"/>
        </td>
        <td class="td_1" >税务登记银行账号</td>
        <td class="td_2 ">
            <input type="text" class="text_field" id="tax_registration_bank_account" name="tax_registration_bank_account" inputName="税务登记银行账号"  maxLength="64" />
        </td>
    </tr>
<tr>
</tr>
    <!--2016-04-15  by zhouxiaolong  如果客户为新户则新增成本中心税务字段  end-->
            <%
                }
            %>
    </table>
</div> 
<%
            if (isQA.equals("true")) {
        %>
     <div id="centerNew7"  class="datecellCss" style="margin-top:-130px;">
    <r:datacell id="datacell1" queryAction="/FAERP/CostcenterAction.do?cmd=simpleQueryVatPay" 
    submitAction="/FAERP/CostcenterAction.do?cmd=insert" width="700px" height="210px" xpath="CostcenterVo" 
    paramFormId="datacell_formid" pageSize="10">
    <r:toolbar location="bottom" tools="nav,pagesize,info"/>
    <r:field fieldName="social_unit_name"   label="福利办理方" allowModify="false"  width="80px">
    </r:field>
    <r:field fieldName="service_type_name"  label="业务类型名称" allowModify="false" width="90px">
    </r:field>
    <r:field fieldName="product_type_name" label="代收付产品小类名称"  width="140px">
    </r:field>
    <r:field fieldName="is_payticket_for_delegate" label="开票类型" allowModify="true"  width="70px">
        <d:select dictTypeId="IS_PAY_FOR_DELEGATE" id="is_pay_for_delegate" onchange="isPayticketforDelegate2()"></d:select>
    </r:field>
    <r:field fieldName="add_tax_rate_for_delegate" label="附加税率" allowModify="true"  width="70px">
	        <select>
	           <option value="0">0</option>
	           <option value="0.0078613183">0.0078613183</option>
	           <option value="0.0065425264">0.0065425264</option>
	        </select>
	    </r:field>
	      <r:field fieldName="start_date" width="110px" label="起始日期"  allowModify="true">
	       <w:date format="yyyy-MM-dd" allowNull="true;"/>
	       </r:field>  
	       <r:field fieldName="end_date" width="110px" label="终止日期"  allowModify="true">
	       <w:date format="yyyy-MM-dd" allowNull="true"/>
       </r:field>
 </r:datacell>
</div> 
    <%
                }
            %>   
              <div class="mx_button" style="margin-top:-250px">
    
     <%
             if (null != detail && !"detail".equals(detail)) {
                 if (isQA.equals("true")) {
         %><!-- add by sqp  QA进来保存按钮  2013年11月15日 11:04:49-->
                     <input type="button" id="saveButton" class="icon_4" value='<fmt:message key="save"/>' style="width: 90px" onClick="javascript:<%=isModify?"updateByQA_onClick()":"insertByQA_onClick()"%>" />
          <%
              } else {
                      if (!"1".equals(create_type_bd) && !isModify) {
          %>
                 <input type="button" class="icon_4" value='<fmt:message key="save_submit_examine"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick('yes_nogapwf')"%>" />
       <%
           }
       %>
        <%
            if ("9".equals(contract_type_bd)) {
        %>
        <input type="button" class="icon_2" id="btnsave" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick('yes_nogapwf')"%>" />
        <%
            } else {
        %>
        <input type="button" class="icon_2" id="btnsave" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick('no_gapwf')"%>" />
        <%
            }
        %>
       <%
           }
           }
       %>
        
        
         <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
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


<%
    //if("zp".equals(f) && ("modify".equals(detail) || "add".equals(detail) ) ) {
%>
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
    <%
        //}
    %>

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
    window.onload=function(){
        jQuery("#centerNew1").hide();
        jQuery("#centerNew2").hide();
        jQuery("#centerNew3").hide();
        jQuery("#centerNew4").hide();
        jQuery("#centerNew5").hide();
        jQuery("#centerNew6").hide();
        jQuery("#centerNew7").hide();
    }
<%  //取出要修改的那条记录，并且回写表单
    if(isModify) {  //如果本页面是修改页面
    //  out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
    }
    
%>
<% if(isModify) {%>
jQuery(".mx_button").attr("style","margin-top:-280px");
<%}%>

        //选择合同甲方
function rtnFunc(arg){
    var lookup = $id("lk_cust");
    lookup.value = arg[0];
    lookup.displayValue = arg[2];
    jQuery("#cust_a_id").val(arg[0]);       
    jQuery("#cust_a_name").val(arg[2]);     
    jQuery("#customer_code").val(arg[1]);
    <!--2016-04-14   by zhouxiaolong  新增合同时判断客服是否为新户  begin-->
    checkIsNew();
    <!--2016-04-14   by zhouxiaolong  新增合同时判断客服是否为新户  end-->
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

//跳转查询发票抬头
function toSelectReceipt() {
    var cust_id = jQuery("#cust_a_id").val();
    if(cust_id == null || cust_id == ""){
        alert("请先选择合同甲方!");
        return;
    } 
    showModalCenter("<%=request.getContextPath()%>/SalcontractAction.do?cmd=toSelectReceipt&cust_id=" + cust_id,null,receiptReturn,850,405,"选择发票抬头");
}

//选择发票抬头返回方法
function receiptReturn(retVal){
    jQuery("#receipt_title").val(retVal[0]);
}

//2016-04-14 by zhouxiaolong 新增合同时验证客服是否为新户  begin
function checkIsNew(){
    var cust_a_id=jQuery("#cust_a_id").val();
    if(cust_a_id!=""&&cust_a_id!=null){
        jQuery.ajax({
            type: "post",
            url: "<%=request.getContextPath()%>/SalcontractAction.do?cmd=isNewCust&cust_id=" + document.getElementById("cust_a_id").value,
            dataType: "html",
            success: function (data) {
                if (data == 0) {
                    jQuery("#centerNew1").show();
                    jQuery("#centerNew2").show();
                    jQuery("#centerNew3").show();
                    jQuery("#centerNew4").show();
                    jQuery("#centerNew5").show();
                    jQuery("#centerNew6").show();
                    jQuery(".mx_button").attr("style","margin-top:-130px");
                    jQuery("#taxpayer_identification_number").attr("validate","notNull;");
                    jQuery("#tax_registration_address").attr("validate","notNull;");
                    jQuery("#tax_registration_telnum").attr("validate","notNull;isNum;");
                    jQuery("#tax_registration_bank").attr("validate","notNull;");
                    jQuery("#tax_registration_bank_account").attr("validate","notNull;isNum;");
                }else{
                	jQuery("#taxpayer_identification_number").removeAttr("validate");
                	jQuery("#tax_registration_address").removeAttr("validate");
                	jQuery("#tax_registration_telnum").removeAttr("validate");
                	jQuery("#tax_registration_bank").removeAttr("validate");
                	jQuery("#tax_registration_bank_account").removeAttr("validate");
                	   <%
                       if (isQA.equals("true")) {
                       %>
                       jQuery(".mx_button").attr("style","margin-top:-250px");
                       <%}%>
                    jQuery("#centerNew1").hide();
                    jQuery("#centerNew2").hide();
                    jQuery("#centerNew3").hide();
                    jQuery("#centerNew4").hide();
                    jQuery("#centerNew5").hide();
                    jQuery("#centerNew6").hide();
                    jQuery("#centerNew7").hide();
                }
            }
        })

    }

}
//2016-04-14 by zhouxiaolong 新增合同时验证客服是否为新户  end

//2016-04-21 by zhouxiaolong 新增合同时验证客服是否为新户  begin
function isPayticketforDelegatewages2(){
var typeid= jQuery("#is_payticket_for_delegatewages_bak").val();
if(typeid=='1'){
    jQuery("#additional_tax_ratewages_bak").attr("validate","notNull;isNumeric;");
    jQuery("#ratewages3").show();
    jQuery("#ratewages4").show();
}else{
    jQuery("#ratewages3").hide();
    jQuery("#ratewages4").hide();
    jQuery("#additional_tax_ratewages_bak").val("");
    jQuery("#additional_tax_ratewages_bak").removeAttr("validate");
}
}

function isPayticketforDelegatesecurity2(){
var typeid= jQuery("#is_payticket_for_delegatesecurity_bak").val();
if(typeid=='1'){
    jQuery("#add_tax_rate_for_delegate_security_bak").attr("validate","notNull;isNumeric;");
    jQuery("#ratesecurity3").show();
    jQuery("#ratesecurity4").show();
}else{
    jQuery("#ratesecurity3").hide();
    jQuery("#ratesecurity4").hide();
    jQuery("#add_tax_rate_for_delegate_security_bak").val("");
    jQuery("#add_tax_rate_for_delegate_security_bak").removeAttr("validate");
}
}

function isPayticketforDelegategongjijin2(){
var typeid= jQuery("#is_payticket_for_delegategongjijin_bak").val();
if(typeid=='1'){
    jQuery("#additional_tax_rate_gongjijin_bak").attr("validate","notNull;isNumeric;");
    jQuery("#rategongjijin3").show();
    jQuery("#rategongjijin4").show();
}else{
    jQuery("#rategongjijin3").hide();
    jQuery("#rategongjijin4").hide();
    jQuery("#additional_tax_rate_gongjijin_bak").val("");
    jQuery("#additional_tax_rate_gongjijin_bak").removeAttr("validate");
}
}

    function isPayticketforDelegate2(){
    if(jQuery("#is_payticket_for_delegate").val()=='1'){
        batch_date("0.0078","add_tax_rate_for_delegate");
        jQuery("#add_tax_rate_for_delegate").attr("readOnly",false);

    }else{
        batch_date("","add_tax_rate_for_delegate");
        jQuery("#add_tax_rate_for_delegate").attr("readOnly",true);
    }
}
function batch_date(obj,name){
    var enCurEntity1 = $id("datacell1").activeEntity;
    var entity = enCurEntity1.getProperty(name);
            enCurEntity1.setProperty(name,obj);
    return true;            
}





//2016-04-21 by zhouxiaolong 新增合同时验证客服是否为新户  end



</script>



