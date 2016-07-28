<%@ page contentType="text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/runqianReport4.tld" prefix="report" %>
<html>
<link type="text/css" href="css/style.css" rel="stylesheet"/>
<body topmargin=0 leftmargin=0 rightmargin=0 bottomMargin=0>
<%
    request.setCharacterEncoding( "GBK" );
    String report = request.getParameter( "raq" );
    String reporttype = request.getParameter( "reporttype" );
    String arg1 = request.getParameter("arg1");
    String arg2 = request.getParameter("arg2");
    String arg3 = request.getParameter("arg3");
    String arg4 = request.getParameter("arg4");
    String arg5 = request.getParameter("arg5");
    String arg6 = request.getParameter("arg6");
    String arg7 = request.getParameter("arg7");
    String arg8 = request.getParameter("arg8");
    String arg9 = request.getParameter("arg9");
    String arg10 = request.getParameter("arg10");
    String arg11 = request.getParameter("arg11");
    String arg12 = request.getParameter("arg12");
    StringBuffer param=new StringBuffer();
    //产品类
    if(reporttype != null&&reporttype.equals("1")){
	    if(arg1 != null&&!arg1.equals("")&&!arg1.equals("null")){
	        param.append("arg1=").append(arg1).append(";") ;
	    }
	    if(arg2 != null&&!arg2.equals("")&&!arg2.equals("null")){
	        param.append("arg2=").append(arg2).append(";") ;
	    }
	    if(arg3 != null&&!arg3.equals("")&&!arg3.equals("null")){
	        param.append("arg3=").append(arg3).append(";") ;
	    }
	    if(arg4 != null&&!arg4.equals("")&&!arg4.equals("null")){
	        param.append("arg4=").append(arg4).append(";") ;
	    }
	    if(arg5 != null&&!arg5.equals("")&&!arg5.equals("null")){
	        param.append("arg5=").append(arg5).append(";") ;
	    }
	    if(arg6 != null&&!arg6.equals("")&&!arg6.equals("null")){
	        param.append("arg6=").append(arg6).append(";") ;
	    }
	    if(arg7 != null&&!arg7.equals("")&&!arg7.equals("null")){
	        param.append("arg7=").append(arg7).append(";") ;
	    }
	    if(arg8 != null&&!arg8.equals("")&&!arg8.equals("null")){
	        param.append("arg8=").append(arg8).append(";") ;
	    }
	    if(arg9 != null&&!arg9.equals("")&&!arg9.equals("null")){
	        param.append("arg9=").append(arg9).append(";");
	    }
	    if(arg10 != null&&!arg10.equals("")&&!arg10.equals("null")){
	        param.append("arg10=").append(arg10).append(";");
	    }
	    if(arg11 != null&&!arg11.equals("")&&!arg11.equals("null")){
	        param.append("arg11=").append(arg11).append(";");
	    }
	    if(arg12 != null&&!arg12.equals("")&&!arg12.equals("null")){
            param.append("arg12=").append(arg12).append(";");
        }
    }
    //信息类
    else if (reporttype!=null&&reporttype.equals("2")){
        if(arg1 != null&&!arg1.equals("")&&!arg1.equals("null")){
            param.append("arg1=").append(arg1).append(";") ;
        }
        if(arg2 != null&&!arg2.equals("")&&!arg2.equals("null")){
            param.append("arg2=").append(arg2).append(";") ;
        }
        if(arg3 != null&&!arg3.equals("")&&!arg3.equals("null")){
            param.append("arg3=").append(arg3.trim()).append(";") ;
        }
    }
    //子女类
    else if (reporttype!=null&&reporttype.equals("3")){
        
        if(arg1 != null&&!arg1.equals("")&&!arg1.equals("null")){
            param.append("arg1=").append(arg1.trim()).append(";") ;
        }
        if(arg2 != null&&!arg2.equals("")&&!arg2.equals("null")){
            param.append("arg2=").append(arg2.trim()).append(";") ;
        }
        if(arg3 != null&&!arg3.equals("")&&!arg3.equals("null")){
            param.append("arg3=").append(arg3.trim()).append(";") ;
        }
        if(arg4 != null&&!arg4.equals("")&&!arg4.equals("null")){
            param.append("arg4=").append(arg4.trim()).append(";") ;
        }
        if(arg5 != null&&!arg5.equals("")&&!arg5.equals("null")){
            param.append("arg5=").append(arg5.trim()).append(";") ;
        }
        if(arg6 != null&&!arg6.equals("")&&!arg6.equals("null")){
            param.append("arg6=").append(arg6.trim()).append(";") ;
        }
        
    }
    //保单报表
    else if(reporttype!=null&&reporttype.equals("4")){
        if(arg1 != null&&!arg1.equals("")&&!arg1.equals("null")){
            param.append("arg1=").append(arg1).append(";") ;
        }
        if(arg2 != null&&!arg2.equals("")&&!arg2.equals("null")){
            param.append("arg2=").append(arg2).append(";") ;
        }
        if(arg3 != null&&!arg3.equals("")&&!arg3.equals("null")){
            param.append("arg3=").append(arg3).append(";") ;
        }
        if(arg4 != null&&!arg4.equals("")&&!arg4.equals("null")){
            param.append("arg4=").append(arg4).append(";") ;
        }
    }
    %>
<jsp:include page="toolbar.jsp" flush="false" />
<table id="rpt" align="center"><tr><td>
        <report:html name="report1" reportFileName="<%=report%>"
            funcBarLocation="top"
            needPageMark="yes"
            generateParamForm="no"
            params="<%=param.toString()%>"
            needPivot="yes"
            pivotLabel=""
            exceptionPage="/jsp/faerp/reportJsp/myError2.jsp"
            appletJarName="runqianReport4Applet.jar,dmGraphApplet.jar"
            pageMarkLabel=""
            textDataLineBreak="\r\n"
            width="-1"
        />

</table>

<script language="javascript">
    //设置分页显示值
    document.getElementById( "t_page_span" ).innerHTML=report1_getTotalPage();
    document.getElementById( "c_page_span" ).innerHTML=report1_getCurrPage() ;
</script>
</body>
</html>
