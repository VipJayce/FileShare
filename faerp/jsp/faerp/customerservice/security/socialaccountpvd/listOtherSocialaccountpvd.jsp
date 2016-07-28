<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.customerservice.security.socialaccountpvd.vo.SocialaccountpvdVo" %>
<%@ page import="rayoo.customerservice.security.socialaccountpvd.util.ISocialaccountpvdConstants" %>
<%@ page import="rayoo.customerservice.security.empsecurity.util.IEmpsecurityConstants" %>
<%  //取出List
	List lResult = null;  //定义结果列表的List变量
	if(request.getAttribute(ISocialaccountpvdConstants.REQUEST_BEANS) != null) {  //如果request中的beans不为空
		lResult = (List)request.getAttribute(ISocialaccountpvdConstants.REQUEST_BEANS);  //赋值给resultList
	}
	Iterator itLResult = null;  //定义访问List变量的迭代器
	if(lResult != null) {  //如果List变量不为空
		itLResult = lResult.iterator();  //赋值迭代器
	}
	SocialaccountpvdVo resultVo = null;  //定义一个临时的vo变量
	 String social_group_id=request.getParameter("social_group_id")==null? "" : request.getParameter("social_group_id").toString();
     String social_unit_id=request.getParameter("social_unit_id")==null? "" : request.getParameter("social_unit_id").toString();
     String group_type = request.getAttribute("group_type")==null?"":request.getAttribute("group_type").toString();
%>
<html>
<fmt:bundle basename="rayoo.customerservice.security.socialaccountpvd.socialaccountpvd_resource" prefix="rayoo.customerservice.security.socialaccountpvd.">
<head>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/SecurityGroupAjax.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
var vpath = "<%=request.getContextPath()%>";
function citySecurityGroupchange(seletvalue){
    
      var group_type = $id('group_type').value;
      if(group_type=='3'){
        group_type='1';
      }else if(group_type=='4')
        group_type='2'
      SecurityGroupAjax.getSecurityGroupbyCitys(seletvalue,group_type,{callback:function(data){
                    setSelectForBean("social_group_id",data,"id","group_name","");
                    if(<%=!"".equals(social_group_id)%>){
                        document.getElementById("social_group_id").value="<%=social_group_id%>";
                    }
                }
            });
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
                var enCur = $id("datacell1").dataset.get(i);
                $id("datacell1").isModefied = true;
                enCur.status = Entity.STATUS_MODIFIED;
                ids.push(elementCheckbox[i].value);  //加入选中的checkbox
            }
        }
        return ids;
    }
	function findCheckbox_onClick() {  //从多选框到修改页面
	    var group_type= document.getElementById('group_type').value;
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		//form.action="<%=request.getContextPath()%>/SocialaccountpvdAction.do?id=" + ids;
		//form.cmd.value = "find";
		//form.submit();
		var url="<%=request.getContextPath()%>/SocialaccountpvdAction.do?id=" + ids+"&cmd=find&group_type="+group_type;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=300px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=修改帐号');
       // showModalCenter(url, window, callBack, 800, 300, "修改账号"); 
	}  
	function deleteMulti_onClick(){  //从多选框物理删除多条记录
	    var idarray = findSelections("checkbox_template","id");  //取得多选框的选择项
        var ids='';
        if(idarray == null) {  //如果ids为空
            alert('<fmt:message key="select_records"/>');
            return;
        }
        for(var i=0;i<idarray.length;i++){
             ids = ids+','+idarray[i];
        }
        //ajax查询该供应商对应的福利办理方是否已被公积金办理表的员工引用
        //判断订单表中有没有该入离职ID有没有对应的订单
        jQuery.getJSON(vpath+"/SocialaccountpvdAction.do?cmd=checkSocialUnit&date="+new Date()+"",{"ids":ids},  function(json){
             if(json.saia!=null && json.saia.length>0){
                 for(var i = 0; i < json.saia.length; i++){
                    alert("<fmt:message key="account"/>："+json.saia[i].account+"<fmt:message key="notices"/>");
                 }
             }else{
                
                if(confirm('<fmt:message key="sure_to_delete"/>')) {  //如果用户在确认对话框按"确定"
                   $id("datacell1").submitAction="/FAERP/SocialaccountpvdAction.do?cmd=deleteMulti&ids="+idarray; 
                   $id("datacell1").submit();//提交 
               }
                
             }
         });
 		
	}
	function simpleQuery_onClick(){  //简单的模糊查询
	    var social_group_id = document.getElementById('social_group_id').value;
        if(social_group_id==null || social_group_id==''){
           alert('<fmt:message key="please_choose_ss_fund_group"/>');
           return;
        }
    	$id("datacell1").loadData();
        $id("datacell1").refresh();
  	}
	function toAdd_onClick() {  //到增加记录页面
	    var group_type= $id('group_type').value;
		var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/socialaccountpvd/insertOtherSocialaccountpvd.jsp?group_type="+group_type;
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=300px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=新增供应商帐号');
        //showModalCenter(url, window, callBack, 800, 300, "新增客户账号");  
	}
	
	function callBack(reg){
        if(reg!=""&&reg!=null){
            $id("datacell1").loadData();
            $id("datacell1").refresh();
        }
    }
    
	function detail_onClick(){  //实现转到详细页面
	   var group_type= document.getElementById('group_type').value;
		var ids = findSelections("checkbox_template","id");  //取得多选框的选择项
		if(ids == null) {  //如果ids为空
	  		alert('<fmt:message key="select_one_record"/>');
	  		return;
		}
		if(ids.length > 1) {  //如果ids有2条以上的纪录
	  		alert('<fmt:message key="only_can_a_record"/>');
	  		return;
		}
		var url="<%=request.getContextPath()%>/SocialaccountpvdAction.do?id=" + ids+"&group_type="+group_type+"&cmd=detail";
        url=url+'&_ts='+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
        window.open(url,'','height=300px,width=800px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=查看详细信息');
        //showModalCenter(url, window, "", 800, 300, "查看详细信息");  
	}
	
	function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template' value=" + entity.getProperty("id") + ">";
    }
    
    function changeCheck(rowNo,checkB){
        //alert(checkB.value + "" + rowNo);
        //alert(rowNo);
        var enCur = $id("datacell1").dataset.get(rowNo);
        $id("datacell1").isModefied = true;
        enCur.status = Entity.STATUS_MODIFIED;
    }

