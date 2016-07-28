<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>到款查询</title>
<script language="javascript">
    jQuery(document).ready(function() {
        jQuery("#inc_date_from_input").dblclick(function(){
            jQuery(this).val("2014-01-01");
        });
    });
    //第一次不加载数据
    jQuery(function(){
        $id("datacell1").isQueryFirst = false;
        $id("celllist1").isQueryFirst = false;
        $id("celllist2").isQueryFirst = false;
    });
    
    function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + entity.getProperty("id") + "\",\"" + entity.getProperty("inc_code") + "\");>";
    }

   function ClickRow(tid,inc_code){
          //$id("tid").value = tid+"";
          $id("celllist1").addParam("incoming_id",tid);
          $id("celllist1").loadData();
          $id("celllist1").refresh();
          
          $id("celllist2").addParam("incoming_id",tid);
          $id("celllist2").loadData();
          $id("celllist2").refresh();
    }
    //查询数据
    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }

	
	//导出数据
     function exportToExcel() {  
         if(confirm('是否确定要导出数据？')) {
	            form.action="<%=request.getContextPath()%>/FININCOMINGAction.do?cmd=exportToExcel";
	            form.submit();
          }
      }  
      
      
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
	<script language="javascript">
		writeTableTopFesco('到款查询','<%=request.getContextPath()%>/');  //显示本页的页眉
	</script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


            <tr>
            <td width="132" rowspan="4" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
            <td width="85"/>
            <td width="196"/>
              <td width="143">    </td>
                <td width="240"/>
        </tr>
                <tr>
            <td align="right">到款编号</td>
            <td align="left"><input type="text" class="text_field" name="inc_code" inputName="到款编号" maxLength="10" value="" style="width: 180px;"/>			</td>
            <td align="right">到款公司名称</td>
            <td align="left">   
                    <input type="text" class="text_field" name="inc_cust_name" inputName="到款公司名称" maxLength="30" value="" style="width: 180px;"/>
             </td>
            <td  align="right">客户名称</td>
            <td  align="left">
            <input type="text" class="text_field" name="last_claim_cust_name" inputName="客户名称" maxLength="30" value="" style="width: 180px;"/>
            </td>
        </tr>
        
        
        <tr>
            <td align="right">到款日期</td>
            <td align="left">
                <w:date format="yyyy-MM-dd" name="inc_date_from" width="67px"/>到<w:date format="yyyy-MM-dd" name="inc_date_to" width="67px"/>
            </td>
            <td align="right">到款金额</td>
                        <td align="left">
                        <input type="text" class="text_field"  style="width:82px" name="inc_amout_from" value="" maxLength="15" onKeyUp="if(isNaN(value))execCommand('undo')"  id="transact_day_from"/>到<input type="text" class="text_field" style="width:82px" maxLength="15" onKeyUp="if(isNaN(value))execCommand('undo')"  name="inc_amout_to" value=""  id="transact_day_to" />
                        </td>
            <td align="right">上传时间</td>
                        <td align="left">
                        <w:date format="yyyy-MM-dd" name="upload_date_from" width="67px"/>到<w:date format="yyyy-MM-dd" name="upload_date_to" width="67px"/></td>
                        </td>
        </tr>
        
        <tr>
            <td align="right">认领状态</td>
            <td align="left">
			<d:select dictTypeId="CLAIM_STATUS_BD" name="claim_status_bd" nullLabel="--请选择--" style="width: 180px;"/>
			</td>
            <td align="right">认领人</td>
                        <td align="left"><input type="text" class="text_field" name="last_claim_user_id" inputName="认领人" maxLength="20" value="" style="width: 180px;"/></td>
            <td align="right">&nbsp;</td>
                        <td align="left">
                    <input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:showListData()">
                    <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
</td>
        </tr>
        
        <tr>
            <td/>
            <td/>
              <td>&nbsp;</td>
                <td/>&nbsp;
        </tr>
</table>
</div>
</form>

<div id="ccParent1" class="button"> 
 <div class="button_right">
                <!--<ul>
                    <li class="e">      <a  onClick="javascript:exportToExcel();">导出</a> </li>
                </ul>
                -->
                <input class="e" type="button"   value="导出"  <au:authorityBtn code="cxdk_exp" type="1"/>  onClick="exportToExcel();">
         </div>
           <div class="clear"></div>            
</div>

