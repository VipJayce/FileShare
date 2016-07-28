<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@ page import="java.util.List" %>
<%@ page import="gap.dd.basedata.vo.BaseDataVo" %>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<link rel="stylesheet" type="text/css" href="js/jquery/multiselect/jquery.multiselect.css" />
<link rel="stylesheet" type="text/css" href="js/jquery/multiselect/style.css" />
<link rel="stylesheet" type="text/css" href="js/jquery/multiselect/jquery-ui.css" />
<script type="text/javascript" src="js/jquery/multiselect/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jquery/multiselect/jquery.multiselect.js"></script>

<%
    List<BaseDataVo> listBig = BaseDataHelper.getData("bill_reason_big_type");
    List<BaseDataVo> listSmall = BaseDataHelper.getData("bill_reason_small_type");
    request.setAttribute("listBig",listBig);
    request.setAttribute("listSmall",listSmall);
%>

<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.authority.helper.LoginHelper" %>
<script language="javascript" src="<venus:base/>/jsp/faerp/finance/bill/billmodify/billmodifypage.js"></script>
<html>
<fmt:bundle basename="rayoo.finance.bill.billmodify.billmodify_resource" prefix="rayoo.finance.bill.billmodify.">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title><fmt:message key='title_billmodify_detail'/></title>
	
    <script language="javascript">
        var venusbase = "<%=request.getContextPath()%>";
    </script>
    <script language="javascript">
        var bigChecked = "";//初始化已选择原因分类大类
        var bigCheckedVal = "";//初始化已选择原因分类大类val
        var savedBigTypeVal = "${billVo.bill_reason_big_type }";
        var savedSmallTypeVal = "${billVo.bill_reason_small_type }";
        window.onload=function(){//初始化多选下拉菜单
            
            if("${billVo.bill_other_reason }" != ""){
                document.getElementById("otherReasonDiv").style.display = "block";
            }else{
                document.getElementById("otherReasonDiv").style.display = "none";
            }
        
            if(savedBigTypeVal != ""){
                _jQuery('#bill_reason_big_type_mul option').each(function(i){//回显已选中的原因分类大类
	                if(this.value == savedBigTypeVal){ 
	                    bigCheckedVal = this.value;
	                    _jQuery("#bill_reason_big_type_mul").get(0).options[i].selected = true;//设置为选中。 
	                    bigChecked = _jQuery('#bill_reason_big_type_mul option[value="'+this.value+'"]').text();
	                } 
	             });
            }
            
            if(savedSmallTypeVal != ""){
                _jQuery('#bill_reason_small_type_mul option').each(function(i){//回显已选中的原因分类小类
	                if(savedSmallTypeVal.indexOf(this.value) >= 0){ 
	                    _jQuery("#bill_reason_small_type_mul").get(0).options[i].selected = true;//设置为选中。 
	                } 
	             });
            }
             
             _jQuery("#bill_reason_small_type_mul").multiselect({
                  header: true,
			      height: 175,
			      minWidth: 250,
			      classes: '',
			      checkAllText: '全选',
			      uncheckAllText: '全不选',
			      noneSelectedText: '--请选择--',
			      selectedText: '# 项已选',
			      selectedList: 0,
			      show: null,
			      hide: null,
			      autoOpen: false,
			      multiple: true,
			      position: {},
			      appendTo: "body"
             });
             
            _jQuery("#bill_reason_big_type_mul").multiselect({ 
                  header: false,
                  height: 175,
                  minWidth: 250,
                  classes: '',
                  noneSelectedText: '--请选择--',
                  selectedText: bigChecked,
                  selectedList: 0,
                  show: null,
                  hide: null,
                  autoOpen: false,
                  multiple: false,
                  position: {},
                  appendTo: "body"
            });
        }
    
        //原因分类，是大分类选择4：其他，可以手工填写内容
        function otherDiv(val){
            var otherReasonObj = document.getElementById("otherReasonDiv");
            if(val == "4"){
                otherReasonObj.style.display="block";
            }else{
                otherReasonObj.style.display="none";
            }
           var bill_reason_big_type_mulChecked = _jQuery("#bill_reason_big_type_mul").val();  
           _jQuery('#bill_reason_big_type_mul option').each(function(i){
                if(_jQuery("#bill_reason_big_type_mul").get(0).options[i].selected){
                    bigCheckedVal = this.value;
                    bigChecked = _jQuery('#bill_reason_big_type_mul option[value="'+this.value+'"]').text();
                }
             });
             
            _jQuery("#bill_reason_big_type_mul").multiselect({ 
                  header: false,
                  height: 175,
                  minWidth: 250,
                  classes: '',
                  selectedText: bigChecked,
                  selectedList: 0,
                  show: null,
                  hide: null,
                  autoOpen: false,
                  multiple: false,
                  position: {},
                  appendTo: "body"
            });
        }
        
        //提交审核前获取所有选中的原因分类，包括大类和小类，传递到后台保存入库
       function getReasonType(){
           var smallValSub = "";//初始化提交前，小类代码
           var small_type_mul_vals = _jQuery("#bill_reason_small_type_mul").val();  
           var flag = true;
           var errorDesc = "";
           _jQuery('#bill_reason_small_type_mul option').each(function(i){//回显已选中的原因分类小类
                if(_jQuery("#bill_reason_small_type_mul").get(0).options[i].selected){ 
                    smallValSub += this.value + ";";
                } 
             });
           if(bigCheckedVal == "" || smallValSub == ""){
                flag = false;
                errorDesc = "请选择原因分类大类和小类！";
           }/*else{
                var applymsg = document.getElementById("applymsg").value;
                if(bigCheckedVal == "4" && (applymsg == "" || applymsg == "null" || applymsg == null)){
                    flag = false;
                    errorDesc = "原因分类大类为其他时，备注必须填写！";
                }
           }*/
           var otherReason = document.getElementById("otherReason").value;
           var result = flag+"*"+errorDesc+"*"+smallValSub+"*"+otherReason;
           return result;
        }
    
        function exportEXCEL_onClick(){
	        //导数据前先提交当前页面修改数据
	         var isupdate = $id("isupdate").value ;
                if(isupdate == "yes"){
                    var xmlSubmit = $id("datacell2").dataset.toString();
		            var myAjax = new Ajax("/FAERP/FinbillitemTempAction.do?cmd=updateFinbillTemp");
		            myAjax.addParam('bill_id', $id("bill_id").value);
		            myAjax.addParam('bill_temp_id', $id("bill_temp_id").value);
		            myAjax.loadData(xmlSubmit);
		            var returnNode = myAjax.getResponseXMLDom();
                }
            //导出数据
	        var bill_id = $id("bill_temp_id").value;
	        var cost_center_name = document.form.cost_center_name.value;
	        var bill_year_month = document.form.bill_year_month.value;
	        var bill_code = document.form.bill_code.value;
	        var login_name = document.form.login_name.value;
	        if(bill_id != null && bill_id !=""){
	            $id("datacell_formid").action="<%=request.getContextPath()%>/jsp/faerp/reportJsp/showBillModifyReport.jsp?raq=bill_modify_new.raq&arg1="+bill_id+"&arg2="+cost_center_name+"&arg3="+bill_year_month+"&arg4="+bill_code+"&arg5="+login_name;
	            $id("datacell_formid").submit();
	        }else{
	           alert("<fmt:message key='alert_data_error'/>");
	           return;
	        }
	    }
	    //查询
	    function select_onClick(){
	        //var isbuttonselect = $id("isbuttonselect").value ;
	        //判断是否是第一次查询
	       // if(isbuttonselect == null||isbuttonselect==""){
	       //    $id("datacell2").reload() ;
	       // }else{
	            var isupdate = $id("isupdate").value ;
	            if(isupdate == "yes"){
	               var xmlSubmit = $id("datacell2").dataset.toString();
	                var myAjax = new Ajax("/FAERP/FinbillitemTempAction.do?cmd=updateFinbillTemp");
	                myAjax.addParam('bill_id', $id("bill_id").value);
	                myAjax.addParam('bill_temp_id', $id("bill_temp_id").value);
	                myAjax.loadData(xmlSubmit);
	                var returnNode = myAjax.getResponseXMLDom();
	            }
	            $id("datacell2").reload() ;
	       // }
	       //$id("isbuttonselect").value = "yes" ;
	    }
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<!--<script language="javascript">
   writeTableTopFesco('账单明细修改','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
--><div class="ringht_s">
	<div style="padding-top:10px; text-align:center;" class="xz_title">${billVo.cost_center_name }${fn:substring(billVo.bill_year_month, 0, 4) }<fmt:message key='year'/>${fn:substring(billVo.bill_year_month, 4, 6) }<fmt:message key='month'/></div>
     <table width="100%">
            <tr>
                <td align="center"><fmt:message key='empnameorcode'/>:&nbsp;&nbsp;<input type="text" name="empnameorcode" id="empnameorcode" /></td>
                <td align="left"><input name="button1" type="button" class="icon_1" onclick="javascript:select_onClick();"  value="<fmt:message key='button_query'/>" /></td>
                <td align="left"><input name="button2" type="button" class="icon_1" onclick="javascript:exportEXCEL_onClick();"  value="<fmt:message key='button_export_exl'/>" /></td>
                <td ><li style="font-size:12px; font-weight:inherit; width:200px; margin-left:50%;"><fmt:message key='bill_code'/>：${billVo.bill_code }</li></td>
                <td align="right" ><li><fmt:message key='totalamount'/>：</li></td>
                <td align="left" id="tdid" ><li>${requestScope.totalamount}</li></td>
            </tr>
     
     </table>
     
    <input type="hidden" value="${billVo.cost_center_name }" name="cost_center_name"/>
    <input type="hidden" value="${billVo.bill_year_month }" name="bill_year_month"/>
    <input type="hidden" value="${billVo.bill_code }" name="bill_code"/>
    <input type="hidden" name="login_name" id="login_name" value="<%=LoginHelper.getLoginName(request)%>"/>
    <input type="hidden" value="${billVo.id }" name="bill_id" id="bill_id"/>
    <input type="hidden" value="${requestScope.bill_temp_id }" name="bill_temp_id" id="bill_temp_id"/>
    <input type="hidden" value="${requestScope.totalamount }" name="totalamount" id="totalamount"/>
    <input type="hidden" name="isbuttonselect" id="isbuttonselect"/>
    <input type="hidden" name="isupdate" id="isupdate"/>
    
    <!-- /FAERP/BillmodifyAction.do?cmd=getItemBybillid4DataCell -->
	<div style="padding: 0 0 8 8;">
	        <r:datacell pageSize="51"
	        id="datacell2"
	        paramFormId="datacell_formid"
	        queryAction=""
	        submitAction=""
	        width="98%"
	        height="304px"
	        xpath="/root/data/itemVo"
	        submitXpath="itemVo"
	        freezeNumber="4"
	        >
	        <r:toolbar location="bottom" tools="nav,pagesize,info" /><!-- 添加分页 谭彦军 -->
	        <r:field fieldName="sno" messagekey="sno" width="50"></r:field>
	        <r:field fieldName="emp_name" messagekey="emp_name" width="70"></r:field>
	        <r:field fieldName="emp_code" messagekey="emp_code" width="70"></r:field>
	        <r:field fieldName="service_year_month" messagekey="service_year_month" width="70"></r:field>
	       
	        <logic:iterate name="titleList" id="smalltitles" scope="request" indexId="indexs">
	           <c:choose>
	               <c:when test="${smalltitles[0] == 1 }">
	                   <logic:iterate name="smalltitles" id="title" scope="page">
						  <c:choose>
						    <c:when test="${fn:contains(title, '_city') }">
						        <r:field fieldName="${title }" messagekey="city" groupval="${smalltitles[9] }" allowModify="true" width="70">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_base') }">
						        <r:field fieldName="${title }" messagekey="base" groupval="${smalltitles[9] }" allowModify="true" width="70">
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_amount') }">
						    
						      <r:field fieldName="${title }" messagekey="amount" groupval="${smalltitles[9] }" allowModify="true" width="70" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})"><!--
						          <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
						          -->
						      </r:field>
						      
						    </c:when>
						    <c:when test="${fn:contains(title, '_eratio') }">
						       <r:field fieldName="${title }" messagekey="eratio" groupval="${smalltitles[9] }" allowModify="true" width="70"><!--
						          <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
						       --></r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_emoney') }">
						        <r:field fieldName="${title }" messagekey="emoney" groupval="${smalltitles[9] }" allowModify="true" width="70" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
						          <!-- <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>-->
						          <h:text onchange="datasetNoNum('datacell2','${title }')"/>
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_pratio') }">
						        <r:field fieldName="${title }" messagekey="pratio" groupval="${smalltitles[9] }" allowModify="true" width="70"><!--
						          <h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>
						        --></r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_pmoney') }">
						        <r:field fieldName="${title }" messagekey="pmoney" groupval="${smalltitles[9] }" allowModify="true" width="70" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
						          <!--<h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>-->
						          <h:text onchange="datasetNoNum('datacell2','${title }')"/>
						        </r:field>
						    </c:when>
						    <c:when test="${fn:contains(title, '_bill_imp_type_db') }">
						        <r:field fieldName="${title }" label="收费属性" groupval="${smalltitles[9] }" allowModify="true" width="70">
						        </r:field>
						    </c:when>
						  </c:choose>
					   </logic:iterate>
	               </c:when>
	               <c:otherwise>
	               		<c:choose>
		            	   	<c:when test="${fn:contains(smalltitles[1], '3379800100000000001') || fn:contains(smalltitles[1], '3379800100000000002') }">
								<r:field fieldName="${smalltitles[1] }" label="${fn:substring(smalltitles[2], 4, fn:length(smalltitles[2]))}" allowModify="true" width="70" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
	                   	   		</r:field>
							</c:when>
							<c:otherwise>
								<r:field fieldName="${smalltitles[1] }" label="${fn:substring(smalltitles[2], 4, fn:length(smalltitles[2]))}" allowModify="true" width="70" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
