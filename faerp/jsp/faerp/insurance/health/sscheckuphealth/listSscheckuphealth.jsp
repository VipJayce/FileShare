<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
//tab切换
    
    function setTab03Syn ( i )
    {
        selectTab03Syn(i);
    }
    
    function selectTab03Syn ( i )
    {
        switch(i){
            case 1:
            document.getElementById("TabCon1").style.display="block";
            document.getElementById("TabConInner1").style.display="block";
            document.getElementById("TabCon2").style.display="none";
            document.getElementById("TabConInner2").style.display="none";
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            break;
            case 2:
            document.getElementById("TabCon1").style.display="none";
            document.getElementById("TabConInner1").style.display="none";
            document.getElementById("TabCon2").style.display="block";
            document.getElementById("TabConInner2").style.display="block";
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            break;
        }
    }


 //弹出导出层
    function toinsert_pop(){
        url="<%=request.getContextPath()%>/jsp/faerp/insurance/health/sscheckuphealth/insertSscheckuphealth.jsp";
        showModalCenter(url, window, returnFun, 800, 430, '新增员工体检');  //
    }
    function returnFun(){
            $id("dc_healthid").reload();
    }
    
    function rtnFuncCustomer_s(arg){
        var lookup = $id("cust_name_s");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        return false;
    }
    function rtnFuncCustomer_f(arg){
        var lookup = $id("cust_name_f");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        return false;
    }
    
    function search_onclick() {
        $id("dc_healthid").reload() ;
    }
    function searchfeedback_onclick() {
        $id("dc_healthfeedbackid").reload() ;
    }
    function toupdate_onclick() { 
        $id("dc_healthid").submit();
    }   
    
    function tofeedbackupdate_onclick() {   
       if(confirm('您确定修改相关数据')) {
          $id("dc_healthfeedbackid").submit();
       } 
        
    }   
    function toReload_onclick() {
         $id("dc_healthid").reload();
    }
    function toReloadFeedback_onclick() {
         $id("dc_healthfeedbackid").reload();
    }
        
    function inputFileWindow(){
            url="<%=request.getContextPath()%>/jsp/faerp/insurance/health/sscheckuphealth/inputhealthdata.jsp";
           showModalCenter(url, window, returnFuninput, 600, 230, '导入员工体检数据');  //增加子岗位
    }
    function returnFuninput(){
       $id("dc_healthid").reload();
    }
    function returnFuninputfeedback(){
       $id("dc_healthfeedbackid").reload();
    }     
    function inputfeedbackFileWindow(){
            url="<%=request.getContextPath()%>/jsp/faerp/insurance/health/sscheckuphealth/inputhealthfeedbackdata.jsp";
           showModalCenter(url, window, returnFuninputfeedback, 600, 230, '导入员工体检反馈数据');  //增加子岗位
    }
    
    function export_onclick(){
        $id("datacell_formid").action="<%=request.getContextPath()%>/SscheckuphealthAction.do?cmd=exportHealth"  ;
        $id("datacell_formid").submit() ;
    }
    function exportFeedback_onclick(){
    
        $id("datacell_formid2").action="<%=request.getContextPath()%>/SscheckuphealthAction.do?cmd=exportFeedbackHealth"  ;
        $id("datacell_formid2").submit() ;
    }
    
    
