<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
    function simpleQuery_onClick(){  //简单的模糊查询
    $id("datacell1").loadData();
    $id("datacell1").refresh();
    }

    function detail_onClick(){  //实现转到详细页面
        var ids =document.getElementById("projectbookid").value;
        if(ids == null||ids=="") {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
    
       var url="<%=request.getContextPath()%>/DetailprojectbookAction.do?cmd=detail&id="+ids;
         window.open(url,'','height=400px,width=950,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=项目书详细页面');
    }
    
         function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
    }
         function ClickRow(value){
            $id("projectbookid").value = value;  
        }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" id="projectbookid" name="projectbookid" value="">
<div id="right">
<script language="javascript">
    writeTableTopFesco('项目书管理','<%=request.getContextPath()%>/');  //显示本页的页眉
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
            <td align="left">项目书名称</td>
            <td align="left">
                <input type="text" class="text_field" name="projectbook_name" inputName="projectbook_name" maxLength="50"/>
            </td>
              <td align="left">项目书编号</td>
            <td align="left">
                <input type="text" class="text_field" name="projectbook_code" inputName="projectbook_code" maxLength="50"/>
            </td>
                <td align="left">城市</td>
            <td align="left">
                 <r:comboSelect id="city_id1" name="city_id1"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择"  />
            </td>
                     
        </tr>
        
        <tr>
            <td align="left">服务开始时间</td>
             <td align="left">
                    <w:date allowInput="true" id="start_date" name="start_date" format="yyyy-MM-dd"  width="180px"/>  
            </td>
          <td colspan="4" align="center">
                <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>   
</table>
</div>          
<div id="ccParent1" class="button"> 
 <div class="button_right">
           <!--      <ul>
                    <li class="a">      <a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
                </ul> -->
                  <input class="a" type="button"   value="查看"    onClick="detail_onClick();">
         </div>
           <div class="clear"></div>            
</div>
 
 <div style="padding: 8 10 8 8;">
 <r:datacell id="datacell1" queryAction="/FAERP/DetailprojectbookAction.do?cmd=queryProjectbookData" width="98%" height="318px" xpath="DetailprojectbookVo" paramFormId="datacell_formid" readonly="true">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="emp" label="操作" width="50px"
            onRefreshFunc="setCheckboxStatus" align="center">
        </r:field>
 <r:field fieldName="city_id" label="城市" width="80px"> <r:comboSelect id="cityList"  name="cityList"
                     queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                     textField="city_name"
                     valueField="id"
                     xpath="PB_CITYVo"
                     width="150px" nullText=""/></r:field>
  <r:field fieldName="projectbook_name" label="项目书名称" width="250px"> </r:field>
 <r:field fieldName="projectbook_code" label="项目书编号" width="120px"></r:field>
   <r:field fieldName="start_date" label="服务开始时间" width="110px"  ><w:date format="yyyy-MM-dd"/> </r:field>
   <r:field fieldName="end_date" label="服务结束时间" width="110px"  ><w:date format="yyyy-MM-dd"/> </r:field>
 <r:field fieldName="cust_send_name" label="委托单位" width="250px"></r:field>
  <r:field fieldName="cust_receive_name" label="受托单位" width="250px"></r:field>
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