<%-- 		                    		<h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/> --%>
		                    		<h:text onchange="datasetNoNum('datacell2','${smalltitles[1] }')"/>
		                   	   	</r:field>
							</c:otherwise>
						</c:choose>
            	   </c:otherwise>
	        	</c:choose>
            </logic:iterate>
            <r:field fieldName="rightsum" messagekey="rightsum" width="70" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                <!--<h:text validateAttr="totalDigit=13;fracDigit=4;type=double;message=不是数字或精度有误！"/>-->
                 <h:text onchange="datasetNoNum('datacell2','rightsum')"/>
            </r:field>
	    </r:datacell>
	</div>
    <table width="100%">
        <tr>
           <td width="50%">
                <div class="xz_title" style="margin-top:10px;width: 92%"><fmt:message key='once_pay'/></div>
                    <r:datacell id="celllist1"
                    queryAction="/FAERP/FinbillAction.do?cmd=queryBillOther&bill_id=${billVo.id}"
                    paramFormId="datacell_formid" width="90%" height="220px"
                    xpath="BillOthersVo" readonly="true">
                    
                    <r:field fieldName="charge_item_bd" messagekey="charge_item_bd" width="145px" >
                        <d:select dictTypeId="CHARGE_ITEM_BD"/>
                    </r:field>
                    <r:field fieldName="amount" messagekey="amount_" width="110px">
                    </r:field>
                    <r:field fieldName="vat_amount" label="增值税" width="150px">
			</r:field>
			<r:field fieldName="add_vat_amount" label="附加税" width="150px">
			</r:field>
                    <r:field fieldName="charge_desc" messagekey="charge_desc" width="160px">
                        <h:text />
                    </r:field>
                    <r:field fieldName="last_update_date" messagekey="last_update_date" width="120px">
                        <w:date format="yyyy-MM-dd"/>
                    </r:field>
                </r:datacell>
           </td>
           <td width="40%" align="left">
                    <div class="xz_title" style="margin-top:10px;width: 98%">原因分类</div>
                    <div>
                            <b style="padding: 5px 5px 15px 5px;"><font color="red">*</font>&nbsp;&nbsp;原因大类 :</b> 
		                    <select id ="bill_reason_big_type_mul" multiple="multiple" name="bill_reason_big_type_mul" size="5"  onchange="otherDiv(this.value);"> 
		                        <%
		                            for (BaseDataVo vo : listBig) {%>
		                            <option id="select_<%=vo.getCode() %>" value="<%=vo.getCode() %>">
		                            <%=vo.getName() %>
		                            <%
		                            }
		                        %>
		                    </select><br/><br/>
		                    <b style="padding: 5px 5px 15px 5px;"><font color="red">*</font>&nbsp;&nbsp;原因小类 :</b> 
		                    <select id="bill_reason_small_type_mul" name="bill_reason_small_type_mul" multiple="multiple" size="5">
		                        <%
		                            for (BaseDataVo vo : listSmall) {%>
		                            <option id="select_<%=vo.getCode() %>" value="<%=vo.getCode() %>">
		                            <%=vo.getName() %>
		                            <%
		                            }
		                        %>
		                     </select>
                    </div><br/>
                    <div id="otherReasonDiv" class="ringht_s" style="display: none;">
                        <b style="padding: 5px 5px 15px 5px;">其他原因 :</b> 
                        <textarea rows="2" cols="50" id="otherReason" name="otherReason">${billVo.bill_other_reason }</textarea>
                    </div><br/>
                    <div class="xz_title" style="margin-top:10px;width: 98%"><fmt:message key='charge_desc'/></div>
                    <div class="ringht_s">
					    <textarea rows="5" cols="63" id="applymsg" name="apply" onkeyup="countChar();"></textarea>
					</div>
					<fmt:message key='wordCount_1'/><span id="surplus">4000</span><fmt:message key='wordCount_2'/>
           </td>
        </tr>
    </table>
		</div>
	 <div class="foot_button">
       <input type="button" value="<fmt:message key='button_modifysub'/>" class="foot_icon_2" onclick="modifysub();">
       <input type="button" value="<fmt:message key='button_bill_modify_scan'/>" class="foot_icon_2" onclick="billModifyScan();">
       <input type="button" onclick="closewin();" value="<fmt:message key='button_close'/>" class="foot_icon_1">
    </div>
</div>
</div>
</form>
</body>
</fmt:bundle>
</html>
