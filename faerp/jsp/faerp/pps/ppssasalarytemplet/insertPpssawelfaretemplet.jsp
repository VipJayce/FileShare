<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ include file="/jsp/include/rmGlobal_insert.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>福利模版配置</title>
<script language="javascript">
	function insert_onClick(){  //插入单条数据
		form.action="<%=request.getContextPath()%>/PpssasalarytempletAction.do?cmd=insert"; //保存时需要存
		form.submit();
	}

    function cancel_onClick(){  //取消后返回列表页面
        form_treebasic.action="<%=request.getContextPath()%>/PpssasalarytempletAction.do?cmd=queryAll_toWelfare";
        form_treebasic.submit();
    }
    
        function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox' name='checkbox_template' value='"+value+"' >";
    }
    /*****************************************datacell相关*********************************************************/
      function toAddWelfarePro_onClick(){   
      var templetid=document.getElementById("templet_id").value;   
      var url="<%=request.getContextPath()%>/jsp/faerp/pps/ppssasalarytemplet/listppswelfareSalaryProject.jsp";
      url=url+"?_ts="+(new Date()).getTime()+"&templet_id="+templetid;
       showModalCenter(url,window,callback, 700, 500, "项目明细页面");       
   }
   
    function callback(obj)
    {
       var ids=checkpageproduct(obj);
        if(ids[1]!=null && ids[1]!="")
        {
            alert(ids[1]);
        }
        if(ids!=null&&ids[0]!="")
        {
              jQuery.getJSON("<venus:base/>/PpssasalarytempletAction.do?cmd=getSalaryProByIds&datatype=welfaresalary&date="+new Date()+"",{"ids":ids[0]},   function(json){
                   dc1=$id("datacell1");
              if(json.beans!=null&&json.beans!="")
              {
            
                for(var i = 0 ;i<json.beans.length;i++)
                {
                       var newEntity =  $id("datacell1").styleEntity.clone(true);//只克隆行样式，不带值
                       newEntity.setProperty("id", json.beans[i].id);
                       newEntity.setProperty("sa_item_name", json.beans[i].sa_item_name);
                       //newEntity.setProperty("property", json.beans[i].property);
                       newEntity.setProperty("ishide", json.beans[i].ishide);
                       newEntity.setProperty("is_personal", json.beans[i].is_personal);
                       newEntity.setProperty("welfare_display_order", i);     
                        dc1.insertRow(newEntity);
                        dc1.activeField.editor.hideEditor();   
            }   
                }
              });
              }
           }
              
 function checkpageproduct(obj)
    {
        var addids="";
        var chid1 = document.getElementsByName("checkbox_template");
        var ids = obj;
        var err_info=""; 
       for(var i = 0;i<ids.length;i++)
        { 
            var istrue='false';
            //datacell1循环判断
            for(var j=0;j<chid1.length;j++){
                var entity1=$id("datacell1").dataset.get(j);
                if(entity1!=null && entity1!="undefined"){
                    if(entity1.getProperty("id")==(ids+",").split(",")[i]){
                        istrue="true";
                        err_info+=entity1.getProperty("sa_item_name")+" 已经在福利列表中，不能重复添加！\n ";
                        break;
                    }
                }else{
                    istrue="false";
                }
                  }
               if(istrue=='false')
               {
                    addids+=(ids+",").split(",")[i]+",";
               }
        }
        
        var returnAry = new Array();
        returnAry[0]=addids;
        returnAry[1]=err_info;
        return returnAry;
    }
  
  function deleteMultiProduct_onClick(){
             var ids = findSelections("checkbox_template");  //取得多选框的选择项      
                  if(ids == null) {  //如果ids为空
           alert('请至少选择一个产品！');
           return;
       }
       if(confirm('确定要删除所选的产品吗？')) {  //如果用户在确认对话框按"确定"
            var datacell = $id("datacell1");
        var elementCheckbox = document.getElementsByName("checkbox_template");
                       for (var i = elementCheckbox.length - 1; i >= 0; i--) {          
                if (elementCheckbox[i].checked) { // 如果被选中   
            var row = datacell.getRow(i);
            var datasettr = datacell.getEntity(row);
           datasettr.setProperty("welfare_display_order","");//清除排序
           datasettr.setProperty("is_personal","");//清除福利个人或公司
           datacell.deleteRow(i);    
            }
            }
       }
    }  
    
    
    //保存
      function to_saveData(){
         var action="<%=request.getContextPath()%>/PpssasalarytempletAction.do?cmd=updateppswelfaretempletitem";
        var myAjax = new Ajax(action);
        var data1=$id("datacell1");
        var xmlSubmit=null;
        if(data1!=null ){
        xmlSubmit=data1.dataset.toString();
        }else{
        alert("请选择配置项目，如果没有点击返回按钮!");
        return;
        }
       myAjax.submitXML(xmlSubmit);
       var returnNode = myAjax.getResponseXMLDom();
        if( returnNode ) {
                      alert(""+myAjax.getProperty("returnValue"));
                      window['returnValue'] = ""+myAjax.getProperty("returnValue");
                      var oid = myAjax.getProperty("returnMessage");
                      cancel_onClick();
                 }
    }
    
    
    /*******上移和下移*********/
     function upIt(){
        var dc1 = $id("datacell1");
        var curRow = dc1.getRowByCell(dc1.activeCell);
        if(curRow == null){
            alert("请选择一条数据!");
            return false ;
        }
        var curRowIndex =  curRow.getAttribute('__entity_rowno');
        if (curRowIndex <= 0) {
            alert("只能选择一条数据!");
            return;
        }
        var curEntity = dc1.activeEntity.clone();
        //alert(curRowIndex - 1);
        var upEntity = dc1.getEntity(curRowIndex-1).clone();
        //设置
        var curData = dc1.dataset;
        
        curData.values[curRowIndex] = upEntity;
        curData.values[curRowIndex-1] = curEntity; 
        dc1.refresh();
        dc1.setActiveCell(dc1.getCell(curRowIndex-1, 0));

    }
    
    
    function downIt(){
        var dc1 = $id("datacell1");
        var curRow = dc1.getRowByCell(dc1.activeCell);
        if(curRow == null){
            alert("请选择一条数据!");
            return false ;
        }
        var curRowIndex =  curRow.getAttribute('__entity_rowno');
        var totalCount = dc1.dataset.getLength();
        //alert((curRowIndex-0) + 1);
        var curRowIndex_1 = (curRowIndex-0) + 1
        if (curRowIndex_1 >= totalCount) {
            alert("只能选择一条数据!");
            return;
        }
        var curEntity = dc1.activeEntity.clone();
        //alert(curRowIndex - 1);
        var downEntity = dc1.getEntity(curRowIndex_1).clone();
        //设置
        var curData = dc1.dataset;
        
        curData.values[curRowIndex] = downEntity; 
        curData.values[curRowIndex_1] = curEntity;
        dc1.refresh();
        dc1.setActiveCell(dc1.getCell(curRowIndex_1, 0));
    }
    
   
   /***********************************************************************************************************/
   
    
