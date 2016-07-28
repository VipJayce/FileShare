<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();

function fmoney(s, n)  {   
   n = n > 0 && n <= 20 ? n : 2;   
   s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";   
   var l = s.split(".")[0].split("").reverse(),   
   r = s.split(".")[1];   
   t = "";   
   for(i = 0; i < l.length; i ++ ) {   
      t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");   
   }   
   return t.split("").reverse().join("") + "." + r;   
} 

</script>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostVo" %>
<%@page import="gap.authority.helper.OrgHelper"%>
<%  //取出本条记录
    EmppostVo resultVo = null;  //定义一个临时的vo变量
    resultVo = (EmppostVo)request.getAttribute("empBean");  //从request中取出vo, 赋值给resultVo
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title>个人订单信息</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
    function setTabBatSyn ( i )
    {
        selectTabBatSyn(i);
    }
    
    function selectTabBatSyn ( i )
    {
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
        }
    }
    function back_onClick(){  //返回列表页面
        window.close();
    }
</script>
</head>
<body>
 
<form name="form" method="post">
    <input type="hidden" name="belongStatus" id="belongStatus" value="${belongStatus}">
    <input type="hidden" name="sendpost_id" id="sendpost_id" value="${sendpost_id}">
 <div id="right">
    <div class="ringht_s">

<div id="ccChild0" class="box_3"> 
    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" >唯一号：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmp_code())%>"></td>
            <td class="td_1" >员工姓名：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmp_name())%>"></td>
            <td class="td_1" >客户方编号：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getInternal_code())%>"></td>
        </tr>
        <tr>
            <td class="td_1" >客户编号：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_code())%>"></td>
            <td class="td_1" >客户姓名：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_name())%>"></td>
            <td class="td_1" >客户简称：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCustomer_simple_name())%>"></td>
        </tr>
        <tr>
            <td class="td_1" >证件类别：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",RmStringHelper.prt(resultVo.getId_card_type_bd()))%>"></td>
            <td class="td_1" >证件号码：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getId_card())%>"></td>
            <td class="td_1" >电话：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getContact_tel1())%>"></td>
        </tr>        
        <tr>
            <td class="td_1" >手机：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getMobile())%>"></td>
            <td class="td_1" >收费开始：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCharge_start_date(),10)%>"></td>
            <td class="td_1" >收费截止：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCharge_end_date(),10)%>"></td>
        </tr>
        <tr>
            <td class="td_1" >入职时间：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getApply_on_post_date(),10)%>"></td>
            <td class="td_1" >报入职时间：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getOn_post_date(),19)%>"></td>
            <td class="td_1" >报入职人：</td>
            <td class="td_2" >
            <%if(resultVo.getOn_post_user_id()!=null&&resultVo.getOn_post_user_id()!=""){ %>
                <input type="text" class="text_field" readonly="readonly" value="<%=OrgHelper.getPartyVoByID(resultVo.getOn_post_user_id().toString()).getName()%>">
            <%}else{ %>
                <input type="text" class="text_field" readonly="readonly" value="">
            <%} %>
            </td>
        </tr>
        <tr>
            <td class="td_1">是否入职通知：</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("NOTICE_STATUS",RmStringHelper.prt(resultVo.getNotice_status()))%>"></td>
            <td class="td_1">是否要体检：</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("IS_PHYSICAL_EXAM",RmStringHelper.prt(resultVo.getIs_physical_examination()))%>"></td>
            <td class="td_1"> 福利办理方：</td>
            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getHire_unit_real_name())%>"></td>
        </tr>
        <tr>
            <td class="td_1">员工入职属性：</td>
            <td class="td_2">
            <input type="text" class="text_field" inputName="员工入职属性" value="<%=BaseDataHelper.getNameByCode("EMP_ENTRY_BD",RmStringHelper.prt(resultVo.getEmp_entry_bd()))%>" readonly="readonly" />
            <td class="td_1">入职备注：</td>
            <td colspan="3" class="td_2" >
                <textarea class="xText_d" readonly="readonly" cols="400" rows="3" name="remark" inputName="备注" maxLength="1000" ><%=RmStringHelper.prt(resultVo.getOn_post_desc()) %></textarea>
            </td>
        </tr>
        <tr>
            <td class="td_1" >离职时间：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getApply_off_post_date(),10)%>"></td>
            <td class="td_1" >报离职时间：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getOff_post_date(),19)%>"></td>
            <td class="td_1" >离职原因：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("OFF_POST_REASON",RmStringHelper.prt(resultVo.getOff_post_reason()))%>"></td>
        </tr>
        <tr>
            <td class="td_1" >报离职人：</td>
            <td class="td_2" >
            <%if(resultVo.getOff_post_user_id()!=null&&resultVo.getOff_post_user_id()!=""){ %>
                <input type="text" class="text_field" readonly="readonly" value="<%=OrgHelper.getPartyVoByID(resultVo.getOff_post_user_id().toString()).getName()%>">
            <%}else{ %>
                <input type="text" class="text_field" readonly="readonly" value="">
            <%} %>
            </td>
            <td class="td_1" >离职备注：</td>
            <td class="td_2" colspan="3"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getOff_post_desc())%>"></td>
        </tr>
        <tr>
            <td class="td_1" >派出单位：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_send_name())%>"></td>
            <td class="td_1" >转移备注：</td>
            <td class="td_2" colspan="3"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getMove_desc())%>"></td>
        </tr>
        <tr>
            <td class="td_1" >接收单位：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_receive_name())%>"></td>
            <td class="td_1" >委派单：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getSend_name())%>"></td>
            <td class="td_1" >员工类别：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("EMP_POST_TYPE_BD",RmStringHelper.prt(resultVo.getEmp_post_type_bd()))%>"></td>
        </tr>
        <tr>
            <td class="td_1" >入职状态：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("POST_STATUS_BD",RmStringHelper.prt(resultVo.getPost_status_bd()))%>"></td>
            <td class="td_1" >是否导入客户端：</td>
            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("IS_PHYSICAL_EXAM",RmStringHelper.prt(resultVo.getIs_import_client()))%>"></td>
            <td class="td_1" ></td>
            <td class="td_2" ></td>
        </tr>
    </table>
