<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.eppartycomponent.vo.EppartycomponentVo" %>
<%@ page import="rayoo.employeepost.eppartycomponent.util.IEppartycomponentConstants" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*"%>
<html>

<%  //判断是否为修改页面
    EppartycomponentVo resultVo = null;  //定义一个临时的vo变量
    boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
    if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
        isModify = true;  //赋值isModify为true
        if(request.getAttribute(IEppartycomponentConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
            resultVo = (EppartycomponentVo)request.getAttribute(IEppartycomponentConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
        }
    }
    String partyCode = resultVo==null ? "" : resultVo.getParty_code();
    String partyType = resultVo==null ? "" : resultVo.getParty_type_bd();
    String partyCompCode = resultVo==null ? "" : resultVo.getParty_comp_code();
    
%>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/PartyGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<fmt:bundle basename="rayoo.employeepost.eppartycomponent.eppartycomponent_resource" prefix="rayoo.employeepost.eppartycomponent.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
      //  dwr.engine.setErrorHandler(function() { 
       // 
      // }); 

       function insert_onClick(){  //插入单条数据
	        var party_type_bd =document.getElementById("party_type_bd").value;
	        var party_name=document.getElementById('party_name').value;
	        var party_comp_code=document.getElementById('party_comp_code').value;
            var party_comp_name=document.getElementById('party_comp_name').value;
	        var party_comp_code1=document.getElementById('party_comp_code1').value;
	        var party_code = document.getElementById('partyCode1').value;
            var contact =  document.getElementById('contact').value;
            var contact_number =  document.getElementById("contact_number").value;
            var re_desc =  document.getElementById("re_desc").value;
	
	        if(party_type_bd==null||party_type_bd==""){
	            alert("<fmt:message key="please_choose_party_type"/>");
	            return;
	        }else{
	            if(party_type_bd=="1"){
	                   if(party_name==null|| party_name==""){
	                        alert("<fmt:message key="party_name_not_null"/>");
	                        return;
	                   }
	                   if(party_comp_code==null|| party_comp_code==""){
	                        alert("<fmt:message key="party_comp_code_not_null"/>");
	                        return;
	                   }
	                   showProgressBar();
	                   jQuery.getJSON("<venus:base/>/EppartycomponentAction.do?cmd=insert&date="+new Date()+"",{"party_type_bd":party_type_bd,"party_name":party_name,"party_comp_code":party_comp_code,"contact":contact,"contact_number":contact_number,"re_desc":re_desc},function(json){
		                    if(json.addsucess=="true"){
		                        alert("<fmt:message key="operation_seccuse"/>");
		                        window['returnValue'] = [''];
		                        hideProgressBar();
		                        window.close(); //关闭
		                        window.opener.toaddrollback();
		                     }else if(json.addsucess=="false"){
		                        alert("<fmt:message key="operation_error"/>");
		                        return;
		                     }
		             });
	            }else if(party_type_bd=="2"){
	                   if(party_comp_name==null|| party_comp_name==""){
	                        alert("<fmt:message key="party_comp_name_not_null"/>");
	                        return;
	                   }
	                   if(party_comp_code1==null|| party_comp_code1==""){
	                        alert("<fmt:message key="party_comp_code1_not_null"/>");
	                        return;
	                   }
	                   if(party_code==null|| party_code==""){
	                        alert("<fmt:message key="party_code_not_null"/>");
	                        return;
	                   }
	                   var party = document.getElementById('partyCode1');
	                   for(i=0;i<party.length;i++){
		                      if(party[i].selected == true){
		                          party_name = party[i].innerText;
		                      }
	                   }
	                   showProgressBar();
	                   jQuery.getJSON("<venus:base/>/EppartycomponentAction.do?cmd=insert&date="+new Date()+"",{"party_type_bd":party_type_bd,"party_name":party_name,"party_code":party_code,"party_comp_name":party_comp_name,"party_comp_code":party_comp_code1,"contact":contact,"contact_number":contact_number,"re_desc":re_desc},function(json){
                            if(json.addsucess=="true"){
                                alert("<fmt:message key="operation_seccuse"/>");
                                window['returnValue'] = [''];
                                hideProgressBar();
                                window.close(); //关闭
                                window.opener.toaddrollback();
                             }else if(json.addsucess=="false"){
                                alert("<fmt:message key="operation_error"/>");
                                return;
                             }
                     });
	            }
	        }
    }

    function update_onClick(id){  //保存修改后的单条数据
        if(!getConfirm()) {  //如果用户在确认对话框中点"取消"
            return false;
        }
        var id= document.getElementById("id").value;
        var party_type_bd =document.getElementById("partyType").value;
        var contact =  document.getElementById('contact').value;
        var contact_number =  document.getElementById("contact_number").value;
        var re_desc =  document.getElementById("re_desc").value;
        var temp='<%=partyCompCode%>';
        if(party_type_bd==null||party_type_bd==""){
            alert("<fmt:message key="please_choose_party_type"/>");
            return;
        }else{
            if(party_type_bd=="1"){
                   var party_name=document.getElementById('party_name').value;
                   var party_comp_code=document.getElementById('party_comp_code').value;
                   if(party_name==null|| party_name==""){
                        alert("<fmt:message key="party_name_not_null"/>");
                        return;
                   }
                   if(party_comp_code==null|| party_comp_code==""){
                        alert("<fmt:message key="party_comp_code_not_null"/>");
                        return;
                   }
                   showProgressBar();//新加入old党总支编号用来更新党支部信息
                   jQuery.getJSON("<venus:base/>/EppartycomponentAction.do?cmd=update&date="+new Date()+"",{"id":id,"party_type_bd":party_type_bd,"party_name":party_name,"party_comp_code":party_comp_code,"contact":contact,"contact_number":contact_number,"re_desc":re_desc,"o_party_code":temp},function(json){
			             if(json.updatesucess=="true"){
			                    alert("<fmt:message key="operation_seccuse"/>");
			                    window['returnValue'] = [''];
			                    hideProgressBar();
			                    window.close(); //关闭
			                    window.opener.toaddrollback();
			              }else if(json.updatesucess=="false"){
                                alert("<fmt:message key="operation_error"/>");
                                return;
                             }
			         });
            }else if(party_type_bd=="2"){
                   var party_comp_name=document.getElementById('party_comp_name').value;
			       var party_comp_code1=document.getElementById('party_comp_code1').value;
			       var party_code = document.getElementById('partyCode1').value;
                   if(party_comp_name==null|| party_comp_name==""){
                        alert("<fmt:message key="party_comp_name_not_null"/>");
                        return;
                   }
                   if(party_comp_code1==null|| party_comp_code1==""){
                        alert("<fmt:message key="party_comp_code1_not_null"/>");
                        return;
                   }
                   if(party_code==null|| party_code==""){
                        alert("<fmt:message key="party_code_not_null"/>");
                        return;
                   }
                   var party = document.getElementById('partyCode1');
                   for(i=0;i<party.length;i++){
                          if(party[i].selected == true){
                              var party_name = party[i].innerText;
                          }
                   }
                   showProgressBar();
                   jQuery.getJSON("<venus:base/>/EppartycomponentAction.do?cmd=update&date="+new Date()+"",{"id":id,"party_type_bd":party_type_bd,"party_name":party_name,"party_code":party_code,"party_comp_name":party_comp_name,"party_comp_code":party_comp_code1,"contact":contact,"contact_number":contact_number,"re_desc":re_desc},function(json){
                         if(json.updatesucess=="true"){
                                alert("<fmt:message key="operation_seccuse"/>");
                                window['returnValue'] = [''];
                                hideProgressBar();
                                window.close(); //关闭
                                window.opener.toaddrollback();
                          }else if(json.updatesucess=="false"){
                                alert("<fmt:message key="operation_error"/>");
                                return;
                             }
                     });
            }
        }
    }

    function cancel(){  //取消后返回列表页面
       window.close();
    }
    
       
	 function PartyGroupChange(){
	    PartyGroupAjax.findPartyGroup('s',function(data){
             setSelectForBean("partyCode1",data,"partyCode","partyName","");
             if(<%=!"".equals(partyCode)%>){
                 document.getElementById("partyCode1").value="<%=partyCode%>";
         }});
	 }
     function changefanshi(){
         var selectname=document.getElementById("party_type_bd").value; 
         if(selectname==""){
          
         }else if(selectname=='1'){
             document.all.partyname.style.display='';
             document.all.partycompname.style.display='none';
             document.all.partycompname1.style.display='none';
         }else if(selectname=='2'){
            document.all.partyname.style.display='none';
            document.all.partycompname.style.display='';
            document.all.partycompname1.style.display='';
            PartyGroupChange();
         }
     }
  
 
</script>
</head>
<body>

<form name="form" method="post">
<input type="hidden" id="partyType" name="partyType" value="<%=partyType %>"/>
<div id="right">

 <div class="ringht_x">
<div id="ccChild0" class="box_3">
<table  width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <input type="hidden" id = "id" name="id" />
        <%if(!isModify){ %>
        <tr>
            <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="choose_party_type"/></td>
            <td class="td_2">
              <%=gap.rm.tools.helper.RmJspHelper.getSelectField("party_type_bd", -1, "PARTY_TYPE_BD", "", " style='width:200px' onchange='changefanshi()' ", false) %>
            </td>
            <td class="td_1"></td>
            <td class="td_2"></td>
        </tr>
        <tr style="display:none" id="partyname" >
           <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="party_name"/></td>
            <td class="td_2" >
                  <input type="text" class="text_field" id="party_name" name="party_name" inputName="党总支部名称" value="" maxLength="50"/>
            </td>
            <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="party_comp_code"/></td>
            <td class="td_2 ">
               <input type="text"  class="text_field" id="party_comp_code" name="party_comp_code" inputName="党总支编号" value="" maxLength="11" />
            </td>
        </tr>
        <tr style="display:none" id="partycompname">
            <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="party_comp_name1"/></td>
            <td class="td_2 ">
               <input type="text"  class="text_field" id="party_comp_name" name="party_comp_name" inputName="党支部名称" value="" maxLength="50" />
            </td>
           <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="party_comp_code2"/></td>
            <td class="td_2" >
                  <input type="text"  class="text_field" id="party_comp_code1" name="party_comp_code1" inputName="党支部编号" value="" maxLength="11" />
            </td>   
        </tr>
        <tr style="display:none" id="partycompname1">
           <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="partyCode1"/></td>
            <td class="td_2" >
                    <select id="partyCode1" name="partyCode1"></select>
            </td>   
            <td class="td_1" ></td>
            <td class="td_2 ">
            </td>
        </tr>
        <%}else{ 
            if(partyType!=null&&partyType!=""&&partyType.equals("1")){
        %>
        <tr>
            <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="party_type"/></td>
            <td class="td_2">
                <input type="text" class="text_field" 
                value="<%=BaseDataHelper.getNameByCode("PARTY_TYPE_BD",RmStringHelper.prt(resultVo.getParty_type_bd()))%>"
                readonly="readonly" />
            </td>
            <td class="td_1"></td>
            <td class="td_2"></td>
        </tr>
        <tr>
           <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="party_name"/></td>
            <td class="td_2" >
                  <input type="text" class="text_field" id="party_name" name="party_name" inputName="党总支部名称" value="" maxLength="50"/>
            </td>
            <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="party_comp_code"/></td>
            <td class="td_2 ">
               <input type="text"  class="text_field" id="party_comp_code" name="party_comp_code" inputName="党总支编号" value="" maxLength="11" />
            </td>
            <input type="hidden" id="partyCode1"/>
        </tr>
        <%}else if(partyType!=null&&partyType!=""&&partyType.equals("2")){ %>
        <tr>
            <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="party_type"/></td>
            <td class="td_2">
                <input type="text" class="text_field"
                value="<%=BaseDataHelper.getNameByCode("PARTY_TYPE_BD",RmStringHelper.prt(resultVo.getParty_type_bd()))%>"
                readonly="readonly" />
            </td>
            <td class="td_1"><span class="style_required_red">*&nbsp;</span><fmt:message key="party_comp_name1"/></td>
            <td class="td_2">
                 <input type="text"  class="text_field" id="party_comp_name" name="party_comp_name" inputName="党支部名称" value="" maxLength="50" />
            </td>
        </tr>
        <tr>
            <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="party_comp_code2"/></td>
            <td class="td_2 ">
               <input type="text"  class="text_field" id="party_comp_code1" name="party_comp_code1" inputName="党支部编号" value="<%=partyCompCode %>" maxLength="11" />
            </td>
           <td class="td_1" ><span class="style_required_red">*&nbsp;</span><fmt:message key="partyCode1"/></td>
            <td class="td_2">
                  <select id="partyCode1" name="partyCode1"></select>
            </td>   
        </tr>
        <%}} %>
        <tr>
          <td class="td_1" ><fmt:message key="contact"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact" name="contact" inputName="联系人" value="" maxLength="50" />
            </td>
            <td class="td_1" ><fmt:message key="contact_number"/></td>
            <td class="td_2 ">
                <input type="text" class="text_field" id="contact_number" name="contact_number" inputName="联系方式" value="" maxLength="11" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
            </td>
        </tr>
        <tr>
            <td class="td_1"><fmt:message key="re_desc"/></td>
            <td colspan="3" class="td_2" >
                <textarea class="textarea_limit_words" cols="60" rows="5" id="re_desc" name="re_desc" inputName="备注" maxLength="1000" ></textarea>
            </td>
        </tr>
    </table>
   
    <div class="foot_button">
        <input type="button" class="icon_2" value='<fmt:message key="save"/>' onClick="javascript:<%=isModify?"update_onClick()":"insert_onClick()"%>" />
        <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel()"/>
     </div>
</div>         
            
<input type="hidden" name="create_date" />

</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
//取出要修改的那条记录，并且回写表单
<%
    if(isModify) {  //如果本页面是修改页面
        out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
        %>
        PartyGroupChange();
        <%
    }
%>
//PartyGroupChange();
</script>