</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="cmd" value="queryAll">
<input type="hidden" id="isClickQuery" value="false" />
<input type="hidden" name="group_type" id="group_type" value="${param.group_type}">
 
<div id="right">
<!--<script language="javascript">-->
<!--	writeTableTopFesco('<fmt:message key="list_page"/>','<%=request.getContextPath()%>/');  //显示本页的页眉-->
<!--</script>-->
<div class="ringht_s"> 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				    <td align="right"><span class="style_required_red">* </span><fmt:message key="ss_fund_group"/></td>
                    <td align="left">
                        <select id="social_group_id" name="social_group_id" ></select>
                    </td>
			         <td align="right"><fmt:message key="security_unit_id"/></td>
			         <td align="left">
				        <r:comboSelect id="com1"  name="social_unit_id"
                            queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                            textField="hire_unit_short_name" 
                            valueField="id" 
                            xpath="SocialunitVo"
                            messagekey="please_choose"
                            width="185px">
                        </r:comboSelect> 
			         </td>
			         <td>
                        <input name="button_ok" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:$id('isClickQuery').value=true;simpleQuery_onClick()">
                        <input name="button_reset" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset()">
                     </td>
		</tr>
</table>
</div>

<div id="ccParent1" class="button"> 
 <div class="button_right">
				<!--<ul>
					<li class="a">	<a  onClick="javascript:detail_onClick();"><fmt:message key="view"/> </a> </li>
					<li class="c"><a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
					<li class="d"><a  onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
					<li class="b"><a  onClick="javascript:findCheckbox_onClick();"><fmt:message key="modify"/> </a> </li>
				</ul>
		 -->
		 <input type="button" class="a" value="<fmt:message key="view"/>" <au:authorityBtn code="ydsbzh_view1" type="1"/>  onclick="detail_onClick();"/>
		 <input type="button" class="c" value="<fmt:message key="insert"/>" <au:authorityBtn code="ydsbzh_add1" type="1"/>  onclick="toAdd_onClick();"/>
		 <input type="button" class="d" value="<fmt:message key="delete"/>" <au:authorityBtn code="ydsbzh_del" type="1"/>  onclick="deleteMulti_onClick();"/>
		 <input type="button" class="b" value="<fmt:message key="modify"/>" <au:authorityBtn code="ydsbzh_modify1" type="1"/>  onclick="findCheckbox_onClick();"/>
		 </div>
           <div class="clear"></div>			