</div>


<table width="99%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div id="bg" class="xixi3">
        <div id="font1" class="tab3" onMouseDown="setTabBatSyn(1);document.getElementById('bg').className='xixi3';">最新订单信息</div>
        <div id="font2" class="tab4" onMouseDown="setTabBatSyn(2);document.getElementById('bg').className='xixi4';">原订单信息</div>
      </div>
      <div id="TabCon1" class="zbox">
        <div class="xz_title"> 社保信息<font color="red">（变更后的新订单对应的“产品名称”标黄，“社保组”标黄表示该组是新增，“基数”标黄表示基数变动，“金额”标黄表示金额变动）</font></div>
        <div style="padding: 8 10 8 8;">
            <r:datacell 
                id="datacell1"
                queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=querySocialSecurityService&sendpost_id=${sendpost_id}"
                width="97%"
                height="240px"
                xpath="EpemporderitemVo"
                submitXpath="EpemporderitemVo"
                paramFormId="datacell_formid"
                pageSize="-1"
                readonly="true"
                showIndex="false"
                >
                  <r:field fieldName="product_name" label="产品名称" allowModify="false">
                       <h:text/>   
                   </r:field>    
                  <r:field fieldName="group_name" label="社保组" allowModify="false">
                       <h:text/>   
                   </r:field>    
                  <r:field fieldName="base" label="基数" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="money" label="总金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="e_money" label="企业金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="p_money" label="个人金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="e_ratio" label="企业比例" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'###.###');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="p_ratio" label="个人比例" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'###.###');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="e_add_money" label="企业附加金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="p_add_money" label="个人附加金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="frequency_bd" label="收费频率" >
                    <d:select dictTypeId="FREQUENCY_BD" />
                  </r:field>
                  <r:field fieldName="start_date" label="收费开始">
                    <w:date format="yyyy-MM-dd"/>
                  </r:field>
                  <r:field fieldName="end_date" label="收费结束">
                    <w:date format="yyyy-MM-dd"/>
                  </r:field>
            </r:datacell>
        </div>
        <div style="padding-left: 140px;">
            <span style="padding-left: 10px;">金额合计：
            </span>
            <span id="sum_money">
            </span>
        </div>
      </div>
      
      <div id="TabCon2" class="zbox" style="display:none">
        <div class="xz_title"> 社保信息<font color="red">（“产品名称”标黄表示该产品删除，“社保组”标黄表示该组删除，“基数”标黄表示基数变动，“金额”标黄表示金额变动，“比例”标黄表示比例变动）</font></div>
        <div style="padding: 8 10 8 8;">
            <r:datacell 
                id="datacell2"
                queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=querySocialSecurityServiceback&sendpost_id=${sendpost_id}"
                width="97%"
                height="240px"
                xpath="EpemporderitemVo"
                submitXpath="EpemporderitemVo"
                paramFormId="datacell_formid"
                pageSize="-1"
                readonly="true"
                showIndex="false"
                >
                  <r:field fieldName="product_name" label="产品名称" allowModify="false">
                       <h:text/>   
                   </r:field>    
                  <r:field fieldName="group_name" label="社保组" allowModify="false">
                       <h:text/>   
                   </r:field>    
                  <r:field fieldName="base" label="基数" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="money" label="总金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="e_money" label="企业金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="p_money" label="个人金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="e_ratio" label="企业比例" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'###.###');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="p_ratio" label="个人比例" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'###.###');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="e_add_money" label="企业附加金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="p_add_money" label="个人附加金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                    <h:text/>
                  </r:field>
                  <r:field fieldName="frequency_bd" label="收费频率" >
                    <d:select dictTypeId="FREQUENCY_BD" />
                  </r:field>
                  <r:field fieldName="start_date" label="收费开始">
                    <w:date format="yyyy-MM-dd"/>
                  </r:field>
                  <r:field fieldName="end_date" label="收费结束">
                    <w:date format="yyyy-MM-dd"/>
                  </r:field>
            </r:datacell>
        </div>
        <div style="padding-left: 140px;">
            <span style="padding-left: 10px;">金额合计：
            </span>
            <span id="sum_money2">
            </span>
        </div>
      </div>
    </td>
  </tr>
