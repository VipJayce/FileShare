<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@page import="gap.authority.helper.OrgHelper"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@ page import="rayoo.employeepost.empentry.emppost.vo.EmppostVo" %>
<%@ page import="rayoo.employeepost.empentry.emppost.util.IEmppostConstants" %>
<%  //取出本条记录
    EmppostVo resultVo = null;  //定义一个临时的vo变量
    resultVo = (EmppostVo)request.getAttribute("empPVo");  //从request中取出vo, 赋值给resultVo
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>其他信息查询</title>
    <script type="text/javascript">
      //datacell是否已经加载的标识符
        var flag = "0";
        var venusbase = "<%=request.getContextPath()%>";
        //切换tab标签
        function setTab(con){
           //找到所有需要切换的div
            var tabDiv = _$(".tabClass");
            if(("null") != tabDiv){
                for(var i=0;i<tabDiv.length;i++){
                    //如果是需要显示的则显示
                    if(i==con){
                        _$("#TabCon"+i).show();
                        if(flag.indexOf(i) == -1){
                           //如果该datacell没有刷新 则加载datacell
                           if(null != $id("datacell"+i) && "" != $id("datacell"+i)){
	                          $id("datacell"+i).loadData();
	                          $id("datacell"+i).refresh();
                           }
                            flag+=i;
                           //第二 三个的时候 即查询公积金 社保时  加载默认第一行的 补缴和和追缴的datacell
                           if(i == 1 || i==2){
                                var entity = $id("datacell"+i).getActiveEntity();
                                if(null != entity && "" != entity){
                                    var securityId=entity.getProperty("securityId");//取得组ID
	                                $id("datacell"+i+"_1").addParam("securityId",securityId);
	                                $id("datacell"+i+"_1").loadData();
	                                $id("datacell"+i+"_1").refresh();
	                                $id("datacell"+i+"_2").addParam("securityId",securityId);
	                                $id("datacell"+i+"_2").loadData();
	                                $id("datacell"+i+"_2").refresh();
                                }
                           }
                           //第四个的时候 即查询订单的时候  ajax请求原订单费用段信息
                           if(i ==3){
                                var url = "<%=request.getContextPath()%>/EmppostAction.do?cmd=ajaxQueryLeaveDetailOrder&id=<%=RmStringHelper.prt(request.getAttribute("emp_post_id"))%>";
                                 _$.ajax({
						                type : "post",
						                url : url,
						                dataType : "html",
						                success : function(data) {
						                      var array = data.split("<splitTag>");
						                      _$("#orderTabel").html(array[0]);
						                      _$("#displayTab").html(array[1]);
						                }
					              });
                           }
                           if(i==6){
	                            var entity = $id("datacell"+i).getActiveEntity();
	                            if(null != entity && "" != entity){
	                              var emp_service_id=entity.getProperty("emp_service_id");//取得组ID
	                              $id("datacell6_1").addParam("emp_service_id",emp_service_id);
	                              $id("datacell6_1").loadData();
	                              $id("datacell6_1").refresh();
	                            }
                           }
                        }
                    }else{
                    //其他的隐藏
                         _$("#TabCon"+i).hide();
                    }
                }
                //变化切换标签的样式
                changeTab(con);
            }
        }
        //显示无效费用字段
        function show_onClick(){
	        if(document.getElementById("displayTab").style.display==''){
	            document.getElementById("displayTab").style.display='none';
	        }else{
	            document.getElementById("displayTab").style.display='';
	        }
        }
        //导出薪资明细
		function exportDetail(){
		    var url = "<%=request.getContextPath()%>/SalarydataAction.do?cmd=expSalaryDetail&emp_post_id=<%=RmStringHelper.prt(request.getAttribute("emp_post_id"))%>";
		    form.action=url;
            form.submit();
		}
		
		//变化切换标签的样式
		function changeTab(con){
		    var tabLength = _$(".xz_gray_content").length+1;//总数等于灰的+1个蓝的
            for(var j=0;j<tabLength;j++){
                if(j == con){
                    //选中的标签本身样式要变成 blue
                    _$("#font"+j).attr("class","xz_blue_content");
                    //上一个标签的右边要变成 blue_left
                    if(_$("#font"+parseInt(j-1)+"-right")){
                        _$("#font"+parseInt(j-1)+"-right").attr("class","xz_blue_left");
                    }
                    //本身的右边要变成 blue_right
                    if(_$("#font"+j+"-right")){
                        _$("#font"+j+"-right").attr("class","xz_blue_right");
                    }
                }else{
                     //没选中的标签本身样式要变成 gray
                    _$("#font"+j).attr("class","xz_gray_content");
                    //上一个标签的右边要变成 xz_gray_side  上一个不为当前点击的 
                    if(_$("#font"+parseInt(j-1)+"-right") && parseInt(j-1) != con){
                        _$("#font"+parseInt(j-1)+"-right").attr("class","xz_gray_side");
                    }
                    //本身的右边要变成 xz_gray_side
                    if(_$("#font"+j+"-right")){
                        _$("#font"+j+"-right").attr("class","xz_gray_side");
                    }                
                }
            }
            
            //如果选中的是第一个 把最左边的head变蓝 其他则变灰
            if(con == 0){
                _$("#xz_head").attr("class","xz_head_blue");
            }else{
                _$("#xz_head").attr("class","xz_head_gray");
            }
            //如果选中的是最后一个 把最右边的tail变蓝 其他的则变灰
             if(con == (tabLength-1)){
                _$("#xz_tail").attr("class","xz_tail_blue");
            }else{
                _$("#xz_tail").attr("class","xz_tail_gray");
            }
		}
    </script>
