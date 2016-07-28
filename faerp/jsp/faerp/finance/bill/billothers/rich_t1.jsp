<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.3.min.js"></script>


<%@page pageEncoding="UTF-8"%>

<html>

	<head>

		<style>

		</style>
		<script>
		var $j = jQuery.noConflict();

		
		function reLoadIt(){
				
			//alert($id("bilotherlist2"));
			//alert(dataset1.dataset.get(0).getProperty("id"));
		}
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
	</head>		
	</head>
	<body>
	<input type="button" onClick="doSomething('3');">
	<div id="test1" style="">
	<h:form checkType="blur">

	<h:text name="dd" id="dd" validateAttr="allowNull=false" />
	<input id="parentId" name="parentId" value="5" type="hidden"/>
	
	<input type="submit"/>
	
 </h:form>
	<input id="dd" name="dd" type="button" onclick="reLoadIt();" value="refresh it">


    <r:datacell id="bilotherlist" 
            queryAction="#"
            submitAction="server_s3.jsp"
            xpath="out1"
            submitXpath="out1" 
            width="1200"
            
             paramFormId="test2" pageSize="-1"
             
        >
     <r:toolbar location="bottom" tools="edit,pagesize,info"/>
            <r:field fieldName="personid" label="部门名称" sortAt="server" width="150">
				<h:text/>
             </r:field>
             
             <r:field fieldName="typeid_11_city" label="城市"  width="50">
		<h:text/>
             </r:field>
             <r:field fieldName="typeid_11_base" label="基数"  width="50">
		<h:text/>
             </r:field>
             <r:field fieldName="typeid_11_amount" label="金额"  width="50">
             </r:field>
             <r:field fieldName="typeid_12_city" label="城市"  width="50">
		<h:text/>
             </r:field>
             <r:field fieldName="typeid_12_base" label="基数"  width="50">
		<h:text/>
             </r:field>
             <r:field fieldName="typeid_12_amount" label="金额"  width="50">
             </r:field>
             
             <r:field fieldName="typeid5" label="企业金额精度方法5"  width="250">
<h:text/>
             </r:field>
             <r:field fieldName="typeid5" label="企业金额精度方法5"  width="250">
<h:text/>
             </r:field>
             <r:field fieldName="typeid5" label="企业金额精度方法5"  width="250">
<h:text/>
             </r:field>
                <r:field fieldName="typeid5" label="企业金额精度方法5"  width="250">
<h:text/>
             </r:field>
               
        </r:datacell>
  
</body>
</html>
<script>
	var isMasked = 0;


	$id("bilotherlist").beforeLoadData = function(){
		return false;
	}
	//加载数据

	var ds1 = new Dataset("out1");
	for(var i=0; i<10; i++){
		var ent1 = new Entity("entity");
		ent1.setProperty("personid", "v" + i);
		//alert(i);
		ds1.addEntity(ent1,true);
	}
	
	$id("bilotherlist").dataset = ds1;
	$id("bilotherlist").headHeight = 23+23;
	Me = $id("bilotherlist");
		Me.init();
		Me.loadData();
		Me.refresh();

	//$id("bilotherlist").refresh();
	
	
	$j(document).ready(function(){
	   //所有的TD的背景图片换成box_title_bg_h46.gif
        var a0 = $j(".eos-hd-row td[class='eos-dc-col-bilotherlist-0']");
        a0.css("background","url('/FAERP/images/fesco/box_title_bg_h46.gif') repeat-x scroll 0 0 transparent");
	   
	
		//alert(isIE);		
		var a1 = $j(".eos-hd-row td[class='eos-dc-col-bilotherlist-1']").clone();
		var a2 = $j(".eos-hd-row td[class='eos-dc-col-bilotherlist-2']").clone();
		var a3 = $j(".eos-hd-row td[class='eos-dc-col-bilotherlist-3']").clone();
		a1.css("height", "23");
		a2.css("height", "23");
		a3.css("height", "23");
		$j(".eos-hd-row td[class='eos-dc-col-bilotherlist-1']").remove();
		$j(".eos-hd-row td[class='eos-dc-col-bilotherlist-2']").remove();
		$j(".eos-hd-row td[class='eos-dc-col-bilotherlist-3']").remove();
		//alert(a1.html());
		var newTable = $j("<td class='eos-dc-col-bilotherlist-0' style='text-align: left; height: 46px;'><table id='dddd'  border='0' cellpadding='0' cellspacing='0' style='border:0px;margin:0px;padding:0px'><tr><td colspan='3' style='text-align:center;height:23px;'> <span style=''>测试分组</span> </td><tr class='oldHeadTr'><td  class='oldHeadTd'></td></tr></table></td>");
		newTable.find(".oldHeadTd").remove();
		newTable.find(".oldHeadTr").append(a1).append(a2).append(a3);	
		//alert($j(".eos-hd-row td[class='eos-dc-col-bilotherlist-0']").html());	
		//alert($j(".eos-hd-row").append(newTable));
		$j(".eos-hd-row td[class='eos-dc-col-bilotherlist-0']").after(newTable)

	});
	

</script>