</script>
</head>
<body>
 <div id="bg" class="xixi1" >
            <div id="font1" class="tab1" onMouseDown="setTab03Syn(1);document.getElementById('bg').className='xixi1'">体检名单</div>
            <div id="font2" class="tab2" onMouseDown="setTab03Syn(2);document.getElementById('bg').className='xixi2'">反馈名单</div>
        </div>
         <div id="TabCon1">
    <div id="right" class="search" >
       <form name="datacell_formid" action="" id="datacell_formid" method="post"> 
         <!--表格1--><!--
         <div class="xz_title" style="margin-top:10px;">生成体检名单</div>
         <div class="box_3">
           <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
             <tr>
               <td class="td_1"><span>*</span>体检月份</td>
               <td class="td_2"><select name="select2" class="sSelect" id="select2">
                 <option value="ro1" selected>请选择</option>
                 <option>6月</option>
                 <option>11月</option>
                              </select></td>

               <td class="td_2"><input name="submit2" type="submit" class="icon_3" value="生成体检名单" /></td>
             </tr>
           </table>
         </div>
         -->
         <div class="box_3">
           <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
             <tr>
               <td class="td_1">客户编号</td>
               <td class="td_2"><input name="cust_id_s" type="text" class="sText" id="cust_id_s" value=""/></td>
               <td class="td_1">客户名称</td>
               <td class="td_2">
               <w:lookup onReturnFunc="rtnFuncCustomer_s" readonly="false" id="cust_name_s" name="cust_name_s" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:170px"/> 
               </td>
               <td class="td_1">唯一号</td>
               <td class="td_2"><input name="emp_code_s" type="text" class="sText" id="emp_code_s" value=""/></td>
             </tr>
             <tr>
               <td class="td_1">员工名称</td>
               <td class="td_2"><input name="emp_name_s" type="text" class="sText" id="emp_name_s" value=""/></td>
               <td class="td_1">身份证</td>
               <td class="td_2"><input name="emp_id_card_s" type="text" class="sText" id="emp_id_card_s" value=""/></td>
               <td class="td_1">所属客服</td>
               <td class="td_2">
               <input name="cust_serrver_s" type="text" class="sText" id="cust_serrver_s" value=""/>
               </td>
             </tr>
             <tr>
               <td class="td_1">是否标准</td>
               <td class="td_2">
               <select name="is_standard_s" class="sSelect" id="is_standard_s">
                 <option value="" selected>请选择</option>
                 <option value="1">标准</option>
                 <option value="0">非标准</option>
                              </select>
               </td>
               <td class="td_1">是否确认享受</td>
               <td class="td_2"><d:select name="is_sure" id="is_sure" dictTypeId="TrueOrFalse" nullLabel="--请选择--" style="width: 189px" /></td>
               <td class="td_1">享受月</td>
               <td class="td_2"><input name="enjoy_month" type="text" class="sText" id="enjoy_month" value=""/></td>
             </tr>
             <tr>
                <td colspan="6" align="right" class="td_2"><input name="butt" type="button" onclick="search_onclick()" class="icon_2" value="查询" /></td>
             </tr>
           </table>
         </div>
          </form>
         <div class="button">
           <div class="button_right">
             <!--<ul>
               <li class="c"><a onClick="toinsert_pop()">新增</a></li>
               <li class="b"><a onClick="toupdate_onclick()">修改</a></li>
               <li class="a"><a onclick="javascript:toReload_onclick();">刷新</a></li>
               <li class="e_1"><a  onclick="javascript:inputFileWindow();">导入</a></li>
               <li class="e"><a onclick="javascript:export_onclick();">导出</a></li>
             </ul>
             --><input class="c" type="button"   value="新增"  <au:authorityBtn code="ygtj_add" type="1"/>  onClick="toinsert_pop();">
             <input class="b" type="button"   value="修改"  <au:authorityBtn code="ygtj_xg" type="1"/>  onClick="toupdate_onclick();">
             <input class="a" type="button"   value="刷新"  <au:authorityBtn code="ygtj_sx" type="1"/>  onClick="toReload_onclick();">      
             <input class="e_1" type="button"   value="导入"  <au:authorityBtn code="ygtj_imp" type="1"/>  onClick="inputFileWindow();">
             <input class="e" type="button"   value="导出"  <au:authorityBtn code="ygtj_exp" type="1"/>  onClick="export_onclick();">    
           </div>
           <div class="clear"></div>
         </div>
               <input type="hidden" id="attackAddressInput" name="attach_address" value="">
           </div>
       </div>   
         <div id="TabConInner1" >
          <r:datacell id="dc_healthid"
            queryAction="/FAERP/SscheckuphealthAction.do?cmd=seachCheckupHealth"
            submitAction="/FAERP/SscheckuphealthAction.do?cmd=updateCheckupHealthFeedback"
            width="98%" xpath="SscheckuphealthVo" submitXpath="SscheckuphealthVo"
            paramFormId="datacell_formid" height="330px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="cust_name" label="客户名称" width="150px">
            </r:field>
            <r:field fieldName="emp_code" label="唯一号" width="100px">
            </r:field>          
            <r:field fieldName="emp_name" label="员工名称" width="100px">
            </r:field>          
            <r:field fieldName="emp_id_card" label="身份证号码" width="130px">
            </r:field>          
            <r:field fieldName="serrvername" label="客服" width="100px">
            </r:field>   
            <r:field fieldName="serrverdep" label="客服部门" width="130px">
            </r:field>           
            <r:field fieldName="is_standard" label="是否标准" width="130px" allowModify="false">
            <h:select property="is_standard">
                         <h:option value="1" label="标准"/>
                         <h:option value="0" label="非标准"/>
              </h:select>
            </r:field>           
            <r:field fieldName="sex" label="性别" width="100px" allowModify="false">
            <d:select dictTypeId="EMP_SEX" name="sex"  property="sex" id="sex"/>
            </r:field>          
            <r:field fieldName="is_marital" label="婚否" width="100px" allowModify="false">
             <h:select property="is_marital">
                         <h:option value="1" label="已婚"/>
                         <h:option value="0" label="未婚"/>
                  </h:select>
            </r:field>          
            <r:field fieldName="str_date" label="体检开始日期" width="130px">
            <w:date format="yyyy-MM-dd"/>
            </r:field>          
            <r:field fieldName="end_date" label="体检截止日期" width="130px">
            <w:date format="yyyy-MM-dd"/>
            </r:field>          
            <r:field fieldName="settlement_date" label="结算日期" width="130px">
            <w:date format="yyyy-MM-dd"/>
            </r:field>
            <r:field fieldName="is_sure_enjoy" label="是否确定享受" width="150px" allowModify="false">
                <d:select dictTypeId="TrueOrFalse"  />
            </r:field> 
            <r:field fieldName="enjoy_month" label="享受月" width="150px" allowModify="false">
            </r:field>          
        </r:datacell>
        </div>
      <div id="TabCon2" style="display:none" >
        <div id="right" class="search"> 
       <form name="datacell_formid2" id="datacell_formid2" action="" method="post"> 
        <div class="box_3">
             <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#c5dbe2">

             <tr>
               <td class="td_1">客户编号</td>
               <td class="td_2"><input name="cust_id_f" type="text" class="sText" id="cust_id_f" value=""/></td>
               <td class="td_1">客户名称</td>
               <td class="td_2">
               <w:lookup onReturnFunc="rtnFuncCustomer_f" readonly="false" id="cust_name_f" name="cust_name_f" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:170px"/> 
               </td>
               <td class="td_1">唯一号</td>
               <td class="td_2"><input name="emp_code_f" type="text" class="sText" id="emp_code_f" value=""/></td>
             </tr>
             <tr>
               <td class="td_1">员工名称</td>
               <td class="td_2"><input name="emp_name_f" type="text" class="sText" id="emp_name_f" value=""/></td>
               <td class="td_1">身份证</td>
               <td class="td_2"><input name="emp_id_card_f" type="text" class="sText" id="emp_id_card_f" value=""/></td>
               <td class="td_1">所属客服</td>
               <td class="td_2"><input name="cust_serrver_f" type="text" class="sText" id="cust_serrver_f" value=""/></td>
             </tr>
                          <tr>
               <td class="td_1">是否体检</td>
               <td class="td_2"><select name="is_checkup_f" class="sSelect" id="is_checkup_f">
                 <option value="" selected>请选择</option>
                 <option value="1">是</option>
                 <option value="0">否</option>
                              </select></td>
               <td class="td_1">体检日期</td>
               <td class="td_2"><w:date allowInput="false" id="checkup_date_f" name="checkup_date_f" format="yyyy-MM-dd" style="width:125px;"/></td>
               <td class="td_1">是否标准</td>
               <td class="td_2">
                    <select name="is_standard_f" class="sSelect" id="is_standard_f">
                 <option value="" selected>请选择</option>
                 <option value="1">标准</option>
                 <option value="0">非标准</option>
                              </select>
                </td>
                          </tr>
             <tr>
               <td colspan="6" align="right" class="td_2"><input name="buttt" type="button" class="icon_2" onclick="searchfeedback_onclick()" value="查询" /></td>
             </tr>
             </table>
             </div>
              </form>
             <div class="button">
               <div class="button_right">
                 <!--<ul>
                 <li class="b"><a onClick="tofeedbackupdate_onclick()">修改</a></li>
                 <li class="a"><a onclick="javascript:toReloadFeedback_onclick();">刷新</a></li>
                   <li class="e_1"><a onclick="javascript:inputfeedbackFileWindow();">导入</a></li>
                   <li class="e"><a onclick="exportFeedback_onclick()">导出</a></li>
                 </ul>
                 --><input class="b" type="button"   value="修改"  <au:authorityBtn code="fkmd_xg" type="1"/>  onClick="tofeedbackupdate_onclick();">
                 <input class="a" type="button"   value="刷新"  <au:authorityBtn code="fkmd_sx" type="1"/>  onClick="toReloadFeedback_onclick();">      
                 <input class="e_1" type="button"   value="导入"  <au:authorityBtn code="fkmd_imp" type="1"/>  onClick="inputfeedbackFileWindow();">
                 <input class="e" type="button"   value="导出"  <au:authorityBtn code="fkmd_exp" type="1"/>  onClick="exportFeedback_onclick();">    
               </div>
               <div class="clear"></div>
             </div>
             </div></div>
              <div id="TabConInner2" style="display:none" >
              <r:datacell id="dc_healthfeedbackid"
            queryAction="/FAERP/SscheckuphealthAction.do?cmd=seachCheckupHealthFeedback"
            submitAction="/FAERP/SscheckuphealthAction.do?cmd=updateCheckupHealthFeedback"
            width="98%" xpath="SscheckuphealthVo" submitXpath="SscheckuphealthVo"
            paramFormId="datacell_formid2" height="340px">
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="cust_name" label="客户名称" width="150px" >
            </r:field>
            <r:field fieldName="emp_code" label="唯一号" width="100px">
            </r:field>          
            <r:field fieldName="emp_name" label="员工名称" width="100px">
            </r:field>          
            <r:field fieldName="emp_id_card" label="身份证号码" width="130px">
            </r:field>          
            <r:field fieldName="serrvername" label="客服" width="100px">
            </r:field> 
            <r:field fieldName="serrverdep" label="客服部门" width="130px">
            </r:field>           
            <r:field fieldName="is_checkup" label="是否体检" width="100px">
              <h:select property="is_checkup">
                         <h:option value="1" label="是"/>
                         <h:option value="0" label="否"/>
              </h:select>
            </r:field>
            <r:field fieldName="is_standard" label="是否标准" width="130px">
             <h:select property="is_standard" disabled="true">
                         <h:option value="1" label="标准"/>
                         <h:option value="0" label="非标准"/>
              </h:select>
            </r:field> 
                      
            <r:field fieldName="checkup_date" label="体检日期" width="100px">
            <w:date format="yyyy-MM-dd" name="" /> 
            </r:field>            
            <r:field fieldName="settlement_amount" label="结算金额" width="100px">
            <h:text/>
            </r:field>            
            <r:field fieldName="package_type" label="体检套餐" width="130px">
            </r:field>            
            <r:field fieldName="getdate" label="收到日期" width="130px" >
            <w:date format="yyyy-MM-dd"  disabled="true"/> 
            </r:field>            
            <r:field fieldName="senddate" label="发送日期" width="130px">
            <w:date format="yyyy-MM-dd"  disabled="true"/> 
            </r:field>          
            <r:field fieldName="city" label="地区" width="100px">
            <h:text/>
            </r:field>    
            <r:field fieldName="signfor_user" label="签收人" width="130px">
            </r:field>            
            <r:field fieldName="health_cust_serrver" label="体检客服" width="130px">
            </r:field>            
            <r:field fieldName="health_cust_serrver_dep" label="体检客服所属部门" width="130px">
            </r:field>            
            <r:field fieldName="checkup_agent" label="体检供应商" width="100px">
            <r:comboSelect id="agent_name" name="agent_name"
                                   queryAction="/FAERP/InsuranceAegntAction.do?cmd=findAllInsuranceAegnt"
                                   textField="agent_name"
                                   valueField="id"
                                   xpath="InsuranceAegntVo"
                                   width="150px"
                                   nullText="请选择" />
            </r:field>  
            <r:field fieldName="remark" label="备注" width="130px">
            </r:field>            
        </r:datacell>
             </div>
</body>
</html>


<script language="javascript">
    $id("dc_healthfeedbackid").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        if(activeFieldName == "is_checkup"||activeFieldName == "settlement_amount"){
            if(activeEntity.getValue(activeFieldName)!=newValue){
                if(confirm('您确定修改该数据吗?该操作会记录当前动作历史!')) {
                $id("dc_healthfeedbackid").refreshRow(getRow(activeCell) ,activeEntity)  ;
           }else{
                return false ;
           }
            }
        }
    };
</script>