<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@ page import="gap.rm.tools.helper.*"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ include file="/jsp/include/globalopenquery.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostVo"%>
<%@ page import="rayoo.employeepost.empentry.epemporderitem.vo.EpemporderitemForQuanGuoVo"%>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants"%>
<%//取出本条记录
EmppostVo resultVo = (EmppostVo)request.getAttribute(IEmppostConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
String str=(String)request.getAttribute("str"); 
String str1=(String)request.getAttribute("str1"); 
EpemporderitemForQuanGuoVo efqgVo = (EpemporderitemForQuanGuoVo)request.getAttribute(IEmppostConstants.REQUEST_EFQGVO);
%>

<html>
    <fmt:bundle basename="rayoo.common.customer.customerservice.customerservice_resource" prefix="rayoo.common.customer.customerservice.">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <META content="IE=11.0000" http-equiv="X-UA-Compatible">
        <META name="GENERATOR" content="MSHTML 11.00.9600.17344">
        <META http-equiv="Content-Type" content="text/html; charset=utf-8">
        <META name="description" content="Minimal empty page">
        <META name="viewport" content="width=device-width, initial-scale=1.0">
        <title>codegen</title>
    </head>
    <body>
        <form name="form" method="post" id="datacell_formid">
            <input type="hidden" id="emp_post_id" name="emp_post_id" value="<%=resultVo.getId() %>">
            <div id="right">
                <div class="ringht_s">
                <div id="ccChild0" class="box_3">
                    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
				        <tr>
				            <td class="td_1" ><fmt:message key="emp_code"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmp_code())%>"></td>
				            <td class="td_1" ><fmt:message key="emp_name"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmp_name())%>"></td>
				            <td class="td_1" ><fmt:message key="internal_code"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getInternal_code())%>"></td>
				        </tr>
				        <tr>
				            <td class="td_1" ><fmt:message key="cust_code"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_code())%>"></td>
				            <td class="td_1" ><fmt:message key="cust_name"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_name())%>"></td>
				            <td class="td_1" ><fmt:message key="simple_cust_name"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCustomer_simple_name())%>"></td>
				        </tr>
				        <tr>
				            <td class="td_1" ><fmt:message key="id_card_type"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getId_card_type_bd()==null?"":BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",RmStringHelper.prt(resultVo.getId_card_type_bd()))%>"></td>
				            <td class="td_1" ><fmt:message key="emp_card_no1"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getId_card())%>"></td>
				            <td class="td_1" ><fmt:message key="tel1"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getContact_tel1())%>"></td>
				        </tr>        
				        <tr>
				            <td class="td_1" ><fmt:message key="mobile1"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getMobile())%>"></td>
				            <td class="td_1" ><fmt:message key="charge_start_date"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCharge_start_date(),10)%>"></td>
				            <td class="td_1" ><fmt:message key="charge_end_date"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCharge_end_date(),10)%>"></td>
				        </tr>
				        <tr>
				            <td class="td_1" ><fmt:message key="apply_on_post_date"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getApply_on_post_date(),10)%>"></td>
				            <td class="td_1" ><fmt:message key="on_post_date"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getOn_post_date(),19)%>"></td>
				            <td class="td_1" ><fmt:message key="on_post_user_id"/>：</td>
				            <td class="td_2" >
				            <%if(resultVo.getOn_post_user_id()!=null&&resultVo.getOn_post_user_id()!=""){ %>
				                <input type="text" class="text_field" readonly="readonly" value="<%=OrgHelper.getPartyVoByID(resultVo.getOn_post_user_id().toString()).getName()%>">
				            <%}else{ %>
				                <input type="text" class="text_field" readonly="readonly" value="">
				            <%} %>
				            </td>
				        </tr>
				        <tr>
				            <td class="td_1"><fmt:message key="is_employ_notice"/>：</td>
				            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getIs_physical_examination()==null?"":BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_employ_notice()))%>"></td>
				            <td class="td_1"><fmt:message key="is_physical_examination"/>：</td>
				            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getIs_physical_examination()==null?"":BaseDataHelper.getNameByCode("IS_PHYSICAL_EXAM",RmStringHelper.prt(resultVo.getIs_physical_examination()))%>"></td>
				            <td class="td_1"><fmt:message key="emp_entry"/>：</td>
				            <td class="td_2">
				            <input type="text" class="text_field" inputName="员工入职属性" value="<%=BaseDataHelper.getNameByCode("EMP_ENTRY_BD",RmStringHelper.prt(resultVo.getEmp_entry_bd()))%>" readonly="readonly" />
				            </td>
				        </tr>
				        <tr>
				            <td class="td_1">社保福利办理方：</td>
				            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getSecurity_unit_real_name())%>"></td>
				            <td class="td_1">公积金福利办理方：</td>
				            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getFund_unit_real_name())%>"></td>
				            <td class="td_1">用退工福利办理方：</td>
				            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getHire_unit_real_name())%>"></td>
				        
				        </tr>
				        <tr>
				            <td class="td_1"><fmt:message key="on_post_desc"/>：</td>
				            <td colspan="5" class="td_2" >
				                <textarea class="xText_d" readonly="readonly" cols="400" rows="3" name="remark" inputName="备注" maxLength="1000" ><%=RmStringHelper.prt(resultVo.getOn_post_desc()) %></textarea>
				            </td>
				        </tr>
				        <tr>
				            <td class="td_1" ><fmt:message key="apply_off_post_date"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getApply_off_post_date(),10)%>"></td>
				            <td class="td_1" ><fmt:message key="off_post_date"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getOff_post_date(),19)%>"></td>
				             <td class="td_1" ><fmt:message key="off_post_user_id"/>：</td>
				            <td class="td_2" >
				            <%if(resultVo.getOff_post_user_id()!=null&&resultVo.getOff_post_user_id()!=""){ %>
				                <input type="text" class="text_field" readonly="readonly" value="<%=OrgHelper.getPartyVoByID(resultVo.getOff_post_user_id().toString()).getName()%>">
				            <%}else{ %>
				                <input type="text" class="text_field" readonly="readonly" value="">
				            <%} %>
				            </td>
				        </tr>
				        <tr>
				            <td class="td_1" ><fmt:message key="off_post_reason"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getOff_post_reason()==null?"":BaseDataHelper.getNameByCode("OFF_POST_REASON",RmStringHelper.prt(resultVo.getOff_post_reason()))%>"></td>
				            <td class="td_1" ><fmt:message key="ge_off_post_reason"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getGe_off_post_reason()==null?"":BaseDataHelper.getNameByCode("GE_OFF_POST_REASON",RmStringHelper.prt(resultVo.getGe_off_post_reason()))%>"></td>
				            <td class="td_1" ><fmt:message key="off_post_desc"/>：</td>
				            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getOff_post_desc())%>"></td>
				        </tr>
				        <tr>
				            <td class="td_1" ><fmt:message key="cust_send_id"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_send_name())%>"></td>
				            <td class="td_1" ><fmt:message key="move_desc"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getMove_desc())%>"></td>
				            <td class="td_1" >报税属性：</td>
                            <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("TAX_FLAG",RmStringHelper.prt(resultVo.getTax_flag()))%>""></td>
				        </tr>
				        <tr>
				            <td class="td_1" ><fmt:message key="cust_receive_id"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_receive_name())%>"></td>
				            <td class="td_1" ><fmt:message key="send"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getSend_name())%>"></td>
				            <td class="td_1" ><fmt:message key="emp_type"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getEmp_post_type_bd()==null?"":BaseDataHelper.getNameByCode("EMP_POST_TYPE_BD",RmStringHelper.prt(resultVo.getEmp_post_type_bd()))%>"></td>
				        </tr>
				        <!-- 2015-4-2 yangyuting add -->
				        <tr>
				                   <td class="td_1" >是否入职E化：</td>
						            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getIs_phoenix()==null?"":BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_phoenix()))%>"></td>
						            <td class="td_1" >是否离职E化：</td>
						            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getIs_Offpost_phoenix()==null?"":BaseDataHelper.getNameByCode("TrueOrFalse",RmStringHelper.prt(resultVo.getIs_Offpost_phoenix()))%>"></td>
						            <td class="td_1" ></td>
						            <td class="td_2" ></td>				       
                         </tr>
				        <tr>
				            <td class="td_1" ><fmt:message key="post_status1"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getPost_status_bd()==null?"":BaseDataHelper.getNameByCode("POST_STATUS_BD",RmStringHelper.prt(resultVo.getPost_status_bd()))%>"></td>
				            <td class="td_1" ><fmt:message key="is_import_client"/>：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=resultVo.getIs_import_client()==null?"":BaseDataHelper.getNameByCode("IS_PHYSICAL_EXAM",RmStringHelper.prt(resultVo.getIs_import_client()))%>"></td>
				            <c:if test="${isModify!=null&&isModify!='1'}">
				            <td class="td_1" >工号：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getJob_num())%>"></td>
				            </c:if>
				            <c:if test="${isModify=='1'}">
				            <td class="td_1" >工号：</td>
				            <td class="td_2" ><input type="text" class="text_field" id="job_num" name="job_num" value="<%=RmStringHelper.prt(resultVo.getJob_num())%>"></td>
				            </c:if>
				        </tr>
				        <c:if test="${isModify!=null&&isModify!='1'}">
				        <tr>
				            <td class="td_1" >HRO：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getHro())%>"></td>
				            <td class="td_1" >业务部门：</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getBusiness())%>"></td>
				            <td class="td_1" >员工状态</td>
				            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("EMP_POSITION",RmStringHelper.prt(resultVo.getEmp_status()))%>"></td>
				        </tr>
				        </c:if>
				        <c:if test="${isModify=='1'}">
				        <tr>
				            <td class="td_1" >HRO：</td>
				            <td class="td_2" ><input type="text" class="text_field" name="hro" id="hro" value="<%=RmStringHelper.prt(resultVo.getHro())%>"></td>
				            <td class="td_1" >业务部门：</td>
				            <td class="td_2" ><input type="text" class="text_field" name="business" id="business" value="<%=RmStringHelper.prt(resultVo.getBusiness())%>"></td>
				            <td class="td_1" >员工状态</td>
				            <td class="td_2" ><d:select id="emp_status" name="emp_status" value="<%=RmStringHelper.prt(resultVo.getEmp_status())%>" dictTypeId="EMP_POSITION"  nullLabel="--请选择--"></d:select></td>
				        </tr>
				        </c:if>
				        <%if(efqgVo.getAgent_name()!=null){ %>
				            <tr>
				                <td class="td_1">供应商名称：</td>
				                <td class="td_2"><input type="text" class="text_field" name="hro" id="hro" value="<%=RmStringHelper.prt(efqgVo.getAgent_name())%>"></td>
				        <%} %>      
				        <%if(efqgVo.getAgent_code()!=null){ %>
				                <td class="td_1">供应商编号：</td>
                                <td class="td_2"><input type="text" class="text_field" name="hro" id="hro" value="<%=RmStringHelper.prt(efqgVo.getAgent_code())%>"></td>
				            </tr>
				        <%} %>
				    </table>
                </div>
            </div>
            <table width="99%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
	                    <div id="bg"  style="width:100%;background-repeat: no-repeat;">
	                          <div id="post_head" class="post_head_blue"></div>
	                          <div id="font0" class="post_blue_content" onMouseDown="setTab(0);">全国--个人订单明细</div>
	                          <div id="font0-right" class="post_blue_right"></div>
	                          <div id="font1" class="post_gray_content" onMouseDown="setTab(1);">ERP--入职订单明细</div>
	                          <div id="font1-right" class="post_gray_side"></div>
	                          <div id="font2" class="post_gray_content" onMouseDown="setTab(2);">全国--入职进度</div>
	                          <div id="font2-right" class="post_gray_side"></div>
	                    </div>
	                    
	                    <div id="TabCon0" class="tabClass">
	                         <r:datacell id="datacell1"
	                         queryAction="/FAERP/EmppostAction.do?cmd=getOrderItemForQuanGuo"
	                         width="100%" height="300px" xpath="EpemporderitemForQuanGuoVo"
	                         paramFormId="datacell_formid">
	                         <r:field fieldName="product_name" label="产品名称" allowModify="false" width="130"></r:field>
	                         <r:field fieldName="pbase" label="个人基数" allowModify="false" width="130"></r:field>
	                         <r:field fieldName="pratio" label="个人比例" allowModify="false" width="130"></r:field>
	                         <r:field fieldName="ebase" label="企业基数" allowModify="false" width="130"></r:field>
	                         <r:field fieldName="eratio" label="企业比例" allowModify="false" width="130"></r:field>
	                         <r:field fieldName="charge_start_date" label="收费开始时间" allowModify="false" width="130">
	                             <w:date format="YYYY-MM-DD" />
	                         </r:field>
	                         <r:field fieldName="charge_end_date" label="收费结束时间" allowModify="false" width="130">
	                             <w:date format="YYYY-MM-DD" />
	                         </r:field>
	                     </r:datacell>
	                    </div>
	                    <div id="TabCon1" class="tabClass" style="display: none;float: left;clear: both;">
	                        <span style="padding-left:15px;color:red;"><fmt:message key="current_only_show_active_fees_section"/><a href="###" id="show1" onclick="javascript:show_onClick();"><u><fmt:message key="click"/></u></a> <fmt:message key="show_all_fees_section"/></span> 
	                        <!--表格 -->
	                        <div class="box_3">
	                          <table width="99%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
	                            <%if(str!=null&&!"".equals(str)){ %>
	                              <% out.print(str);%>
	                            <%} %>
	                           </table>
	                          <table width="99%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" style="display:none" id="displayTab">
	                            <%if(str1!=null&&!"".equals(str1)){ %>
	                              <% out.print(str1);%>
	                            <%} %>
	                           </table>
	                        </div>
	                        <!--表格 end-->
	                    </div><br/>
	                    <div id="TabCon2" class="tabClass" style="display: none;float: left;clear: both;height: 350px;">
	                        <table cellspacing="0px" style="border-collapse:collapse;background-color:white;" align="center">
	                            ${postStatusHtml }
						    </table>
	                    </div>
                    </td>
                </tr>
            </table>
            <div class="foot_button">
               <input type="button" class="foot_icon_1" value='<fmt:message key="close"/>' onclick="javascript:back_onClick();" />
            </div>
        </form>
        <script language="javascript">
            writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
            jQuery(function(){
                $id("datacell1").isQueryFirst = true;
            });
            
            function show_onClick(){
                if(document.getElementById("displayTab").style.display==''){
                    document.getElementById("displayTab").style.display='none';
                }else{
                    document.getElementById("displayTab").style.display='';
                }
            }
            
            function back_onClick(){  //返回列表页面
                window.close();
            }
            
            //切换tab标签
            function setTab(con){
               //找到所有需要切换的div
                var tabDiv = _$(".tabClass");
                if(("null") != tabDiv){
                    for(var i=0;i<tabDiv.length;i++){
                        if(i==con){//如果是需要显示的则显示
                            _$("#TabCon"+i).show();
                        }else{
                            //其他的隐藏
                            _$("#TabCon"+i).hide();
                        }
                    }
                    //变化切换标签的样式
                    changeTab(con);
                }
            }
            
            //变化切换标签的样式
            function changeTab(con){
                var tabLength = _$(".post_gray_content").length+1;//总数等于灰的+1个蓝的
                for(var j=0;j<tabLength;j++){
                    if(j == con){
                        //选中的标签本身样式要变成 blue
                        _$("#font"+j).attr("class","post_blue_content");
                        //上一个标签的右边要变成 blue_left
                        if(_$("#font"+parseInt(j-1)+"-right")){
                            _$("#font"+parseInt(j-1)+"-right").attr("class","post_blue_left");
                        }
                        //本身的右边要变成 blue_right
                        if(_$("#font"+j+"-right")){
                            _$("#font"+j+"-right").attr("class","post_blue_right");
                        }
                    }else{
                         //没选中的标签本身样式要变成 gray
                        _$("#font"+j).attr("class","post_gray_content");
                        //上一个标签的右边要变成 post_gray_side  上一个不为当前点击的 
                        if(_$("#font"+parseInt(j-1)+"-right") && parseInt(j-1) != con){
                            _$("#font"+parseInt(j-1)+"-right").attr("class","post_gray_side");
                        }
                        //本身的右边要变成 post_gray_side
                        if(_$("#font"+j+"-right")){
                            _$("#font"+j+"-right").attr("class","post_gray_side");
                        }                
                    }
                }
                
                //如果选中的是第一个 把最左边的head变蓝 其他则变灰
                if(con == 0){
                    _$("#post_head").attr("class","post_head_blue");
                }else{
                    _$("#post_head").attr("class","post_head_gray");
                }
                //如果选中的是最后一个 把最右边的tail变蓝 其他的则变灰
                 if(con == (tabLength-1)){
                    _$("#post_tail").attr("class","post_tail_blue");
                }else{
                    _$("#post_tail").attr("class","post_tail_gray");
                }
            }
        </script> 
    </body>
    </fmt:bundle>
</html>
  
