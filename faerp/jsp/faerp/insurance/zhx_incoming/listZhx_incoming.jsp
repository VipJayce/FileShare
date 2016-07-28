<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中信到款导入查询</title>
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
    //删除
    function deleteMulti_onClick(){
      var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/Zhx_incomingAction.do?cmd=deleteMulti&ids=" + ids;
        form.submit();
    }
    
    //查看详细
	function detail_onClick() {  
		  var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        var url = "<%=request.getContextPath()%>/Zhx_incomingAction.do?cmd=detail&id=" + ids+"&_ts="+(new Date()).getTime();
        window.open(url,'','height=430px,width=750px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看客户信息');
	}  
	
	//查询
	function simpleQuery_onClick(){
	    $id("Zhx_incoming").loadData();
        $id("Zhx_incoming").refresh();
	}
	
	/*点击全选
	function checkAll(item) {
    if (_$(item).attr("checked")) {
        changeEntityChk(true);
        _$(":checkbox").attr("checked", true);
    } else {
        changeEntityChk(false);
        _$(":checkbox").attr("checked", false);
    }
}
*/
 jQuery(document).ready(function(){
  jQuery("#importZX").bind("click", function(){
           vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/insurance/zhx_incoming/import_zhx_incoming.jsp", "", "dialogWidth=600px; dialogHeight=250px");
           if (vReturnValue == '1') {
                jQuery("#button_ok").click();
           }
          });
        });

    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    
    
    
       function downLoad_onClick(){
        form.action="<%=request.getContextPath()%>/Zhx_incomingAction.do?cmd=downLoadExcel";
        form.submit();
    }

</script>
</head>
<body>

<form name="form" method="post"  id="datacell_formid">
<div id="right">
<script language="javascript">
	writeTableTopFesco('中信到款导入查询','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
			<td align="right">文件类型&nbsp;</td>
			<td align="left">
				<input type="text" class="text_field" name="file_type" inputName="文件类型" size="140px"/>
			</td>
		<td align="right">标题&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" name="title" inputName="标题" size="140px"/>
            </td>
                   <td align="right">到款查询人&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" name="inquiry_user" inputName="查询用户"  size="140px"/>
		</tr>
		<tr>
	
                   <td align="right">到款查询时间&nbsp;</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="inquiry_time"   style="size:140px"/>
            </td>
            <td></td>
            <td></td>
            <td></td>
		    <td align="left">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
		</tr>
</table>
</div>


 

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
					<input  class="a_1"  type="button" onClick="javascript:detail_onClick();" value="查看详细">
					<input class="xz_1" type="button"   value="下载中信模板"   onClick="downLoad_onClick();">
					 <input type="button" id="importZX"  class="p_1"  value="上传中信到款明细"/>
					<input class="d"   type="button" onClick="javascript:deleteMulti_onClick();" value="删除">
		 </div>
           <div class="clear"></div>			
</div>

<div style="padding: 5 0 8 8;">
        <r:datacell
            id="Zhx_incoming"
            paramFormId="datacell_formid"
            queryAction="/FAERP/Zhx_incomingAction.do?cmd=queryAll"
            submitAction="#"
            width="98%"
            height="318px"
            xpath="Zhx_incomingVo"
            submitXpath="Zhx_incomingVo"
            pageSize="100"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
           <r:field fieldName="id" label="操作" width="40px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
            <r:field fieldName="file_type" label="文件类型" width="120px;" allowModify="false"/>
            <r:field fieldName="title" label="标题" allowModify="false">
            </r:field>
            <r:field fieldName="inquiry_user" label="查询用户" width="100px;" allowModify="false"/>
             <r:field fieldName="inquiry_time" label="查询时间" allowModify="false">
                <w:date format="yyyy-MM-dd"/>
            </r:field>
             <r:field fieldName="inquiry_condition" label="查询条件" width="120px;" allowModify="false"/>
             <r:field fieldName="deal_time" label="交易日期" width="120px;" allowModify="false"/>
             <r:field fieldName="money_range" label="金额范围" width="120px;" allowModify="false"/>
             <r:field fieldName="account" label="账户信息" width="120px;" allowModify="false"/>
               <r:field fieldName="create_user_name" label="上传人" width="100px;" allowModify="false"/>
                <r:field fieldName="create_date" label="上传时间" allowModify="false">
                <w:date format="yyyy-MM-dd"/>
            </r:field>
            
        </r:datacell>
    </div>
</div>
</div>
</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">

</script>	
