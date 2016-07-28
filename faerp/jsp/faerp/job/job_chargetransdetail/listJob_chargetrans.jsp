<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<h:script src="/js/jquery/jquery-1.7.2.min.js"/>

<script type="text/javascript">
jQuery.noConflict();
</script>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>


<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>费用划转单</title>
<script language="javascript">
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
	  
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到确认记录页面
	    var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
        if(ids == null) {  //如果ids为空
            alert('<fmt:message key="select_one_record"/>');
            return;
        }
        if("${requestScope.dept_partid}" == "" || "${requestScope.dept_partid}" == "null" || "${requestScope.dept_partid}" == null){
           alert("系统管理员不能进行划转费用确认操作！");
           return ;
       }
       var entities = $id("datacell1").dataset.getAlltEntities();
       for(var i=0;i<entities.length;i++){
            var ch = $id("datacell1").getRow(i).getElementsByTagName("input");
            if(ch[0].checked){
                //客服确认(划出部门确认)判断
	            if(entities[i].getProperty("outdept_id") == "${dept_partid}" && entities[i].getProperty("serviceconfirmor_name") != "" && entities[i].getProperty("serviceconfirmor_name") != null && entities[i].getProperty("serviceconfirmor_name") != "null"){
	                alert("第"+(i+1)+"行数据客服已经确认！");
	                return ;
	            } 
	            //财务是是否确认判断
	             if("${financedept_id}" ==  "${dept_partid}" && entities[i].getProperty("financeconfirmor_name") != "" && entities[i].getProperty("financeconfirmor_name") != null && entities[i].getProperty("financeconfirmor_name") != "null"){
                    alert("第"+(i+1)+"行数据财务已经确认！");
                    return ;
                } 
                //划入部门是否确认判断
                 if(entities[i].getProperty("cutindept_id") == "${dept_partid}" && entities[i].getProperty("counselconfirmor_name") != "" && entities[i].getProperty("counselconfirmor_name") != null && entities[i].getProperty("counselconfirmor_name") != "null"){
                    alert("第"+(i+1)+"行数据已经确认！");
                    return ;
                } 
            }
       }
      
		var url="<%=request.getContextPath()%>/Job_chargetransdetailAction.do?cmd=confirmchargetrans&ids="+ids+"&_ts="+(new Date()).getTime();
        /**
         jQuery.post(url,function(data){
             if(data){
                 if(data.getValue("root/data/returnValue")=="1"){                 
                     //alert("确认"+data+"条成功!");
                     alert("确认成功！");
                     simpleQuery_onClick();
                 }else{
                    //alert("已经确认，无须再确认！");
                    alert(data.getValue("root/data/returnMessage"));
                 }
             }else{
                 alert("确认失败！");
                 //simpleQuery_onClick();
             }
       });
       **/
       var myAjax = new Ajax(url);
       myAjax.submitXML(null, 'UTF-8');
       var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
            if( myAjax.getValue("root/data/returnValue") == "1" ) {
                alert("确认成功！");
                simpleQuery_onClick();
             }else {
                 alert(myAjax.getValue("root/data/returnMessage") ); 
             }
      }
       
       
	}
	/*function detail_onClick(){  //实现转到详细页面
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		form.action="<%=request.getContextPath()%>/Job_chargetransdetailAction.do?id=" + ids;
		form.cmd.value = "detail";
		form.submit(); 
		//var url="<%=request.getContextPath()%>/Job_chargetransdetailAction.do?cmd=detail&id=" + ids;
        //window.open(url,'','height=500px,width=850px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看费用划转单');
	}
	    */
	//生成复选框
	 function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    

    
   //客户参照
    function rtnCustFunc(arg){
    var lookup = $id("lk_cust");
        lookup.value = arg[0];
        lookup.displayValue = arg[2];
        jQuery("#cust_id").val(arg[0]);       
        return false;
    }
    

    function selectall(obj){
        if(obj.checked){
      
            var elements = document.getElementsByName("checkbox_template");
	        for(var i=0;i<elements.length;i++){
	            elements[i].checked = true;
	        }
        }else{
            var elements = document.getElementsByName("checkbox_template");
            for(var i=0;i<elements.length;i++){
                elements[i].checked = false;
            }
        }
    }

</script>
</head>
<body>

<form name="form" id="form1" method="post" action="<%=request.getContextPath()%>/Job_chargetransdetailAction.do">
<input type="hidden" name="cmd" value="queryAll">
 <input type="hidden" name="backFlag" id="backFlag" value="true">
 