<div style="padding: 8 0 8 8;">
        <r:datacell 
        id="datacell1"
        paramFormId="datacell_formid"
        queryAction="/FAERP/FININCOMINGAction.do?cmd=searchIncomingQueryData"
        width="98%"
        height="250px"
        xpath="FININCOMINGVo"
        readonly="true"
        pageSize="100"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center" >
       </r:field> 
      <r:field fieldName="inc_code" label="到款编号" width="85px">
        <h:text/>
      </r:field>
      <r:field fieldName="inc_date" label="到款日期" width="85px">
        <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="inc_cust_name" label="到款公司名称" width="200px" >
        <h:text/>
      </r:field>
      <r:field fieldName="inc_amout" label=" 到款额" width="85px">
        <h:text/>
      </r:field>
      <r:field fieldName="customer_code" label="认领客户编号" width="90px;"></r:field>
      <r:field fieldName="last_claim_cust_name" label="认领客户名称" width="200px">
        <h:text/>
      </r:field>     
      <r:field fieldName="create_user_id" label="创建人"  width="70px">
        <h:text/>
      </r:field>
      <r:field fieldName="upload_date" label=" 上传时间" width="85px">
        <w:date format="yyyy-MM-dd"/>
      </r:field>
      <r:field fieldName="last_claim_user_id" label="认领人" width="70px">
        <h:text/>
      </r:field>   
      <r:field fieldName="inc_bank" label="银行" width="60px">
      <d:select dictTypeId="BANK"></d:select>
      </r:field>
      <r:field fieldName="last_claim_date" label="认领时间" width="140px;" allowModify="false">
      <w:date name="last_claim_date" />
      </r:field>
      <r:field fieldName="claim_status_bd" label="认领状态" >
        <d:select dictTypeId="CLAIM_STATUS_BD" />
      </r:field>
      <r:field fieldName="un_claim_amout" label="未认领金额" >
       <h:text/>
      </r:field>
    </r:datacell>
    </div>
    
    
    <table cellpadding="0" style="padding: 8 0 8 8;" border="0" width="99%">
    <tr>
        <td valign="top" width="70%">
            认领记录<br>
                    <r:datacell 
                        id="celllist1"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/FININCOMINGAction.do?cmd=getFinverificationByIncomingID"
                        width="100%" height="250px"
                        xpath="FinverificationVo"
                        readonly="true"
                        >
                
                      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                      <r:field fieldName="cust_code" label="客户编号" width="70px">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="cust_name" label="客户名称" width="190px">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="cost_center_name" label="成本中心" width="190px">
                        <h:text/>
                      </r:field>        
                      <r:field fieldName="create_date" label="认领日期" width="150px">
                      </r:field>
                      <r:field fieldName="ver_amount" label="认领金额" width="90px">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="balance_amount" label="预收金额" width="70px">
                        <h:text/>
                      </r:field>
                       <r:field fieldName="create_user_id" label="认领人" width="70px">
                        <h:text/>
                      </r:field>                     
                      <r:field fieldName="bill_type_bd" label="应收类型" width="90px">
                        <d:select dictTypeId="BILL_TYPE_BD"/>
                      </r:field>
                      <r:field fieldName="bill_year_month" label="应收年月" width="70px">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="bill_amount" label="应收金额" width="90px">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="ver_invoice_status_bd" label="开票状态" width="90px">
                        <d:select dictTypeId="INVOICE_STATUS_BD"/>
                      </r:field>
                    </r:datacell>
        </td>
     </tr>
   </table>
   
   
   <table cellpadding="0" style="padding: 8 0 8 8;" border="0" width="99%">
    <tr>
        <td valign="top" width="100%">
            无账单认领记录<br>
                    <r:datacell 
				        id="celllist2"
				        paramFormId="datacell_formid"
				        queryAction="/FAERP/FinclaimAction.do?cmd=searchDataFinClaim&v_inc_code=v_inc_code"
				        width="100%"
				        height="250px"
				        xpath="FinclaimVo"
				        readonly="true"
				        pageSize="100"
				        >
				      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
				      <r:field fieldName="inc_cust_name" label="到款公司名称" width="200px" >
				        <h:text/>
				      </r:field>
				      <r:field fieldName="inc_amout" label=" 到款额" width="90px">
				        <h:text/>
				      </r:field>
				      <r:field fieldName="inc_date" label="到款日期"  width="80px">
				        <w:date format="yyyy-MM-dd"/>
				      </r:field>
				      <r:field fieldName="last_claim_cust_name" label="认领客户名称" width="180px;">
				      </r:field>
				      <r:field fieldName="claim_amount" label="认领金额" width="90px">
				        <h:text/>
				      </r:field>     
				      <r:field fieldName="claim_user_id" label="认领人" width="70px">
				        <h:text/>
				      </r:field>
				      <r:field fieldName="claim_year_month" label=" 认领帐期" width="60px">
				      </r:field>
				      <r:field fieldName="create_date" label=" 认领时间"  width="130px;">
				        <w:date format="yyyy-MM-dd HH:mm:ss"/>
				      </r:field>
				      <r:field fieldName="claim_desc" label="认领备注" width="240px;">
				       <h:text/>
				      </r:field>
				    </r:datacell>
        </td>
     </tr>
   </table>
    
</div>
</div>

</fmt:bundle>
</body>
</html>