</div>

<div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/SocialaccountpvdAction.do?cmd=simpleQuery" 
        submitAction="/FAERP/SocialaccountpvdAction.do?cmd=sunbmitID" width="98%"
        xpath="SocialaccountpvdVo"
        submitXpath="SocialaccountpvdVo"
        paramFormId="datacell_formid" height="318px"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info"/>
      <r:field allowModify="false"  fieldName="id_index" sortAt="none" label="<input type='checkbox' name='checkall' value='' onclick='checkAllList_onClick(this);' />" width="30px" onRefreshFunc="setCheckboxStatus">
      </r:field>           
      <r:field fieldName="group_name" messagekey="ss_fund_group" width="150px" allowModify="false">
              
      </r:field>
      
      <r:field fieldName="social_unit_id" messagekey="security_unit_id" width="100px" allowModify="false">
            <r:comboSelect id="com2" 
                queryAction="/FAERP/SocialunitAction.do?cmd=getListSocialunit"
                textField="hire_unit_short_name" 
                valueField="id" 
                xpath="SocialunitVo"
                messagekey="please_choose">
            </r:comboSelect>     
      </r:field>
      
      <r:field fieldName="accounts" messagekey="account" width="250px" allowModify="false">
      </r:field>
      
      <r:field fieldName="open_unit" messagekey="open_unit" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
      
      <r:field fieldName="open_unit_accounts" messagekey="open_unit_account" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
      <c:choose>
        <c:when test="${group_type=='2'}">
            <r:field fieldName="end_date" messagekey="end_date" width="150px" allowModify="false">
            <h:text/> 
      </r:field>
      <r:field fieldName="get_day" messagekey="get_day" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
      <r:field fieldName="seal_party" messagekey="seal_party" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
      <r:field fieldName="remarks" messagekey="remarks" width="150px" allowModify="false">
            <h:text/>      
      </r:field>
        </c:when>
      </c:choose>
      
    </r:datacell>
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
$id("datacell1").headTextAlign="center";
    //解决修改行数据，多选框勾选消失BUG
    $id("datacell1").beforeRefreshCell = function(cell,field){
        //alert(field.fieldId.indexOf("id_index"));
        if(field && field.fieldId && field.fieldId.indexOf("id_index") >= 0){
            return false;
        }
        return true;
    } 
    
    //初次进来页面 datacell不进行查询
    $id("datacell1").beforeLoadData = function(){
        if(!$id('isClickQuery').value || $id('isClickQuery').value.indexOf("false") >= 0){
           //alert("run hear");
           return false;
        }
        return true;
    }
    //后台返回的信息
    $id("datacell1").afterSubmit= function(ajax){
           alert(""+ajax.getProperty("returnValue"));
    }
    //实现beforeEdit接口
    $id("datacell1").beforeEdit=function(cell,colIndex,rowIndex){
        var entity=this.getEntityByCell(cell);
        var security_group_id = entity.getProperty("security_group_id");
        //alert(city_id);
        if (colIndex == 15){
            var combo1 = $id("com1");
            combo1.addParam("security_group_id",security_group_id);
            combo1.loadData();
            combo1.refresh();
        }
        return true;
    }    
   //实现on updateCell
    $id("datacell1").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
        //alert(activeCell.getAttribute("fieldId").indexOf("service_name2"));
        if(activeCell.getAttribute("fieldId") && activeCell.getAttribute("fieldId").indexOf("transact_type_name") >= 0){
            var activeEditor = $id("datacell1").activeEditor;
            activeEntity.setProperty("transact_type_name", activeEditor.getDisplayValue(newValue));
            activeEntity.setProperty("transact_type_id", newValue);
        }
        return true;
    }
//忽略datacell的修改
    $id("datacell1").afterEdit = function( newValue, oldValue , datacell1 ){
        $id("datacell1").isModefied = false;
    }
    
    //初始化社保组
    citySecurityGroupchange("0571','0520");
</script>	
