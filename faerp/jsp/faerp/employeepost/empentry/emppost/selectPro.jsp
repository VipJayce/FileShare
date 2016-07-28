<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="choose_func_product"/></title>
<link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
</style>
<script language="javascript">

var vpath = "<%=request.getContextPath()%>";

    //为页面列表的radio和checkbox定义点击方法
	jQuery(document).ready(function(){
	    
	    jQuery("#grdGrouptbody input[type='radio']").live("click", function () {
	        GetCityProduct();
	    });
	    
	    jQuery("#grdGrouptbody select[name='select_shortcut']").live("change", function () {
            changeProduct();
        });
	    
	    jQuery("#grdProducttbody :checkbox").live("click", function () {
	        selectTodo(this);
	    });
	});

    function simpleQuery_onClick(){  //简单的模糊查询
        var cityId = $id("city_idList_search").getValue(cityId);
        $id("citypro_init").addParam("city_id", cityId+"");
        $id("citypro_init").loadData();
        $id("citypro_init").refresh();
    }

    
    //勾选一个产品，则往母页面社保公积金产品列表插入一条
    AddopenerProduct = function (security_product_id,group_id) {
       
        //ajax查询该产品的详细
         jQuery.getJSON(vpath+"/EmppostAction.do?cmd=searchProductById&date="+new Date()+"",{"security_product_id":security_product_id,"group_id":group_id},  function(json){
                 var dc1 = window.opener.$id("grdCityEnsureTbody");
                 
                 for(var i = 0; i < json.saia.length; i++){
	                 var newEntity =  dc1.styleEntity.clone(true);//只克隆行样式，不带值
	                
	                 newEntity.setProperty("id", json.saia[i].id);
	                 newEntity.setProperty("city_id", json.saia[i].city_id);
                     newEntity.setProperty("product_id", json.saia[i].product_id);
                     newEntity.setProperty("group_product", json.saia[i].group_product);
                     newEntity.setProperty("product_code", json.saia[i].product_code);
                     newEntity.setProperty("group_id", json.saia[i].group_id);
                     newEntity.setProperty("bind_radix_bd", json.saia[i].bind_radix_bd);
                     newEntity.setProperty("product_name", json.saia[i].product_name);
                     newEntity.setProperty("group_name", json.saia[i].group_name);
                     newEntity.setProperty("e_ratio", json.saia[i].e_ratio);
                     newEntity.setProperty("p_ratio", json.saia[i].p_ratio);
                     newEntity.setProperty("e_precision_bd", json.saia[i].e_precision_bd);
                     newEntity.setProperty("e_caculate_type_bd", json.saia[i].e_caculate_type_bd);
                     newEntity.setProperty("p_precision_bd", json.saia[i].p_precision_bd);
                     newEntity.setProperty("p_caculate_type_bd", json.saia[i].p_caculate_type_bd);
                     newEntity.setProperty("charge_frequency_bd", json.saia[i].charge_frequency_bd);
                     newEntity.setProperty("base", "");
                     newEntity.setProperty("money", "");
                     newEntity.setProperty("e_money", "");
                     newEntity.setProperty("p_money", "");
                     newEntity.setProperty("e_add_ratio", json.saia[i].e_add_ratio);
                     newEntity.setProperty("p_add_ratio", json.saia[i].p_add_ratio);

                     dc1.insertRow(newEntity);
                     //alert(dc1.activeField.fieldId);
                     dc1.activeField.editor.hideEditor();           
                     //alert(dc1.getField(0).fieldName);
                     
                }
                dc1.refresh();
                //alert(dc1.activeCell.getAttribute("fieldId"));
                //dc1.refreshCell( dc1.activeCell )
                //dc1.lostFocus();
                dc1.getField(1).sorted = '';
                dc1.doSort(dc1.getField(1));  
                
                //alert(dc1.dataset.getLength());
                window.focus();
            }); 
        
    }
</script>
</head>
<body>
<div>
<div class="zbox" style="float:left; width:48%">
<form name="form" method="post" id="simpleQuery">
<div class="xz_title" style="margin-top:10px;"><fmt:message key="query"/></div>
<table width="100%" border="0" cellspacing="1" cellpadding="0">
  <tr>
    <td class="td_1"><fmt:message key="private_id"/></td>
    <td class="td_2">
        <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       messagekey="please_choose" />
    </td>
    </tr>
  <tr>
    <td class="td_1"><fmt:message key="ss_fund"/></td>
    <td class="td_2"><input type="text" class="xText" id="group_name" name="group_name" value=""/></td>
    </tr>
  <tr>
    <td colspan="2" class="td_2">
    <div class="foot_button">
      <input type="button" class="foot_icon_1" value="<fmt:message key="query"/>" onClick="javascript:simpleQuery_onClick()">
    </div></td>
    </tr>
  </table>
 
  <div>
                    <r:datacell 
                         id="citypro_init"
                         queryAction="/FAERP/EmppostAction.do?cmd=searchGroup"
                         width="100%"
                         xpath="SecuritygroupVo"
                         submitXpath="SecuritygroupVo"
                         paramFormId="simpleQuery" 
                         pageSize="-1"
                         >
                         <r:toolbar location="bottom" tools="info"/>
                         <r:field width="120" fieldName="city_id" messagekey="private_id">
                         </r:field>
                         <r:field width="250" fieldName="group_name" messagekey="ss_fund">
                         </r:field>
                    </r:datacell>
  </div>
  
  </div>
  
  </form>
  <div class="zbox" style="float:right; width:48%;">
  

 <!--按钮 end-->
  <div class="xz_title" style="margin-top:10px;"><fmt:message key="selected_fund"/></div>
     <!--按钮-->                  
 <div id="ccParent1" class="button"> 
        <div class="button_right">
                <ul>
                    <li class="d"><a  onClick="javascript:deleteGroup();"><fmt:message key="delete"/> </a> </li>
                </ul>
                
         </div>
         <div class="clear"></div>          
 </div>
  <div class="box" style="height:200px;">
  
      
      <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th width="9%"  >
          </th>
          <th width="10%"  ><fmt:message key="private_id"/></th>
          <th width="12%"><fmt:message key="ss_fund"/></th>
          <th width="10%"><fmt:message key="quick_set"/></th>
          
          </tr>
           <tbody id="grdGrouptbody">
          
        
           </tbody>
      </table>
  </div>
  
   <div class="xz_title" style="margin-top:10px;"><fmt:message key="ss_fund_product"/></div>
  <div class="box" id="values_div" style="height:230px;">
 
      
      <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th width="4%"  >
            &nbsp;
          </th>
          <th width="91%"  ><fmt:message key="product"/></th>
        </tr>
        <tbody id="grdProducttbody">
       
        
        </tbody>
      </table>
  </div>
 
  </div>
  
    <div class="foot_button">
      <input type="button" class="foot_icon_1" value="<fmt:message key="close"/>" onClick="javascript:window.close()">
    </div>
</div>
</fmt:bundle>
<script type="text/javascript" language="JavaScript" src="<venus:base/>/jsp/faerp/employeepost/empentry/emppost/SearchCityEnsure.js"></script>

</body>
</html>