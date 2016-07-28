<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/CommonCheck.js"/>
<h:script src="/js/caculateMoney.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.employeepost.pbcustlevelset.vo.PbcustlevelsetVo" %>
     <%
     PbcustlevelsetVo pbVo =null;    //从request中取出vo, 赋值给resultVo
     if(request.getAttribute("pbcustlevelsetVo") != null) {  //如果request中取出的bean不为空
         pbVo = (PbcustlevelsetVo)request.getAttribute("pbcustlevelsetVo");  //从request中取出vo, 赋值给resultVo
     }
%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>

<%@page import="rayoo.employeepost.pbcustlevelset.vo.PbcustlevelsetVo;"%>
<html>
<fmt:bundle basename="rayoo.salse.customer.customer_resource" prefix="rayoo.salse.customer.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FESCO Adecco ERP系统</title>

<script language="javascript">    
   function save_onclick(){
          var cust_id = $id("cust_id").value ;
          var work_type_bd  =$id("work_type_bd").value ;
          var cust_level_bd = radio_checked("r_cust_level_bd");
          var cust_offPost_level_bd = radio_checked("r_cust_offPost_level_bd");//2015-1-26 yangyuting add
          var e_apply_type = radio_checked("r_e_apply_type");  //$id("e_apply_type").value ;
          // 2015-1-21 yangyuting add
          var onsite_name = document.getElementById("onsite_name").value;
          var onsite_mobile =document.getElementById("onsite_mobile").value ;
          if(onsite_name!=""){
            if(!checkOnsiteName(onsite_name)){
                return false;
                }
          }
          if(onsite_mobile!=""){
            if(!checkOnsitemobile(onsite_mobile)){
             return false;
            }
          }
          
        //  alert("cust_level_bd:"+cust_level_bd+"--e_apply_type:"+e_apply_type) ;
          if (cust_id == null||cust_id==''){
             alert("客户数据问题，请重新进入！") ;
             return false ;
          }
         // if (cust_level_bd == null||cust_level_bd==''){
         //    alert("客户级别不能为空") ;
         //    return false ;
         // }
          //if (e_apply_type == null||e_apply_type==''){
          ////   alert("客户级别不能为空") ;
           //  return false ;
          //}
          
   			jQuery.ajax({
                   url: "<%=request.getContextPath()%>/PbcustlevelsetAction.do?cmd=update&cust_level_bd="+cust_level_bd+"&cust_id="+cust_id+"&e_apply_type="+e_apply_type+"&work_type_bd="+work_type_bd+"&onsite_name="+encodeURI(onsite_name)+"&onsite_mobile="+onsite_mobile+"&cust_offPost_level_bd="+cust_offPost_level_bd,
                  type: 'post',
                  dataType: 'html',
                  error: function(){
                      alert('系统编译错误！');
                      return  null;
                  },
                  success: function(text){
                    alert(text)
                     $id("dc_send").reload();
                    window.close() ;
                    window.opener.callBack("1");  //回调进行刷新
                 }
             });
   
   }
   
   
   function  winclose_onclick(){
   		window.close() ;
   		window.opener.callBack("1");  //回调进行刷新
   }
   
   //获取redio值
   function radio_checked(redio_name){
              var chkObjs = document.getElementsByName(redio_name);
              var chk = "0" ;
                for(var i=0;i<chkObjs.length;i++){
                    if(chkObjs[i].checked){
                        chk = chkObjs[i].value ;
                        break;
                    }
                }
                return  chk ;
   }
   
   
   function toupdate_onclick() { 
        $id("dc_send").submit();
    }   
    
    function toReload_onclick() {
         $id("dc_send").reload();
    }
    /**
    *  yangyuting add 
    **/
    function checkOnsiteName(onsiteName){
	    if(onsiteName.length>=5){
	        alert("onsite姓名字符长度不能超过5个字符");
	        return false;
	    }else{
	        return true;
	    }
    }
    function checkOnsitemobile(onsiteMobile){
   var reg = new RegExp("^[0-9]*$");
       if(!reg.test(onsiteMobile)||onsiteMobile.length!=8){
		   alert("onsite电话只能是8位数字");
		   return false;  
		}
	   else {
	     return true;
	   }
    }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" action="<%=request.getContextPath()%>/PbcustlevelsetAction.do?cmd=update">
