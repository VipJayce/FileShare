<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@page import="rayoo.finance.receivable.MyUtils"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	   function cancel_onClick(){  //取消后返回列表页面
	       form.action="<%=request.getContextPath()%>/jsp/faerp/system/fin_invoice_template/listfin_invoice_template.jsp";
	       form.submit();
	   }

       //添加产品
       function add_product() {
          //  if(!checkInvoiceStatus()){
          //          return;
          //  }
          var url="<%=request.getContextPath()%>/jsp/faerp/system/fin_invoice_template/insertFin_invoice_template_item.jsp?id=${bean.id}";
          url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
          showModalCenter(url, window, retCallback, 860, 200, "产品与财务科目对照设置");  //增加子岗位
       }
         
        function retCallback() {
              $id("celllist1").loadData();
              $id("celllist1").refresh();
         }
         
         
         //添加三级科目
         function add_subjcode3() {
            var v2_ccode=$id("v2_ccode").value;
            var v_bustype=$id("v_bustype").value;
            var parent_id=$id("parent_id").value;
            
            if(v_bustype==null || v_bustype==""){
                v_bustype="";
                $id("v_bustype").value="";
            }
            
            if(v2_ccode=="" || parent_id==""){
                alert("请选择一条二级科目记录！");
                return;
            }
            
            var url="<%=request.getContextPath()%>/jsp/faerp/u8/u8_product_master_subjcom/insertU8_detail_subjcom3.jsp?id=${bean.id}&subjcode="+v2_ccode+"&v_bustype="+v_bustype+"&parent_id="+parent_id;
            url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            showModalCenter(url, window, retCallback2, 860, 200, "凭证与三级科目对照设置");  //增加子岗位
         }
         
        function retCallback2() {
              //$id("celllist2").loadData();
              //$id("celllist2").refresh();
         }
         
	         

       //修改产品
       function edit_product() {
            if(!checkInvoiceStatus()){
                    return;
            }
            var ids = selectIds1();
            if(ids == null || ids == '') {
                alert("请选择一条记录！");
                return;
            }
            
            if(ids.length > 1){
                alert("只能选择一条记录！");
                return;
            }
            
            var datacell = $id("celllist1");
            var dataset1 = datacell.dataset;
            var datasettr1 = dataset1.findEntity("id",ids);
            var product_id = datasettr1.getValue("product_id");
            var product_name = datasettr1.getValue("product_name");
            var fin_subjects_code = datasettr1.getValue("fin_subjects_code");
            var fin_small_subjects_bd = datasettr1.getValue("fin_small_subjects_bd");
                        
            
          var url="<%=request.getContextPath()%>/jsp/faerp/system/fin_invoice_template/insertFin_invoice_template_item.jsp?id=${bean.id}&t_id="+ids;
          url=url+"&product_id="+product_id+"&product_name="+product_name+"&fin_subjects_code="+fin_subjects_code+"&fin_small_subjects_bd="+fin_small_subjects_bd; 
          url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
          url = encodeURI(url);
          //alert(url);
          showModalCenter(url, window, retCallback, 860, 200, "产品与财务科目对照设置");  //增加子岗位
       }
        
       function toDelete_onClick() {
            if(!checkInvoiceStatus()){
                    return;
            }
            var ids = selectIds1();
	        if(ids == null || ids == '') {
	            alert("请选择一条记录！");
	            return;
	        }
            
           if(!confirm('确定要删除所选择的记录么?')){
               return false;
            }

            var url="<%=request.getContextPath()%>/Fin_invoice_template_itemAction.do?cmd=deleteData&ids=" + ids;
            url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            jQuery.post(url,function(data){
                if(data){
                        if(data!=""){
                            alert(data);
                        }else{
                            alert("删除失败！");
                        }
                 }
             });
             
             $id("celllist1").loadData();
             $id("celllist1").refresh();
         }
         
   _$(document).ready(function() {
     var is_display_year_month="${bean.is_display_year_month}";
     if(is_display_year_month=="1"){
         _$("#is_display_year_month1").attr("checked", "checked");
     }else{
        _$("#is_display_year_month0").attr("checked", "checked");
     }
	}); 
         
	function query_onClick(){
	       var v_product_name=replaceyh($id("v_product_name").value);
	       if(v_product_name!=""){
			       if(!checkForms(v_product_name)){
			             return;
			       }
	       }else{
	           $id("v_product_name").value=v_product_name;
	           //return;
	       }
	       $id("v_product_name").value=v_product_name;
	       $id("celllist1").loadData();
	       $id("celllist1").refresh();
	}
	
	function checkForms(obj){
       var iu;
       var iuu;
      var regArray=new Array("!","^","*","(",")","=","[","]","?","~","`","!","→","←","↑","↓","！","@","◎","#","＃","$","…","※","￥","§","×","｛","｝","％","/","\'","\"");
       iuu=regArray.length;     
            for(iu=1;iu<=iuu;iu++){  
		              if (obj.indexOf(regArray[iu])!=-1){
		                     alert("输入内容中不可以包含：" + regArray[iu]);                  
		                     return false;
		              }
		       }
		return true;              
		}
		
		 function replaceyh(str)
		{
		    str=str.replace(/[ ]/g,""); 
		    return str;
		}
		
		
     function checkInvoiceStatus(){
           var bill_invoice_status_bd="0";
           var fin_invoice_template_id="${bean.id}";
           _$.ajax({
                   url : "/FAERP/Fin_invoice_template_itemAction.do?cmd=checkInvoiceStatus&fin_invoice_template_id="+fin_invoice_template_id+"&_ts="+(new Date()).getTime(),
                   type: 'GET',
                   dataType: 'html',
                   async: false,
                   timeout: 10000,
                   error: function(){
                       alert('Error loading XML document');
                       return  null;
                   },
                   success: function(text){
                       if(text!=null){       
                              if(text == '1'){
                                      bill_invoice_status_bd="1";
                                       return false;
                                  }
                           }
                       }
           });
           
           if(bill_invoice_status_bd!="0"){
                alert("当前发票模板所关联的客户账单的开票状态有部分开票不可更改模板！");
                return false;
           }
           return true;
     }
     
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<!-- 主表ID  -->
<input id="product_master_subjcom_id" name="product_master_subjcom_id" type="hidden"  value="" />
<!-- 二级ID  -->
<input id="parent_id" name="parent_id" type="hidden"  value="" />
<!-- 二级科目编码  -->
<input id="v2_ccode" name="v2_ccode" type="hidden"  value="" />

