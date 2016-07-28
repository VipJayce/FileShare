<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<html>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>


<html>
<fmt:bundle basename="rayoo.employeepost.eppartyrelation.eppartyrelation_resource" prefix="rayoo.employeepost.eppartyrelation.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
function simpleQuery_onClick(){  //按条件查询
   // alert($("status").value);
    $id("datacell1").loadData();
    $id("datacell1").refresh();
}
 function setTab001Syn ( i )
{  

    document.getElementById('bg').className='reserve_xixi'+i;
    selectTab001Syn(i);
  
}
function selectTab001Syn ( i )
   {
       switch(i){
           case 1:
               var status = document.getElementById("relation_status").value;
               var rid =document.getElementById("rid").value;
               var entity = $id("datacell1").activeEntity;
               if(entity != undefined)
               {
		               document.getElementById("font1").style.color="#FFFFFF";
		               document.getElementById("font2").style.color="#000000";
		               document.getElementById("font3").style.color="#000000";
                      if(status=="1" || status=="3")//未转入和转出的均可再次进行转入操作
                      {
                                 document.getElementById("TabCon1").style.display="block";          
                                 document.getElementById("TabCon2").style.display="none";   
                                 document.getElementById("TabCon3").style.display="none";    
                       } else{
                           alert("<fmt:message key="emp_can_not_transfer_operation"/>");
                            if(status!=null&&status!="")
                            {
                                      if(status=="2")
                                       {
                                             setTab001Syn ( 2 );
                                             document.getElementById('bg').className='reserve_xixi2';
                                       }
                                       else if(status=="4")
                                       {
                                               document.getElementById("bg").className="reserve_xixi3";
                                               setTab001Syn ( 3 );
                                       }
                            }
                       }
               }
               else{
                       document.getElementById("font1").style.color="#FFFFFF";
                       document.getElementById("font2").style.color="#000000";
                       document.getElementById("font3").style.color="#000000";
               }
               break;

           case 2:
               var status = document.getElementById("relation_status").value;
               var rid =document.getElementById("rid").value;
               var tabindex = document.getElementById("tabindex").value;
               var entity = $id("datacell1").activeEntity;
               if(entity != undefined)
               {
	               document.getElementById("font1").style.color="#000000";
	               document.getElementById("font2").style.color="#FFFFFF";
	               document.getElementById("font3").style.color="#000000";
	                if(status== "2"||status=="4")
	               {
	                    document.getElementById("TabCon1").style.display="none";          
                        document.getElementById("TabCon2").style.display="block";   
                        document.getElementById("TabCon3").style.display="none";    
	               }
	                else
	               {
	                     if(status!= "3")
	                     {
	                        alert("<fmt:message key="emp_can_not_turn_out_operation"/>");
	                     }
	                     else
	                     {
	                         if(tabindex='1')
                            {
                                selectTab001Syn(1);
                                 document.getElementById('bg').className='reserve_xixi1';
                            }      
                            else
                            {
                                selectTab001Syn(3);
                                 document.getElementById('bg').className='reserve_xixi3';
                            }
	                     }
	                 
	               }
               }
              else{
                       document.getElementById("font1").style.color="#000000";
                       document.getElementById("font2").style.color="#FFFFFF";
                       document.getElementById("font3").style.color="#000000";
               }
               
               break;

           case 3:
               var status= document.getElementById("relation_status").value;
               var entity = $id("datacell1").activeEntity;
               if(entity != undefined)
               {
		               document.getElementById("font1").style.color="#000000";
		               document.getElementById("font2").style.color="#000000";
		               document.getElementById("font3").style.color="#FFFFFF";
                       if(status== "2"||status=="4")
                      {
                              document.getElementById("TabCon1").style.display="none";          
                              document.getElementById("TabCon2").style.display="none";   
                              document.getElementById("TabCon3").style.display="block"; 
                      }
                      else
                      {
                        if(status!= "3")
                        {
                            alert("<fmt:message key="emp_can_not_internal_transfer_operation"/>"); 
                        }
                        else
                        {
                              if(tabindex='1')
                            {
                                selectTab001Syn(1);
                                 document.getElementById('bg').className='reserve_xixi1';
                            }      
                            else
                            {
                                selectTab001Syn(2);
                                 document.getElementById('bg').className='reserve_xixi2';
                            }
                        }
                      }
                    
               }
                else{
                       document.getElementById("font1").style.color="#000000";
                       document.getElementById("font2").style.color="#000000";
                       document.getElementById("font3").style.color="#FFFFFF";
               }
               break;
       }
   }
 
 function setCheckboxStatus(value,entity,rowNo,cellNo){
   return "<input type='radio' name='checkbox_template' value=" + entity.getProperty("id") + "  onClick=ClickRow(\"" + entity.getProperty("id") + "\");>";
}
    
 function ClickRow(obj)
 {
               document.getElementById("emp_id").value=obj;
               jQuery.getJSON("<venus:base/>/EppartymemerAction.do?cmd=detail1&date="+new Date()+"",{"empid":obj},function(json){
                 if(json!=null)
                 {
                     document.getElementById("in_date").value=json.bean.in_date;
                     document.getElementById("become_date").value=json.bean.become_date;
                     document.getElementById("relation_area").value=json.bean.relation_area;
                     document.getElementById("relationship_from").value=json.bean.relation_area;
                     document.getElementById("rid").value=json.bean.rid;
                  
                     if(json.bean.relation_area!=null)
                     {
                         document.getElementById("relation_area").value=json.bean.relation_area;
                     }
                     if(json.bean.inside_position)
                     {
                            document.getElementById("inside_position").value=json.bean.inside_position;
                     }
                  
                     document.getElementById("is_secretary").value=json.bean.is_secretary;
                     if(json.bean.is_secretary=="0")
                     {
                             document.getElementById("is_secretary").checked = false;
                     }
                     else
                     {
                             document.getElementById("is_secretary").checked = true;
                     }
                     document.getElementById("is_over_sea_in").value=json.bean.is_over_sea_in;
                     if(json.bean.is_over_sea_in=="0")
                     {
                             document.getElementById("is_over_sea_in").checked = false;
                     }
                     else
                     {
                             document.getElementById("is_over_sea_in").checked = true;
                     }
                     document.getElementById("party_member_id").value=json.bean.party_memer_id;
                     document.getElementById("relation_status").value=json.bean.status;
                     var status = json.bean.status;
                     if(status=="1"|| status=="3")
                     {
                           document.getElementById('bg').className='reserve_xixi1';
                           setTab001Syn ( 1 );
                     }else if(status=="2"||status=="4")
                     {                
                        
                         var tabindex= "";
                         tabindex=document.getElementById("tabindex").value;
                         if(tabindex=="")
                         {
                            setTab001Syn ( 2 );
                         }
                         else if(tabindex='2')
                         {
                            setTab001Syn ( 2 );
                         }
                         else if(tabindex='3')
                         {
                            setTab001Syn ( 3 );
                         }
                     }
                  
                 }
               });
       
 }
 
 function querydetail()
 {
     var selectitems = document.getElementsByName("checkbox_template");
     var selected=false;
     for(var i =0;i<selectitems.length;i++)
     {
         if(selectitems[i].checked)
         {
             selected=true;                
         }
     }
     
     if(selected)
     {
             var emp_id =  document.getElementById("emp_id").value;
             var url="<%=request.getContextPath()%>/EppartyrelationAction.do?cmd=partyRecord&emp_id="+emp_id;
             showModalCenter(url, window,"",650,300,"查看维护详情");
     }else
     {
         alert("<fmt:message key="please_choose_one_party"/>");
         return;
     }

 }
  function moveIn_onClick()
    {
        var rid= document.getElementById("rid").value;
        var partyCode = $id("partyCode1").getValue();
        var end_date=  document.getElementById("end_date").value;
        var move_in_date=  document.getElementById("move_in_date").value;
        var relationship_from = document.getElementById("relationship_from").value;
        
         if(document.getElementById("rid").value=="null"||document.getElementById("rid").value=="")
        {
            alert("<fmt:message key="please_choose_one_party"/>");
            return;
        }
         var reg = new RegExp("^[1-9]{1}[0-9]{3}((0[1-9]{1})|(1[0-2]{1}))$");  
        if(document.getElementById("end_date").value==null||document.getElementById("end_date").value=="")
        {
            alert("<fmt:message key="party_fee_end_month_not_null"/>");
            document.getElementById("end_date").select();
            return;
        }
        if(!reg.test(document.getElementById("end_date").value))
        {
            alert("<fmt:message key="date_format_false"/>");
            document.getElementById("end_date").select();
            return;
        }
        if(document.getElementById("move_in_date").value==null||document.getElementById("move_in_date").value=="")
        {
            alert("<fmt:message key="please_check_in_move_in_date"/>");
            return;
        }
        if($id("partyCode1").getValue()=="")
        {
            alert("<fmt:message key="please_choose_partyCode1"/>");
            return;
        }
        var is_secretary_temp = document.getElementById("is_secretary").value;
        var is_secretary;
        if(is_secretary_temp.checked)
        {
            is_secretary="<fmt:message key="is_secretary_temp_true"/>";
        }
        else
        {
            is_secretary="<fmt:message key="is_secretary_temp_false"/>";
        }
         jQuery.getJSON("<venus:base/>/EppartyrelationAction.do?cmd=partyMove&moveid=in&date="+new Date()+"",{"rid":rid,"partyCode":partyCode,"end_date":end_date,"move_in_date":move_in_date,"relationship_from":relationship_from,"is_secretary":is_secretary},function(json){
         alert(json.result);
         document.getElementById("TabCon1").style.display="none";
         document.getElementById("TabCon2").style.display="none";
         document.getElementById("TabCon3").style.display="none";
         if($name("status_bd").value=='')
         {
              $id("datacell1").addParam("status","6"); 
         }
         else
         {
                $id("datacell1").addParam("status",$name("status_bd").value); 
         }

         $id("datacell1").loadData();
         $id("datacell1").refresh();
         });
    }
     function moveOut_onClick()
    {
         var rid= document.getElementById("rid").value;
         var move_out_date = $id("move_out_date").getValue();
         var relationship_to=  document.getElementById("relationship_to").value;
         var remarks=  document.getElementById("remarks").value;
         if(document.getElementById("rid").value=="null"||document.getElementById("rid").value=="")
        {
            alert("<fmt:message key="please_choose_one_party"/>");
            return;
        }
        if($id("move_out_date").value==null)
        {
            alert("<fmt:message key="please_choose_move_out_date"/>");
            return ;
        }
        if( document.getElementById("relationship_to").value==null|| document.getElementById("relationship_to").value=='')
        {
            alert('<fmt:message key="relationship_to_not_null"/>');
            return ;
        }
         jQuery.getJSON("<venus:base/>/EppartyrelationAction.do?cmd=partyMove&moveid=out&date="+new Date()+"",{"rid":rid,"move_out_date":move_out_date,"relationship_to":relationship_to,"remarks":remarks},function(json){
          alert(json.result);
         document.getElementById("TabCon1").style.display="none";
         document.getElementById("TabCon2").style.display="none";
         document.getElementById("TabCon3").style.display="none";
         if($name("status_bd").value=='')
         {
              $id("datacell1").addParam("status","7"); 
         }
         else
         {
                $id("datacell1").addParam("status",$name("status_bd").value); 
         }

         $id("datacell1").loadData();
         $id("datacell1").refresh();
         });
    }
     function moveinternal_onClick()
    {
         var rid= document.getElementById("rid").value;
         var last_update_date = $id("last_update_date").getValue();
         var partyCode3=  document.getElementById("partyCode3").value;
         var remarks=  document.getElementById("remarks").value;

        if(document.getElementById("rid").value=="null"||document.getElementById("rid").value=="")
        {
            alert("<fmt:message key="please_choose_one_party"/>");
            return;
        }
        if($id("partyCode3").getValue()=="")
        {
            alert("<fmt:message key="please_choose_partyCode1"/>");
            return;
        }
        if($id("last_update_date").value==null)
        {
            alert("<fmt:message key="please_choose_last_update_date"/>");
            return;
        }

         jQuery.getJSON("<venus:base/>/EppartyrelationAction.do?cmd=partyMove&moveid=internal&date="+new Date()+"",{"rid":rid,"partyCode":partyCode3,"last_update_date":last_update_date,"remarks":remarks},function(json){
        alert(json.result);
        document.getElementById("TabCon1").style.display="none";
        document.getElementById("TabCon2").style.display="none";
        document.getElementById("TabCon3").style.display="none";
        if($name("status_bd").value=='')
        {
            $id("datacell1").addParam("status","7"); 
        }
        else
        {
              $id("datacell1").addParam("status",$name("status_bd").value); 
        }
           $id("datacell1").addParam("status","8"); 
           $id("datacell1").loadData();
           $id("datacell1").refresh();
       });
    }
     //选择客户
    function rtnFuncCustomer(arg){
        var lookup = $id("lk_clz");
        lookup.value = arg[2];
        lookup.displayValue = arg[2];
        //document.getElementById('query_cust_name').value = arg[2];
        //jQuery("#customer_id").val(arg[0]);        
        return false;
    }
  function exportExcel_onClick()
 {
        form.action="<%=request.getContextPath()%>/EppartyrelationAction.do?cmd=exportExcel" ;
        form.submit();
 }
