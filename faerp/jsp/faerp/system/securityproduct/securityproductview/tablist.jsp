<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<script language="javascript">
    var dir_base = "/FAERP";
</script>

<link href="/FAERP/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<script language="javascript" src="/FAERP/js/jquery/jquery-1.3.min.js"></script>
<script type='text/javascript' src='/FAERP/js/common/variable-i18n_zh.js'></script>

<link href="/FAERP/css/alex-css.jsp" type="text/css" rel="stylesheet">
<!-- liuping add -->
<link href="/FAERP/css/common.css" type="text/css" rel="stylesheet">

<link href="/FAERP/css/index.css" type="text/css" rel="stylesheet">
<link href="/FAERP/css/tabs.css.jsp" rel="stylesheet" type="text/css">
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
.fex_row{LEFT:expression(document.getElementById('values_div').scrollLeft);POSITION: relative;}
</style>


<script language="javascript" src="/FAERP/js/common.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>无标题文档</title>
 <script  language="javascript">
    var tabs;
     function updateData() { //定义修改状态时显示的标签页
        tabs  =  new Array(
            new Array ("比例查看","<%=request.getContextPath()%>/SecurityproductAction.do?cmd=queryAllview"),
            new Array ("导出","<%=request.getContextPath()%>/SecurityproductAction.do?cmd=queryAllexport")
        );
        
    }
 updateData(); 
 </script>
 
 <script src="/FAERP/js/template/tabs.js"></script>

</head>
<body>
<div id="right">
    <div class="right_title_bg">
      <div class=" right_title">社保产品比例查看</div>
    </div>
<div>
    <table class="table_div_content" style="width:100%">
        <tr>
            <td>
                <table width="100%">
                  <tr>
                    <td>
                    <div id="tabsDiv"></div>
                    </td>
                </tr>
                </table>
            </td>
        </tr>
    </table>
</div>  

</div>
<script type="text/javascript">

writeTabs(500);
</script>
</body>
</html>
