<%@ page contentType="text/html; charset=UTF-8"%>

	
 <html>
 <head>
 
<script type="text/javascript">
    function testview() {
       var login = document.getElementById("LoginX");  
       // login.Initial("<%=request.getContextPath()%>/DomainLoginAction.do","login_id","login_password");
       try{
              login.Initial("<%=request.getContextPath()%>/DomainLoginAction.do","fescoadecco",false);
              var url = login.NavigateUri(); 
              var loginName=login.GetUserName();
             //alert("loginName"+loginName+"url"+url);
           if (url!='error') {   
               //form1.action=url;
              document.getElementById("login_id").value=login.GetUserName();
              form1.submit(); 
              // window.location.href = msg;
            }else
            { 
          form1.action="login.jsp";
           form1.submit(); 
          } 
       }
       catch(err){// 如果没有装插件则直接跳转到正常登录页面
               window.location.href="<%=request.getContextPath()%>";
       }
    }
</script>
  
 </head>
 <body>
 
 <form action="<%=request.getContextPath()%>/DomainLoginAction.do" name="form1">
 <input type="hidden" value="" name="login_id"  id="login_id" >
 </form>
 
 
                                                                
 
    <object id="LoginX" classid="clsid:10C86C16-186E-4564-A789-676D231549D2" 
        width="500"
        height="100" 
        codebase="<%=request.getContextPath()%>/jsp/login/setup.exe">
        <param name="WebUrl" value="DomainLoginAction.do" />
    </object>
    <a href="<%=request.getContextPath()%>/jsp/login/setup.exe">下载</a>
 </body>
 <script type="text/javascript">
 
 testview();
 </script>
 </html>
 