</script>

</head>
<body>

<form name="form" id="datacell_formid" method="post" action="<%=request.getContextPath()%>/EppartyrelationAction.do">
 
 
<div id="right">
<script language="javascript">
    writeTableTopFesco('<fmt:message key="party_relationship_maintenance"/>');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="174" rowspan="10" style="padding-top:0;"><div class="search_title"><fmt:message key="query_condition"/></div> </td>
          
            <td/>
            <td/>
            <td/>   
            <td/>
        </tr>

        <tr>
            <td align="right"><fmt:message key="emp_name"/></td>
            <td align="left">
                <input type="text" class="text_field" id="emp_name" name="emp_name" inputName="员工姓名" />
            </td>
            <td align="right"><fmt:message key="id_card"/></td>
            <td align="left">
                 <input type="text" class="text_field" id = "id_card" name="id_card" inputName="身份证" />
            </td>
            <td align="right"><fmt:message key="emp_code"/></td>
            <td align="left">
                 <input type="text" class="text_field" id="emp_code" name="emp_code" inputName="唯一号" />
            </td>
        </tr>
        
        <tr>
            <td align="right"><fmt:message key="cust_name"/></td>
            <td align="left">
             <w:lookup name="cust_name" onReturnFunc="rtnFuncCustomer" id="lk_clz" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" messagekey="choose_cust" height="440" width="600"  style="width:195px"/>
            
            </td>
            <td align="right"><fmt:message key="sex"/></td>
            <td align="left">
          <d:select name="emp_sex" id="emp_sex" dictTypeId="EMP_SEX" nullLabel="--请选择--" />
            </td>
             <td align="right"><fmt:message key="view_branch"/></td>
            <td align="left">
             <r:comboSelect id="partyCode" name="partyCode"  queryAction="/FAERP/EppartycomponentAction.do?cmd=getPartyCode"
                       textField="party_name" valueField="id" xpath="EppartycomponentVo" width="200px" messagekey="please_choose" />
            </td>
        </tr>
        <tr>
            <td align="right"><fmt:message key="maintain_type"/></td>
            <td align="left">
                <d:select name="status_bd" id="status_bd" dictTypeId="RELATION_STATUS_BD" nullLabel="--请选择--"  />
            </td>
            <td align="right"></td>
            <td align="left"></td>
            <td align="right"></td>
            <td align="left">
            <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
             <input type="reset" class="icon_1"  />
            </td>
        </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right"><!--
                <ul>
                    <li class="e">      <a  onClick="javascript:exportExcel_onClick();"><fmt:message key="export"/> </a> </li>
                    <li class="p_1">    <a  onClick="javascript:querydetail();">查看维护详细</a> </li>
                </ul>
         -->
          <input type="button" class="e" value='<fmt:message key="export"/>'   <au:authorityBtn code="dzzgxwh_exp" type="1"/>  onClick="exportExcel_onClick();" />
          <input type="button" class="p_1" value='<fmt:message key="look_maintain_info"/>'   <au:authorityBtn code="dzzgxwh_viewItem" type="1"/>  onClick="querydetail();" />
         </div>
           <div class="clear"></div>            
