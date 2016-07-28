<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Datacell</title>
	<script language="javascript">
	    function select_onClick(){
      var ids = findSelections("checkbox_template","id");
        if(ids.length == 0){
            alert("请至少选择一条记录!");
            return;
        }
        window.returnValue=ids;
        window.close();
}

//增加所有
function selectAll_onClick(){
      var type = document.getElementById("type").value;
      var city_id = document.getElementById("city_id").value;
      var product_id = document.getElementById("product_id").value;
      jQuery.getJSON("<%=request.getContextPath()%>/AgentsecurityproductAction.do?cmd=findAllProductData&date="+new Date()+"",{"type":type,"city_id":city_id,"product_id":product_id},  function(json){
            for(var i = 0; i < json.saia.length; i++){
                var number = 0;  //定义游标
                var ids = null;  //定义id值的数组
                for(var i = 0; i < json.saia.length; i++){
		            if(json.saia[i].id!=null){
		                number += 1;  //游标加1
		                if(ids == null) {
		                    ids = new Array(0);
		                }
		                //alert(json.saia[i].id);
		                ids.push(json.saia[i].id);
		            }
		        }
		        window.returnValue=ids;
                window.close();
           }
       });
            
        
}

 function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
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
 function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template'  value=" + entity.getProperty("id") + " />";
     }
         function showListData(){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }
</script>
	</head>
	<body>
	<form name="form" method="post" id="datacell_formid">
     <div id="right">
	<div class="ringht_s">

	<div id="ccChild0" class="search">
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
          <td width="140" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          </tr>
          <tr>
          <input type="hidden" id="type" name="type" value="${param.type}"/>
            <td  align="right">省市</td>
            <td  align="left">
             <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                     value="${param.city_id}"
                       nullText="请选择" />
            </td>
            
            <c:if test="${param.type=='1'}">
            <td  align="right">社保产品</td>
             </c:if>
                <c:if test="${param.type=='2'}">
            <td  align="right">公积金产品</td>
             </c:if>
            <td  align="left">
            <r:comboSelect id="product_id" name="product_id"
                       queryAction="/FAERP/ProductAction.do?cmd=getListSecurityData&big_type_id=999&type=${param.type}"
                       textField="product_name"
                       valueField="id"
                       xpath="ProductVo"
                       width="200px"
                       property="param/city_id"
                       nullText="请选择" />
            </td>
        
            </tr>
        
        <tr>
            <td/>
            <td/>
            <td/>

              <td style="padding-left: 40px">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">            </td>
              <td/>
        </tr>
</table>
	</div>


	<div id="ccParent1" class="button">
	<div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript:select_onClick();"><fmt:message key="confirm" /> </a></li>
        <li class="g"><a onClick="javascript:selectAll_onClick();">全部添加 </a></li>
    </ul>
	</div>
	<div class="clear"></div>
	</div>

	<div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
        queryAction="/FAERP/SecurityproductAction.do?cmd=searchSecurityData&type=${param.type}"
        width="98%" height="320px" xpath="SecurityproductVo"
        paramFormId="datacell_formid" readonly="true"> 

		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="id" label="操作" width="50px"
			onRefreshFunc="setCheckboxStatus" align="center">
		</r:field>
		<r:field fieldName="city_id" label="城市" width="80px" >
			<r:comboSelect id="countryList" name="city_id1"
				queryAction="/FAERP/PB_CITYAction.do?cmd=getListData" textField="city_name"
				valueField="id" xpath="PB_CITYVo" width="150px" nullText="请选择" />
		</r:field>
		<r:field fieldName="product_id" width="100px" label="社保公积金产品">
			<r:comboSelect id="product_id1" name="product_id1"
                       queryAction="/FAERP/ProductAction.do?cmd=getListData&big_type_id=999"
                       textField="product_name"
                       valueField="id"
                       xpath="ProductVo"
                       width="200px"
                       nullText="请选择" />
		</r:field>
		<r:field fieldName="product_name" label="社保产品比例名称" width="150px">
	
		</r:field>
		<r:field fieldName="e_ratio" label="公司比例" >
		
		</r:field>
		<r:field fieldName="p_ratio" label="个人比例" >
	
		</r:field>
		<r:field fieldName="e_add_ratio" label="公司附加金额" width="120px">
			
		</r:field>
		<r:field fieldName="p_add_ratio" label="个人附加金额" width="120px" >
			
		</r:field>
		
		<r:field fieldName="charge_frequency_bd" label="收费频率">
			<d:select dictTypeId="CHARGE_FREQUENCY_BD"/>
		</r:field>
		<r:field fieldName="is_outstrip_limit_bd" label="是否超上下限" >
			<d:select dictTypeId="TrueOrFalse" />
		</r:field>
		
		<r:field fieldName="remark" label="备注">
    
        </r:field>
	</r:datacell></div>

	</div>
	</div>
	</form>
</fmt:bundle>
</body>
</html>


