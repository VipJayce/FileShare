<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ taglib uri="http://taglib.gapext.com/tags/richweb" prefix="r"%>
<%@ taglib uri="http://taglib.gapext.com/tags/webcomp" prefix="w"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>
<fmt:bundle basename="rayoo.salse.pbcustomerservice.pbcustomerservice_resource" prefix="rayoo.salse.pbcustomerservice.">
<script language="javascript">		
	function submitit(){
		var manager =  parent.document.getElementById("manager").value;
		if(manager == 1){
			alert("<fmt:message key="choose_tree_person"/>");
			return;
		}
        var myAjax = new Ajax("/FAERP/PbcustomerserviceAction.do?cmd=userScopeSubmit&manager=" + manager);     
 		var treeObj = $id("rightTree");
 		treeObj.createHiddenData(false);
 		var funcsize = '<b:size property="TreeObj"/>';
 		for( var i = 1 ; i <= funcsize; i++ ) {
 		    if( $name("TreeObj[" + i + "]/partyid" ) != null ) {	
 		    	//alert( $name("TreeObj[" + i + "]/partyid" ).value);   	        
 		        myAjax.addParam("TreeObj[" + i + "]/id", $name("TreeObj[" + i + "]/partyid" ).value);
 		        //return;
 		    }	    
 		}
    	//myAjax.addParam("TreeObj[0]/id", manager);

 		myAjax.submit();    
 		
 		//调运业务逻辑后的返回值
 		
        if( myAjax.getValue("root/data/returnValue") == 1 )
            alert( '<fmt:message key="save_success"/>' );  <!--  保存成功 -->
        else {
            alert( '<fmt:message key="save_false"/>' );         <!-- 保存失败 -->
        }
       
}

</script>
</head>
<body  topmargin=0 leftmargin=0 ><!-- background="image/txl_tree_bg.jpg"  -->
<input type="hidden" value="" name="" id='ddd'>
 <table width="95%"  height="460"  border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#7EBAFF" >
 		<tr>
 			<td bgcolor="#FFFFFF" valign="top"><input type="button" class="foot_icon_1"
				value="<fmt:message key="save"/>" onclick="submitit();" />
		  	<w:tree id="rightTree" hasCheckBox="true" checkBoxType="associated" >
		  	 	<w:treeRoot display="公司" />
			  	<w:treeNode nodeType="TreeObj" showField="name" xpath="TreeObj">
	                <w:treeRelation parentNodeType="root" field="parent_partyid" value="1099100700000000004" />
	                <w:treeRelation field="parent_partyid" parentField="partyid" parentNodeType="TreeObj"/>
				    <w:treeCheckbox field="partyid" checkedXpath="PersonObj" checkedField="partyid"/>
	            </w:treeNode>
		  	</w:tree>
          </td>
        </tr>
      </table>

</body>
</html>

</fmt:bundle> 