</div>
 <div style="padding: 8 5 8 8;">
 <r:datacell 
        id="datacell1"
       queryAction="/FAERP/EppartyrelationAction.do?cmd=simpleQuery2"
        width="98%"
        height="302px"
        xpath="PartyRelationEmployeeVo"
        submitXpath="PartyRelationEmployeeVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
       <r:field fieldName="cid"  label="" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>   
       <r:field fieldName="emp_name" width="178px" messagekey="emp_name">
       </r:field>    
       <r:field fieldName="emp_sex" width="50px" messagekey="sex" allowModify="false">
         <d:select dictTypeId="EMP_SEX"/>
       </r:field>    
      <r:field fieldName="id_card" width="150px" messagekey="id_card" >
       </r:field>    
       <r:field fieldName="emp_code" width="80px" messagekey="emp_code" >
       </r:field>    
       <r:field fieldName="cust_name" width="237px" messagekey="cust_name" >
       </r:field>   
       <r:field fieldName="emp_status" width="100px" messagekey="on_post_status" >
       </r:field>   
       <r:field fieldName="au_name" width="100px" messagekey="cust_user_name" >
       </r:field> 
       <r:field fieldName="party_component_id" width="200px" messagekey="party_code" >
       </r:field>   
    </r:datacell>
</div>
 
 

