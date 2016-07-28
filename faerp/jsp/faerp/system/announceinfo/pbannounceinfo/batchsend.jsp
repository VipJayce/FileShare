<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js" />
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>codegen</title>
	<script language="javascript">
 function setCheckbox(value,entity,rowNo,cellNo){
        return "<input type='checkbox'  name='temp'  value=" + entity.getProperty("id") + " />";
     }
function checkselectitem()
{
           var aegnt_check = document.getElementsByName("temp");
           
           var ids = null;  //定义id值的数组
           if(ids == null) {
               ids = new Array(0);
           }
           for(var i=0;i<aegnt_check.length;i++){  //循环checkbox组
               if(aegnt_check[i].checked){
                   ids.push(aegnt_check[i].value);  //加入选中的checkbox
               }
           }
           return ids;
}
function checkAllList() {
        var element = document.getElementsByName("temp"); 
        for(var i=0;i<element.length;i++){
           if(element[i].type=="checkbox" && element[i].name=="temp") {
             element[i].checked= !element[i].checked ? true : false;
            }
         } 
      }     
      
function save(){
myTree1.returnValueName();
myTree3.returnValueName();
var deptids=myTree1.codeStrList;
var outpartyids=myTree3.codeStrList;
document.all.form.ids.value=checkselectitem();
var rids= document.getElementById("ids").value;
jQuery.getJSON("<%=request.getContextPath()%>/PbannounceinfoAction.do?cmd=queryEmp&date="+new Date()+"",{"deptids":deptids,"outpartyids":outpartyids,"roleids1":rids},   function(json){
            if(json.saia!=null&&json.saia=="成功")
                {
              window.returnValue=json.ids1;
                window.close();
                 }else{
                 alert("该部门或角色下没有人员");
                 }
                    });
}      

</script>
	</head>
	<body>
	
	<form id="form" name="form" method="post">
	<input type="hidden" id="ids" name="ids"/>
	<div id="right">
	<div class="ringht_s">
		  <table width="100%" height="40" border="0" cellpadding="0"
                cellspacing="1" bgcolor="#c5dbe2">
               <tr><td align="left">
                <span>选择部门或者角色</span>
                <td>
                </tr>
		<tr>
            <td>
            <div >
                    <iframe name="myTree1" width="300" height="200"
                        src="<venus:base/>/jsp/authority/tree/deeptree_iframe.jsp?inputType=checkbox&rootXmlSource=<venus:base/>/jsp/authority/tree/orgTree.jsp?submit_all%3D0%26return_type%3Dparty_id%26tree_level%3D2%26data_limit%3D0"></iframe>
                    </div>
                       </td>
            <td class="clear">
            <r:datacell id="datacell1"
                queryAction="/FAERP/PbannounceinfoAction.do?cmd=queryRole"
                isCount="false" width="300px" xpath="AupartyVo" readonly="true"
                paramFormId="datacell_formid" height="200px" pageSize="-1">
                <r:field allowModify="false" fieldName="id_index" sortAt="none"
                    label="<input type='checkbox' name='checkall' value='' onclick='checkAllList();' />"
                    width="50px" onRefreshFunc="setCheckbox">
                </r:field>
                <r:field fieldName="name" width="100px" label="角色名称">
                </r:field>
            </r:datacell>
            </td>
        </tr>
            </table>
                <div>
		<table width="100%" height="40" border="0" cellpadding="0"
			cellspacing="1" bgcolor="#c5dbe2">
		  <div class="clear"> 
			<tr>
			<td align="left">排除某人</td>
			</tr>
			</div>
			<tr>
				<td><iframe name="myTree3" width="650" height="180"
					src="<venus:base/>/jsp/authority/tree/deeptree_iframe.jsp?inputType=checkbox&rootXmlSource=<venus:base/>/jsp/authority/tree/orgTree.jsp?submit_all%3D0%26return_type%3Dparty_id%26tree_level%3D0%26data_limit%3D0"></iframe>
				</td>
			</tr>
		</table>
		</div>
		<div id="ccChild0" class="box_3">
        <table width="100%" height="40" border="0" cellpadding="0"
            cellspacing="1" bgcolor="#c5dbe2">
            <tr>
                <td align="center"><input type="button" onclick="save()"
                    value="保存" align="center" /></td>
            </tr>
        </table>
        </div>
        </div>
        </div>
	</form>
	<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
	</body>
</fmt:bundle>
</html>
