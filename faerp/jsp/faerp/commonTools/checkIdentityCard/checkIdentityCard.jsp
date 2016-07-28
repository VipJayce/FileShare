<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>身份证号码校验</title>
<link href="<%=request.getContextPath()%>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">

    
    <script>
            function checkIdCrad(){
            
                var idCardNum=_$("#idCard").val();
               _$.ajax({
            type: "post",
            dataType :"json",
            url:"<%=request.getContextPath()%>/IdCardNumUnscrambleAction.do?cmd=unscramble" ,
            data:{"id_card_num":idCardNum},
          success:function(result){
    
             _$("#info").val(result.info);
             _$("#belong").val(result.belong);
             _$("#id_card_num15").val(result.id_card_num15);
             _$("#id_card_num18").val(result.id_card_num18);
             _$("#gender").val(result.gender);
              _$("#birthday").val(result.birthday);
                  }
     
             });
          
            
            }
    
    </script>
    
    
</head>
<body>




<div id="right"><script language="javascript"> 
    writeTableTopFesco('身份证号码校验','/FAERP/');  //显示本页的页眉
</script>


            <script language="javascript">
    writeTableTop("身份证号码校验",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
        
         <div id="TabCon1">
         <div id="TabConInner1" >
         <form name="datacell_formid" action="" id="datacell_formid" method="post">

<div id="auDivParent0"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild0',this,'<%=request.getContextPath()%>/')" >&nbsp;
        校验号码
        </td>
    </tr>
</table>
</div>

<div id="auDivChild0"  style="padding_top:20px;background-color: #EAEAEA"> 
<table class="table_div_content" >
<tr><td>
    <table class="table_noFrame" width="100%" style="margin-top: 10px;" border="0">
        <tr>
            <td width="18%" align="right"><span class="style_required_red">* </span>输入身份证号码</td>
            <td width="35%" align="left">
                <input name="idCard" id="idCard" class="text_field" type="text"  style="width: 480px;"   >
            </td>
            <td  align="left" colspan="2"><input name="button_ok" class="button_ellipse" style="float: left;" type="button" value="校验号码"  onclick="javascript:checkIdCrad();"></td>
        </tr>
        
    </table>

</td></tr>
</table>
</div>
                    
<div id="auDivParent1"> 
<table class="table_div_control">
    <tr> 
        <td>
            <img src="<%=request.getContextPath()%>/images/icon/07-0.gif" class="div_control_image" onClick="javascript:hideshow('auDivChild1',this,'<%=request.getContextPath()%>/')">&nbsp;
        校验结果
        </td>
  
    </tr>
</table>
</div>


<div id="auDivChild1"  style="padding_top:20px;"> 
<table class="table_div_content" >
<tr><td>
    <table class="table_noFrame" width="100%" style="margin-bottom: 30px;margin-top: 10px;">
        <tr>
            <td width="18%" align="right">校验结果</td>
            <td width="35%" align="left" colspan="3">
                <input type="text" class="text_field" style="width: 990px;" id="info" />
            </td>
           
        </tr>
          <tr>
            <td width="15%" align="right">15位号码</td>
            <td width="35%" align="left">
                <input type="text" class="text_field" style="width: 400px;" id="id_card_num15" />
            </td>
            <td width="15%" align="right">18位号码</td>
            <td width="35%" align="left"><input name="button_ok" class="text_field" type="text"  style="width: 400px;" id="id_card_num18"  ></td>
        </tr>
             <tr>
            <td width="15%" align="right">出生日期</td>
            <td width="35%" align="left">
                <input type="text" class="text_field" style="width: 400px;" id="birthday" />
            </td>
            <td width="15%" align="right">性别</td>
            <td width="35%" align="left"><input name="button_ok" class="text_field" type="text"  style="width: 400px;" id="gender"  ></td>
        </tr>
        
            <tr>
            <td width="18%" align="right">号码属地</td>
            <td width="35%" align="left" colspan="3">
                <input type="text" class="text_field" style="width: 990px;" id="belong" />
            </td>
          
        </tr>

    </table>

</td></tr>
</table>
</div>

 </form>
 
      </div>
 </div>

         
</body>
</html>

