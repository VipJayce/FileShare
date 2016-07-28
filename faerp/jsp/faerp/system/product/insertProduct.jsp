<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="rayoo.system.product.vo.ProductVo" %>
<%@ page import="rayoo.common.system.attachmentfile.vo.AttachmentfileVo" %>
<%@ page import="rayoo.system.productscheme.vo.ProductschemeVo" %>
<%@ page import="rayoo.system.product.util.IProductConstants" %>
<%@page import="gap.rm.tools.helper.RmJspHelper"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<%@ page import="gap.rm.tools.helper.RmUploadHelper" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<jsp:useBean id="agentaction" class="rayoo.sales.agent.action.AgentAction" scope="page" />
<%  //判断是否为修改页面
    String parentid="";
    ProductVo resultVo = null;  //定义一个临时的vo变量
    AttachmentfileVo avo=null;//附件VO
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(IProductConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (ProductVo)request.getAttribute(IProductConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
        
        if(request.getAttribute("parentid") != null) {  //如果request中取出的bean不为空
            parentid = (String)request.getAttribute("parentid");  //从request中取出vo, 赋值给resultVo
        }
        
        if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
            avo = (AttachmentfileVo)request.getAttribute("AttachmentfileVo");  //从request中取出vo, 赋值给resultVo
        }
        
    }
    String attachName = avo==null?"":avo.getAttachment_file_name().toString();
    String attachAddress = avo==null?"":avo.getAttachment_file_path().toString();