</head>
<body>
 <form id="datacell_formid" name="form" method="post" action="">
 </form>
<div id="right">
  <div class="ringht_s">
        <!-- ccChild0 div start>>>>>>>>>>>>>>>>>>>>>>>> -->
        <div id="ccChild0" class="box_3"> 
		    <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		        <tr>
		            <td class="td_1" >唯一号：</td>
		            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmp_code())%>"></td>
		            <td class="td_1" >员工姓名：</td>
		            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmp_name())%>"></td>
		            <td class="td_1" >客户编号：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_code())%>"></td>
		        </tr>
		        <tr>
		            <td class="td_1" >客户名称：</td>
		            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_name())%>"></td>
		            <td class="td_1" >证件类别：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("ID_CARD_TYPE_BD",RmStringHelper.prt(resultVo.getId_card_type_bd()))%>"></td>
                    <td class="td_1" >证件号码：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getId_card())%>"></td>
		        </tr>
		        <tr>
		            <td class="td_1" >手机：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getMobile())%>"></td>
                    <td class="td_1" >email：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getEmail())%>"></td>
                    <td class="td_1" >户口地址：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getResident_addresss())%>"></td>
                    
		        </tr>        
		        <tr>
		            <td class="td_1" >联系地址：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getAddress())%>"></td>
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
                   <td class="td_1">社保福利办理方：</td>
                   <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getSecurity_unit_real_name())%>"></td>
                   <td class="td_1">公积金福利办理方：</td>
                   <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getFund_unit_real_name())%>"></td>
		        </tr>
		        <tr>
		            <td class="td_1">用退工福利办理方：</td>
                    <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getHire_unit_real_name())%>"></td>
                    <td class="td_1">银行卡开户行名称：</td>
                    <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getBank_name())%>"></td>
                    <td class="td_1">银行卡号：</td>
                    <td class="td_2"><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getAccount_num())%>"></td>
	            </tr>
		        <tr>
		           <td class="td_1">入职备注：</td>
                    <td colspan="5" class="td_2" >
                        <textarea class="xText_d" readonly="readonly" cols="400" rows="3" name="remark" inputName="备注" maxLength="1000"  ><%=RmStringHelper.prt(resultVo.getOn_post_desc()) %></textarea>
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
		            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getOff_post_desc())%>"></td>
		             <td class="td_1" >派出单位：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_send_name())%>"></td>
		        </tr>
		        <tr>
		            <td class="td_1" >转移备注：</td>
		            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getMove_desc())%>"></td>
		            <td class="td_1" >入职状态：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("POST_STATUS_BD",RmStringHelper.prt(resultVo.getPost_status_bd()))%>"></td>
                    <td class="td_1" >是否导入客户端：</td>
                    <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("IS_PHYSICAL_EXAM",RmStringHelper.prt(resultVo.getIs_import_client()))%>"></td>
		        </tr>
		        <tr>
		            <td class="td_1" >接收单位：</td>
		            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getCust_receive_name())%>"></td>
		            <td class="td_1" >委派单：</td>
		            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=RmStringHelper.prt(resultVo.getSend_name())%>"></td>
		            <td class="td_1" >员工类别：</td>
		            <td class="td_2" ><input type="text" class="text_field" readonly="readonly" value="<%=BaseDataHelper.getNameByCode("EMP_POST_TYPE_BD",RmStringHelper.prt(resultVo.getEmp_post_type_bd()))%>"></td>
		        </tr>
		    </table>
		</div>
        <!-- ccChild0 div end>>>>>>>>>>>>>>>>>>>>>>>> -->
        
        <div class="xz_title">亲属信息</div>
	    <div style="padding: 8 0 8 8;" >
	        <r:datacell 
	            id="datacell_sib_info"
	            paramFormId="datacell_formid"
	            queryAction="/FAERP/FaerpEmployeeAction.do?cmd=searchEmpSiblingData&emp_id=${empPVo.emp_id}"
	            width="99%"
	            height="100px"
	            xpath="EmpsiblingVo"
	            readonly="true"
	            pageSize="-1"
	            >
	          <r:field fieldName="sib_name" label="姓名">
	            <h:text/>
	          </r:field>
	          <r:field fieldName="sib_relation" label="亲属">
	            <d:select dictTypeId="SIB_RELATION" />
	          </r:field>
	          <r:field fieldName="sib_id_card_num" label="证件号码" width="180px">
	            <h:text/>
	          </r:field>
	          <r:field fieldName="sib_id_card_type_bd" label="证件类别" width="130px">
	            <d:select dictTypeId="ID_CARD_TYPE_BD" />
	          </r:field>
	          <r:field fieldName="sib_sex_bd" label="性别">
	            <d:select dictTypeId="EMP_SEX" />
	          </r:field>
	          <r:field fieldName="sib_birthday" label="出生日期" width="130px">
	           <w:date format="yyyy-MM-dd"/>
	          </r:field>
	          <r:field fieldName="sib_desc" label="备注" width="220px">
	            <h:text/>
	          </r:field>
	        </r:datacell>
	    </div>  
        
        <!-- div bg start>>>>>>>>>> -->
        <div id="bg"  style="width:100%;background-repeat: no-repeat;">
              <div id="xz_head" class="xz_head_blue"></div>
              <div id="font0" class="xz_blue_content" onMouseDown="setTab(0);">工资查询</div>
              <div id="font0-right" class="xz_blue_right"></div>
              <div id="font1" class="xz_gray_content" onMouseDown="setTab(1);">社保查询</div>
               <div id="font1-right" class="xz_gray_side"></div>
              <div id="font2" class="xz_gray_content" onMouseDown="setTab(2);">公积金查询</div>
              <div id="font2-right" class="xz_gray_side"></div>
              <div id="font3" class="xz_gray_content" onMouseDown="setTab(3);">个人订单</div>
              <div id="font3-right" class="xz_gray_side"></div>
              <div id="font4" class="xz_gray_content" onMouseDown="setTab(4);">福利办理</div>
              <div id="font4-right" class="xz_gray_side"></div>
              <div id="font5" class="xz_gray_content" onMouseDown="setTab(5);">福利理赔</div>
              <div id="font5-right" class="xz_gray_side"></div>
              <div id="font6" class="xz_gray_content" onMouseDown="setTab(6);">分类信息查询</div>
              <div id="font6-right" class="xz_gray_side"></div>
              <div id="font7" class="xz_gray_content" onMouseDown="setTab(7);">用退工查询</div>
              <div id="font7-right" class="xz_gray_side"></div>
              <div id="font8" class="xz_gray_content" onMouseDown="setTab(8);">劳动合同管理</div>
              <div id="xz_tail" class="xz_tail_gray"></div>
        </div>
        <!-- div bg end>>>>>>>>>> -->
        
        <!-- TabCon0 start->>>>>>>>>> -->
        <div id="TabCon0" class="tabClass">
            <c:if  test="${empty scVo}"><div class="xz_title" style="margin-top: 50px;text-align: center;clear: both;">未找到该员工的薪资记录！</div></c:if>
            <c:if  test="${not empty scVo}">
                <div class="xz_title" style="margine-top:30px;"> ${scVo.sa_class_name}</div>
                <div class="clear"></div>
                <div style="padding: 0 0 8 8;">
                    <r:datacell 
                        id="datacell0"
                        paramFormId="datacell_formid"
                        queryAction="/FAERP/SalarydataAction.do?cmd=queryDetailSalary&emp_post_id=${emp_post_id}&sa_class_id=${scVo.id}"
                        width="98%"
                        height="304px"
                        pageSize="20"
                        xpath="SalarydataVo"
                        freezeNumber="1"
                        >
                      <r:toolbar  tools="nav,pagesize,info"/>
                      <r:field sortAt="none" fieldName="pay_year_month" label="工资所属年月" width="120px;"></r:field>
                      <logic:iterate name="salarydataTitleList" id="salarydataTitle" scope="session" indexId="indexs">
                            <r:field sortAt="none" fieldName="def${salarydataTitle.item_serial_new_id }"
                                label="${salarydataTitle.newsalarylabel }"
                                onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                           </r:field>
                      </logic:iterate>
                    </r:datacell>
                    <input type="button" onclick="exportDetail();" value="工资导出" class="foot_icon_2" style="margin-left: 50%;">
                </div>
            </c:if>
       </div>
        <!-- TabCon0 end->>>>>>>>>> -->
        
        <!-- TabCon1 start->>>>>>>>>>> -->
        <div id="TabCon1" class="tabClass" style="display: none;">
                <div class="clear"></div>
                <div style="padding: 0 0 8 8;">
                        <r:datacell 
                            id="datacell1"
                            queryAction="/FAERP/EmpsecurityAction.do?cmd=listQueryLeaveDetailSocialSecurity&emp_post_id=${emp_post_id}&type=ss"
                            width="98%"
                            height="304px"
                            xpath="QuerySocialSecurityVo"
                            paramFormId="datacell_formid"
                            readonly="true"
                            pageSize="20"
                        >
                
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/> 
                          <r:field fieldName="big_name" label='大分类'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="small_name" label='小分类'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="hire_unit_short_name" label='福利办理方'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="transact_man" label='办理人'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="transact_date" label='办理日期'>
                            <w:date format="yyyy-MM-dd"/>
                          </r:field>
                          <r:field fieldName="type_name_new" label='办理类型'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="transact_remarks" label='办理备注'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="start_month" label='缴费起始月'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="end_month" label='缴费截止月'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="fund_month" label='报表月'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="pay_base" label='基数'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="security_status_bd" label='状态'>
                            <d:select dictTypeId="SECURITY_STATUS_BD" />
                          </r:field>
                          <r:field fieldName="stop_date" label='停办日期'>
                            <w:date format="yyyy-MM-dd"/>
                          </r:field>
                          <r:field fieldName="stop_man" label='停办人'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="type_name_stop" label='停办类型'>
                            <h:text/>
                          </r:field>
                          <r:field fieldName="stop_remarks" label='停办备注'>
                            <h:text/>
                          </r:field>
                    </r:datacell>
                </div>
                <div class="xz_title">汇缴</div>
                <div style="padding: 8 10 8 8;">
                    <r:datacell 
                        id="datacell1_1"
                        queryAction="/FAERP/EmpsecurityAction.do?cmd=searchUnremittedData"
                        width="98%"
                        height="200px"
                        xpath="EmpsecurityitemVo"
                        paramFormId="datacell_formid"
                        readonly="true"
                    >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="product_name" label="产品">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="product_ratio_name" label="产品比例">
                               <h:text/>   
                           </r:field>    
                          <r:field fieldName="base" label="基数">
                               <h:text/>
                           </r:field>
                          <r:field fieldName="e_ratio" label="企业比例">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="p_ratio" label="个人比例">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="money" label="金额">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="e_money" label="企业金额">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="p_money" label="个人金额">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="e_add_money" label="企业附加金额">
                            <h:text/>
                          </r:field>
                        
                    </r:datacell>
                </div>
                    
                    <p></p>
                    <div class="xz_title">补缴</div>
                    <div style="padding: 8 10 8 8;">
                          <r:datacell 
                                id="datacell1_2"
                                queryAction="/FAERP/EmpsecurityAction.do?cmd=searchInBackData"
                                width="98%"
                                height="180px"
                                xpath="EmpsecuritysupplyVo"
                                paramFormId="datacell_formid"
                                readonly="true"
                          >
                              <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                              <r:field fieldName="start_month" label="补缴起始月">
                                <h:text/>
                              </r:field>
                              <r:field fieldName="end_month" label="补缴截止月">
                                   <h:text/>   
                               </r:field>    
                              <r:field fieldName="fund_month" label="报表月">
                                   <h:text/>   
                               </r:field>    
                              <r:field fieldName="base" label="基数">
                                   <h:text/>
                               </r:field>
                              <r:field fieldName="month_inback" label="月补缴额">
                                <h:text/>
                              </r:field>
                              <r:field fieldName="money" label="金额">
                                <h:text/>
                              </r:field>
                              <r:field fieldName="e_money" label="企业金额">
                                <h:text/>
                              </r:field>
                              <r:field fieldName="p_money" label="个人金额">
                                <h:text/>
                              </r:field>
                              <r:field fieldName="remarks" label="备注" width="300px">
                                <h:text/>
                              </r:field>
                            </r:datacell>
                     </div>
       </div>
        <!-- TabCon1 end->>>>>>>>>>> -->
        
         <!-- TabCon2 start->>>>>>>>>>> -->
       <div id="TabCon2" class="tabClass" style="display: none;clear: both;float: left;">
                <div class="clear"></div>
                <div style="padding: 8 10 8 8;">
				    <r:datacell 
				        id="datacell2"
				        queryAction="/FAERP/EmpsecurityAction.do?cmd=listQueryLeaveDetailSocialSecurity&emp_post_id=${emp_post_id}&type=pf"
				        width="98%"
				        height="320px"
				        xpath="QuerySocialSecurityVo"
				        paramFormId="datacell_formid"
				        freezeNumber="1"
				        readonly="true"
				        >
				          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
				           <r:field fieldName="group_name" label="公积金组" sortAt="none" >
				          </r:field>
				          <r:field fieldName="account" label="公积金账号" sortAt="none">
				          </r:field>
                          <r:field fieldName="hire_unit_short_name" label="福利办理方" sortAt="none">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="transact_man" label="办理人" sortAt="none">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="transact_date" label="办理日期" sortAt="none">
				            <w:date format="yyyy-MM-dd"/>
				          </r:field>
				          <r:field fieldName="type_name_new" label="办理类型" sortAt="none">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="transact_remarks" label="办理备注" sortAt="none">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="start_month" label="缴费起始月" sortAt="none">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="end_month" label="缴费截止月" sortAt="none">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="fund_month" label="报表月" sortAt="none">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="pay_base" label="基数" sortAt="none">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="security_status_bd" label="状态" sortAt="none">
				            <d:select dictTypeId="SECURITY_STATUS_BD" />
				          </r:field>
				          <r:field fieldName="stop_date" label="停办日期" sortAt="none">
				            <w:date format="yyyy-MM-dd"/>
				          </r:field>
				          <r:field fieldName="stop_man" label="停办人" sortAt="none">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="type_name_stop" label="停办类型" sortAt="none">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="stop_remarks" label="停办备注" sortAt="none">
				            <h:text/>
				          </r:field>
				    </r:datacell>
			    </div>
			    <div class="xz_title">汇缴</div>
                <div style="padding: 8 10 8 8;;">
                    <r:datacell 
                        id="datacell2_1"
                        queryAction="/FAERP/EmpsecurityAction.do?cmd=searchUnremittedData"
                        width="98%"
                        height="180px"
                        xpath="EmpsecurityitemVo"
                        paramFormId="datacell_formid"
                        readonly="true"
                    >
                          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                          <r:field fieldName="product_name" label="产品">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="product_ratio_name" label="产品比例">
                               <h:text/>   
                           </r:field>    
                          <r:field fieldName="base" label="基数">
                               <h:text/>
                           </r:field>
                          <r:field fieldName="e_ratio" label="企业比例">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="p_ratio" label="个人比例">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="money" label="金额">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="e_money" label="企业金额">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="p_money" label="个人金额">
                            <h:text/>
                          </r:field>
                          <r:field fieldName="e_add_money" label="企业附加金额">
                            <h:text/>
                          </r:field>
                        
                    </r:datacell>
                </div>
                    
                    <p></p>
                    <div class="xz_title">补缴</div>
                    <div style="padding: 8 10 8 8;">
                          <r:datacell 
                                id="datacell2_2"
                                queryAction="/FAERP/EmpsecurityAction.do?cmd=searchInBackData"
                                width="98%"
                                height="180px"
                                xpath="EmpsecuritysupplyVo"
                                paramFormId="datacell_formid"
                                readonly="true"
                          >
                              <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                              <r:field fieldName="start_month" label="补缴起始月">
                                <h:text/>
                              </r:field>
                              <r:field fieldName="end_month" label="补缴截止月">
                                   <h:text/>   
                               </r:field>    
                              <r:field fieldName="fund_month" label="报表月">
                                   <h:text/>   
                               </r:field>    
                              <r:field fieldName="base" label="基数">
                                   <h:text/>
                               </r:field>
                              <r:field fieldName="month_inback" label="月补缴额">
                                <h:text/>
                              </r:field>
                              <r:field fieldName="money" label="金额">
                                <h:text/>
                              </r:field>
                              <r:field fieldName="e_money" label="企业金额">
                                <h:text/>
                              </r:field>
                              <r:field fieldName="p_money" label="个人金额">
                                <h:text/>
                              </r:field>
                              <r:field fieldName="remarks" label="备注" width="300px">
                                <h:text/>
                              </r:field>
                            </r:datacell>
                     </div>
       </div>
        <!-- TabCon2 end->>>>>>>>>>> -->
        
         <!-- TabCon3 start->>>>>>>>>>> -->
        <div id="TabCon3" class="tabClass" style="display: none;clear: both;float: left;">
            <span style="padding-left:15px;color:red;">当前仅显示有效费用段<a href="###" id="show1" onclick="javascript:show_onClick();"><u>点击</u></a> 显示所有费用段。“详细”后面括号里的日期代表该费用段的生成日期</span> 
	        <div class="box_3">
		        <table width="99%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" id="orderTabel">
		           </table>
		          <table width="99%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" style="display:none" id="displayTab">
		           </table>
		     </div>
	     </div>
	     <!-- TabCon3 end->>>>>>>>>>> -->
	     
	     <!-- TabCon4 start->>>>>>>>>>> -->
        <div id="TabCon4" class="tabClass" style="display: none;clear: both;float: left;">
            <div class="clear"></div>
             <div style="padding: 8 10 8 8;">
			    <r:datacell id="datacell4"
			            queryAction="/FAERP/ApplyinsuranceAction.do?cmd=queryLeaveDetailApplyinsurance&emp_post_id=${emp_post_id}"
			            width="100%" xpath="ApplyinsuranceVo" 
			            paramFormId="datacell_formid" height="340px" pageSize="50">
			            <r:toolbar location="bottom" tools="nav,pagesize,info" />
			            <r:field fieldName="emp_code" label="唯一号" width="100px">
			            </r:field>
			            <r:field fieldName="emp_name" label="姓名" width="100px">
			            </r:field>
			            <r:field fieldName="emp_sex" label="性别" width="100px">
			             <h:select property="emp_sex" disabled="true">
			                         <h:option value="1" label="男"/>
			                         <h:option value="0" label="女"/>
			                  </h:select>
			            </r:field>
			            <r:field fieldName="birth_date" label="出生日期" width="100px">
			            <w:date format="yyyy-MM-dd" name="" disabled="true"/> 
			            </r:field>
			            <r:field fieldName="id_card" label="身份证号" width="100px">
			            </r:field>
			            <r:field fieldName="product_name" label="产品名称" width="130px">
			            </r:field>
			            <r:field fieldName="apply_status_bd" label="办理状态" width="100px">
			            <h:select property="apply_status_bd" disabled="true">
			                         <h:option value="1" label="已办理"/>
			                         <h:option value="0" label="待办理"/>
			                  </h:select>
			            </r:field>
			            <r:field fieldName="apply_type_bd" label="办理类型" width="100px">
			                <d:select dictTypeId="APPLY_TYPE_BD" disabled="true"/>
			            </r:field>
			            <r:field fieldName="insurance_property_bd" label="医保属性" width="100px">
			             <h:select property="insurance_property_bd" disabled="true">
			                         <h:option value="1" label="有医保"/>
			                         <h:option value="0" label="无医保"/>
			                  </h:select>
			            </r:field>
			            <r:field fieldName="city_name" label="医保属地" width="100px">
			            </r:field>
			            <r:field fieldName="apply_date" label="福利办理日期" width="100px">
			            <w:date format="yyyy-MM-dd"  /> 
			            </r:field>
			            <r:field fieldName="remark" label="备注" width="200px">
			            </r:field>
			            <r:field fieldName="chil_name" label="子女姓名" width="100px">
			            </r:field>
			            <r:field fieldName="chil_sex_bd" label="子女性别" width="100px">
			            <h:select property="chil_sex_bd" disabled="true">
			                         <h:option value="1" label="男"/>
			                         <h:option value="0" label="女"/>
			                  </h:select>
			            </r:field>
			            <r:field fieldName="chil_birthday" label="出生日期" width="100px">
			               <w:date format="yyyy-MM-dd" name="" disabled="true"/> 
			            </r:field>
			            <r:field fieldName="chil_applicant_date" label="子女投保日期" width="100px">
			            <w:date format="yyyy-MM-dd" name="" disabled="true"/> 
			            </r:field>
			        </r:datacell>
			  </div>
         </div>
         <!-- TabCon4 end->>>>>>>>>>> -->
         
         <!-- TabCon5 start->>>>>>>>>>> -->
        <div id="TabCon5" class="tabClass" style="display: none;clear: both;float: left;">
            <div class="clear"></div>
             <div style="padding: 8 10 8 8;">
		            <r:datacell 
				        id="datacell5"
				       queryAction="/FAERP/SettlementclaimAction.do?cmd=queryLeaveDetailSettlementClaim&emp_post_id=${emp_post_id}"       
				       isCount="false"
				        width="100%"
				        xpath="SettlementclaimVo"
				        height="320"        
				        paramFormId="datacell_formid"
				        >
				        <r:toolbar location="bottom" tools="nav,pagesize,info"/>
				       <r:field allowModify="false" fieldName="chk"
				            label="<input type='checkbox' name='checkall' onclick='checkAll(this);' />"
				            sortAt="none" width="30px" >
				            <h:switchCheckbox name="chk" id="chk" checkedValue="1"
				                uncheckedValue="0" />
				        </r:field>
				       <r:field fieldName="batch_code" width="100px" label="批次号">
				       </r:field> 
				       <r:field fieldName="policy_code" width="100px" label="保单编号">
				       </r:field> 
				       <r:field fieldName="emp_code" width="100px" label="唯一号">
				       </r:field> 
				       <r:field fieldName="emp_name" width="100px" label="申请人名称">
				       </r:field> 
				       <r:field fieldName="id_card" width="100px" label="证件号">
				       </r:field> 
				       <r:field fieldName="birth_date" width="100px" label="生日" allowModify="false">
				       <w:date format="yyyy-MM-dd" />
				       </r:field> 
				       <r:field fieldName="custCode" width="100px" label="客户编号">
				       </r:field> 
				       <r:field fieldName="custName" width="100px" label="客户">
				       </r:field> 
				       <r:field fieldName="additional_name" width="100px" label="附险人姓名">
				       </r:field> 
				       <r:field fieldName="invoice_code" width="100px" label="发票编号">
				       </r:field> 
				       <r:field fieldName="visiting_hospital" width="100px" label="就诊医院">
				       </r:field> 
				       <r:field fieldName="disease_name" width="100px" label="疾病名称">
				       </r:field> 
				       <r:field fieldName="face_amount" width="100px" label="票面金额（初次申请金额）">
				       </r:field> 
				       <r:field fieldName="issuing_date" width="100px" label="出险日期" allowModify="false">
				       <w:date format="yyyy-MM-dd" />
				       </r:field> 
				       <r:field fieldName="visting_date" width="100px" label="就诊日期" allowModify="false">
				       <w:date format="yyyy-MM-dd" />
				       </r:field> 
				       <r:field fieldName="claim_no" width="100px" label="理赔号">
				       </r:field> 
				       <r:field fieldName="takingover_date" width="100px" label="交接日期" allowModify="false">
				       <w:date format="yyyy-MM-dd" />
				       </r:field> 
				       <r:field fieldName="item_name_bd" width="100px" label="项目名称">
				       </r:field> 
				       <r:field fieldName="real_applied_amount" width="100px" label="实际申请金额">
				       </r:field> 
				       <r:field fieldName="payAmount" width="100px" label="自费">
				       </r:field> 
				       <r:field fieldName="wholly_payment" width="100px" label="统筹支付">
				       </r:field> 
				       <r:field fieldName="attached_payment" width="100px" label="附加支付">
				       </r:field>       
				       <r:field fieldName="conceitedAmount" width="100px" label="分类自负">
				       </r:field>     
				       <!--<r:field fieldName="reason_substract" width="100px" label="扣除原因">
				       </r:field>
				       <r:field fieldName="substracted_amount" width="100px" label="扣除金额">
				       </r:field>  
				       --><r:field fieldName="deductible_amount" width="100px" label="免赔额">
				       </r:field>  
				       <r:field fieldName="percentage_claims" width="100px" label="赔付比例（险种）">
				       </r:field>  
				       <r:field fieldName="real_claims_amount" width="100px" label="实际赔付金额">
				       </r:field>  
				       <r:field fieldName="total_real_claims" width="100px" label="总实际赔付">
				       </r:field> 
				       <r:field fieldName="systemCalculateAmount" width="100px" label="系统计算金额">
				       </r:field> 
				       <r:field fieldName="reason_refuse" width="100px" label="拒赔原因">
				       </r:field>  
				       <r:field fieldName="absent_docs" width="100px" label="缺少材料">
				       </r:field>  
				       <r:field fieldName="contents_absent_docs" width="100px" label="拒赔内容">
				       </r:field>  
				       <r:field fieldName="claims_rejected_bd" width="100px" label="拒赔张数">
				       </r:field>  
				       <r:field fieldName="rejected_amount" width="100px" label="拒赔金额">
				       </r:field>     
				       <r:field fieldName="account_num" width="100px" label="银行账号">
				       </r:field>       
				       <r:field fieldName="bank_name" width="100px" label="开户行">
				       </r:field>       
				       <r:field fieldName="province_name" width="100px" label="账号省名">
				       </r:field>       
				       <r:field fieldName="city_area_name" width="100px" label="账号市区名">
				       </r:field>       
				       <r:field fieldName="user_name" width="100px" label="客服">
				       </r:field>         
				       <r:field fieldName="claims_state" width="100px" label="付款状态" allowModify="false">
				       <d:select dictTypeId="CLAIMS_STATE_BD" />
				       </r:field>
				    </r:datacell>
				 </div>
         </div>
         <!-- TabCon5 end->>>>>>>>>>> -->
         
         <!-- TabCon6 start->>>>>>>>>>> -->
         <div id="TabCon6" class="tabClass" style="display: none;clear: both;float: left;">
            <div style="padding: 8 10 8 8;">
				    <r:datacell 
				        id="datacell6"
				        queryAction="/FAERP/EmppostAction.do?cmd=queryLeaveDetailEntryData&emp_post_id=${emp_post_id}"
				        width="98%"
				        height="320px"
				        xpath="EmppostVo"
				        paramFormId="datacell_formid"
				        readonly="true"
				        >
				
				          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
				          <r:field fieldName="send_name" label="委派单名称">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="cust_name" label="客户名称">
				               <h:text/>   
				           </r:field>    
				          <r:field fieldName="city_id" label="城市" width="100px">
				                <r:comboSelect id="countryList" name="city_id"
				                     queryAction="PB_CITYAction.do?cmd=getListData"
				                     textField="city_name"
				                     valueField="id"
				                     xpath="PB_CITYVo"
				                     width="150px"/>
				           </r:field>   
				          <r:field fieldName="id_card" label="证件号码">
				               <h:text/>
				           </r:field>
				           <r:field fieldName="emp_code" label="唯一号">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="emp_name" label="员工姓名">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="post_status_bd" label="状态">
				            <d:select dictTypeId="POST_STATUS_BD" />
				          </r:field>
				          <r:field fieldName="big_name" label="员工大分类">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="small_name" label="员工小分类">
				            <h:text/>
				          </r:field>
				          <r:field fieldName="service_status_bd" label="分类状态">
				            <d:select dictTypeId="SERVICE_STATUS_BD" />
				          </r:field>
				          <r:field fieldName="classify_date" label="分类日期">
				            <w:date format="yyyy-MM-dd" />
				          </r:field>
				          <r:field fieldName="apply_on_post_date" label="入职日期">
				            <w:date format="yyyy-MM-dd" />
				          </r:field>
				          <r:field fieldName="apply_off_post_date" label="离职日期">
				            <w:date format="yyyy-MM-dd" />
				          </r:field>
				          <r:field fieldName="user_name" label="客服">
				            <h:text/>
				          </r:field>
				    </r:datacell>
		    </div>
			                
		    <div style="padding: 8 0 8 8;">
		        <r:datacell 
		            id="datacell6_1"
		            paramFormId="datacell_formid"
		            queryAction="/FAERP/EmppostAction.do?cmd=searchZlitem"
		            width="920px"
		            height="304px"
		            xpath="EmpserviceitemVo"
		            readonly="true"
		            pageSize="-1"
		            >
		          <r:field fieldName="agent_name" label="供应商" width="300px">
		            <h:text/>
		          </r:field>
		          <r:field fieldName="service_name" label="服务名称" width="180px">
		            <h:text/>
		          </r:field>
		          <r:field fieldName="service_status" label="状态" width="180px">
		            <d:select dictTypeId="SERVICE_STATUS" />
		          </r:field>
		          <r:field fieldName="service_date" label="办理日期" width="180px">
		           <w:date format="yyyy-MM-dd"/>
		          </r:field>
		        </r:datacell>
		    </div>  
         </div>
         <!-- TabCon6 end->>>>>>>>>>> -->
         
          <!-- TabCon7 start->>>>>>>>>>> -->
         <div id="TabCon7" class="tabClass" style="display: none;clear: both;float: left;">
            <div style="padding: 8 10 8 8;">
				 <r:datacell id="datacell7" queryAction="/FAERP/HirefireAction.do?cmd=queryLeaveDetailHireFireData&emp_post_id=${emp_post_id}" 
				 width="98%" height="318px" xpath="HirefireVo" paramFormId="datacell_formid" readonly="true">
				 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
				 <r:field fieldName="cust_name" label='客户名称' width="150px;"></r:field>
				 <r:field fieldName="user_name" label='客服'></r:field>
				 <r:field fieldName="bigname" label='用工分类' width="150px;"></r:field>
				 <r:field fieldName="apply_on_post_date" label='入职时间' allowModify="false">
				    <w:date format="YYYY-MM-DD"/>
				 </r:field>
				 <r:field fieldName="apply_off_post_date" label='离职时间' allowModify="false">
				    <w:date format="YYYY-MM-DD"/>
				 </r:field>
				 <r:field fieldName="hire_address" label='用工所在地'></r:field>
				 <r:field fieldName="archives_address" label='现档案所在地'></r:field>
				 <r:field fieldName="hire_fire_status_bd" label='状态' allowModify="false">
				    <d:select dictTypeId="HIRE_FIRE_STATUS_BD" />
				 </r:field>
				 <r:field fieldName="hire_handle_date" label='办理用工日期' allowModify="false">
                    <w:date format="YYYY-MM-DD"/>
                 </r:field>
                 <r:field fieldName="fire_handle_date" label='办理退工日期' allowModify="false">
                    <w:date format="YYYY-MM-DD"/>
                 </r:field>
				 <r:field fieldName="back_reason" label='回退原因' width="150px;">
				 </r:field>
				 <r:field fieldName="cancel_reason" label='撤销原因' width="150px;">
				 </r:field>
				 <r:field fieldName="is_laborbook_bd" label='是否有劳动手册' allowModify="false">
				    <d:select dictTypeId="TrueOrFalse"/>
				 </r:field>
				 <r:field fieldName="is_fire_prove_bd" label='是否有退工单' allowModify="false">
				    <d:select dictTypeId="TrueOrFalse"/>
				 </r:field>
				 </r:datacell>
			</div>   
         </div>
         <!-- TabCon7 end->>>>>>>>>>> -->
         
          <!-- TabCon8 start->>>>>>>>>>> -->
         <div id="TabCon8" class="tabClass" style="display: none;clear: both;float: left;">
            <div style="padding: 8 10 8 8;">
				 <r:datacell id="datacell8" queryAction="/FAERP/LaborcontractAction.do?cmd=queryLeaveDetailLaborData&emp_post_id=${emp_post_id}" 
				     width="98%" height="320px" xpath="LaborcontractVo" 
				    paramFormId="datacell_formid" pageSize="10" readonly="true">
				    <r:toolbar location="bottom" tools="nav,pagesize,info"/>
				    <r:field fieldName="emp_post_type_bd" label='员工类型' allowModify="false">
				        <d:select dictTypeId="EMP_POST_TYPE_BD"></d:select>
				    </r:field>
				    <r:field fieldName="cust_name" label='客户公司'></r:field>
				    <r:field fieldName="user_name" label='客服'></r:field>
				    <r:field fieldName="salary" label='工资(正)'>
				    </r:field>
				    <r:field fieldName="labor_status_bd" label='签署状态'>
				        <d:select dictTypeId="LABOR_STATUS_BD" ></d:select>
				    </r:field>
				    <r:field fieldName="subscribe_date" label='签署日期'>
				        <w:date  id="subscribe_date" name="subscribe_date" format="yyyy-MM-dd" />
				    </r:field>
				    <r:field fieldName="welfare_address" label='福利办理地'>
				    </r:field>
				    <r:field fieldName="position" label='职务'>
				    </r:field>
				    <r:field fieldName="working_bd" label='工作制'>
				        <d:select dictTypeId="WORKING_BD" ></d:select>
				    </r:field>
				    <r:field fieldName="send_start_date" label='派遣期限起始日期'>
				         <w:date  id="send_start_date" name="send_start_date" format="yyyy-MM-dd" />
				    </r:field>
				    <r:field fieldName="send_end_date" label='派遣期限截至日期'>
				         <w:date  id="send_end_date" name="send_end_date" format="yyyy-MM-dd" />
				    </r:field>
				    <r:field fieldName="start_date" label='合同开始日期'>
				         <w:date id="start_date" name="start_date" format="yyyy-MM-dd" />
				    </r:field>
				    <r:field fieldName="end_date" label='合同结束日期'>
				         <w:date  id="end_date" name="end_date" format="yyyy-MM-dd" />
				    </r:field>
				    <r:field fieldName="try_start_date" label='试用期开始日期'>
				         <w:date  id="try_start_date" name="try_start_date" format="YYYY-MM-DD" />
				    </r:field>
				    <r:field fieldName="try_end_date" label='试用期结束日期'>
				         <w:date  id="try_end_date" name="try_end_date" format="yyyy-MM-dd" />
				    </r:field>
				    <r:field fieldName="try_salary" label='工资(试)'>
				    </r:field>
				    <r:field fieldName="labor_type_bd" label='合同类型' allowModify="false">
				        <d:select dictTypeId="LABOR_TYPE_BD" ></d:select>
				    </r:field>
				    <r:field fieldName="last_update_date" label='操作日期' allowModify="false">
				         <w:date  id="last_update_date" name="last_update_date" format="yyyy-MM-dd" />
				    </r:field>
				    <r:field fieldName="remark" label='备注'>
				    </r:field>
				 </r:datacell>
			 </div>             
         </div>
         <!-- TabCon8 end->>>>>>>>>>> -->
  </div>