</table>

<table width="99%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
      <div class="zbox">
        <div class="xz_title"> 服务产品信息</div>
        <div style="padding: 8 10 8 8;">
            <r:datacell id="datacell3" 
                            queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=queryProjectServiceProduct&sendpost_id=${sendpost_id}"
                            width="100%" height="240px" 
                            xpath="AgentSendPostOrderItemVo" 
                            paramFormId="datacell_formid" 
                            readonly="false">
                    <r:field fieldName="product_name" label="产品名称"></r:field>
                    <r:field fieldName="money" label="产品价格">
                        <h:text/>
                    </r:field>
                    <!-- 
                    <r:field fieldName="frequency_bd" label="收费频率">
                         <d:select dictTypeId="FREQUENCY_BD"/>
                        <h:text/>
                    </r:field>
                    -->
                    <r:field fieldName="start_date" label="开始时间">
                        <w:date allowInput="true" id="start_date" name="start_date" format="YYYY-MM-DD" property="bean/start_date" width="190px" readonly="true"/>
                    </r:field>
                    <%
                    if (request.getAttribute("belongStatus") != null){
                        if (!"0".equals(request.getAttribute("belongStatus") + "")){
                    %>
                    <r:field fieldName="end_date" label="结束时间">
                        <w:date allowInput="true" id="end_date" name="end_date" format="YYYY-MM-DD" property="bean/end_date" width="190px" readonly="true"/>
                    </r:field>
                    <%        
                        }
                    }
                        %>
                </r:datacell>
        </div>
        <div style="padding-left: 120px;">
            <span style="padding-left: 10px;">价格合计：
            </span>
            <span id="sum_money_">
            </span>
        </div>
      </div>
    </td>
  </tr>
</table>
<div class="foot_button">
    <input type="button" class="foot_icon_1" value='关闭' onclick="javascript:back_onClick();" />
</div>

</div>
     </div>