<input id="v_bustype" name="v_bustype" type="hidden"  value="" />
<div id="right">
<script language="javascript">
        writeTableTopFesco("发票模板配置",'<%=request.getContextPath()%>/');
</script>


 

 
<div id="right">
<div id="ccChild1"     class="box_xinzeng" style="height: 115px">
<div class="xz_title" style="padding-top: 10px">发票模板信息</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td width="21%" class="td_1" >模板名称</td>
			<td width="39%" class="td_2 ">${bean.template_name}</td>
			<td width="11%" class="td_1" >模板备注</td>
			<td width="29%" class="td_2" >${bean.template_remark}</td>
		</tr>
		<tr>
		    <td  class="td_1" >是否显示账期</td>
            <td  class="td_2 ">
            <input name="is_display_year_month" type="radio" id="is_display_year_month1" value="1">
            是
            <label for="radio">
              <input type="radio" name="is_display_year_month"  id="is_display_year_month0"  value="0">
            </label>
           否
            </td>
			<td colspan="2" class="td_2" align="left">
			<%
			String view=(String)request.getAttribute("view");
			if(MyUtils.isNull(view)){
			    %>
            <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
            <%
            }
            %>
			</td>
		</tr>
	</table> 
</div>         


<div class="xz_title" style="padding-top: 10px">发票模板配置</div>
<%
            if(MyUtils.isNull(view)){
%>
	<div class="button_right" style="padding-left: 8px">
	  <input class="c_2"  id="c_1" type="button"   value="添加产品" onclick="add_product();">
	  <input class="d" type="button"   value="删除" onClick="javascript:toDelete_onClick();">
	   <input class="b"  id="b_1" type="button"   value="修改" onclick="edit_product();">
	   
	</div>   
	<div style="padding-left: 8px">
	产品名称：<input name="v_product_name" type="text" id="v_product_name" value="${pb_cost_center_vo.receipt_title}"  style="width: 30%"/>
    <input type="button" class="icon_2" value="查询"  onClick="javascript:query_onClick()"/>
    </div>   
<%
            }
%>
<div id="values_div2" style="width:100%;height:200px; padding: 5 0 8 8;">
        <r:datacell id="celllist1"
            queryAction="/FAERP/Fin_invoice_template_itemAction.do?cmd=getListBySimpleQuery&fin_invoice_template_id=${bean.id}"
            paramFormId="datacell_formid" width="99%" height="304px"
            xpath="Fin_invoice_template_itemVo" readonly="true" pageSize="10">
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field allowModify="false" fieldName="chk"
                label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
                sortAt="none" width="30px">
                <h:switchCheckbox name="chk" id="chk" checkedValue="1" uncheckedValue="0"/>
            </r:field>
            <r:field fieldName="product_name" label="产品名称" width="220px">
                <h:text />
            </r:field>
            <r:field fieldName="fin_subjects_code" label="财务开票编码" width="170px">
            </r:field>
            <r:field fieldName="fin_subjects_name" label="开票项目" width="170px">
            </r:field>
            <r:field fieldName="fin_small_subjects_bd"  label="辅助科目" allowModify="false" width="150px;">
            <d:select dictTypeId="FIN_SMALL_SUBJECTS_BD"></d:select>
            </r:field>
            <r:field fieldName="create_date" label="创建时间" width="150px">
                <w:date format="yyyy-MM-dd HH:mm:ss" />
            </r:field>
        </r:datacell>
        </div>
</div>  

</div>  
   
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
	
	function checkAll(item) {
    if (_$(item).attr("checked")) {
        changeEntityChk(true);
        _$(":checkbox").attr("checked", true);
    } else {
        changeEntityChk(false);
        _$(":checkbox").attr("checked", false);
    }
}


function changeEntityChk(flag) {
    var dc1 = $id("celllist1").dataset;
    var values = dc1.values;
    for(var i=0; i<values.length; i++){
        var entity = values[i];
        entity.setProperty("chk", flag);
    }
}

    function selectIds1() {
        var myids = new Array(0);
        var dc = $id("celllist1");
        var ds = dc.dataset;
        _$("input[type='checkbox']").each(function(i) {
            //第0个为全选按钮
            if (i != 0 && _$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i-1];//第二个checkbox其实是第一行
                var entity = dc.getEntity(row);
                myids.push(entity.getValue("id"));
            }
        });
        return myids;
    }
</script>
</body>
</html>