<div id="right">
<script language="javascript">
	writeTableTopFesco('费用划转单','<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">


			<tr>
			<td width="174" rowspan="10" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
          
			<td/>
			<td/>
			  <td>    </td>
            	<td/>
		</tr>
				<tr>
				<td align="right">顾问名称</td>
            <td align="left">
                <input type="text" class="text_field" name="counselor_name1" inputName="顾问名称" maxLength="50"/>
            </td>
			<td align="right">职员名称</td>
			<td align="left">
				<input type="text" class="text_field" name="emp_name" inputName="职员名称" maxLength="50"/>
			</td>
			 <td align="right">确认状态</td>
            <td align="left">
                
                <select name="iscomfire" >
                <option value="0" selected="selected">请选择</option>
                 <option value="1">已确认</option>
                  <option value="2" selected="selected">未确认</option>
                </select>
            </td>
		</tr>
		<tr>
		
			<td align="right">客户</td>
            <td align="left">
                 <w:lookup onReturnFunc="rtnCustFunc" readonly="false" displayValue="" id="lk_cust" 
                                   lookupUrl="/JcustomerAction.do?cmd=getJCustRef" dialogTitle="选择客户" 
                                   height="440" width="710" allowInput="false" style="width:188px"/>
                <input type="hidden" name="cust_id" id="cust_id">
            </td>
		 <td align="right">职位名称</td>
            <td align="left">
                <input type="text" class="text_field" name="postition_name1" inputName="职位名称" maxLength="50"/>
            </td>
         <td align="right">划转年月</td>
            <td align="left">
                <input type="text" class="text_field" name="transyearmonth" inputName="划转年月" maxLength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
            </td>
		</tr>
		<tr>
		  <td align="right"></td>
          <td align="left"></td>
          <td align="right"></td>
          <td align="left"></td>
          <td align="left" colspan="2">
            <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
            <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
		  </td>
		</tr>
</table>
</div>

					
<div id="ccParent1" class="button"> 
 <div class="button_right">
				<ul>
					<!--  <li class="a">    	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>-->
					<li class="c"><a onClick="javascript:toAdd_onClick();" >确认</a> </li>
				</ul>
				
		 </div>
           <div class="clear"></div>			
</div>
 
 
 
 <div style="padding: 8 8 8 8;">
 <!-- 
 <r:datacell id="datacell1" queryAction="/FAERP/Job_chargetransdetailAction.do?cmd=listData" width="98%" height="318px" xpath="Job_chargetransdetailVo" paramFormId="form1"

  readonly="true">
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="<input type='checkbox' name='ch_operate' onclick='selectall(this);'/>" width="40px" onRefreshFunc="setCheckboxStatus" sortAt="none" ></r:field>
 <r:field fieldName="cust_name" label="客户" width="250px" ></r:field>    
 <r:field fieldName="pm_name" label="PM" width="110px">
 </r:field>
 <r:field fieldName="pm_teamname" label="PM-Team"  width="180px"></r:field>
 <r:field fieldName="counselor_name" label="顾问"  width="60px"></r:field>
 <r:field fieldName="position_name" label="职位"  width="100px"></r:field>
 <r:field fieldName="employee_name" label="职员"  width="60px"></r:field>
 <r:field fieldName="sendstartdate" label="外派日期"  width="80px">
 <w:date format="YYYY-MM-DD"/>
 </r:field>
 <r:field fieldName="sendenddate" label="截止日期"  width="80px">
 <w:date format="YYYY-MM-DD"/></r:field>
 <r:field fieldName="sendperiod" label="外派期限"  width="60px"></r:field>
 <r:field fieldName="expenseitem" label="费用项目"  width="100px"></r:field>
 <r:field fieldName="expenseamount" label="费用金额"  width="70px"></r:field>
 <r:field fieldName="description" label="备注" width="150px"></r:field>
 <r:field fieldName="serviceconfirmor_name" label="客服确认人"  width="70px"></r:field>
  <r:field fieldName="counselconfirmor_name" label="顾问确认人"  width="70px"></r:field>
   <r:field fieldName="financeconfirmor_name" label="财务确认人"  width="70px"></r:field>
 </r:datacell>
 -->
 <r:datacell id="datacell1" width="98%" height="318px" 
  paramFormId="form1"
  queryAction="/FAERP/Job_chargetransdetailAction.do?cmd=listData"
   xpath="/root/data/itemvo"
   submitAction=""
   submitXpath="itemvo"
  readonly="true" >
 <r:toolbar location="bottom" tools="nav,pagesize,info"/>
 <r:field fieldName="id" label="<input type='checkbox' name='ch_operate' onclick='selectall(this);'/>" width="40px" onRefreshFunc="setCheckboxStatus" sortAt="none" ></r:field>
 <r:field fieldName="transyearmonth" label="划转年月" width="80px" ></r:field>
 <r:field fieldName="cust_name" label="客户" width="180px" ></r:field>    
 <r:field fieldName="pm_name" label="PM" width="100px"> </r:field>
 <r:field fieldName="pm_teamname" label="PM-Team"  width="100px"></r:field>
 <r:field fieldName="counselor_name" label="顾问"  width="100px"></r:field>
 <r:field fieldName="position_name" label="职位"  width="100px"></r:field>
 <r:field fieldName="employee_name" label="职员"  width="100px"></r:field>
 <r:field fieldName="sendstartdate" label="外派日期"  width="100px">
 <w:date format="YYYY-MM-DD"/>
 </r:field>
 <r:field fieldName="sendenddate" label="截止日期"  width="100px">
 <w:date format="YYYY-MM-DD"/></r:field>
 <r:field fieldName="sendperiod" label="外派期限"  width="100px"></r:field>
 <l:iterate id="tableheaders" property="tableheaders" >
    <r:field fieldName="${tableheaders}" label="${tableheaders}"  width="100px"></r:field>
 </l:iterate>
 <r:field fieldName="description" label="备注" width="150px" ></r:field>
 <r:field fieldName="serviceconfirmor_name" label="客服确认人"  width="70px"></r:field>
  <!--<r:field fieldName="counselconfirmor_name" label="顾问确认人"  width="70px"></r:field>-->
  <l:iterate id="tableheaders" property="tableheaders" >
    <r:field fieldName="${tableheaders}confirmor" label="${tableheaders}确认人"  width="100px"></r:field>
 </l:iterate>
   <r:field fieldName="financeconfirmor_name" label="财务确认人"  width="70px"></r:field>
 </r:datacell>
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

</script>	
