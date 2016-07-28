<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/jsp/include/global.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.employeepost.eppartyfee.vo.EppartyfeeVo" %>
<%@ page import="rayoo.employeepost.eppartyfee.util.IEppartyfeeConstants" %>
<%  //取出List
    List lResult = null;  //定义结果列表的List变量
    if(request.getAttribute(IEppartyfeeConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
        lResult = (List)request.getAttribute(IEppartyfeeConstants.REQUEST_BEANS);  //赋值给resultList
    }
    Iterator itLResult = null;  //定义访问List变量的迭代器
    if(lResult != null) {  //如果List变量不为空
        itLResult = lResult.iterator();  //赋值迭代器
    }
    EppartyfeeVo resultVo = null;  //定义一个临时的vo变量
%>
<html>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
 /*  function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
        var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
        var number = 0;  //定义游标
        var ids = null;  //定义id值的数组
        for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
            if(elementCheckbox[i].checked) {  //如果被选中
                number += 1;  //游标加1
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
    function findCheckbox_onClick() {  //从多选框到修改页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?id=" + ids;
        form.cmd.value = "find";
        form.submit();
    }  
    function deleteMulti_onClick(){  //从多选框物理删除多条记录
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
            form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?ids=" + ids;
            form.cmd.value = "deleteMulti";
            form.submit();
        }
    }
    function simpleQuery_onClick(){  //简单的模糊查询
        form.cmd.value = "simpleQuery";
        form.submit();
    }
    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyfee/insertEppartyfee.jsp";
        form.submit();
    }
    function detail_onClick(){  //实现转到详细页面
        var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if(ids.length > 1) {  //如果ids有2条以上的纪录
            alert('<fmt:message key="only_can_a_record"/>');
            return;
        }
        form.action="<%=request.getContextPath()%>/EppartyfeeAction.do?id=" + ids;
        form.cmd.value = "detail";
        form.submit();
    }
    */
//tab切换
    function setTabSyn ( i )
    {
        selectTabSyn(i);
    }
    
    function selectTabSyn ( i )
    {
        switch(i){
            case 1:
            document.getElementById("font1").style.color="#ffffff";
            document.getElementById("font2").style.color="#000000";
            $("#box_tab").empty();
            $("#box_tab").append(" <iframe id = \"paypartyfee\" name=\"paypartyfee\"  src=\"<%=request.getContextPath()%>\/jsp/faerp/insurance/empMedCheck/empMedCheckList.jsp\" scrolling=\"no\"  frameBorder=0 width=\"100%\" height=\"500px;\"><\/iframe>");
          //  document.all.paypartyfee.src="<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyfee/payPartyfee.jsp";
             // $("#payPartyfee").attr("src","<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyfee/payPartyfee.jsp");  
            
            break;
            case 2:
            document.getElementById("font1").style.color="#000000";
            document.getElementById("font2").style.color="#ffffff";
            $("#box_tab").empty();
            $("#box_tab").append(" <iframe id = \"paypartyfee\" name=\"paypartyfee\"  src=\"<%=request.getContextPath()%>\/jsp/faerp/insurance/empMedCheck/FeedbackList.jsp\" scrolling=\"no\"  frameBorder=0 width=\"100%\" height=\"500px;\"><\/iframe>");
           // document.all.paypartyfee.src="<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyfee/notPayPartyfee.jsp";
     
         //   $("#box_tab").attr('src','<%=request.getContextPath()%>/jsp/faerp/employeepost/eppartyfee/notPayPartyfee.jsp');  
            break;
        }
    }
</script>
</head>
<body>

<form name="form" method="post" action="<%=request.getContextPath()%>/EppartyfeeAction.do">
<input type="hidden" name="cmd" value="queryAll">
 
 
<div id="right">
<script language="javascript">
   writeTableTopFesco('员工体检','<%=request.getContextPath()%>/');
</script>
<div class="ringht_s">
    <div class="tab">
        <div id="bg" class="xixi1">
            <div id="font1" class="tab1" onMouseDown="setTabSyn(1);document.getElementById('bg').className='xixi1'">体检名单</div>
            <div id="font2" class="tab2" onMouseDown="setTabSyn(2);document.getElementById('bg').className='xixi2'">反馈名单</div>
        </div>

                <div class="box_tab" id="box_tab">
              <iframe id = "empMedCheck" name="empMedCheck"  src="<%=request.getContextPath()%>/jsp/faerp/insurance/empMedCheck/empMedCheckList.jsp" scrolling="no"  frameBorder=0 width="100%" height="500px;"></iframe>
         </div>

        
    </div>

</div>
</form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //表单回写
    if(request.getAttribute(IEppartyfeeConstants.REQUEST_WRITE_BACK_FORM_VALUES) != null) {  //如果request中取出的表单回写bean不为空
        out.print(RmVoHelper.writeBackMapToForm((java.util.Map)request.getAttribute(IEppartyfeeConstants.REQUEST_WRITE_BACK_FORM_VALUES)));  //输出表单回写方法的脚本
    }
%>
</script>   
