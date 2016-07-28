<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
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
	
	
	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell").loadData();
        $id("datacell").refresh();
  	}
	//打印
	function print(){
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}else{
        	var flags=true;
            jQuery.ajax({
            url: '/FAERP/NewPrintingMaterialsAction.do?cmd=print&emp_post_id='+ids+"&date="+new Date(),
            type: 'GET',
            dataType: 'html',
            async: false,
            timeout: 80000,
            error: function(){
            	alert('Error loading XML document');
                return  null;
            },
            success: function(text){
            	if(text!=null){
                   alert(text);
                   //simpleQuery_onClick();
                }

            }
            });
            return flags;
        }
		//alert(ids);
		
	}
	
	function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		window.showModalDialog('/FAERP/EmppostAction.do?cmd=detailPerOrder&id='+ids,'','dialogHeight:510px;dialogWidth:1000px;center:yes;help:no;resizable:no;scroll:yes;status:no;');
		
	}
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' id='checkbox_template'  value=" + entity.getProperty("id") + ">";
    }
    
    function checkAllList() {
      var element = document.getElementsByName("checkbox_template"); 
      for(var i=0;i<element.length;i++){
         if(element[i].type=="checkbox" && element[i].name=="checkbox_template") {
           element[i].checked= !element[i].checked ? true : false;
          }
       } 
    }

</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
	writeTableTopFesco('新开材料打印','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="200" height="75" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
		<tr>
			<td align="right">客户编号</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_code" id="cust_code" inputName="员工编号" maxLength="50"/>
			</td>
			<td align="right">客户名称</td>
			<td align="left">
				<input type="text" class="text_field" name="cust_name" id="cust_name" inputName="员工姓名" maxLength="50"/>
			</td>
			<td align="right">员工唯一号</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_code" id="emp_code" inputName="唯一号" maxLength="25"/>
			</td>
			
		</tr>
		<tr>
			<td align="right">员工姓名</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name" id="emp_name" inputName="证件号码" maxLength="64"/>
			</td>
			<td align="right">身份证号码</td>
			<td align="left">
				<input type="text" class="text_field" name="id_card" id="id_card" inputName="证件号码" maxLength="64"/>
			</td>
			
			<td align="right">打印结果</td>
			<td align="left">
				<select name='print_msg' id='print_msg'  >
				<option value='' >--选择--</option>
				<option value='打印成功' >成功</option>
				<option value='打印失败' >失败</option>
				
				</select>
			</td>
			<td align="right"></td>
			<td align="left">
				<input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onclick="javascript:simpleQuery_onClick()">
			</td>
		</tr>
		
		
	</table>
</div>
<div id="ccParent1" class="button"> 
 <div class="button_right">
	<input class="dj_1" type="button"   value="打印" onClick="print();">
 	<input class="a_2" type="button"   value="查看个人订单" onClick="detail_onClick();">
 
 </div>
 <div class="clear"></div>			
</div> 
<r:datacell 
        id="datacell"
       queryAction="/FAERP/NewPrintingMaterialsAction.do?cmd=simpleQuery"       
       isCount="false"
        width="100%"
        xpath="EmppostVo"
        height="320"        
        paramFormId="datacell_formid"
        >
        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field allowModify="false" fieldName="id" sortAt="none" label="<input type='checkbox' name='temp' id='temp' value='' onclick='checkAllList();' />" width="50px" onRefreshFunc="setCheckboxStatus" >
       </r:field> 
       <r:field fieldName="cust_code" width="80px" label="客户编号">
       </r:field> 
       <r:field fieldName="cust_name" width="150px" label="客户名称">
       </r:field>   
       <r:field fieldName="emp_name" width="80px" label="员工姓名">
       </r:field> 
       <r:field fieldName="id_card" width="160px" label="员工身份证">
       </r:field> 
       <r:field fieldName="post_status_bd" label="入离职状态" allowModify="false">
        <d:select dictTypeId="POST_STATUS_BD"/>
      </r:field>
       <r:field fieldName="apply_on_post_date" width="100px" label="入职时间" allowModify="false">
       <w:date format="yyyy-MM-dd" />
       </r:field> 
  	   <r:field fieldName="print_status" width="80px" label="打印状态" allowModify="false">
  	   <d:select dictTypeId="PRINT_STATUS"/>
       </r:field> 
       <r:field fieldName="print_date" width="150px" label="打印时间" allowModify="false">
       <w:date format="yyyy-MM-dd HH:mm:ss" />
       </r:field> 
       <r:field fieldName="print_msg" width="100px" label="打印信息" >
       </r:field> 
    </r:datacell>
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>
