<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script language="javascript">


 function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='temp'   );>";
    }
    
    
    
    function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
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

    function simpleQuery_onClick(){  //简单的模糊查询
        form.cmd.value = "simpleQuery";
        form.submit();
    }
    
       function exp_onClick(){  //导出到excel
        form.action="<%=request.getContextPath()%>/TempppsempdetailAction.do";
        form.cmd.value = "exp";
        form.submit();
    }
    

</script>
</head>
<body>

<form name="form" method="post"   id="datacell_formid"  action="<%=request.getContextPath()%>/TempppsempdetailAction.do">
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" id="cmd1"   name="cmd1" value="queryAll">
    <input type="hidden"  id="action1"  name="action1" value="TempppsempdetailAction.do">
 
 <%   
 String batch_id=(String)request.getAttribute("batch_id");


%>
<input  type="hidden"  name="batch_id" id="batch_id" value="<%=batch_id %>">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco("批量导入员工信息",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                <li class="a">      <a  onClick="javascript:exp_onClick();">导出</a> </li>
                </ul>
                
         </div>
           <div class="clear"></div>            
</div>
 
 
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/TempppsempdetailAction.do?cmd=simpleQuery"
        width="99%"
        xpath="TempppsempdetailVo"
        submitXpath="TempppsempdetailVo"
        paramFormId="datacell_formid"
        >
       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
             
       <r:field fieldName="emp_name" label="员工姓名" width="100px">
                  
       </r:field>   
       <r:field fieldName="emp_code" label="员工唯一号" width="100px">
                  
       </r:field>    
      <r:field fieldName="id_card_type" width="140px" label="证件类型" allowModify="false">
        <d:select dictTypeId="ID_CARD_TYPE_BD" />
      </r:field>
      <r:field fieldName="id_card" width="140px" label="证件号码">
      </r:field>
      <r:field fieldName="customer_code"  label="客户编号">
      </r:field>
      <r:field fieldName="customer_name" label="客户名称">
      </r:field>
      <!-- 暂时不导这些内容
       <r:field fieldName="send_code" label="委派单编号">
      </r:field>
      
      <r:field fieldName="quotation_code" label="报价单编号">
      </r:field>
      
      <r:field fieldName="post_date" label="入职日期">
      </r:field>
       <r:field fieldName="tel" label="电话">
       </r:field>
       -->
      <r:field fieldName="excute_status" label="导入状态" allowModify="false">
           <d:select dictTypeId="IMP_FLAG" />
      </r:field>
      <r:field fieldName="failure_reason" label="失败原因"  width="350px">
      </r:field>
      
    </r:datacell>
    </div>
 

</div>
</div>
</form>
</body>
</html>

