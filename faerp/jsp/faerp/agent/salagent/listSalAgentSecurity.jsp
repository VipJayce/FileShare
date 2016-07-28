<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>添加社保公积金产品</title>
    <script language="javascript">
    function findSelections(checkboxName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    
    function checkpageproduct(obj)
    {
          var addids="";
        var chid1 = document.getElementsByName("checkbox_template1");
        var ids = obj; 
       
        for(var i = 0;i<ids.length;i++)
        { 
            var istrue='false';
            for(var j=0;j<chid1.length;j++)
            {
                var entity=$id("datacell1").dataset.get(j);   
                if(entity.getProperty("security_id")==(ids+",").split(",")[i])
                {
                   istrue="true";
                   alert(entity.getProperty("product_name")+"已经在列表中，请确认与列表中没有重复的才能添加！");
                   return;
                }
                else
                {
                     istrue="false";                       
                }
             }
               if(istrue=='false')
               {
                    addids+=(ids+",").split(",")[i]+",";
               }
        }
        var returnAry = new Array();
        returnAry[0]=addids;
        return returnAry;
    }
    
        function toaddProductlistrollback(obj)
    {
       
       var ids=checkpageproduct(obj);

       if(ids==undefined){
       return;
       }
     
        if(ids[0]!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/SecurityproductAction.do?cmd=SimpleProductByIDS&date="+new Date()+"",{"ids":ids[0]},   function(json){
                        
          
              if(json.beans!=null&&json.beans!="")
              {
              
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("security_id", json.beans[i].id);
                       newEntity.setProperty("city_id", json.beans[i].city_id);
                       newEntity.setProperty("product_id", json.beans[i].product_id);
                       newEntity.setProperty("product_name", json.beans[i].product_name);
                       newEntity.setProperty("e_ratio", json.beans[i].e_ratio);
              
                        newEntity.setProperty("p_ratio", json.beans[i].p_ratio);
                       newEntity.setProperty("e_add_ratio", json.beans[i].e_add_ratio);
                       newEntity.setProperty("p_add_ratio", json.beans[i].p_add_ratio);        
                       newEntity.setProperty("charge_frequency_bd", json.beans[i].charge_frequency_bd);
                         newEntity.setProperty("is_outstrip_limit_bd", json.beans[i].is_outstrip_limit_bd);
                       newEntity.setProperty("remark", json.beans[i].remark);
                             $id("datacell1").addRow(newEntity);
                     $id("datacell1").activeField.editor.hideEditor();   
                }
              }
              });
        }
        }
    function toAddProduct_onClick1(){
        var agentId = document.getElementById("agentId").value;
        jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/SalagentAction.do?cmd=checkAgentIsUse&agentId="+agentId,
            dataType : "html",
            success : function(data) {
                if (data > 0 ){
                    alert("当前供应商已引用，无法添加或删除操作");
                    return;
                }else{
			        var city_id=document.getElementById("cityid").value;
			        var url="<%=request.getContextPath()%>/jsp/faerp/system/securityproduct/allsecurityproduct.jsp?type=1&city_id="+city_id;
			        showModalCenter(url, window,toaddProductlistrollback,750,465,"添加社保产品");
			    }
            }
        });
    }

          function setCheckboxStatus1(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template1'  value ="+value+" >";
    }
      function deleteMultiProduct_onClick(){
        var agentId = document.getElementById("agentId").value;
        jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/SalagentAction.do?cmd=checkAgentIsUse&agentId="+agentId,
            dataType : "html",
            success : function(data) {
                if (data > 0 ){
                    alert("当前供应商已引用，无法添加或删除操作");
                    return;
                }else{
		             var ids= findSelections("checkbox_template1");  //取得多选框的选择项      
		                  if(ids == null) {  //如果ids为空
		           alert('请至少选择一个产品！');
		           return;
		       }
		  
		       if(confirm('确定要删除所选的产品吗？')) {  //如果用户在确认对话框按"确定"
		               var datacell = $id("datacell1");         
		                     var elementCheckbox = document.getElementsByName("checkbox_template1");
		                       for (var i = elementCheckbox.length - 1; i >= 0; i--) {     
		                if (elementCheckbox[i].checked) { // 如果被选中        
		                   datacell.deleteRow(i);    
		            }
		        }
		       }  
                }
            }
        });
    }
    
    function deleteAllProduct_onClick(type){
        var agentId = document.getElementById("agentId").value;
        
        if(confirm('确定要删除所有的产品吗？')) {  //如果用户在确认对话框按"确定"
	        jQuery.ajax({
	            type : "post",
	            url : "<%=request.getContextPath()%>/AgentsecurityproductAction.do?cmd=deleteAllProductData&type="+type+"&agentId="+agentId,
	            dataType : "html",
	            success : function(data) {
	                if (data > 0 ){
	                    alert("当前供应商已引用，无法添加或删除操作");
	                    return;
	                }else{
	                    alert('删除成功');
	                    if(type=='1'){
	                        $id("datacell1").loadData();
                            $id("datacell1").refresh();
                        }else{
                            $id("datacell2").loadData();
                            $id("datacell2").refresh();
                        }
	                }
	            }
	       });
	       
	    }
    }
    
    function toSaveProduct_onClick(){
            $id("datacell1").isModefied = true;   
           if( $id("datacell1").submit()){
              alert("保存成功!");
            $id("datacell1").loadData();
            $id("datacell1").refresh();
            }
    }
     function checkpageproduct2(obj)
    {
          var addids="";
        var chid1 = document.getElementsByName("checkbox_template2");
        var ids = obj; 
       
        for(var i = 0;i<ids.length;i++)
        { 
            var istrue='false';
            for(var j=0;j<chid1.length;j++)
            {
                var entity=$id("datacell2").dataset.get(j);   
                if(entity.getProperty("security_id")==(ids+",").split(",")[i])
                {
                   istrue="true";
                   alert(entity.getProperty("product_name")+"已经在列表中，请确认与列表中没有重复的才能添加！");
                   return;
                }
                else
                {
                     istrue="false";                       
                }
             }
               if(istrue=='false')
               {
                    addids+=(ids+",").split(",")[i]+",";
               }
        }
        var returnAry = new Array();
        returnAry[0]=addids;
        return returnAry;
    }
    
        function toaddProductlistrollback2(obj)
    {
       
       var ids=checkpageproduct2(obj);

       if(ids==undefined){
       return;
       }
     
        if(ids[0]!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/SecurityproductAction.do?cmd=SimpleProductByIDS&date="+new Date()+"",{"ids":ids[0]},   function(json){
                        
          
              if(json.beans!=null&&json.beans!="")
              {
              
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell2").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("security_id", json.beans[i].id);
                       newEntity.setProperty("city_id", json.beans[i].city_id);
                       newEntity.setProperty("product_id", json.beans[i].product_id);
                       newEntity.setProperty("product_name", json.beans[i].product_name);
                       newEntity.setProperty("e_ratio", json.beans[i].e_ratio);
              
                        newEntity.setProperty("p_ratio", json.beans[i].p_ratio);
                       newEntity.setProperty("e_add_ratio", json.beans[i].e_add_ratio);
                       newEntity.setProperty("p_add_ratio", json.beans[i].p_add_ratio);        
                       newEntity.setProperty("charge_frequency_bd", json.beans[i].charge_frequency_bd);
                         newEntity.setProperty("is_outstrip_limit_bd", json.beans[i].is_outstrip_limit_bd);
                       newEntity.setProperty("remark", json.beans[i].remark);
                             $id("datacell2").addRow(newEntity);
                     $id("datacell2").activeField.editor.hideEditor();   
                }
              }
              });
        }
        }
    function toAddProduct_onClick2(){
    var city_id=document.getElementById("cityid").value;
            var url="<%=request.getContextPath()%>/jsp/faerp/system/securityproduct/allsecurityproduct.jsp?type=2&city_id="+city_id;
          
             showModalCenter(url, window,toaddProductlistrollback2,750,465,"添加公积金产品");
    }

          function setCheckboxStatus2(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template2'  value ="+value+" >";
    }
      function deleteMultiProduct_onClick2(){
        var agentId = document.getElementById("agentId").value;
        jQuery.ajax({
            type : "post",
            url : "<%=request.getContextPath()%>/SalagentAction.do?cmd=checkAgentIsUse&agentId="+agentId,
            dataType : "html",
            success : function(data) {
                if (data > 0 ){
                    alert("当前供应商已引用，无法添加或删除操作");
                    return;
                }else{
		             var ids= findSelections("checkbox_template2");  //取得多选框的选择项      
		                  if(ids == null) {  //如果ids为空
		           alert('请至少选择一个产品！');
		           return;
		       }
		  
		       if(confirm('确定要删除所选的产品吗？')) {  //如果用户在确认对话框按"确定"
		               var datacell = $id("datacell2");         
		                     var elementCheckbox = document.getElementsByName("checkbox_template2");
		                       for (var i = elementCheckbox.length - 1; i >= 0; i--) {     
		                if (elementCheckbox[i].checked) { // 如果被选中        
		                   datacell.deleteRow(i);    
		            }
		        }
		       }  
                }
            }
        });
    }
    function toSaveProduct_onClick2(){
            $id("datacell2").isModefied = true;   
           if( $id("datacell2").submit()){
              alert("保存成功!");
            $id("datacell2").loadData();
            $id("datacell2").refresh();
            }
    }
   function save_onClick(){
      $id("datacell1").isModefied = true;
                $id("datacell2").isModefied = true;
                if($id("datacell2").submit()&&$id("datacell1").submit()){
                        alert("保存成功！");
                        window.close();
                    }
                    }