<div id="right"> <div class="ringht_x">
<div id="ccChild0" class="box_3"> 
<div class="xz_title"><fmt:message key="customer_information"/></div>
    <table width="100%" border="0" cellspacing="1" cellpadding="0"  bgcolor="#c5dbe2">
        <tr>
             <td class="td_1"><fmt:message key="customer_code"/></td>
            <td class="td_2 ">
                 ${requestScope.bean.customer_code}
                 <input type="hidden" name="cust_id" id="cust_id" value="${requestScope.bean.id}"/>
            </td>
        </tr>
        <tr>
        <td class="td_1"><fmt:message key="customer_name"/></td>
            <td class="td_2 ">
               ${requestScope.bean.customer_name}
            </td>
            </tr>
    </table>
    </div>
    <div class="xz_title">设置客户级别</div>
    <br/>
     <div align="center">
	 <table width="90%" border="0" cellspacing="0" cellpadding="0"  >
        <tr>
             <td  align="right"><span class="style_required_red">* </span>流程入职办理设置:</td>
            <td  align="left">
           
                  <%if( pbVo!=null&&pbVo.getCust_level_bd().equals("1")){%>
                  <input type="radio" value="1" name="r_cust_level_bd" checked="true"/>E化入职办理
                  <%}else{  %>
                  
                    <input type="radio" value="1" name="r_cust_level_bd" />E化入职办理
                    <%} %>
                  <%if(pbVo!=null&& pbVo.getCust_level_bd().equals("0")){%>
                 <input type="radio" value="0" name="r_cust_level_bd" checked="true"/>传统入职办理
                  <%}else{ %>
                  <input type="radio" value="0" name="r_cust_level_bd" />传统入职办理
                    <%} %>
         <!--   <input type="radio" value="1" name="r_cust_level_bd" checked="true"/>E化办理
            <input type="radio" value="0" name="r_cust_level_bd"/>传统办理
                <d:radio dictTypeId="CUST_LEVEL_BD" name="r_cust_level_bd" value="${requestScope.cust_level_bd}"/>
            --></td>
             <td  align="right"><span class="style_required_red">* </span> 是否快捷办理:</td>
            <td  align="left"><!--
                <d:radio dictTypeId="E_APPLY_TYPE" name="r_e_apply_type" value="${requestScope.e_apply_type}"/>
            -->
                  <%if( pbVo!=null&&pbVo.getE_apply_type().equals("1")){%>
                  <input type="radio" value="1" name="r_e_apply_type" checked="true"/>是
                  <%}else{ %>
                    <input type="radio" value="1" name="r_e_apply_type" />是
                    <%} %>
                  <%if( pbVo!=null&&pbVo.getE_apply_type().equals("0")){%>
                  <input type="radio" value="0" name="r_e_apply_type" checked="true"/>否
                  <%}else{ %>
                    <input type="radio" value="0" name="r_e_apply_type" />否
                    <%} %>
            </td>
             <td  align="right"><span class="style_required_red">* </span> 工作制:</td>
            <td  align="left" >
                <d:select dictTypeId="WORK_TYPE_BD" style="width:80"  name="work_type_bd" id="work_type_bd"  value="${requestScope.work_type_bd}" ></d:select>
            </td>
        </tr>
        <!-- yangyuting add 2015-1-21 start -->
        <tr>
          <td  align="right"><span class="style_required_red">* </span>流程离职办理设置:</td>
            <td  align="left">
           
                  <%if( pbVo!=null&&null!=pbVo.getCust_offPost_level_bd()&&pbVo.getCust_offPost_level_bd().equals("1")){%>
                  <input type="radio" value="1" name="r_cust_offPost_level_bd" checked="true"/>E化离职办理
                  <%}else{  %>
                  
                    <input type="radio" value="1" name="r_cust_offPost_level_bd" />E化离职办理
                    <%} %>
                  <%if(pbVo!=null&& (null==pbVo.getCust_offPost_level_bd()||pbVo.getCust_offPost_level_bd().equals("0"))){%>
                 <input type="radio" value="0" name="r_cust_offPost_level_bd" checked="true"/>传统离职办理
                  <%}else{ %>
                  <input type="radio" value="0" name="r_cust_offPost_level_bd" />传统离职办理
                    <%} %>
        <td  align="right">onstie姓名:</td>
            <td  align="left" >
                        <input type="text" 
                         <%if( pbVo!=null&&pbVo.getOnsite_name()!=null){%>
	                        value="<%=pbVo.getOnsite_name()%>" 
	                        <%}else{ %>
	                        value=""
	                        <%} %>
                        name="onsite_name" />
                        
            </td>
             <td  align="right"> onstie电话:</td>
            <td  align="left" >
                     <input type="text"
                       <%if( pbVo!=null&&pbVo.getOnsite_mobile()!=null){%>
                            value="<%=pbVo.getOnsite_mobile()%>" 
                            <%}else{ %>
                            value=""
                            <%} %>
                     name="onsite_mobile" />
            </td>
        </tr>
          <!-- yangyuting add 2015-1-21 end -->
    </table>
    </div>
    
    
    <div class="foot_button">
    <input name="button_app" class="button_ellipse" type="button" value="<fmt:message key="save"/>"   onclick="javascript:save_onclick();">
    <input name="button_back" class="button_ellipse" type="button" value="关闭"  onclick="javascript:winclose_onclick() ;" >
    <br/><br/>
    <div class="xz_title"></div>
    
    <div align="left">
    <br/>
    <div class="button">
           <div class="button_right">
             <input class="b" type="button"   value="修改"  <au:authorityBtn code="ygtj_xg" type="1"/>  onClick="toupdate_onclick();">
             <input class="a" type="button"   value="刷新"  <au:authorityBtn code="ygtj_sx" type="1"/>  onClick="toReload_onclick();">      
           </div>
           <div class="clear"></div>
         </div>
         <br/>
     <r:datacell 
              id="dc_send"
              queryAction="/FAERP/empSendListAction.do?cmd=simpleQueryByCustLevelSet"
              submitAction="/FAERP/empSendListAction.do?cmd=updateByCustLevelSet"
              width="100%"
              height="220px"
              xpath="SendVo"
              submitXpath="SendVo"
              paramFormId="datacell_formid"
              readonly="felse"
              >
             <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      
              <r:field fieldName="customer_code" label="客户编号" width="100px" >
              </r:field>
              <r:field fieldName="customer_name" label="客户名称" width="200px">
              </r:field>
              <r:field fieldName="send_code" label="委派单编号" width="100px">
              </r:field>
              <r:field fieldName="send_name" label="委派单名称" width="200px">
              </r:field>
              <r:field fieldName="is_mailcontract" label="邮寄类型"  width="100px">
                  <d:select dictTypeId="IS_MAILCONTRACT_NEW" />
              </r:field>
              <r:field fieldName="is_laborBook" label="是否劳动手册"  width="100px">
                  <d:select dictTypeId="IS_LABORBOOK_BD" />
              </r:field>
        </r:datacell>
    <dir></dir>
</div>
</div>
</div>
</form>

</body>
</fmt:bundle>
</html>
