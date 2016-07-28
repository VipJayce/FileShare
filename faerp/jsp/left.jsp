<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="gap.authority.au.aufunctree.vo.AuFunctreeVo" %>
<%@ page import="gap.authority.helper.LoginHelper" %>
<%@ page import="java.util.Map" %> 
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%  session = request.getSession(false);
String login_language=session.getAttribute("LOGIN_LANGUAGE")==null?"":session.getAttribute("LOGIN_LANGUAGE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="venus.frames.mainframe.util.Helper"%>
<%@page import="rayoo.finance.receivable.MyUtils"%>
<%@page import="gap.rm.tools.helper.RmStringHelper"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv=Content-Type content="text/html;  charset=UTF-8">
<title>iHR Core System</title>
<link href="<%=request.getContextPath()%>/css/common.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/index.css" rel="stylesheet" type="text/css" />
<style>
 html{  scrollbar-face-color:#2b9dd9;  scrollbar-highlight-color:#2eb2f7;  scrollbar-3dlight-color:#66bfee;  scrollbar-darkshadow-color:#000;  scrollbar-Shadow-color:#000;  scrollbar-arrow-color:#FFF;  scrollbar-track-color:#e5f4fc;  }  
</style>
<script>
function  abc(url){
//parent.frames["contents"].document.location=url;
//alert(parent.document.getElementById("contentFrame").src);
if(parent.document.getElementById("contentFrame").src!=null){
parent.document.getElementById("contentFrame").src=url;
//parent.document.getElementById("contentFrame").location.reload();
}
}
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/fesco/jquery.accordion.js"></script>
 
<script type="text/javascript">
            
            $(function () {
                $('ul').accordion();
                $('ul li:has(ul, div) > a').click(function(event, silent) {
                    if (silent === undefined) {
                        $.address.value('/');
                        $('ul li[class*=active]:has(ul, div) > a').each(function() {
                            $.address.parameter('a', $(this).attr('href').replace(/^#/, ''), true);
                        });
                        $.address.update();
                        return false;
                    }
                });
            });
            
            $.address.change(function(event) {
                var params = event.parameters['a'];
                $('ul li:has(ul, div) > a').each(function() {
                    var active = $(this).parent('li').attr('class').indexOf('active') != -1;
                    if ($.inArray(
                            $(this).attr('href').replace(/^#/, ''), 
                            [].concat(params ? params : [])) != -1) {
                        if (!active) $(this).trigger('click', [true]);
                    } else if (active) {
                        $(this).trigger('click', [true]);
                    }
                });
            });
            
        </script>

        <%!
    private List removeDupList(List list) {
        Map map = new HashMap();
        for (int i = 0; i < list.size(); i++) {
            AuFunctreeVo vo = (AuFunctreeVo)list.get(i);
            map.put(vo.getTotal_code(),vo);
        }
        List newList = new ArrayList();
        for (Iterator it = map.keySet().iterator();it.hasNext(); ) {
            AuFunctreeVo vo = (AuFunctreeVo)map.get(it.next());
            newList.add(vo);
        }
        return newList;
    }
%>
</head>
<body style="overflow:auto;  overflow-x: hidden;">
<!--左侧菜单-->
<div id="left">
  <ul class="accordion">
 <%
 
           List list = LoginHelper.getFirstLevelMenu(request);

                            for(int i = 0; i < list.size(); i++) {
                                AuFunctreeVo vo = (AuFunctreeVo)list.get(i);
                                if(login_language.equals("english")){
                        %>
                          <li> <a href="#<%=vo.getId() %><%=vo.getCode() %>" ><span class="left_icon_1"><img src="<%=request.getContextPath()%>/<%=vo.getImages_url() %>" style="vertical-align:middle;"/></span><%=vo.getEn_name() %></a>
                             <ul>
                             <%
                                }else{%>
                                 <li> <a href="#<%=vo.getId() %><%=vo.getCode() %>" ><span class="left_icon_1"><img src="<%=request.getContextPath()%>/<%=vo.getImages_url() %>" style="vertical-align:middle;"/></span><%=vo.getName() %></a>
                             <ul>
                                <%                                    
                                }
							     List twoLevelMenu  = new ArrayList();
							     twoLevelMenu  = LoginHelper.getNextLevelMenu(request,vo.getTotal_code());
							     if (twoLevelMenu != null && twoLevelMenu.size() > 0 ) {
							         List folderMenu = new ArrayList();
							         List leafMenu = new ArrayList(); //确保只有二级的菜单项在最上面
							         for (int j = 0; j< twoLevelMenu.size(); j++) {
							             AuFunctreeVo tempvo = (AuFunctreeVo)twoLevelMenu.get(j);
							             if ("1".equals(tempvo.getIs_leaf())) {
							                 leafMenu.add(LoginHelper.getPreviousLevelMenu(request,tempvo.getTotal_code()));
							             } else {
							                 folderMenu.add(tempvo);
							             }
							         }
							         leafMenu = removeDupList(leafMenu);
							         leafMenu.addAll(folderMenu);
							         for(int k = 0; k < leafMenu.size();k++) { //二级菜单
											             AuFunctreeVo svo = (AuFunctreeVo)leafMenu.get(k);  
							         if(login_language.equals("english")){
											%>
											  <li> <a href="#<%=svo.getId() %>"  class="ll" ><%=svo.getEn_name() %></a>
											        <% 
							         } else{
							             %>
							             <li> <a href="#<%=svo.getId() %>"  class="ll" ><%=svo.getName() %></a>
							             <% 
							         } List threeLevelMenuList = LoginHelper.getNextLevelMenu(request,svo.getTotal_code());
											         if(threeLevelMenuList != null&&threeLevelMenuList.size()>0) { 
											         
											             %>
											             <div> 
											             <%
											             for(int m= 0; m< threeLevelMenuList.size(); m++) {  // 三级菜单
									                            AuFunctreeVo tvo = (AuFunctreeVo)threeLevelMenuList.get(m);
											             if(login_language.equals("english")){
											         %>
											          <span><a href="javascript:abc('<%=request.getContextPath()%><%=tvo.getUrl() %>');"><%=tvo.getEn_name() %></a></span>
											<%
											             }  else {
											                 %>
											                   <span><a href="javascript:abc('<%=request.getContextPath()%><%=tvo.getUrl() %>');"><%=tvo.getName() %></a></span>
											                 <%
											                    }
											             }%>
											    </div>
											<%
											   }
											    %>
											</li>    
											<%
											}
							
							          } %>
                             
                               </ul>
                            </li>
                        <%}%>
  </ul>
</div>
<!--左侧菜单 end-->
</body>
</html>