</script>

	</head>
	<body>

	<form name="form" method="post" id="datacell_formid">
	<input type="hidden" name="cmd" value="queryAll">
	<input type="hidden" id="agentId" name="agentId" value="${bean.id }">
		  <input type="hidden" id="cityid" name="cityid" value="${bean.city_id }">
    <div id="right">
	<div class="ringht_s">
	<div id="ccParent1" class="button">
	<div class="xz_title" style="padding-top: 10px">社保配置</div>
<div class="button_right">
	    <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAddProduct_onClick1();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"   onClick="deleteMultiProduct_onClick();">
	    <input class="d" type="button"   value="全部删除"   onClick="deleteAllProduct_onClick('1');">
	<input class="bc"  type="button" style="padding-left:1px"  value="<fmt:message key="save"/>"    onClick="toSaveProduct_onClick();">
	</div>
	<div class="clear"></div>
	</div>
	<div style="padding: 8 10 8 8;">
	<r:datacell  id="datacell1"      
        queryAction="/FAERP/AgentsecurityproductAction.do?cmd=queryProductData&type=1"
        submitAction="/FAERP/AgentsecurityproductAction.do?cmd=updateSecurityProduct"
        width="98%" height="190px" xpath="AgentsecurityproductVo"
        submitXpath="AgentsecurityproductVo" 
         paramFormId="datacell_formid" readonly="false" pageSize="-1">
    <r:toolbar location="bottom" tools="nav,pagesize,info" />
          <r:field fieldName="security_id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus1"  align="center" ></r:field>
    <r:field fieldName="city_id" label="城市" width="80px" allowModify="false">
            <r:comboSelect id="countryList" name="city_id1"
                queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name"
                valueField="id" xpath="PB_CITYVo" width="150px" nullText="请选择"  disabled="true"/>
        </r:field>         
        <r:field fieldName="product_id" width="100px" label="社保公积金产品" allowModify="false">
            <r:comboSelect id="product_id1" name="product_id1"
                       queryAction="/FAERP/ProductAction.do?cmd=getListData&big_type_id=999"
                       textField="product_name"
                       valueField="id"
                       xpath="ProductVo"
                       width="200px"
                       nullText="请选择" disabled="true"/>
        </r:field>
        <r:field fieldName="product_name" label="社保产品比例名称" width="150px" allowModify="false">
         
        </r:field>
        <r:field fieldName="e_ratio" label="公司比例" width="120px" allowModify="false" >  
        </r:field>
              <r:field fieldName="p_ratio" label="个人比例" width="120px" allowModify="false" >  
        </r:field>
          <r:field fieldName="e_add_ratio" label="公司附加金额" width="120px" allowModify="false">  
        </r:field>
         <r:field fieldName="p_add_ratio" label="个人附加金额" width="120px" allowModify="false" > 
        </r:field>
      
        <r:field fieldName="charge_frequency_bd" label="收费频率" width="80px" allowModify="false">
            <d:select dictTypeId="CHARGE_FREQUENCY_BD" disabled="true"/>
        </r:field>
    <r:field fieldName="is_outstrip_limit_bd" label="是否超上下限" allowModify="false">
            <d:select dictTypeId="TrueOrFalse" disabled="true" />
        </r:field>
      <r:field fieldName="remark" label="备注" allowModify="false">
        </r:field>
        
    </r:datacell></div>
    
 <div id="ccParent1" class="button">
    <div class="xz_title">公积金配置</div>
    <div class="button_right">
    <ul>
         <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAddProduct_onClick2();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMultiProduct_onClick2();">
        <input class="d" type="button"   value="全部删除"   onClick="deleteAllProduct_onClick('2');">
    <input class="bc"  type="button" style="padding-left:1px"  value="<fmt:message key="save"/>"    onClick="toSaveProduct_onClick2();">
     </ul>
    </div>
    <div class="clear"></div>
    </div>
    <div style="padding: 8 10 8 8;">
 <r:datacell  id="datacell2"      
        queryAction="/FAERP/AgentsecurityproductAction.do?cmd=queryProductData&type=2"
        submitAction="/FAERP/AgentsecurityproductAction.do?cmd=updateSecurityProduct"
        width="98%" height="190px" xpath="AgentsecurityproductVo"
        submitXpath="AgentsecurityproductVo" 
         paramFormId="datacell_formid" readonly="false"  pageSize="-1">
    <r:toolbar location="bottom" tools="nav,pagesize,info" />
          <r:field fieldName="security_id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus2"  align="center" ></r:field>
    <r:field fieldName="city_id" label="城市" width="80px"  allowModify="false">
            <r:comboSelect id="countryList2" name="city_id2"
                queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name"
                valueField="id" xpath="PB_CITYVo" width="150px" nullText="请选择" disabled="true"/>
        </r:field>         
        <r:field fieldName="product_id" width="100px" label="社保公积金产品" allowModify="false">
            <r:comboSelect id="product_id2" name="product_id2"
                       queryAction="/FAERP/ProductAction.do?cmd=getListData&big_type_id=999"
                       textField="product_name"
                       valueField="id"
                       xpath="ProductVo"
                       width="200px"
                       nullText="请选择" disabled="true" />
        </r:field>
        <r:field fieldName="product_name" label="社保产品比例名称" width="150px" allowModify="false">
         
        </r:field>
        <r:field fieldName="e_ratio" label="公司比例" width="120px" allowModify="false" >  
        </r:field>
              <r:field fieldName="p_ratio" label="个人比例" width="120px" allowModify="false" >  
        </r:field>
          <r:field fieldName="e_add_ratio" label="公司附加金额" width="120px" allowModify="false">  
        </r:field>
         <r:field fieldName="p_add_ratio" label="个人附加金额" width="120px" allowModify="false" >  
        </r:field>
      
        <r:field fieldName="charge_frequency_bd" label="收费频率" width="80px" allowModify="false">
            <d:select dictTypeId="CHARGE_FREQUENCY_BD" disabled="true"/>
        </r:field>
    <r:field fieldName="is_outstrip_limit_bd" label="是否超上下限" allowModify="false">
            <d:select dictTypeId="TrueOrFalse" disabled="true"/>
        </r:field>
      <r:field fieldName="remark" label="备注" allowModify="false">
        </r:field>   
    </r:datacell>
    </div>
    
   <div class="mx_button" style="text-align: center;padding-top:5px;">
        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick();" />
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:window.close();"/>
        </div> 
	</div>
	</div>
	</form>

</fmt:bundle>
</body>
</html>


