<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="java.util.*" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostsendVo" %>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants" %>
<%@ page import="rayoo.employeepost.empinfo.employee.vo.EmployeeVo" %>
<%  
    //派出信息
    String id = (String)session.getAttribute("id");
    String city_id = (String)session.getAttribute("city_id");
    
   
%>
<html>
<fmt:bundle basename="rayoo.employeepost.empentry.emppost.emppost_resource" prefix="rayoo.employeepost.empentry.emppost.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<title></title>

<script language="javascript">

    var vpath = "<%=request.getContextPath()%>";

    jQuery(document).ready(function(){
        jQuery("#showratio tr").live("click", function () {
            updatetoTbody(this);
        });
        
    });

    function back_onClick(){  //返回列表页面
        form.action="<%=request.getContextPath()%>/EmppostAction.do?cmd=queryAll&backFlag=true";
        form.submit();
    }
    
    function toSecondStep(){  //前往下一步
        if(checkAllCont()){
            var dc1 = $id("grdCityEnsureTbody");
            var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=queryPostBat";
            //将两个datacell的xml内容合并
            var xmlSubmit = dc1.dataset.toString();
            var myAjax = new Ajax(action);
            var form = $id("datacell_formid");
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }           
             myAjax.submitXML(xmlSubmit, 'UTF-8');
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == 1 ) {
                      window.location.href="<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/emppost/initInsertbat2.jsp?city_id=<%=city_id%>";
                  } else if( myAjax.getValue("root/data/returnValue") == -1 ) {
                      alert("<fmt:message key="entry_agent_error"/>"); 
                  } else {
                      alert("<fmt:message key="accu_save_error"/>"); 
                  }
             }
         }
    }
    
    function checkAllCont(){//页面提交验证
        var ali = true;
        var datacell = $id("grdCityEnsureTbody");
        var dataset = datacell.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
                var datasettr = dataset.get(i);
                
                if(datasettr.getProperty("e_ratio")==null || datasettr.getProperty("e_ratio")==''){
                    alert("<fmt:message key="e_ratio_not_null"/>");
                    ali = false;
                    return ali;
                }
                if(datasettr.getProperty("p_ratio")==null || datasettr.getProperty("p_ratio")==''){
                    alert("<fmt:message key="p_ratio_not_null"/>");
                    ali = false;
                    return ali;
                }
                if(datasettr.getProperty("e_add_ratio")==null || datasettr.getProperty("e_add_ratio")==''){
                    alert("<fmt:message key="e_add_ratio_not_null"/>");
                    ali = false;
                    return ali;
                }
                if(datasettr.getProperty("p_add_ratio")==null || datasettr.getProperty("p_add_ratio")==''){
                    alert("<fmt:message key="p_add_ratio_not_null"/>");
                    ali = false;
                    return ali;
                }
            }
            
            return ali;
       }
    
    //检查输入参数是否为浮点数
    function checkFloat(str){
        var rc=true;
        oneDecimal=false;
        if (str+"" == "undefined" || str == null || str==''){
            rc=false;
        } else{
            for(i=0;i<str.length;i++){
                ch=str.charAt(i);
                if(i==0 && ch=='-'){
                    continue;
                }
                if(ch=="." && !oneDecimal){
                oneDecimal=true;
                    continue;
                }
                if ((ch< "0") || (ch >'9')){
                    rc=false;
                    break;
                }
            }
        }
        return rc;
    }  
    
    //验证输入的金额格式
    function  checkaddoney(fieldname,msgname){
        var datacell = $id("grdCityEnsureTbody");
        
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        
       var e_money = datasettr.getProperty(fieldname);
       if(!checkFloat(e_money)){
           alert("<fmt:message key="check_in"/>"+msgname+"<fmt:message key="must_float_num"/>");
           datasettr.setProperty(fieldname,"0");
           return;
       }
       if(fieldname=='e_ratio' || fieldname=='p_ratio'){
           if(e_money>1){
               alert("<fmt:message key="in_num_not_gt_one"/>");
               datasettr.setProperty(fieldname,"0");
               return;
           }
       }
        
    }
    
    //生成浮动层列表
    function toappenddiv(group_id,id){
         var showratio=jQuery("#showratio");
         showratio.empty();
         
         jQuery.getJSON(vpath+"/EmppostAction.do?cmd=searchProductsById&date="+new Date()+"",{"group_id":group_id,"security_product_id":id},  function(json){
             
                 for(var i = 0; i < json.saia.length; i++){
                    
                    var tr = jQuery("<tr onMouseOver=\"this.style.textDecoration='underline'\" onMouseOut=\"this.style.textDecoration='none'\"></tr>");
                    jQuery(tr).attr("style","cursor:hand");
                    
                    var td0 = jQuery("<td align='center' width='15%'></td>");
                    var html1 = jQuery("<input type='hidden' name='div_security_product_id' value=''>");
                    jQuery(html1).attr("value",json.saia[i].id);
                    jQuery(td0).append(html1);
                    var html2 = jQuery("<input type='hidden' name='div_product_id' value=''>");
                    jQuery(html2).attr("value",json.saia[i].product_id);
                    jQuery(td0).append(html2);
                    var html3 = jQuery("<input type='hidden' name='div_e_precision_bd' value=''>");
                    jQuery(html3).attr("value",json.saia[i].e_precision_bd);
                    jQuery(td0).append(html3);
                    var html4 = jQuery("<input type='hidden' name='div_e_caculate_type_bd' value=''>");
                    jQuery(html4).attr("value",json.saia[i].e_caculate_type_bd);
                    jQuery(td0).append(html4);
                    var html5 = jQuery("<input type='hidden' name='div_p_precision_bd' value=''>");
                    jQuery(html5).attr("value",json.saia[i].p_precision_bd);
                    jQuery(td0).append(html5);
                    var html6 = jQuery("<input type='hidden' name='div_p_caculate_type_bd' value=''>");
                    jQuery(html6).attr("value",json.saia[i].p_caculate_type_bd);
                    jQuery(td0).append(html6);
                    jQuery(td0).append(json.saia[i].product_name);
                    jQuery(tr).append(td0);
                    
                    var td5 = jQuery("<td align='center'></td>");
                    jQuery(td5).append(json.saia[i].e_ratio);
                    jQuery(tr).append(td5);
                    
                    var td6 = jQuery("<td align='center'></td>");
                    jQuery(td6).append(json.saia[i].p_ratio);
                    jQuery(tr).append(td6);
                    
                    var td2 = jQuery("<td align='center'></td>");
                    jQuery(td2).append(json.saia[i].charge_frequency_bd);
                    jQuery(tr).append(td2);
                    
                    var td3 = jQuery("<td align='center'></td>");
                    jQuery(td3).append(json.saia[i].e_add_ratio);
                    jQuery(tr).append(td3);
                    
                    var td4 = jQuery("<td align='center'></td>");
                    jQuery(td4).append(json.saia[i].p_add_ratio);
                    jQuery(tr).append(td4);
        
                    jQuery(showratio).append(tr);
                
             }
        });
    }
    
    //点击浮动层的某一条，修改列表中对应的条目（同一个product_id，不同的社保产品）
    //同时，重新根据新的产品判断基数范围，并且重新计算金额
    function updatetoTbody(obj){
         var showratio=jQuery(obj);//div浮动层被点击的行对象
         var product_id=jQuery(showratio).find("input[name='div_product_id']").val();//浮动层被点击的product_id值
         
         var security_product_id = jQuery(showratio).find("input[name='div_security_product_id']").val();
         var e_ratio = jQuery(showratio).find('td').eq(1).text();
         var p_ratio = jQuery(showratio).find('td').eq(2).text();
         var charge_frequency_bd = jQuery(showratio).find('td').eq(3).text();
         var e_add_ratio = jQuery(showratio).find('td').eq(4).text();
         var p_add_ratio = jQuery(showratio).find('td').eq(5).text();
         var e_precision_bd = jQuery(showratio).find("input[name='div_e_precision_bd']").val();
         var p_precision_bd = jQuery(showratio).find("input[name='div_p_precision_bd']").val();
         var e_caculate_type_bd = jQuery(showratio).find("input[name='div_e_caculate_type_bd']").val();
         var p_caculate_type_bd = jQuery(showratio).find("input[name='div_p_caculate_type_bd']").val();
         
         var datacell = $id("grdCityEnsureTbody");//datacell列表对象
         var dataset = datacell.dataset;
         var trentity = dataset.findEntity("product_id", product_id);//列表中对应的相同product_id的行
         trentity.setProperty("id", security_product_id);
         trentity.setProperty("e_ratio", e_ratio);
         trentity.setProperty("p_ratio", p_ratio);
         trentity.setProperty("frequency_bd", charge_frequency_bd);
         trentity.setProperty("e_add_ratio", e_add_ratio);
         trentity.setProperty("p_add_ratio", p_add_ratio);
         trentity.setProperty("e_precision_bd", e_precision_bd);
         trentity.setProperty("p_precision_bd", p_precision_bd);
         trentity.setProperty("e_caculate_type_bd", e_caculate_type_bd);
         trentity.setProperty("p_caculate_type_bd", p_caculate_type_bd);
         
         $id("grdCityEnsureTbody").refresh();

    }
    
    //显示浮动层
    function show(obj){
        var dc1 = $id("grdCityEnsureTbody");
        var activeRow = dc1.activeRow;
        var entity = dc1.getEntity(activeRow);
        var group_id = entity.getProperty("group_id");
        var id = entity.getProperty("id");
        
        //2016-03-10 chenxiaopei 如果是上海的工伤，且起始日期为空或大于2015-10-01，则不弹出
        var city_id = entity.getProperty("city_id");
        var product_id = entity.getProperty("product_id");
        var start_date  = entity.getProperty("sf_start_date");
        if(city_id =='1099110100000000050' && product_id=='1099110200000000009' 
        	&& start_date!=null && start_date!='' && start_date>='201510' ){
        	//*如果有供应商/客户账号没有配置费率的，则也不能弹出，只能手动输入比例
        }else{
	        //先调用ajax查询与所选社保产品属于同一产品的社保产品列表，加载到浮动层div中
	        toappenddiv(group_id,id);
	        
	        window.event.cancelBubble = true;
	        var divId=document.getElementById("div1");
	        var cellPosition = getPosition(dc1.activeCell);
	        
	        divId.style.left= cellPosition.left + dc1.activeCell.offsetWidth + 2;  
	        divId.style.top= cellPosition.top + dc1.activeCell.offsetHeight + 2;  
	        divId.style.width="500";  
	        divId.style.heigth="400";  
	        divId.style.background = '#FFFFFF';  
	        divId.style.display="block";  
		}
    }  
    //点击其他位置，隐藏浮动层
    function hideDiv(){  
        var divId=document.getElementById("div1");  
        if(!checkEventObj(event.srcElement,"div1"))  
            divId.style.display="none";  
    }
    
    function checkEventObj(obj,idName){  
        if(obj.tagName == "BODY"){ return false; }  
        if(obj.id == idName){ return true; }  
        else{ return checkEventObj(obj.parentElement, idName); }  
    }  

    function openSelectPro(){
        window.open("<%=request.getContextPath()%>/jsp/faerp/employeepost/empentry/emppost/selectProbat.jsp","newwindow","width=900px,height=600px,location=no");
    }
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id") + ">";
    }
    
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
    
    //批量删除
    function DelSite() {  
       var ids = findSelections("checkbox_template");  //取得多选框的选择项
       if(ids == null) {  //如果ids为空
           alert("<fmt:message key="please_choose_accu_product"/>");
           return;
       }
       if(confirm("<fmt:message key="sure_to_delete_for_accu_product"/>")) {  //如果用户在确认对话框按"确定"
            var datacell = $id("grdCityEnsureTbody");
            var dataset = datacell.dataset;
            for(var j=0;j<ids.length;j++){  //循环checkbox组选中的
                 dataset.removeEntity(dataset.findEntity("id", ids[j]), true);
            }
        
       }
       $id("grdCityEnsureTbody").refresh();
    }
    