</div>

    
</div>
 <div class="reserve_tab">
        <div id="bg" class="reserve_xixi1">
            <div id="font1" class="reserve_tab1" onMouseDown="setTab001Syn(1);"><fmt:message key="transfer"/></div>
            <div id="font2" class="reserve_tab2" onMouseDown="setTab001Syn(2);"><fmt:message key="turn_out"/></div>
            <div id="font3" class="reserve_tab3" onMouseDown="setTab001Syn(3);"><fmt:message key="internal_transfer"/></div>
        </div>
    </div>
    <input type="hidden" name = "moveid" id="moveid"/>
    <input type="hidden" name="rid" id ="rid"/>
    <input type="hidden" name="emp_id" id="emp_id"/>
    <input type="hidden" name="relation_status" id="relation_status"/>
    <input type="hidden" name="party_member_id" id="party_member_id"/>
<input type="hidden" id="tabindex" name="tabindex"/>
    <div id="ccChild1"     class="box_xinzeng"> 
    <div id="TabCon1" style="font-size: 12;display:none; " > 
 <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" style="font-size: 12;">
          <tr>
            <td style="background:#f1f7f9; text-align:right; width:200px;"><fmt:message key="relationship_from"/></td>
            <td style="background:#fff;width:200px;"><input name="relationship_from" type="text" class="sText" id="relationship_from" readonly="readonly" /></td>
            <td style="background:#f1f7f9; text-align:right; width:200px;" width="80px"><span class="style_required_red">*&nbsp;</span><fmt:message key="transfer_partyCode1"/></td>
            <td style="background:#fff;width:200px;">
            <r:comboSelect id="partyCode1" name="partyCode1"  queryAction="/FAERP/EppartycomponentAction.do?cmd=getPartyCode"
                       textField="party_name" valueField="id" xpath="EppartycomponentVo" width="200px" messagekey="please_choose" />
            </td>
            </tr>
          <tr>
            <td style="background:#f1f7f9; text-align:right; width:200px;"><span class="style_required_red">*&nbsp;</span><fmt:message key="transfer_date"/></td>
            <td style="background:#fff;width:200px;"><w:date allowInput="true" id="move_in_date" name="move_in_date" format="YYYY-MM-DD"/></td>
            <td style="background:#f1f7f9; text-align:right; width:200px;"><span class="style_required_red">*&nbsp;</span><fmt:message key="party_fee_end_date"/></td>
            <td style="background:#fff;width:200px;"><input name="end_date" type="text" class="sText" id="end_date" /></td>
          </tr>
          </table>
          <div class="dc_button" style="padding-right:30%;"><input type="button" class="icon_2" value="<fmt:message key="relation_to"/>" onClick="javascript:moveIn_onClick();"/></div>
    </div>
    <div id="TabCon2" style="font-size: 12;display:none; ">
        <div class="xz_title"><fmt:message key="turn_out"/></div>
        <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" style="font-size: 12;">
          <tr>
          <td style="background:#f1f7f9; text-align:right; width:200px;"><span class="style_required_red">*&nbsp;</span><fmt:message key="turn_out_date"/></td>
          <td style="background:#fff;width:200px;"> <w:date allowInput="true" id="move_out_date" name="move_out_date" format="YYYY-MM-DD"/></td>
          <td style="background:#f1f7f9; text-align:right; width:200px;"><span class="style_required_red">*&nbsp;</span><fmt:message key="relationship_to"/></td>
          <td style="background:#fff;width:200px;"><input  id="relationship_to" name="relationship_to" type="text"  class="sText" /></td>
        </tr>
        <tr>
          <td style="background:#f1f7f9; text-align:right; width:200px;"><fmt:message key="on_post_desc1"/></td>
          <td colspan="3" style="background:#fff;width:200px;"><textarea name="remarks" rows="3" style="width:350px;" class="xText_d" id="remarks"></textarea>
            <span class="dc_button" style="margin-left:40%;">
            <input type="button" class="icon_2" value="<fmt:message key="relation_turn_out"/>"   onClick="javascript:moveOut_onClick();"/>
            </span></td>
        </tr>
    </table>
    </div>
    <div id="TabCon3" style="font-size: 12;display:none; " >
