<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="test.Person" %>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>


<%@page pageEncoding="UTF-8"%>

<html>

	<head>
		<title>Title</title>
	</head>

<%

	Person a = new Person();
	a.setId("1");
	a.setName("1name");
	a.setParentId("0");	
	Person b = new Person();
	b.setId("2");
	b.setName("2name");
	b.setParentId("1");
	Person c = new Person();
	c.setId("3");
	c.setName("3name");
	c.setParentId("1");
	List pos = new ArrayList();
	pos.add(a);
	pos.add(b);
	pos.add(c);

	Person d = new Person();
	d.setId("3");
	d.setName("3name");
	List poschecked = new ArrayList();
	poschecked.add(d);	
	
	Person d2 = new Person();
	d2.setId("2");
	d2.setName("2name");
	List poschecked2 = new ArrayList();
	poschecked2.add(d2);

	List poschecked3 = new ArrayList();
	poschecked3.add(poschecked);
	//poschecked3.add(poschecked2);

	request.setAttribute("pos", pos);
	request.setAttribute("poschecked", poschecked3);
 %>
	<body>

		<script>

function getParam()

{
	return "<queryOrg><orgid>0</orgid></queryOrg>"
}
function submitit(){
        var myAjax = new Ajax("server_s4_new.jsp");     
 		var treeObj = $id("comp");
 		treeObj.createHiddenData();
 		var funcsize = '<b:size property="pos"/>';
 		//alert(funcsize);
 		for( var i = 1 ; i <=funcsize; i++ ) {
 		    if( $name("pos2[" + i + "]/id" ) != null ) {		        
 		        myAjax.addParam("pos2[" + i + "]/id", $name("pos2[" + i + "]/id" ).value);

 		    }	    
 		}
    	myAjax.addParam("acRole/roleid", "im");

 		myAjax.submit();    
 		
 		//调运业务逻辑后的返回值
 		var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
            if( myAjax.getValue("root/data/retCode") == 1 )
                alert( 's' );  <!--  保存成功 -->
            else {
                alert( 'f' );         <!-- 保存失败 -->
            }
        } else {
            alert( 'f' );         <!-- 保存失败 -->
        }
}
</script>

 
 <input type="button" name="submit" onclick="submitit();" >
        <w:tree id="comp" hasRoot="false"  hasCheckBox="true" checkBoxType="associated" >
            <w:treeRoot display="dd" />
            <w:treeNode nodeType="pos2" showField="name" xpath="pos">
                <w:treeRelation parentNodeType="root" field="parentId" value="0" />
                <w:treeRelation field="parentId" parentField="id" parentNodeType="pos2"/>
			    <w:treeCheckbox field="id" checkedXpath="poschecked" checkedField="__entry/id"/>
            </w:treeNode>

        </w:tree>


	</body>

</html>

