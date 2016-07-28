<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%  //取出List
    String Medicalkit = request.getAttribute("Medicalkit")==null?"":request.getAttribute("Medicalkit").toString();
%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
    <head>
    
    <title></title>
    <script language="javascript">
    function select_onClick(){
        entity=choose_row("datacell1");
        var returnAry = new Array();
        returnAry[0] = entity.getProperty("id");
        returnAry[1] = entity.getProperty("city_id");
        returnAry[2] = entity.getProperty("templete_name");
        returnAry[3]=entity.getProperty("templete_content");
        returnAry[4] = entity.getProperty("is_remittance_error");
        window.returnValue = returnAry;
        window.close();
    }
    

    function simpleQuery_onClick(){  //查询所有记录
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function choose_row(dcId){
    dc = $id(dcId);
    obj = dc.getActiveEntity();
        if(!obj){
           alert("请选择一条记录！");
           return;
        }
     return obj;
    }

</script>
    </head>
    <body>

    <form name="form" method="post"  id="datacell_formid">
        
    <input type="hidden" name="backFlag" id="backFlag" value="true">
    <input type="hidden" name="Medicalkit" id="Medicalkit" value="<%=Medicalkit %>">
      <div id="right">
      <div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="140" rowspan="10" style="padding-top: 0;">
            <div class="search_title">查询条件</div>
            </td>
        </tr>
        <tr>
          
            <td align="left">城市</td>
            <td align="left">
                 <r:comboSelect id="city_idList_search" name="city_id1"
                       queryAction="PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                       nullText="请选择" />
            </td>
                  <td align="left">
                 <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
            </td>
        </tr>
        <tr>
        <td align="left">模板名称</td>
            <td align="left">
                 <input type="text" class="text_field" name="templete_name1" value="" maxLength="100"/>
            </td>
            <td align="left">
                 <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
       
            </td>
            <td align="right"></td>
        </tr>
    
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript:select_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
    <div class="clear"></div>
    </div>
         <div  id="div1" style="margin:5 0 0 10px;">
                            <r:datacell 
                            queryAction="/FAERP/AgenttempleteAction.do?cmd=queryTempleteData"
                            id="datacell1"
                            paramFormId="datacell_formid" 
                            width="97%" height="305px" 
                            xpath="AgenttempleteVo"
                            readonly="true"
                            >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                                    <r:field fieldName="city_id" label="城市">
                            <r:comboSelect id="countryList"  name="countryList"
                     queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                     textField="city_name"
                     valueField="id"
                     xpath="PB_CITYVo"
                     width="150px" nullText=""/>
                              </r:field>
                          <r:field fieldName="templete_name" label="服务条款模板名称" width="150px">
                          </r:field>
                
                      
                        </r:datacell>
            </div>
            </div>
            </div>
    </form>
</fmt:bundle>

</body>
</html>
<script type="text/javascript">
$id("datacell1").onDblClickRow = function(rowTR, rowNo ,entity,datacell){
    select_onClick();
}
</script>