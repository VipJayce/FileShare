<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>

<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
     function setCheckboxStatus(value,entity,rowNo,cellNo){
         return "<input type='checkbox'  name='temp' value=" + entity.getProperty("id") + ">";
    }

    function showListData(){
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function toAdd_onClick() { 
        $id("datacell1").addRow();
    }
    
    function deleteMulti_onClick(){ 
             $id("datacell1").deleteRow();
    }
    
    function toSave_onClick() {

            var datacell = $id("datacell1");
            var dataset = datacell.dataset;
            var startdate = jQuery("#start_date").val();
            for(var i=0; i<dataset.getLength(); i++){
                var datasettr = dataset.get(i);
                if(datasettr.getProperty("end_date")==null || datasettr.getProperty("end_date")==''){
                    alert('请输入服务产品的结束日期！');
                    return ;
                }
                //if(datasettr.getProperty("end_date")<startdate){
                //    alert('服务产品结束日期不能早于开始日期！');
                //    return;
                //}
            }
            
            var action = "<%=request.getContextPath()%>/EmppostAction.do?cmd=insertServiceTemp";
            var xmlSubmit = datacell.dataset.toString();
            var myAjax = new Ajax(action);
            var form = $id("datacell_formid");
            if (form) {
                for (var i = 0; i < form.elements.length; i++) {
                    var elem = form.elements[i];
                    if (elem.name) {
                        myAjax.addParam(elem.name, getElementValue(elem));
                    }
                }
            }           
             myAjax.submitXML(xmlSubmit, 'UTF-8');
             var returnNode = myAjax.getResponseXMLDom();
             if( returnNode ) {
                 if( myAjax.getValue("root/data/returnValue") == 1 ) {
                      alert( '设定成功！' );
                      window.close();
                  } else {
                      alert( '未设定任何产品！' ); 
                  }
             }
        
        
    }
    
    function toReload_onClick() {
         $id("datacell1").reload();
    }
    


</script>
</head>
<body>
<% 
String  end_date=(String)request.getAttribute("end_date");

String  emp_postID=(String)request.getAttribute("emp_postID");
String start_date=(String)request.getAttribute("start_date");

System.out.println("_____________________"+emp_postID);;
System.out.println("_____________________"+end_date);;
System.out.println("_____________________"+start_date);;


%>
<form name="form" method="post" id="empqeclarqepart_formid">
<input  type="hidden"  id="end_date"   name ="end_date"   value="<%=end_date %>">
<input  type="hidden" id= "emp_postID" name="emp_postID"   value="<%=emp_postID %>">
<input  type="hidden" id= "start_date" name="start_date"   value="<%=start_date %>">
 
<div id="right">
<script language="javascript">
</script>
<div class="ringht_s">
 


<input type="hidden" name="empid" id="empid" value="">                  
<div id="ccParent1" class="button"> 
     <div class="button_right">
        <ul>
                     <li class="bc">      <a  onClick="javascript:toSave_onClick();">保存</a> </li>
        </ul>
    </div>
    <div class="clear"></div>           
</div>
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/EmppostAction.do?cmd=queryListService"
        submitAction="/FAERP/EmppostAction.do?cmd=insertServiceTemp"
        width="99%"
        xpath="ServiceTemp"
        submitXpath="ServiceTemp"
        paramFormId="empqeclarqepart_formid"
        pageSize="-1"
        >

      <r:field fieldName="product_name" label="服务产品">
      </r:field>
      <r:field fieldName="group_name" label="社保组">
       </r:field>    
      <r:field fieldName="end_date" label="结束日期">
            <w:date format="yyyy-MM-dd" name=""/>  
       </r:field>
      

      
    </r:datacell>
    </div>

</div>
</div>
</form>
</fmt:bundle>
</body>
</html>
<script type="text/javascript">

    //初次进来页面 datacell不进行查询
    //$id("datacell1").afterLoadData = function(){
    //    var product_name = document.getElementsByName("temp");
    //    return true;
    //}


    //初次进来页面 datacell不进行查询
    $id("datacell1").afterSubmit = function(){
    
         alert("操作成功！");
          window.close();
        return true;
    }
    
    $id("datacell1").afterEdit = function(cell,colIndex,rowIndex){
        var datacell = $id("datacell1");
        var activeRow = datacell.activeRow;
        var datasettr = datacell.getEntity(activeRow);//得到当前操作的行dataset
        var dataset = datacell.dataset;

        var group_id = datasettr.getProperty("group_id");
        var end_date = datasettr.getProperty("end_date");
        //add by sjx for bug 739 start
        //设定的服务结束时间不得早于最晚服务年月
        var service_year_month = datasettr.getProperty("last_service_year_month");
        if(end_date.substr(0,7).replace("-","") < service_year_month){
            alert("该服务在" + service_year_month + "月已有支付记录，结束时间不能早于此月!");
            //结束时间设为初始值
        	end_date=$id("end_date").value;
        	datasettr.setProperty("end_date",end_date);
        }
        //取当月的最后一天
        var date= new Date(Date.parse(end_date.replace(/-/g,   "/")));
        date.setMonth(date.getMonth()+1);
        date.setDate(0);
        var lastDayInMonth = end_date.substr(0,7) + "-" + date.getDate();
        //社保公积金服务的结束时间只能等于该月的最后一天
        if(group_id!=null && end_date < lastDayInMonth){
            alert("该服务是按月收费，所以结束时间只能设定为每个月的最后一天！");
            //结束时间设为初始值
        	end_date=$id("end_date").value;
        	datasettr.setProperty("end_date",end_date);
        }
        //add by sjx for bug 739 end
        //上海社保统一设置结束日期 add by yiwenbin
        var group_name = datasettr.getProperty("group_name");        
        //取得同一组的所有行
        for(var i=0; i<dataset.getLength(); i++){
        	//update by sjx for byg 739 start
        	//if(group_name==null||group_name.indexOf('上海')>-1){//上海社保结束日期设为一致
        		//if(group_id==null||(dataset.get(i).getProperty("group_id")!=null &&　dataset.get(i).getProperty("group_id")==group_id)){
        	if(group_name!=null&&group_name.indexOf('上海')>-1){//上海社保结束日期设为一致
        		if(dataset.get(i).getProperty("group_id")!=null &&　dataset.get(i).getProperty("group_id")==group_id){
                //统一设置为一致
                dataset.get(i).setProperty("end_date",end_date);
                datacell.refreshRow(datacell.getRow(i));
            	}
        	}
        	//补充福利结束时间设为一致
        	if(group_id==null&&dataset.get(i).getProperty("group_id")==null){
        		 //统一设置为一致
                dataset.get(i).setProperty("end_date",end_date);
                datacell.refreshRow(datacell.getRow(i));
        	}
        	//update by sjx for byg 739 end
       }
       return false;
    }

</script>