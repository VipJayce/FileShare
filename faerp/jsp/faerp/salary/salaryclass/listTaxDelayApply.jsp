<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>

<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>codegen</title>
    <script language="javascript">
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='id'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("id") + "\");>";
    }
    
   _$(document).ready(function() {
            if ($id("lk_cust")) {
                $id("lk_cust").onReturnFunc = function (returnValue){
                    var lookup = $id("lk_cust");
                    lookup.value = returnValue[0];
                    _$("#cust_name").val(returnValue[2]);
                    _$("#cust_id").val(returnValue[0]);
                    lookup.displayValue = returnValue[2];
                    return false;
                }
            }
            $id("datacell1").isQueryFirst = false;
            setDefaultDate("input_date");
    });
    

    function simpleQuery_onClick(){  //简单的模糊查询
       
       $id("datacell1").paramFormId = "datacell_formid";
       $id("datacell1").addParam("cust_id",$id("cust_id").value);
       $id("datacell1").addParam("create_date_from",$id("create_date_from").getValue());
       $id("datacell1").addParam("create_date_to",$id("create_date_to").getValue());
       $id("datacell1").loadData();
       $id("datacell1").refresh();
    }
    
    //审批明细
    function approveDetail(){
        var entity = $id("datacell1").getActiveEntity();
        var wfname="TaxDelayApplyWorkFlow";
        if(entity != null && entity != ""){
             var url="/FAERP/FininvoiceAction.do?cmd=getApprovalDetailsPage&wfname=" + wfname +"&mid=" +entity.getValue("id");
             url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
             showModalCenter(url, window, "",740, 360, "报税延后申请审批详细"); 
        }else{
             alert("请选择一条记录");
        }
    }
    
    
 
 
 
</script>
    </head>
    <body>
    <form name="datacell_formid" method="post" id="datacell_formid">
    <div id="right"><script language="javascript">
    writeTableTopFesco("延后报税申请查询",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
    <div class="ringht_s">


    <div id="ccChild0" class="search">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">


        <tr>
            <td width="174" rowspan="11" style="padding-top: 0;">
            <div class="search_title">查询条件</div>
            </td>

            <td />
            <td />
            <td></td>
            <td />
        </tr>
        <tr>
            <td align="right">选择客户</td>
            <td align="left"><w:lookup readonly="true" id="lk_cust"
                lookupUrl="/FAERP/CustomersimpleAction.do?cmd=getAllCustomerByCondition"
                messagekey="select_cust_name" height="500" width="600" style="width:162px" /></td>
            <input type="hidden" name="cust_name" id="cust_name">
            <input type="hidden" name="cust_id" id="cust_id">
            </td>
            <td align="right">申请时间</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="create_date_from" width="67px" id="create_date_from"/>到<w:date format="yyyy-MM-dd" name="create_date_to" width="67px" id="create_date_to"/></td>
            </td>
        </tr>

        <tr>
            <td/>
            <td/>
            <td><input name="button_ok" class="icon_1" type="button"
                value='查询'
                onClick="javascript:simpleQuery_onClick()"> <input
                name="button_reset" class="icon_1" type="button"
                value='重置'
                onClick="javascript:this.form.reset()"></td>
            <td />
        </tr>
    </table>
    </div>
    <div id="ccParent1" class="button">
    <div class="button_right">
         <input class="e_3" type="button"   value="审批详细"   onClick="approveDetail();">
    </div>
    <div class="clear"></div>
    </div>
    <div style="padding: 5 0 0 5;" >
    <r:datacell id="datacell1"
        queryAction="/FAERP/WorkFlowApplyLogAction.do?cmd=simpleQuery"
        isCount="false" width="99%" xpath="WorkFlowApplyLogVo" readonly="true"
        paramFormId="datacell_formid" height="318px">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
        <r:field fieldName="id" width="0px" label="id">
        </r:field>
        <r:field fieldName="cust_code" width="80px" label="客户编号">
        </r:field>
        <r:field fieldName="cust_name" width="200px" label="客户名称">
        </r:field>
        <r:field fieldName="audit_status" width="120px" label="审批状态">
            <select id="audit_status_select" name="audit_status_select" style="width:120px;">
                    <option value="1">审批中</option>
                    <option value="2">审批通过</option>
                    <option value="3">审批驳回</option>
             </select>
        </r:field>
        <r:field fieldName="pay_day" width="120px" label="工资发放日">
        </r:field>
        <r:field fieldName="apply_reason" width="120px" label="申请原因">
        </r:field>
        <r:field fieldName="approve_user" width="120px" label="最后审批人">
        </r:field>
        <r:field fieldName="apply_user" width="120px" label="申请人">
        </r:field>
        <r:field fieldName="last_update_date" width="140px" label="最后修改时间">
            <w:date format="yyyy-MM-dd HH:mm:ss"/>
        </r:field>
        <r:field fieldName="create_date" width="140px" label="申请时间">
            <w:date format="yyyy-MM-dd HH:mm:ss"/>
        </r:field>

    </r:datacell>
    </div>
    </div>
    </div>
    </form>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