</script>
</head>
<body >
<div id="right">
<form name="form_treebasic" id="form_treebasic" method="post"  >
<input type="hidden" id="templet_id" name="templet_id" value="${bean.id }">
<script type="text/javascript">
writeTableTopFesco('福利模版配置','<%=request.getContextPath()%>/');
</script>
 <div class="ringht_x" style="height: 40px;">
<div id="ccChild1"     class="box_xinzeng" style="height: 40px;"> 
<table  width="100%" height="30" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" ></span>客户名称</td>
            <td class="td_2"  >
                <input type="text" class="text_field"  id="customer_name"  name="customer_name" inputName="客户名称" value="${bean.customer_name}" maxLength="30" readonly="readonly""/> 
            </td>
            <td class="td_1" > </span>薪资模版代码</td>
            <td class="td_2 " >
            <input type="text" class="text_field"  id="salary_templet_code"  name="salary_templet_code" inputName="薪资模版代码" value="${bean.salary_templet_code}" maxLength="30" readonly="readonly""/>  
            </td>
             <td class="td_1" ></span>薪资模版名称</td>
            <td class="td_2" >
             <input type="text" class="text_field"  id="salary_templet_name"  name="salary_templet_name" inputName="薪资模版名称" value="${bean.salary_templet_name }" maxLength="30"  readonly="readonly""/>
             </td>
        </tr>
    </table>
  </div>
 </div>
    <!-- 收入、支出部分  begin-->
    <div id="ccParent1" class="button" >
    <div class="xz_title" style="padding-top: 10px">福利项目</div>
    <div class="button_right" style="padding-left: 10px">
        <input class="c" type="button"   value="<fmt:message key="insert"/>"    onClick="toAddWelfarePro_onClick();">
        <input class="d" type="button"   value="<fmt:message key="delete"/>"    onClick="deleteMultiProduct_onClick();">
         <input class="q" type="button"   value="上移"    onClick="upIt();">
          <input class="q" type="button"   value="下移"    onClick="downIt();">
</div>    
   <div class="clear"></div>
    </div> 
    <r:datacell  id="datacell1"
        queryAction="/FAERP/PpssasalarytempletAction.do?cmd=getSalaryitemData_2&itemtype=welfare&templetid=${bean.id }"
        width="98%" height="198px" xpath="PpssasalarytempletitemVo" submitXpath="PpssasalarytempletitemVo" 
         paramFormId="datacell_formid" readonly="false" pageSize="-1">
        <r:toolbar location="bottom" tools="nav,pagesize,info" />
      <r:field fieldName="id" label="操作" width="35px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
           <r:field fieldName="sa_item_name" label="薪资项目名称" width="186px" allowModify="false"  sortAt="none">
        </r:field>
          <r:field fieldName="sa_item_ename" label="薪资项目英文名称" width="186px" allowModify="true" >
            <h:text/>
        </r:field>
            <r:field fieldName="payroll_name" label="工资单名称" width="245px" allowModify="true" sortAt="none">
            <h:text/>
        </r:field>
        <!-- 
        <r:field fieldName="property" label="增减属性" width="210px" allowModify="true" sortAt="none">
        <d:select dictTypeId="PROPERTY"  />
        </r:field>
        -->
         <r:field fieldName="is_personal" label="是否个人福利" width="245"  sortAt="none" >
           <d:select dictTypeId="PersonalORCompany" />
        </r:field>
           <r:field fieldName="ishide" label="零值是否显示" width="245"  sortAt="none">
           <d:select dictTypeId="TrueOrFalse"  />
        </r:field>
        <r:field fieldName="welfare_display_order" label="排序" width="0"  >
        </r:field>
    </r:datacell>
     
     <table class="table_noFrame"  align="center">
    <tr>
         <td >
        <!-- <input name="button_back" class="icon_2" type="button" value="检验历史"  onclick="javascript:backTask_onClick();" > -->
        <input name="button_app" class="icon_2" type="button" value="保存"  onclick="javascript:to_saveData();" >
        <input name="button_back" class="icon_2" type="button" value="返回"  onclick="javascript:cancel_onClick();" >
        </td>
    </tr>
</table>
     
</form>

<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</div>
</div>
</body>

</fmt:bundle>
</html>
<script language="javascript">

</script>
