<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">
	 function setCheckboxStatus(value,entity,rowNo,cellNo){
	       return "<input type='radio'  name='temp' value='"+value+"'  );>";
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

	function simpleQuery_onClick(){  //简单的模糊查询
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
  	
  	//选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("cust_name1");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        return false;
    }
    
    //回访记录导出  
    function toDownLoad_onclick()
    {
      if(confirm('是否确定要导出数据？')) {
          document.form.action="<%=request.getContextPath()%>/VisitrecordAction.do?cmd=exportVisitrecordToExcel";
          document.form.submit();
      }
    }
    
    //查看按钮事件
    function detail_onClick(){  //实现转到详细页面
        var ids = findSelections("temp");
        if(ids == null || ids == '') {
            alert('请选择一条记录！');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('只能选择一条数据！');
            return;
        }
        var url="<%=request.getContextPath()%>/VisitrecordAction.do?cmd=detail&id=" + ids;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        showModalCenter(url, window, simpleQuery_onClick, 900, 350, "查看回访记录"); 
    }
</script>
</head>
<body>

<form name="form"   id="datacell_formid"  method="post">
<div id="right">
<script language="javascript">
	writeTableTopFesco("回访记录",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="187" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
        </tr>
        <tr>
          <td align="right">唯一号</td>
          <td align="left"><input type="text" class="text_field" name="emp_code1" inputName="唯一号" maxLength="19"/></td>
          <td align="right">员工姓名</td>
          <td align="left"><input type="text" class="text_field" name="emp_name1" inputName="员工姓名" maxLength="50"/></td>
          <td align="right">客户编号</td>
            <td align="left"><input type="text" class="text_field" name="cust_code1" inputName="客户编号" maxLength="25"/></td>
        </tr>
        <tr>
            <td align="right">客户名称</td>
            <td align="left">
                 <w:lookup onReturnFunc="rtnFuncCustomer" name="cust_name1" id="cust_name1" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:195px"/>
            </td>
            <td align="right">福利城市</td>
            <td align="left">
                  <r:comboSelect id="city_id" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="--请选择--" /> 
            </td>
            <td align="right">呼叫结果</td>
            <td align="left"><d:select dictTypeId="CALL_RESULT" name="call_result" id="call_result" nullLabel="--请选择--" /></td>
        </tr>
        <tr>
             <td align="right">呼叫类型</td>
            <td align="left"><d:select dictTypeId="CALL_TYPE" name="call_type" id="call_type" nullLabel="--请选择--" /></td>
             <td align="right">&nbsp;</td>
            <td align="left">&nbsp;</td>
            <td align="right"><input name="button_ok22" id="button_ok22" class="icon_1"   type="button" value='查询' onClick="javascript:simpleQuery_onClick()"></td>
            <td>&nbsp;&nbsp;&nbsp;<input name="button_reset" class="icon_1" type="button" value='重置' onClick="javascript:this.form.reset()"></td>
        </tr>
    </table>
</div>
                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
           <input type="button" class="a" value="查看" onClick="detail_onClick();" /> 
           <input type="button"  class="e_2" value="回访记录导出" onClick="toDownLoad_onclick();"  />
         </div>
           <div class="clear"></div>
</div>
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/VisitrecordAction.do?cmd=simpleQuery"
        width="99%"
        height="320px"
        xpath="VisitrecordVo"
        submitXpath="VisitrecordVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field> 
       <r:field fieldName="emp_code"  label="唯一号">
      </r:field>          
       <r:field fieldName="emp_name"  label="员工姓名">
      </r:field>
      <r:field fieldName="cust_code"  label="客户编号">
      </r:field>          
       <r:field fieldName="cust_name"  label="客户名称">
      </r:field>
      <r:field fieldName="id_card" label="身份证号">
      </r:field>
      <r:field fieldName="mobile" label="手机">
      </r:field>
      <r:field fieldName="city_name" label="福利城市">
      </r:field>
      <r:field width="150" fieldName="apply_on_post_date" label="入职时间" allowModify="false">
       <w:date format="yyyy-MM-dd" />
      </r:field>
      <r:field width="150" fieldName="call_time" label="呼叫时间" allowModify="false">
       <w:date format="yyyy-MM-dd" />
      </r:field>
      <r:field fieldName="call_type" label="呼叫类型">
      <d:select dictTypeId="CALL_TYPE" />
      </r:field>
      <r:field fieldName="call_result" label="呼叫结果">
      <d:select dictTypeId="CALL_RESULT" />
      </r:field>
       <r:field fieldName="is_notice" label="员工是否收到福利供应商办理入职手续通知">
       <d:select dictTypeId="IS_NOTICE" />
      </r:field>
      <r:field fieldName="is_understand" label="员工对入职流程是否明确">
      <d:select dictTypeId="IS_UNDERSTAND" />
      </r:field>
      <r:field fieldName="cause_remark" label="员工不清晰流程记录">
      </r:field>
      <r:field fieldName="other_remark" label="备注">
      </r:field>
       <r:field fieldName="call_msg" label="失败原因">
      </r:field>
    </r:datacell>
    </div>
</div>
</div>
</form>
</body>
</html>
