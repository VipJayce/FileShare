<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="rayoo.finance.billimport.finbillimpdatacountry.finbillimpdatacountry_resource" prefix="rayoo.finance.billimport.finbillimpdatacountry.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
     function setCheckboxStatus(value,entity,rowNo,cellNo){
        return "<input type='radio'  name='temp' onClick=\"ClickRow('" + entity.getProperty("id") + "','"+entity.getProperty("is_compared") +"');\">";
     }
    
    function ClickRow(value,value2){
        document.getElementById("cid").value=value;
        document.getElementById("compared").value=value2;
    }

    function showListData(){
         $id("celllist1").loadData();
         $id("celllist1").refresh();
     }

    function toCompare(){
        var imp_id=jQuery("#cid").val();
        if(imp_id == null || imp_id == ""){
            alert("请选择一条数据！");
            return;
        }
        var compared=jQuery("#compared").val();
         if(compared==1){
            alert("已经比对过的数据不能再次计算！");
            return;
         }
         document.getElementById("comparedbutton").disabled="disabled";//锁按钮
        jQuery.getJSON("<%=request.getContextPath()%>/GeimphwtAction.do?cmd=toCompare&date="+new Date()+"",{"imp_id":imp_id},function(json){
             if(json.saia!=""){
                alert(json.saia);
                document.getElementById("comparedbutton").disabled="";
             }else{
                alert("比对完成！");
                document.getElementById("comparedbutton").disabled="";
                $id("celllist1").loadData();
                $id("celllist1").refresh();
             }
         });
    }
    
    //删除
    function delete_onClick(){
        var imp_id=jQuery("#cid").val();
        if(imp_id == null || imp_id == ""){
            alert("<fmt:message key='alert_select_one_delete'/>");
            return;
        }
        jQuery.getJSON("<%=request.getContextPath()%>/GeimphwtAction.do?cmd=deleteData&date="+new Date()+"",{"imp_id":imp_id},function(json){
             if(json.saia!=""){
                alert(json.saia);
             }else{
                alert("<fmt:message key='alert_delete_confirm'/>");
                $id("celllist1").loadData();
                $id("celllist1").refresh();
             }
         });
    }
    
     jQuery(function(){
        $id("celllist1").isQueryFirst = false;
    });
    
    function showWindow(){
         var id=document.getElementById("cid").value;
        //$id("celllist1").submit();//提交
          var url="<%=request.getContextPath()%>/jsp/faerp/finance/billimport/finbillimpbatchn/detailFinbillimpbatchn.jsp?cid="+id;
          showModalCenter(url, window,"",900,410,"<fmt:message key='page_detailFinbillimpbatchn'/>");       
    }

    jQuery(document).ready(function(){
    jQuery("#importHwt").bind("click", function(){
       vReturnValue = window.showModalDialog("<%=request.getContextPath()%>/jsp/faerp/ge/geimphwt/importHwtExcel.jsp", "", "dialogWidth=600px; dialogHeight=250px");
       if (vReturnValue == '1') {
            jQuery("#button_ok22").click();
       }
      }
    );
});

//报表导出
function exp_onClick(){
    var imp_id=jQuery("#cid").val();
        if(imp_id == null || imp_id == ""){
            alert("<fmt:message key='alert_select_one_delete'/>");
            return;
        }
        var compared=jQuery("#compared").val();
         if(compared==0){
            alert("该数据未比对，不能导出！");
            return;
         }
     $id("datacell_formid").action=encodeURI("<%=request.getContextPath()%>/jsp/faerp/reportJsp/showGeComparedReport.jsp?raq=ge_group_report.rpg&imp_id="+imp_id);
     $id("datacell_formid").submit();
}

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
 <div id="right">
<div class="ringht_s">
 <input type="hidden" id="cid" name="cid"/>
 <input type="hidden" id="compared" name="compared"/>
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">

        <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key='title_search'/></div> </td>
        </tr>
        <tr>
            <td align="right">批次号&nbsp;</td>
            <td align="left">
               <input type="text" class="text_field" name="imp_batch_id1" id="imp_batch_id1" inputName="批次号" maxLength="64" style="width:215"/>            </td>
            <td align="right">导入时间&nbsp;</td>
            <td align="left"><w:date format="yyyy-MM-dd" name="create_date_from" width="80px"/>&nbsp;到&nbsp;<w:date format="yyyy-MM-dd" name="create_date_to" width="80px"/></td>
            <td align="right">导入人&nbsp;</td>
            <td align="left">
                <input type="text" class="text_field" name="create_user_name1" id="create_user_name1" inputName="操作人" maxLength="64" style="width:215"/>            </td>
        </tr>
        <tr>
            <td>导入批次名称&nbsp;</td>
            <td><input type="text" class="text_field" name="batch_name" id="batch_name" inputName="导入批次名称" style="width:215"/></td>
            <td align="right">比对状态&nbsp;</td>
           <td align="left"><d:select id="is_compared1" name="is_compared1" dictTypeId="IS_COMPARED" nullLabel="--请选择--" /></td>
            <td align="right"></td>
            <td align="left">
        </tr>
        <tr>
        <td colspan="4" align="right">
               <input name="button_ok22"  id="button_ok22" class="icon_1"   type="button" value='<fmt:message key="button_query"/>' onClick="javascript:showListData()">&nbsp;&nbsp;
           </td>
           <td>   
              <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="button_reset"/>' onClick="javascript:this.form.reset()">
            </td>
        </tr>
</table>
</div>

<input type="hidden" name="postid" id="postid" value="">
<div id="ccParent1" class="button"> 
     <div class="button_right">
    <input type="button" id="importHwt"  class="e_1" value="导入"   />
    <!-- 
    <input type="button" class="a" value="<fmt:message key='button_item'/>" onClick="showWindow();" />
     -->
    <input type="button" class="d" value="<fmt:message key='button_shanchu'/>"  onClick="delete_onClick()" />
    <input class="bc_1"   id="comparedbutton"  type="button" value="计算" onClick="toCompare();">
    <input type="button" class="bl"  value="导出"  onClick="exp_onClick();" />
    
    </div>
    <div class="clear"></div>           
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="celllist1"
        queryAction="/FAERP/GeimphwtAction.do?cmd=QueryData"
        submitAction="/FAERP/GeimphwtAction.do?cmd=toCompare"
        width="99%"
        height="305px" 
        xpath="GeimpVo"
        paramFormId="datacell_formid"
        >

      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="id" messagekey="operation" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
      </r:field>
      <r:field fieldName="id"  label="批次号" width="170">
      </r:field>
      <r:field fieldName="imp_name"   label="批次名称"  width="350" allowModify="false">
        <h:text/>
      </r:field>
      <r:field fieldName="create_date" messagekey="create_date" width="140">
        <w:date  name="" readOnly="true"/>
      </r:field>
      <r:field fieldName="create_user_name" label="导入人"  width="100" allowModify="false">
      </r:field>
      <r:field fieldName="is_compared" label="是否已比对"  width="100" allowModify="false">
      <d:select dictTypeId="IS_COMPARED"/>
      </r:field>
       <r:field fieldName="last_update_user_name" label="比对人"  width="150">
      </r:field>
    </r:datacell>
    </div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

