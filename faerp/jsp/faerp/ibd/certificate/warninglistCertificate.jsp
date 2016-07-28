<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>IBD证件提醒</title>
    <script language="javascript">
    function simpleQuery_onClick(){  //简单的模糊查询'
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function setRadioStatus(value,entity,rowNo,cellNo){
        return "<input type='radio' name='checkbox_template' value='"+value+"' >";
    }
    
    //从列表中找出选中的id值列表
    function findSelections(type) {  
        var id = getCheckItem();
        if(id == '') {
            alert('请选择一条记录。');
            return;
        }else{
            var url="<%=request.getContextPath()%>/CertificateItemAction.do?cmd=detail&empId=" + id;
            window.open(url,'','height=600px,width=900px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=派工单修改');
    
        }
    }
	
	//获取选中的节点
	function getCheckItem(){
	   var id = "";
        var dc = $id("datacell1");
        _$("input[type='radio']").each(function(i) {
            if (_$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i];
                var entity = dc.getEntity(row);
                id = entity.getValue("id");
            }
        });
        return id;
	}
	
	//选择客户回调函数
    function rtnFuncEmp(arg){
        var lookup = $id("lk_clz");
        var custName = "";
        if(arg[2].indexOf('（')){
            custName = arg[2].replace("（","(");
        }
        if(arg[2].indexOf('）')){
            custName = custName.replace("）",")");
        }
        var custName = custName.trim();
        lookup.value = custName;
        lookup.displayValue = custName;
        return false;
    }
</script>
    </head>
    <body>

    <form name="form" method="post" id="datacell_formid">
    <input type="hidden" name="cmd" value="">
    <div id="right">
		    <div class="right_title_bg"><div class=" right_title">IBD证件提醒</div>
		    </div>
		    <div class="ringht_s">
		  <div id="ccChild0" class="search">
		        <table width="100%" border="0" cellspacing="0" cellpadding="0">
		            <tr>
		                <td width="174" rowspan="10" style="padding-top: 0;">
		                <div class="search_title">查询条件</div>
		                </td>
		            </tr>
		            <tr>
		                <td align="left">唯一号</td>
		                <td align="left">
		                     <input type="text" class="text_field" name="emp_code" id="emp_code" inputName="员工唯一号" value="" maxLength="64" />
		                </td>
		                <td align="left">员工姓名</td>
		                <td align="left">
		                     <input type="text" class="text_field" name="emp_name" id="emp_name" inputName="员工姓名" value="" maxLength="50" />
		                 </td>
		                <td align="left">客户编号</td>
		                <td align="left">
		                     <input type="text" class="text_field" name="cust_code" id="cust_code" inputName="客户编号" value="" maxLength="50" />
		                 </td>
		            </tr>
		            <tr>
		                <td align="left">客户名称</td>
		                <td align="left">
			                  <w:lookup onReturnFunc="rtnFuncEmp" name="cust_name" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" 
			                  messagekey="choose_customer" height="440" width="600"  style="width:195px"/>
		                </td>
		                <td align="left">证件名称</td>
		                <td align="left">
		                     <input type="text" class="text_field" name="card_name" id="card_name" inputName="证件名称" value="" maxLength="50" />
		                 </td>
		                 <td>提醒月数</td>
		                 <td>
		                     <select name="month" class="text_field">
		                         <option value="1">1</option>
		                         <option value="2">2</option>
		                         <option value="3" selected="selected">3</option>
		                         <option value="4">4</option>
		                         <option value="5">5</option>
		                     </select>
		                 </td>
		            </tr>
		            <tr>
		                 <td align="left">
		                      <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
		                      <input type="reset" class="icon_1" type="button" value="重置">
		                 </td>
		            </tr>
		        </table>
		    </div>
		    <!--查询 end-->
		    <!--按钮-->
		        <div class="button">
		            <div class="button_right">
		                <ul>
		                  <li class="a"><a onClick="javascript:findSelections('view');">查看</a></li>
		                </ul>
		            </div>
		            <div class="clear"></div>
		        </div>
			    <!--按钮 end-->
			    <!--表格 -->
			    <div style="padding: 8 10 8 8;">
			           <r:datacell id="datacell1" queryAction="/FAERP/CertificateAction.do?cmd=simpleWarning" width="100%"
			                  height="320px" xpath="EmployeeVo" submitXpath="EmployeeVo" paramFormId="datacell_formid">
			                    <r:toolbar location="bottom" tools="nav,pagesize,info" />
				                <!--<r:field allowModify="false" fieldName="chk" label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />" sortAt="none" width="30px">
				                    <h:switchCheckbox name="chk" id="chk" checkedValue="1" uncheckedValue="0" />
				                </r:field>-->
				                <r:field fieldName="id" label="操作" width="50px" sortAt="none" onRefreshFunc="setRadioStatus"  align="center"></r:field>
				                <r:field fieldName="emp_name" label="员工姓名" width="120"></r:field>
				                <r:field fieldName="emp_code" label="唯一号" width="150"></r:field>
				                <r:field fieldName="id_card_type_bd" label="证件类型" width="120" allowModify="false">
				                        <d:select name="id_card_type_bd" id="id_card_type_bd" dictTypeId="ID_CARD_TYPE_BD" ></d:select>
				                </r:field>
				                <r:field fieldName="id_card" label="证件号码" width="150"></r:field>
				                <r:field fieldName="cust_code" label="客户编号" width="150"></r:field>
				                <r:field fieldName="cust_name" label="客户" width="220"></r:field>
			            </r:datacell>
			    </div>
		        <!--表格 end-->
		    </div>
		</div>
    </form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>