<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<%
String login_user_id= RmJspHelper.getParty_idFromRequest(request);
%>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>政策大表</title>

<script language="javascript">
    function exportEXCEL_onClick(){
         var frm = $id("datacell_formid");
      //表单验证
      if( !checkForm(frm) ) {
          return;
      }
        
        var city_id = $id("city_idList_search").getValue();
        var group = $id("group_List").getValue();
        //document.getElementById("aa").value=city_id+'ds'+group
        //alert(city_id+'ds'+group);
        var url="";
        
        if(city_id==null || city_id==""){
            alert("城市不能为空！");
            return;
        }
                
        if(group==null || group==""){
            alert("社保/公积金组不能为空！");
            return;
        }
        
        url = "<%=request.getContextPath()%>/jsp/faerp/agent/agentreport/showagentpolicy.jsp?raq=agent_securityproduct.raq&city_id="+city_id+"&group="+group;

        window.open(url,'','height=600px,width=1024px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=');
        
    }
    
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
<script language="javascript">
       writeTableTopFesco('政策大表','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">

    <table width="98%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
            <div class="zbox">
            <div class="xz_title">报表</div>
            <!--表格1-->
            <div class="box_3">
            <table width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                <tr>
                  <td  align="right" class="td_1">
               城 市
            </td>
              <td align="left" class="td_2">
                        <r:comboSelect id="city_idList_search" name="city_id"
                       queryAction="/FAERP/PB_CITYAction.do?cmd=getListData"
                       textField="city_name"
                       valueField="id"
                       xpath="PB_CITYVo"
                       width="200px"
                    
                       nullText="请选择"
                       />
              </td>
                <td align="right" class="td_1">社保/公积金组</td>
              <td align="left" class="td_2">
                     <r:comboSelect id="group_List" name="security_group_id"
                       queryAction="/FAERP/SalagentAction.do?cmd=getGroupListByCity"
                       valueField="id"
                       textField="group_name"
                       xpath="SecuritygroupVo"
                       width="200px"
                       linkId="city_idList_search"
                       nullText="请选择" />
              </td>
              </tr>
            </table>
            </div>
            <div class="foot_button">
                 <a class="foot_icon_3"  onClick="javascript:exportEXCEL_onClick();">导出报表</a>
            </div>
            <!--表格1 end--></div>
            </td>
        </tr>
    </table>
    </form>
</body>
</fmt:bundle>
</html>