%>
<html>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function insert_onClick(){  //插入单条数据
    if(checkAllForms()){
        var product_name=document.form.product_name.value;
        var big_type_id=document.form.big_type_id.value;
        var small_type_id=document.form.small_type_id.value;
        var three_type_id=document.form.three_type_id.value;
        var product_dept=document.form.product_dept.value;
        var charging_frequency=document.form.charging_frequency.value;
        var product_en_name=document.form.product_en_name.value;
        var trid=document.form.trid;
        var attach_name=document.form.attach_name.value;
        var scheme_type=document.form.scheme_type.value;
        var scheme=document.form.is_scheme.value;
        if(big_type_id==""||big_type_id=="0"){
            alert(" 产品大类不能为空！");
            return;
        }
        if(small_type_id==""||small_type_id=="0"){
            alert(" 产品小类不能为空！");
            return;
        }
        if(product_name==""){
            alert(" 产品名称不能为空！");
            document.form.product_name.focus();
            return;
        }
       if(big_type_id=="104"){
                if(three_type_id==""||three_type_id=="0"){
	            alert(" 产品三级分类不能为空！");
	            return;
	            }
        }
           //如果是财务外包产品，则必须要选择收费频率
       if(big_type_id=="108"){
            if(product_en_name==""||product_en_name==null){
                alert("请输入产品英文名称!");
                return;
            }
            if(charging_frequency==""||charging_frequency==null){
                alert("请选择财务外包产品的收费频率!");
                return;
            }
       }
       if(scheme=="1"){
		       if(scheme_type==1){
		          if(trid==undefined){//产品
		              alert("请添加产品信息！");
		              return;
		          }
		       }else if(scheme_type==2){
		           if(attach_name==""){//附件
                      alert("请添加附件信息！");
                      return;
                  }
		       }else{
		       alert("请选择方案类型！");
		       return;
		       }
       }
       if(product_dept==""){
            alert(" 产品所属部门不能为空！");
            return;
        }
           
        form.action="<%=request.getContextPath()%>/ProductAction.do?cmd=insert&big_type_id="+big_type_id+"&small_type_id="+small_type_id+"&three_type_id="+three_type_id;
        form.submit();
        }
    }

    function update_onClick(){  //保存修改后的单条数据
     if(checkAllForms()){
        var product_name=document.form.product_name.value;
        var big_type_id=document.form.big_type_id.value;
        var small_type_id=document.form.small_type_id.value;
        var three_type_id=document.form.three_type_id.value;
        var product_dept=document.form.product_dept.value;
        var charging_frequency=document.form.charging_frequency.value;
         var product_en_name=document.form.product_en_name.value;
        var trid=document.form.trid;
        var attach_name=document.form.attach_name.value;
        var scheme_type=document.form.scheme_type.value;
        var scheme=document.form.is_scheme.value;
        if(big_type_id==""){
            alert(" 产品大类不能为空！");
            return;
        }
        if(small_type_id==""){
            alert(" 产品小类不能为空！");
            return;
        }
        if(product_name==""){
            alert(" 产品名称不能为空！");
            return;
        }
        
         if(big_type_id=="104"){
          if(three_type_id==""||three_type_id=="0"){
          alert(" 产品三级分类不能为空！");
          return;
          }
       }
       //如果是财务外包产品，则必须要选择收费频率
       if(big_type_id=="108"){
           if(product_en_name==""||product_en_name==null){
                alert("请输入产品英文名称!");
                return;
            }
            if(charging_frequency==""||charging_frequency==null){
                alert("请选择财务外包产品的收费频率!");
                return;
            }
       }
        if(scheme=="1"){
               if(scheme_type==1){
                  if(trid==undefined){//产品
                      alert("请添加产品信息！");
                      return;
                  }
               }else if(scheme_type==2){
                   if(attach_name==""){//附件
                      alert("请添加附件信息！");
                      return;
                  }
               }else{
               alert("请选择方案类型！");
               return;
               }
       }
         
       if(product_dept==""){
            alert(" 产品所属部门不能为空！");
            return;
       }
        
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
        form.action="<%=request.getContextPath()%>/ProductAction.do?cmd=update&big_type_id="+big_type_id+"&small_type_id="+small_type_id+"&three_type_id="+three_type_id;
        form.submit();
        }
    }

    function cancel_onClick(){  //取消后返回列表页面
        form.action="<%=request.getContextPath()%>/ProductAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    

        
        //是否定方案产品
        function IsScheme(){
        var scheme_type=document.form.scheme_type;
        var scheme=document.form.is_scheme.value;
        <%
        if(isModify){
        %>
         var oldscheme=<%=resultVo.getIs_scheme()%>;
         if(scheme!=oldscheme||scheme==''){
            document.form.is_scheme.value=oldscheme;
            alert(" 是否定方案产品不可修改！");
            return;
         }
        <%}%>
        //alert("scheme="+scheme);
            if(scheme==1&&scheme!=''){
	           scheme_type.selectedIndex=1;
	            document.form.scheme_type.disabled=false;
	            document.getElementById("div1").style.display='';
            }else{
             scheme_type.selectedIndex=0;
            document.form.scheme_type.disabled=true;
            
            }
        }
        
        //方案类型
        function SchemeType(){
        var scheme_type=document.form.scheme_type.value;
            <%
            if(isModify){
            %>
            var oldscheme_type=<%=resultVo.getScheme_type()%>;
	         if(scheme_type!=oldscheme_type||scheme_type==''){
	            document.form.scheme_type.value=oldscheme_type;
	            alert(" 方案类型不可修改！");
	            return;
	         }
            <%}%>
            if(scheme_type==1){
            document.getElementById("div1").style.display='';
            document.getElementById("div2").style.display='none';
            document.getElementById("div3").style.display='none';
            }else if(scheme_type==2){
            document.getElementById("div3").style.display='';
            document.getElementById("div1").style.display='none';
            document.getElementById("div2").style.display='none';
            }else{
            document.getElementById("div1").style.display='none';
            document.getElementById("div2").style.display='none';
            document.getElementById("div3").style.display='none';
            }
        }
        
        //选择产品
        function getWindowList() {
        //产品大分类
        var big_type_id=document.form.big_type_id.value;
        var ids = window.showModalDialog('<venus:base/>/ProductAction.do?cmd=queryByProduct&big_type_id='+big_type_id+"&parentid=<%=parentid%>&date="+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
        if(ids) {
        
         //得到当前有多少行数据
        var table1=document.getElementById('tab');
        var rows=table1.rows;
        var row=rows.length;
        if(rows!="undefined"){
        //显示删除按钮
        if(row>=1)document.getElementById("del").style.display='';
        }
        
        //后台取到数据
        jQuery.getJSON("<venus:base/>/ProductAction.do?cmd=getChooseData&date="+new Date()+"",{"ids":ids},  function(json){
         for(var i = 0; i < json.saia.length; i++){
            jQuery("#tab").append("<tr id=tr"+json.saia[i].id+"><td ><input type=\"hidden\" name=\"trid\" value="+json.saia[i].id+"><input type=\"checkbox\" name=\"checkbox_template\" value="+json.saia[i].id+"></td><!--<td >"+(i+row)+"</td>--><td >&nbsp;"+json.saia[i].product_name+"</td><td>&nbsp;"+json.saia[i].big_type_id+"</td><td>&nbsp;"+json.saia[i].small_type_id+"</td><td>&nbsp;"+json.saia[i].three_type_id+"</td></tr>");
            }
        }); 
            document.getElementById("div2").style.display='';
        }
    }
    
    
    function getSupplierList(){
     var ids = window.showModalDialog('<venus:base/>/AgentAction.do?cmd=queryAllGetByID&agent_type=&date='+new Date(),'','dialogHeight:490px;dialogWidth:750px;center:yes;help:no;resizable:no;scroll:no;status:no;');
    if(ids==undefined)return;
    document.form.product_supplier.value=ids[0];
    document.form.product_supplier_name.value=ids[1];
    }
    
    
      //移除一行子记录
     function remove(){
        var arrayObj = new Array(); 
         function selectIdCount(){
         selecCount=0;
         var idTag=  document.getElementsByName("checkbox_template");
          for(i=0;i<idTag.length;i++)
          {
            if(idTag[i].checked==true){
              selecCount++;
              arrayObj.push(idTag[i].value);
              }
          }
         }
         
         selectIdCount();
             if(selecCount<1)
           {  alert('请选择一条以上的记录');
           return;
           }
        
        for(var i =0;i<arrayObj.length;i++){
        //alert(arrayObj[i]);
        jQuery("#tr"+arrayObj[i]).remove();
        }
        
        //隐藏删除按钮
        var table1=document.getElementById('tab');
        var rows=table1.rows;
        var row=0;
        if(rows!="undefined"){
        row=rows.length;
               if(row<=1){
               document.getElementById("del").style.display='none';
               document.getElementById("div2").style.display='none';
               }
        }
    }
    
    
	/**
	 * 功能描述：动态生成产品大类下拉菜单的内容
	 * 参数：  selectId --下拉框id;
	 *              key -- 填充时作为option value的对象属性
	 *              value -- 填充时作为option展示的对象属性
	 */    
	function getAllBigType(selectObject,key,value,selectvalue){
	    if(selectObject.length==1) {
	        AjaxControl.getBigTypeId("big_type_id",{callback:function(data){
	             //alert('getAllBigType data:'+data+" 长度:" +data.length);
	                if (data != null && typeof data == 'object') 
	                {
	                    setSelectForBean(selectObject.id,data,key,value,selectvalue);
	                }
	                  <%
					if(isModify){
					%>
					getAllSmallType(document.form.big_type_id,'small_type_id','code','name','<%=isModify ? resultVo.getSmall_type_id() : "" %>');
					<%}%> 
	            }
	         
	        });
	    }else{
	        return;
	    }
	}


	/**
	 * 功能描述：动态生成产品小类下拉菜单的内容
	 * 参数：selectObject --下拉框对象;
	                targetId         -- 下拉框目标对象;
	 *              key -- 填充时作为option value的对象属性
	 *              value -- 填充时作为option展示的对象属性
	 */    
	function getAllSmallType(selectObject,targetId,key,value,selectvalue){
	
	   var big_type_id=document.form.big_type_id.value;
	     <%
        if(isModify){
        %>
       var big_type_id_old=<%=resultVo.getBig_type_id()%>
       if(big_type_id!=big_type_id_old){
       document.form.big_type_id.value=big_type_id_old;
       alert("产品大类不可修改");
       return;
       }
       <%}%>

		    if(selectObject.value=="105"){
		    document.getElementById("tr1").style.display='';
		    }else{
		    document.getElementById("tr1").style.display='none';
		    }
	    AjaxControl.getSmallTypeId(selectObject.value,{callback:function(data){
	            if (data != null && typeof data == 'object') 
	            {
	                DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
	                DWRUtil.addOptions(targetId,{000:'--请选择--'});
	                setSelectForBean(targetId,data,key,value,selectvalue);
	                <%
                    if(isModify){
                    %>
                    getAllThreeType(document.form.small_type_id,'three_type_id','code','name','<%=isModify ? resultVo.getThree_type_id() : "" %>');
                    <%}%> 
	            }
	        }
	    });
	}


	/**
	 * 功能描述：动态生成产品三级分类下拉菜单的内容
	 * 参数：selectObject --下拉框对象;
	                targetId         -- 下拉框目标对象;
	 *              key -- 填充时作为option value的对象属性
	 *              value -- 填充时作为option展示的对象属性
	 */    
	function getAllThreeType(selectObject,targetId,key,value,selectvalue){
	    AjaxControl.getThreeTypeId(selectObject.value,{callback:function(data){
	            if (data != null && typeof data == 'object') 
	            {
	                DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
	                DWRUtil.addOptions(targetId,{000:'--请选择--'});
	                setSelectForBean(targetId,data,key,value,selectvalue);
	            }
	        }
	    });
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
	


    function getTree(product_dept,product_dept_name, basePath, inputType, rootCode, isSubmitAll, returnValueType, treeLevel, dataLimit){

        //树结点的类型，分radio和checkbox两种，默认radio
        if(inputType==null || inputType=="")
            inputType = "radio";

        //控制树的节点是否全带checkbox（radio），yes全带，no只有树的最末尾一层带
        if(isSubmitAll==null || isSubmitAll=="")
            isSubmitAll = "no";

        //返回值是哪个字段，可以选择partyrelation表的id、party_id和code三者之一，默认为code
        if(returnValueType==null || returnValueType=="")
            returnValueType = "party_id";
            
        //参数：控制树能展示到的层次，0 全部，1 公司，2 部门，3 岗位，-3 去除岗位，默认为0
        if(treeLevel == null || treeLevel=="") {
            treeLevel = "0";
        }
        
        //参数：是否控制数据权限,0 否，1 是
        if(dataLimit == null || dataLimit=="") {
            dataLimit = "0";
        }

        var treePath = basePath+"/jsp/authority/tree/treeRef.jsp?inputType="+inputType+"&nodeRelationType=noRelation&rootXmlSource="
                +basePath+"/jsp/authority/tree/orgTree.jsp?parent_code%3D"+rootCode+"%26submit_all%3D"+isSubmitAll+"%26return_type%3D"+returnValueType+"%26tree_level%3D"+treeLevel+"%26data_limit%3D"+dataLimit;
        
        var rtObj = window.showModalDialog(treePath, new Object(),'dialogHeight=600px;dialogWidth=350px;resizable:yes;status:no;scroll:auto;');
        if(rtObj != undefined && rtObj.length > 0){
            var allTextValue = "";
            var allTextName = "";
            for(var i=0; i<rtObj.length-1; i++) {
                allTextValue += rtObj[i]['returnValue'] + ",";
                allTextName += rtObj[i]['childName'] + ",";
            }
            allTextValue += rtObj[rtObj.length-1]['returnValue'];
            allTextName += rtObj[rtObj.length-1]['childName'];
            document.form.product_dept.value=allTextValue;
            document.form.product_dept_name.value=allTextName;
        } 
    }
</script>
</head>
<body>
<form name="form" method="post">
<div id="right">
<script language="javascript">
    if(<%=isModify%>)
        writeTableTopFesco('修改产品','<%=request.getContextPath()%>/');
    else
        writeTableTopFesco('添加产品','<%=request.getContextPath()%>/');
</script>

<div id="ccChild1"     class="box_xinzeng" style="height: 440px"> 
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td width="12%" class="td_1" ><span class="style_required_red">* </span>产品大类</td>
            <td width="19%" class="td_2" >
            <select id="big_type_id" name="big_type_id" onChange="javascript:getAllSmallType(this,'small_type_id','code','name','<%=isModify ? resultVo.getSmall_type_id() : "" %>')">
            <option value="">--请选择--</option>
            </select>            </td>
            <td width="17%" class="td_1" ><span class="style_required_red">* </span>产品小类</td>
            <td width="24%" class="td_2" >
            <select id="small_type_id" onChange="javascript:getAllThreeType(this,'three_type_id','code','name','<%=isModify ? resultVo.getThree_type_id() : "" %>')">
            <option value="">--请选择--</option>
            </select>            </td>
            <td width="12%" class="td_1" >产品三级分类</td>
            <td width="18%" class="td_2" ><select id="three_type_id"><option value="">--请选择--</option></select></td>
        </tr>
        <tr>
          <td class="td_1" ><span class="style_required_red">* </span>产品名称</td>
          <td class="td_2 "><input type="text" class="text_field" name="product_name" inputName="产品名称" value="" maxLength="60" validate="notNull;"/></td>
          <td class="td_1" >产品英文名称</td>
          <td class="td_2 "><input type="text" class="text_field" name="product_en_name" inputName="产品英文名称" value="" maxLength="60" /></td>
          <td class="td_1"></td>
          <td class="td_2 "></td>
        </tr>
        <tr>
        <td class="td_1" ><span class="style_required_red">* </span>是否定方案产品</td>
          <td class="td_2" ><%=RmJspHelper.getSelectField("is_scheme", -1,"TrueOrFalse",isModify ? resultVo.getIs_scheme() : "0","onChange=\"IsScheme()\"",true) %> </td>
          <td class="td_1" >方案类型</td>
          <td class="td_2" ><%=RmJspHelper.getSelectField("scheme_type", -1,"scheme_type",isModify ? resultVo.getScheme_type() : "0"," disabled  onChange=\"SchemeType()\"",false) %>         </td>
          <td class="td_1"></td>
          <td class="td_2 "></td>      
 </tr>
        <tr>
            <td class="td_1" >生效日期</td>
            <td class="td_2">

            <w:date  format="yyyy-MM-dd" name="effect_date" width="188px" property="bean/effect_date" />
            </td>
            <td class="td_1" >失效日期</td>
            <td class="td_2">
            <w:date  format="yyyy-MM-dd" name="lapse_date" width="188px" property="bean/lapse_date" />
            </td>
            <td class="td_1" >收费频率(财务外包)</td>
            <td class="td_2" ><%=RmJspHelper.getSelectField("charging_frequency", -1,"FINOUT_PRODUCT_TYPE",isModify ? resultVo.getCharging_frequency() : "0","",false) %></td>
        </tr>
        <tr>
            <td  class="td_1" ><span class="style_required_red">* </span>标准成本</td>
            <td  class="td_2" >
            <input type="text" class="text_field" name="product_cost" inputName="标准成本" maxLength="10" integerDigits="18" decimalDigits="2" onkeyup="if(isNaN(value))execCommand('undo')" validate="notNull;"/>            
           <h:hidden name="product_cost_old" value="${bean.product_cost}"/>
            </td>
            <td  class="td_1" ><span class="style_required_red">* </span>标准价格</td>
            <td  class="td_2" >
                <input type="text" class="text_field" name="product_price" inputName="标准价格" maxLength="10"  decimalDigits="2"  onkeyup="if(isNaN(value))execCommand('undo')" validate="notNull;"/>          
                <h:hidden name="product_price_old" value="${bean.product_price}"/>
                </td>
            <td class="td_1" >是否按天计算</td>
            <td class="td_2" ><%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_calculate_per_day", -1,"TrueOrFalse",isModify ? resultVo.getIs_calculate_per_day() : "0","",false) %>           </td>
        </tr>
        <tr>
            <td class="td_1" >是否一次性付款</td>
            <td class="td_2" ><%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_payall", -1,"TrueOrFalse",isModify ? resultVo.getIs_payall() : "0","",false) %></td>
            <td class="td_1" >入职时是否可修改</td>
            <td class="td_2" ><%=gap.rm.tools.helper.RmJspHelper.getSelectField("onpost_input", -1,"TrueOrFalse",isModify ? resultVo.getOnpost_input() : "0","",false) %>           </td>
            <td  class="td_1" >产品供应商名称</td>
            <td  class="td_2" >
            <input type="text" class="text_field_reference_readonly" validators="isSearch" name="product_supplier_name" inputName="产品供应商名称"  maxLength="10" value="<%=(isModify ? (resultVo.getProduct_supplier()!=null&&resultVo.getProduct_supplier()!="") ? agentaction.getAgentNameByID(resultVo.getProduct_supplier().toString()) : "北京外企德科人力资源服务上海有限公司" : "北京外企德科人力资源服务上海有限公司")%>"/><input type="hidden" name="product_supplier" value="1099120100000000439"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getSupplierList();"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" >是否可补收</td>
            <td class="td_2" ><%=gap.rm.tools.helper.RmJspHelper.getSelectField("is_subpay", -1,"TrueOrFalse",isModify ? resultVo.getIs_subpay() : "0","",false) %>          </td>
            <td class="td_1" ><span class="style_required_red">* </span>产品所属部门</td>
            <td class="td_2" >
            <input type="text" class="text_field_reference_readonly" validators="isSearch" name="product_dept_name" inputName="产品所属部门"  maxLength="10" value="<%=(isModify ? (resultVo.getProduct_dept()!=null&&resultVo.getProduct_dept()!="")  ? OrgHelper.getPartyVoByID(resultVo.getProduct_dept().toString()).getName() : "" : "" )%>"/><input type="hidden" name="product_dept" value="${bean.product_dept}"/><img class="refButtonClass" src="<venus:base/>/images/au/09.gif" onClick="javascript:getTree('product_dept', 'product_dept_name','<venus:base/>','radio','','','','2','');"/> 
            </td>
           <td class="td_1" >是否可报销</td>
            <td class="td_2" ><%=RmJspHelper.getSelectField("is_reimbursement", -1,"TrueOrFalse",isModify ? resultVo.getIs_reimbursement() : "0","",false) %></td>
        </tr>
        <tr id="tr1" style="display:none">
            <td class="td_1" >发放频率</td>
            <td class="td_2 ">
            <%//=gap.rm.tools.helper.RmJspHelper.getSelectField("grant_frequency", -1,"GRANT_FREQUENCY",isModify ? resultVo.getGrant_frequency().toString() : "1","",false) %>            
            <d:select dictTypeId="GRANT_FREQUENCY" value="${bean.grant_frequency}" nullLabel="--请选择--"></d:select>
            </td>
            <td  class="td_1" >发放张数</td>
            <td  class="td_2" ><input type="text" class="text_field" name="grant_counts" inputName="发放张数" maxLength="19" integerDigits="18" decimalDigits="0" />            </td>
            <td class="td_2" ></td>
            <td class="td_2" ></td>
        </tr>
		<tr>
            <td class="td_1" >财务汇总科目</td>
            <td class="td_2 ">
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("fin_big_subjects_bd", -1,"FIN_BIG_SUBJECTS_BD",isModify ? resultVo.getFin_big_subjects_bd() : "1","",false) %>            </td>
            <td  class="td_1" >财务明细科目</td>
            <td  class="td_2" >
            <%=gap.rm.tools.helper.RmJspHelper.getSelectField("fin_small_subjects_bd", -1,"FIN_SUBJECTS_BD",isModify ? resultVo.getFin_small_subjects_bd() : "1","",false) %>    
            </td>
            <td class="td_1" >排序</td>
            <td class="td_2" ><input type="text" class="text_field" name="sirial_no" inputName="排序" maxLength="9" integerDigits="18" decimalDigits="0" /> </td>
        </tr>
        <tr>
          <td class="td_1">产品简单描述</td>
          <td colspan="5" class="td_2" ><span class="td_2 ">
            <textarea name="product_simple_desc" rows="3" class="xText_d" id="text22" style="width:98%;color: black;"></textarea>
          </span></td>
          </tr>
        <tr>
            <td class="td_1">产品详细描述</td>
            <td colspan="5" class="td_2" ><span class="td_2 ">
               <textarea name="product_detail_desc" rows="3" class="xText_d" id="text22" style="width:98%;color: black;"></textarea>
            </span>&nbsp;            <!--赔付比例-->&nbsp;            <!-- <input type="text" class="text_field" name="compensation_proportion" inputName="赔付比例" value="" maxLength="10" />  -->           </td>
            </tr>
    </table>
    
    
       <div class="button_right" style="display:none" id="div3" style="margin-top:15px;">
             <table  width="100%" cellspacing="0"  class="datagrid1" border="0">
	        <tr>
	            <td width="12%" align="right">附件上传:</td>
	            <td width="20%" align="left">
	                 <input type="text" id="attachNameInput" class="text_field_reference_readonly" name="attach_name" inputName="附件地址" value="<%=gap.rm.tools.helper.RmStringHelper.prt(attachName)%>" hiddenInputId="attach_name"/><img class="refButtonClass" src="<%=request.getContextPath()%>/images/icon/reference.gif" onClick="javascript:UploadFileWindow();"/>
	                <input type="hidden" id="attackAddressInput" name="attach_address" value="<%=gap.rm.tools.helper.RmStringHelper.prt(attachAddress)%>">
	            </td>
	            <td width="60%" align="left"  style="margin-left:5px;"><% if(isModify&&avo!=null)out.print("<a href='"+request.getContextPath()+"/ProductAction.do?cmd=downLoad&attachment_id="+avo.getId()+"'><font color=blue>"+avo.getAttachment_file_name()+"</font></a>");%>&nbsp;</td>
	        </tr>
	        </table>
       </div>
    
      <div class="button_right" style="display:none" id="div1" style="margin-top:15px;">
        <ul>
          <li class="g_1"><a onClick="javascript:getWindowList();" >选择产品</a></li>
          <li class="d" style="display:none" id="del" ><a onClick="javascript:remove();" >删除</a></li>
        </ul>
      </div>
      <div class="clear"></div>
      <div class="box_xinzeng_table" style="display:none" id="div2" >
      <table  id="tab" width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th><input type="checkbox" name="checkbox_template" value="checkbox" onClick="checkAllList_onClick(this);"></th>
          <!--<th>序号</th>-->
          <th>产品名称</th>
          <th>产品大类</th>
          <th>产品小类</th>
          <th>产品三级分类</th>
        </tr>
        <%
        if(isModify)
                if(request.getAttribute("sublist") != null) {  //如果request中取出的bean不为空
                 List list = (List)request.getAttribute("sublist");  //从request中取出vo, 赋值给resultVo
                for(int i=0;i<list.size();i++){
                    ProductVo pvo=(ProductVo)list.get(i);
                {%>
          <tr id="tr<%=pvo.getId()%>">
          <td><input type="checkbox" name="checkbox_template" value="<%=pvo.getId()%>"></td>
          <input type="hidden" name="trid" value="<%=pvo.getId()%>">
          <td >&nbsp;<%=pvo.getProduct_name()%></td>
          <td>&nbsp;<%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(pvo.getBig_type_id()))%></td>
          <td>&nbsp;<%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(pvo.getSmall_type_id()))%></td>
          <td>&nbsp;<%=BaseDataHelper.getNameByCode("big_type_id",String.valueOf(pvo.getThree_type_id()))%></td>
        </tr>
        <%}}} %>

      </table>
    
    
    </div>
    <div class="mx_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
      </div>
</div>         
<input type="hidden" name="id" value="">
<input type="hidden" name="create_date" />
</form>
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
//页面加载后产品大类下拉框填充
getAllBigType(document.form.big_type_id,'code','name','<%= isModify ? resultVo.getBig_type_id() : "" %>');
function displaydiv(){
		<%
		if(isModify){
		            //判断是否有子表信息
				    //if(request.getAttribute("sublist") != null) {  //如果request中取出的bean不为空
					     //List list = (List)request.getAttribute("sublist");  
							    //if(list.size()>0){
							        if(resultVo.getScheme_type()!=null&&resultVo.getScheme_type().equals("1")){
							    %>
							    document.getElementById("div1").style.display='';
							    document.getElementById("div2").style.display='';
							    document.getElementById("del").style.display='';
							 <%}
				    //}
				    //判断是否有附件
			       //if(request.getAttribute("AttachmentfileVo") != null) {  //如果request中取出的bean不为空
			         if(resultVo.getScheme_type()!=null&&resultVo.getScheme_type().equals("2")){
					   %>
					   document.getElementById("div3").style.display='';
					   <% 
				    }
			       //判断方案类型是否可用
				   if(resultVo!=null&&resultVo.getScheme_type()==null){
					     %>
					    document.form.scheme_type.disabled=true;
						<%
				   }else{
				       %>
				       document.form.scheme_type.disabled=false;;
				   <% }
		}%>
}
<%
if(isModify){
%>
displaydiv();
<%}%>
</script>
