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
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("city_id") + "\");>";//city_idList
    }

	   function ClickRow(value,value1){
	       //alert(value+"______"+value1);
	        $id("tid").value = value;
	        $id("t_city_id").value = value1;
	    }
    
	    function showListData(){
	        $id("datacell1").loadData();
	        $id("datacell1").refresh();
            $id("tid").value = "";
            $id("t_city_id").value = "";
	    }

		function toAdd_onClick() { 
		    $id("datacell1").refresh();
		    $id("datacell1").addRow();
		    $id("tid").value = "";
            $id("t_city_id").value = "";
		}
		
		function deleteMulti_onClick(){
		    
		    if(!choose_row("tid")){
               return;
            }
            if(!confirm('是否确定要停用选择的数据？')) {
                return;
            }
            $id("datacell1").isModefied = true;
		    $id("datacell1").deleteRow();
		    if($id("datacell1").submit()){
		    alert("操作成功！");
		    $id("tid").value = "";
            $id("t_city_id").value = "";
		    }
		}
		function toSave_onClick() {
		  //var count=check_base();
		  //if(count==""){
			    $id("datacell1").isModefied = true;
			    if($id("datacell1").submit()){
		            alert("操作成功！");
		            $id("tid").value = "";
	                $id("t_city_id").value = "";
	                return;
		        }
	        //}
	           // alert(count+"  行年缴费月格式不正确");
		}   
		function toReload_onClick() {
		    $id("tid").value = "";
            $id("t_city_id").value = "";
		    $id("datacell1").reload();
		}
           
       //导出数据
       function exportToExcel() {  
	       if(confirm('是否确定要导出数据？')) {
	        form.action="<%=request.getContextPath()%>/SecuritygroupAction.do?cmd=exportToExcel";
	        form.submit();
	        }
	    }  
	   
	   function editjishuCheckbox_onClick(){
	        var tid=$id("tid").value;
	        var city_id=$id("t_city_id").value;
	        if(!choose_row("tid")){
	           return;
	        }
	        //alert("tid="+tid+"city_id="+city_id);
	        var url="<%=request.getContextPath()%>/jsp/faerp/system/securityproduct/listproductbase.jsp?security_product_id="+tid+"&city_id="+city_id;
	        //var url="<%=request.getContextPath()%>/SecurityproductitemAction.do?cmd=queryAll&security_product_id=" + tid+"&city_id="+city_id;
	        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
	        showModalCenter(url, window, refesh, 980, 450, "编辑产品基数");  //增加子岗位
	   }
	   
	   function refesh()
    {
       $id("tid").value="";
       $id("t_city_id").value="";
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    //<h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年缴费月格式不正确;allowNull=false;"  />
    //如果是年缴费（不足一年按一年算）则需要填写缴费年月，月缴怎不需要填写
    function check_base(){
       var loop=document.getElementsByName("temp");
       var count="";
       var enCurEntity="";
       var frequency="";
       var yearlypaymonth="";
      var check_str=/^[12]\d{3}(0\d|1[0-2])$/;
      for(var i=0;i<loop.length;i++){
        enCurEntity = $id("datacell1").dataset.get(i);
        frequency = enCurEntity.getProperty("charge_frequency_bd");
        yearlypaymonth=enCurEntity.getProperty("yearly_pay_month");
       if(frequency=="2"){
                     if(!check_str.test(yearlypaymonth)){
                                    count+="  第"+(i+1);
                                    }
        }
      }
      return count;
     
    //if(frequency=="2"){
     //    if(!check_str.test(yearlypaymonth)){
    //     alert("年缴费月格式不正确");
    //     return false;
     //    }
    //     return true;
     //   }
     //   return true;
    }
    
</script>
	</head>
	<body>
	<form name="form" method="post" id="datacell_formid">
	<input id="tid" name="tid" type="hidden"  value="" />
	<input id="t_city_id" name="t_city_id" type="hidden"  value="" />
	<div id="right"><script language="javascript">
		writeTableTopFesco('社保产品比例维护','<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
	<div class="ringht_s">
	<div id="ccChild0" class="search">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="175" rowspan="2" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
            <td width="202" align="right">省市</td>
            <td width="180" align="left">
             <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择" />
            </td>
            <td width="249" align="right">社保公积金产品</td>
            <td width="511" align="left">
            <r:comboSelect id="product_id" name="product_id"
                       queryAction="/FAERP/ProductAction.do?cmd=getListData&big_type_id=999"
                       textField="product_name"
                       valueField="id"
                       xpath="ProductVo"
                       width="200px"
                       nullText="请选择" />
            </td>
            </tr>
        
        <tr>
            <td/>
            <td/>
              <td>
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">            </td>
                <td/>
        </tr>
</table>
	</div>


	<div id="ccParent1" class="button">
	<div class="button_right">
	<ul>
		<li class="c"><a onClick="javascript:toAdd_onClick();"><fmt:message key="insert" /> </a></li>
		<li class="bc"><a onClick="javascript:toSave_onClick();">保存</a></li>
		<li class="a"><a onClick="javascript:toReload_onClick();">刷新 </a></li>
		<li class="k"><a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="stop"/> </a> </li>
        <li class="q_1"><a  onClick="javascript:editjishuCheckbox_onClick();"><fmt:message key="jishu"/> </a> </li>
		</li>
	</ul>
	</div>
	<div class="clear"></div>
	</div>

	<div style="padding: 8 10 8 8;"><r:datacell id="datacell1"
		queryAction="/FAERP/SecurityproductAction.do?cmd=searchSecurityGroupData"
		submitAction="/FAERP/SecurityproductAction.do?cmd=insertSecurityGroupData"
		width="98%" height="320px" xpath="SecurityproductVo"
		submitXpath="SecurityproductVo" paramFormId="datacell_formid">

		<r:toolbar location="bottom" tools="nav,pagesize,info" />
		<r:field fieldName="emp" label="操作" width="50px"
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
			<h:text />
		</r:field>
		<r:field fieldName="e_ratio" label="公司比例" >
			<h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
		</r:field>
		<r:field fieldName="p_ratio" label="个人比例" >
			<h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
		</r:field>
		<r:field fieldName="e_add_ratio" label="公司附加金额" width="120px">
			<h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
		</r:field>
		<r:field fieldName="p_add_ratio" label="个人附加金额" width="120px" >
			<h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
		</r:field>
		<r:field fieldName="e_caculate_type_bd" label="公司舍入原则">
			<d:select dictTypeId="E_CACULATE_TYPE_BD" extAttr="validateAttr='allowNull=false'" />
		</r:field>
		<r:field fieldName="p_caculate_type_bd" label="个人舍入原则" >
			<d:select dictTypeId="P_CACULATE_TYPE_BD" extAttr="validateAttr='allowNull=false'" />
		</r:field>
		<r:field fieldName="e_precision_bd" label="公司精度" >
			<d:select dictTypeId="E_PRECISION_BD" extAttr="validateAttr='allowNull=false'" />
		</r:field>
		<r:field fieldName="p_precision_bd" label="个人精度">
			<d:select dictTypeId="P_PRECISION_BD" extAttr="validateAttr='allowNull=false'" />
		</r:field>
		<r:field fieldName="e_parity_bd" label="公司奇偶限限定" >
			<d:select dictTypeId="E_PARITY_BD" />
		</r:field>
		<r:field fieldName="p_parity_bd" label="个人奇偶限限定" >
			<d:select dictTypeId="P_PARITY_BD"/>
		</r:field>
		<r:field fieldName="charge_frequency_bd" label="收费频率">
			<d:select dictTypeId="CHARGE_FREQUENCY_BD"/>
		</r:field>
		<r:field fieldName="is_outstrip_limit_bd" label="是否超上下限" >
			<d:select dictTypeId="TrueOrFalse" />
		</r:field>
		<r:field fieldName="yearly_pay_month" label="年缴费月" >
		<h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;"/>
		</r:field>
		<r:field fieldName="product_explanation" label="产品说明"> 
			<h:text />
		</r:field>
		<r:field fieldName="remark" label="备注">
            <h:text />
        </r:field>
	</r:datacell></div>

	</div>
	</div>
	</form>
</fmt:bundle>
</body>
</html>
<script>
       function choose_row(tagid) {
             if($id(tagid).value==""){
                    alert("请选择一条记录！");
                    return false;
             }
             return true;
        }



    function choose_datacell_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("请选择一条记录！");
           return;
        }
     return obj;
    }
</script>