</script>
</head>
<body onclick="hideDiv()">
 
<form name="form" method="post" id="datacell_formid">
 
<div id="right">
    <div class="right_title_bg">
        <div class=" right_title"> <fmt:message key="batch_on_post"/></div>
    </div>
</div>
<div>
    <input name="rel_id" type="hidden" value="<%=id%>"/>
    <input id="city_id" name="city_id" type="hidden" value="<%=city_id%>"/>
    <!--社保公积金-->
    <div class="zbox">
        <div class="xz_title"><fmt:message key="ss_fund"/> </div>
        <!-- 已选社保公积金组end-->
        <div>
            <table width="100%">
                <tr>
                    <td width="120">
                        &nbsp;&nbsp;<fmt:message key="selected_ss_fund_group"/>：
                    </td>
                    <td id="selectgroups">
                    <logic:iterate   name="groupbeans"  id="data" scope="session" indexId="indexs">
                        <div style="display:inline" id="<bean:write name="data" property="id"/>" align="left">
                            <input type="hidden" name="select_group_id" value="<bean:write name="data" property="id"/>" />
                            <input type="hidden" name="select_city_id" value="<bean:write name="data" property="city_id"/>" />
                            <input type="hidden" name="select_group_name" value="<bean:write name="data" property="group_name"/>" />
                            <bean:write name="data" property="group_name"/>
                        </div>
                    </logic:iterate>
                    </td>
                </tr>
            </table>
            
        </div>
        <!-- 已选社保公积金组end-->
        
        <!--按钮-->
    <div class="button">
            <div class="button_right">
                <ul>
                  <li class="c"><a onClick="javascript:openSelectPro();"><fmt:message key="setted"/></a></li>
                  <li class="d"><a onClick="javascript:DelSite();"><fmt:message key="deleted"/></a></li>
                </ul>
                <div class="clear"></div>
            </div>
            
        </div>
    <!--按钮 end-->
    <!--表格 -->
    <div id="values_div">
      <r:datacell 
                         id="grdCityEnsureTbody"
                         queryAction="/FAERP/EmppostAction.do?cmd=initInsertBat1"
                         submitAction="/FAERP/EmppostAction.do?cmd=queryPostBat"
                         width="100%"
                         xpath="SecurityAllVo"
                         submitXpath="SecurityAllVo"
                         paramFormId="datacell_formid"
                         pageSize="-1" readonly="false"
                         >
                         <r:field  fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="50px" onRefreshFunc="setCheckboxStatus">
                         </r:field>
                         <r:field  fieldName="group_product" messagekey="ss_group_and_product_order" width="0">
                         </r:field>
                         <r:field  fieldName="product_name" messagekey="product">
                         </r:field>
                         <r:field fieldName="group_name" messagekey="ss_fund">
                         </r:field>
                         <r:field fieldName="e_ratio" messagekey="enterprise_pro" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.####');})">
                             <h:text onclick="javascript:show(this);" onchange="javascript:checkaddoney('e_ratio','企业比例');"/>
                         </r:field>
                         <r:field fieldName="p_ratio" messagekey="person_pro" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.####');})">
                             <h:text onclick="javascript:show(this);" onchange="javascript:checkaddoney('p_ratio','个人比例');"/>
                         </r:field>
                         <r:field fieldName="e_add_ratio" messagekey="enterprise_add_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text onchange="javascript:checkaddoney('e_add_ratio','企业附加金额');"/>
                         </r:field>
                         <r:field fieldName="p_add_ratio" messagekey="person_add_money" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                            <h:text onchange="javascript:checkaddoney('p_add_ratio','个人附加金额');"/>
                         </r:field>
                         
                       </r:datacell>
    </div>
    <!--表格 end-->
    <div id="div1" style="display: none; border: #000 1px solid; position: absolute;z-index:999;">
                <table  width="500" cellspacing="0"  class="datagrid1">
                    <tr>
                      <th width="9%"><fmt:message key="product"/></th>
                      <th width="10%"><fmt:message key="enterprise_pro"/></th>
                      <th width="10%"><fmt:message key="person_pro"/></th>
                      <th width="10%"><fmt:message key="pay_frequency"/></th>
                      <th width="10%"><fmt:message key="enterprise_add_money"/></th>
                      <th width="10%"><fmt:message key="person_add_money"/></th>
                      </tr>
                      <tbody id="showratio">
                      
                      
                      </tbody>
                </table>
            </div>
            
    </div>
    <!--社保公积金 end-->
   
     
    <div class="foot_button">
          <input type="button" class="foot_icon_1" value="<fmt:message key="next_step"/>" onclick="toSecondStep();" />
          <input type="button" class="foot_icon_1" value="<fmt:message key="go_back"/>" onClick="javascript:back_onClick();"/>
    </div>

    
</div>

</div>
</form>
</fmt:bundle>
</body>
</html>
