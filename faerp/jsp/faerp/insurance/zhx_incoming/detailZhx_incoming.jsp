<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<%String zhx_id=request.getAttribute("zhx_id").toString(); %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中信到款导入明细查询</title>
<script language="javascript">
    //查询
    function simpleQuery_onClick(){
        $id("Zhx_incoming").loadData();
        $id("Zhx_incoming").refresh();
    }
  
</script>
</head>
<body>

<form name="form" method="post"  id="datacell_formid">
 <input type="hidden" name="zhx_id" id="zhx_id" value="<%=zhx_id %>">
<div id="right">
<script language="javascript">
    writeTableTopFesco('中信到款导入明细','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<!--  

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
                   <td align="right">到款查询用户&nbsp;</td>
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
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClickTo="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>
-->
 

                    
<div id="ccParent1" class="button"> 
           <div class="clear"></div>            
</div>
<div style="padding: 5 0 8 8;">
        <r:datacell
            id="Zhx_incoming"
            paramFormId="datacell_formid"
            queryAction="/FAERP/Zhx_incomingAction.do?cmd=query_item&id=${requestScope.zhx_id}"
            submitAction="#"
            width="98%"
            height="318px"
            xpath="Zhx_incoming_ItemVo"
            submitXpath="Zhx_incoming_ItemVo"
            pageSize="100"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field fieldName="deal_time" label="交易日期" width="80px;" allowModify="false"/>
            <r:field fieldName="account" label="对方帐号" allowModify="false" width="120px;">
            </r:field>
            <r:field fieldName="account_name" label="对方账户名称" width="160px;" allowModify="false"/>
             <r:field fieldName="pay_money" label="付款发生额" width="100px;" allowModify="false"/>
             <r:field fieldName="income_money" label="收款发生额" width="100px;" allowModify="false"/>
             <r:field fieldName="remark" label="摘要" width="120px;" allowModify="false"/>
            
        </r:datacell>
    </div>
</div>
</div>
</form>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</fmt:bundle>
</html>

<script language="javascript">

</script>   