</div>
</body>
</html>
<script language="javascript">
    jQuery(function(){
         $id("datacell1").isQueryFirst = false;
         $id("datacell1_1").isQueryFirst = false;
         $id("datacell1_2").isQueryFirst = false;
         $id("datacell2").isQueryFirst = false;
         $id("datacell2_1").isQueryFirst = false;
         $id("datacell2_2").isQueryFirst = false;
         $id("datacell4").isQueryFirst = false;
         $id("datacell5").isQueryFirst = false;
         $id("datacell6").isQueryFirst = false;
         $id("datacell6_1").isQueryFirst = false;
         $id("datacell7").isQueryFirst = false;
         $id("datacell8").isQueryFirst = false;
    });
    
    
     $id("datacell1").onClickRow  = function(rowTR,rowIndex,entity,datacell){
          var securityId=entity.getProperty("securityId");//取得组ID
          $id("datacell1_1").addParam("securityId",securityId);
          $id("datacell1_1").loadData();
          $id("datacell1_1").refresh();
           $id("datacell1_2").addParam("securityId",securityId);
          $id("datacell1_2").loadData();
          $id("datacell1_2").refresh();
     }
      $id("datacell2").onClickRow  = function(rowTR,rowIndex,entity,datacell){
          var securityId=entity.getProperty("securityId");//取得组ID
          $id("datacell2_1").addParam("securityId",securityId);
          $id("datacell2_1").loadData();
          $id("datacell2_1").refresh();
          $id("datacell2_2").addParam("securityId",securityId);
          $id("datacell2_2").loadData();
          $id("datacell2_2").refresh();
     }
     $id("datacell6").onClickRow  = function(rowTR,rowIndex,entity,datacell){
          var emp_service_id=entity.getProperty("emp_service_id");//取得组ID
          $id("datacell6_1").addParam("emp_service_id",emp_service_id);
          $id("datacell6_1").loadData();
          $id("datacell6_1").refresh();
     }
</script>