</form>
</fmt:bundle>
<script language="javascript">
        writeTableBottom('<%=request.getContextPath()%>/');  //显示本页的页脚
        var vpath = "<%=request.getContextPath()%>";
        var initedDataCell = 0;
       
        $id("datacell1").afterRefresh = function(){
            var dc = $id("datacell1");
            var rowCount = dc.getCurrentRowCount();
            //var sumBaseValue = parseFloat("0.00");
            var sumMoneyValue = parseFloat("0.00");
            for(var i = 0;i<rowCount;i++){
                //sumBaseValue = sumBaseValue + parseFloat(dc.getCellValue(dc.getCell(i,2)));
                sumMoneyValue = sumMoneyValue + parseFloat(dc.getCellValue(dc.getCell(i,3)));
            }
            
            initedDataCell++;
            //列表第一次加载,需要加载变化标识颜色
            if (initedDataCell ==1 ){
                setBiaoshi();
            }
            //jQuery("#sum_base").text(fmoney(sumBaseValue,2))
            jQuery("#sum_money").text(fmoney(sumMoneyValue,2));
        }
        
        function setBiaoshi(){
	        var datacell = $id("datacell1");
	        var dataset = datacell.dataset;//取得页面的datacell
	        var fields = datacell.fields;//获得页面所有的列
	         var sendpost_id = jQuery("#sendpost_id").val();
	        //后台查询该员工的原订单中对应各社保产品的基数金额等
	        jQuery.getJSON(vpath+"/AgentEmpSendPostAction.do?cmd=searchItemChange&date="+new Date()+"",{"id":sendpost_id,"async":false},  function(json){
	           for(var j = 0; j < json.saia.length; j++){
	               if(json.saia[j].new_item_id!=null){
	                    var type = json.saia[j].change_type;
	                    //行循环
			            for(var i=0; i<dataset.getLength(); i++){
			                var datasettr = dataset.get(i);
			                var item_id = datasettr.getProperty("id");
			                if(item_id==json.saia[j].new_item_id){
			                     if(type==1){//基数有变化
			                         var cell = datacell.getCell(i,2);
			                         cell.style.backgroundColor = "yellow";
			                     }
			                     if(type==2){//金额有变化
                                     var cell = datacell.getCell(i,3);
                                     cell.style.backgroundColor = "yellow";
                                 }
                                 if(type==3){//比例有变化
                                     var cell = datacell.getCell(i,6);
                                     cell.style.backgroundColor = "yellow";
                                     var cell1 = datacell.getCell(i,7);
                                     cell1.style.backgroundColor = "yellow";
                                 }
                                 if(type==4){//组有变化
                                     var cell = datacell.getCell(i,1);
                                     cell.style.backgroundColor = "yellow";
                                 }
                                 if(type==5){//新增的产品
                                     var cell = datacell.getCell(i,0);
                                     cell.style.backgroundColor = "yellow";
                                 }
			                }
			            }
	               }
	              
	           }
	                      
	      });
	    
	    }
        
        var initedDataCell1 = 0;
        $id("datacell2").afterRefresh = function(){
            var dc = $id("datacell2");
            var rowCount = dc.getCurrentRowCount();
            //var sumBaseValue = parseFloat("0.00");
            var sumMoneyValue = parseFloat("0.00");
            for(var i = 0;i<rowCount;i++){
                //sumBaseValue = sumBaseValue + parseFloat(dc.getCellValue(dc.getCell(i,2)));
                sumMoneyValue = sumMoneyValue + parseFloat(dc.getCellValue(dc.getCell(i,3)));
                
            }
            
            initedDataCell1++;
            //列表第一次加载,需要加载变化标识颜色
            if (initedDataCell1 ==1 ){
                setBiaoshi1();
            }
                
            //jQuery("#sum_base").text(fmoney(sumBaseValue,2))
            jQuery("#sum_money2").text(fmoney(sumMoneyValue,2));
        }
        
        function setBiaoshi1(){
            var datacell = $id("datacell2");
            var dataset = datacell.dataset;//取得页面的datacell
            var fields = datacell.fields;//获得页面所有的列
             var sendpost_id = jQuery("#sendpost_id").val();
            //后台查询该员工的原订单中对应各社保产品的基数金额等
            jQuery.getJSON(vpath+"/AgentEmpSendPostAction.do?cmd=searchItemChange&date="+new Date()+"",{"id":sendpost_id,"async":false},  function(json){
               for(var j = 0; j < json.saia.length; j++){
                   if(json.saia[j].old_item_id!=null){
                        var type = json.saia[j].change_type;
                        //行循环
                        for(var i=0; i<dataset.getLength(); i++){
                            var datasettr = dataset.get(i);
                            var item_id = datasettr.getProperty("id");
                            if(item_id==json.saia[j].old_item_id){
                                 if(type==1){//基数有变化
                                     var cell = datacell.getCell(i,2);
                                     cell.style.backgroundColor = "yellow";
                                 }
                                 if(type==2){//金额有变化
                                     var cell = datacell.getCell(i,3);
                                     cell.style.backgroundColor = "yellow";
                                 }
                                 if(type==3){//比例有变化
                                     var cell = datacell.getCell(i,6);
                                     cell.style.backgroundColor = "yellow";
                                     var cell1 = datacell.getCell(i,7);
                                     cell1.style.backgroundColor = "yellow";
                                 }
                                 if(type==4){//组有变化
                                     var cell = datacell.getCell(i,1);
                                     cell.style.backgroundColor = "yellow";
                                 }
                                 if(type==6){//减少的产品
                                     var cell = datacell.getCell(i,0);
                                     cell.style.backgroundColor = "yellow";
                                 }
                            }
                        }
                   }
                  
               }
                          
          });
        
        }
        
        $id("datacell3").afterRefresh = function(){
            var dc = $id("datacell3");
            var rowCount = dc.getCurrentRowCount();
            var sumMoneyValue = parseFloat("0.00");
            for(var i = 0;i<rowCount;i++){
                sumMoneyValue = sumMoneyValue + parseFloat(dc.getCellValue(dc.getCell(i,1)));
            }
            jQuery("#sum_money_").text(fmoney(sumMoneyValue,2));
        }
</script>
</body>
</html>