<div class="xz_title"><fmt:message key="internal_transfer"/></div>
        <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" style="font-size: 12;">
          <tr>
            <td style="background:#f1f7f9; text-align:right; width:200px;"><span class="style_required_red">*&nbsp;</span><fmt:message key="transfer_partyCode1"/></td>
            <td style="background:#fff;width:200px;">
            <r:comboSelect id="partyCode3" name="partyCode3"  queryAction="/FAERP/EppartycomponentAction.do?cmd=getPartyCode"
                       textField="party_name" valueField="id" xpath="EppartycomponentVo" width="200px" messagekey="please_choose" />
            </td>
            <td style="background:#f1f7f9; text-align:right; width:200px;"><span class="style_required_red">*&nbsp;</span><fmt:message key="internal_transfer_date"/></td>
            <td style="background:#fff;width:200px;"><w:date allowInput="true" id="last_update_date" name="last_update_date" format="YYYY-MM-DD"/></td>
        </tr>
          <tr>
            <td style="background:#f1f7f9; text-align:right; width:200px;"><fmt:message key="on_post_desc1"/></td>
            <td colspan="3" style="background:#fff;width:200px;"><textarea name="remarks" rows="3" class="xText_d"  style="width:350px;"  id="remarks"></textarea>
              <span class="dc_button" style="margin-left:40%;">
              <input type="button" class="icon_2" value="<fmt:message key="internal_transfer"/>"  onClick="javascript:moveinternal_onClick();"/>
              </span></td>
            </tr>
          </table>
    </div>
    <div class="xz_title"><fmt:message key="party_info1"/></div>
 <div class="ringht_s">
 <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2" style="font-size: 12">
        <tr>
            <td class="td_1" ><fmt:message key="to_party_date"/></td>
            <td class="td_2">
                <input type="text" class="text_field_reference_readonly" name="in_date" id="in_date" inputName="转入日期" style="width: 205px;" readonly="readonly"/>
            </td>
            <td  class="td_1" ><fmt:message key="become_date1"/></td>
            <td class="td_2" >
             <input type="text" class="text_field_reference_readonly" name="become_date" id="become_date" inputName="转入日期" style="width: 205px;" readonly="readonly"/>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="relation_area1"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id ="relation_area" name="relation_area" inputName="原组织关系 所在(支部)" value=""readonly="readonly"/>
            </td>
            <td class="td_1" ><fmt:message key="inside_position"/></td>
            <td class="td_2" >
                <input type="text" class="text_field" id="inside_position" name="inside_position" inputName="党内职务" value="" readonly="readonly"/>
            </td>
        </tr>
        <tr>
            <td class="td_1" ><fmt:message key="is_secretary"/></td>
            <td class="td_2 ">
                 <input type='checkbox'  id="is_secretary" name="is_secretary"  value="0" pdType='control' control='checkbox_template' disabled="disabled"  />
                
            </td>
            <td class="td_1" ><fmt:message key="is_over_sea_in"/></td>
            <td class="td_2 ">
                 <input type='checkbox'  id="is_over_sea_in" name="is_over_sea_in"  value="0" pdType='control' control='checkbox_template'  disabled="disabled" />
            </td>
        </tr>
  
        
    </table>
 </div>
 </div>
</form>
</fmt:bundle>


</body>
</html>
<script language="javascript">
//初始化不加载页面信息<siqp添加>
_$(function(){
    $id("datacell1").isQueryFirst = false;
});
</script>
