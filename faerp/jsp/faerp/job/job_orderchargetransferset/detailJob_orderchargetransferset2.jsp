<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%@include file="/jsp/faerp/finance/common.jsp"%>


<%@ page import="rayoo.job.job_chargeetransfertemplate.vo.Job_chargeetransfertemplateVo" %>
<%@ page import="rayoo.job.job_chargeetransfertemplate.util.IJob_chargeetransfertemplateConstants" %>


<%@page import="rayoo.job.job_orderchargetransferset.vo.Job_orderchargetransfersetVo"%>
<%@page import="rayoo.job.job_orderchargetransferset.util.IJob_orderchargetransfersetConstants"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

   

    function allrefresh(){
            $id("datacell_big").loadData();
                            $id("datacell_big").refresh();
                           refresh_onClick();
                            $id("datacell_param").loadData();
                            $id("datacell_param").refresh();
                            }
                            
                                  function cancel_onClick(){  //取消后返回列表页面
        window.close();
         window.opener.simpleQuery_onClick();
    }     
</script>
</head>
<body>
<div id="right">
<script language="javascript">

        writeTableTopFesco('招聘订单费用划转查看页面','<%=request.getContextPath()%>/');
</script>
<div class="ringht">
<div id="ccChild1"     class="box_xinzeng" style="height: 180px">
<div class="xz_title" style="padding-top: 10px">基本信息</div>
<form name="orderchargetransfersetform" method="post" id="orderchargetransfersetform" >
<input type="hidden" name="id" id="charge_id" value="${bean.id }">
    <table  width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
            <td class="td_1" width="23%">招聘订单</td>
            <td class="td_2">
                <input type="text" class="text_field" name="order_code" inputName="order_code" value="${bean.order_code }" maxLength="100" readonly="readonly" />
                <input type="hidden" name="order_id" value="${bean.order_id }" />
                <input type="hidden" name="settype" value="${bean.settype }" />
            </td>
            <td class="td_1" >费用划出部门</td>
            <td class="td_2" >
             <r:comboSelect id="outdept_id" name="outdept_id"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                       readonly="true"
                      property="bean/outdept_id"
                       xpath="DepartmentVo"
                       nullText="请选择"  />
            </td>
        </tr>
         <tr>
          <td class="td_1" >备注</td>  
          <td class="td_2" >
            <textarea rows="5" cols="70" name="description" id="transferset_description" readonly="readonly">${bean.description }</textarea>
            </td>
            <td class="td_2" colspan="2" rowspan="5">
             
              <input type="button" class="foot_icon_2"  value='返回'  onClick="javascript:cancel_onClick()" /></div>
            </td>
        </tr>        
         </table>
         
   </form>
</div>

<!-- 模板大项的列表 -->

<script language="javascript">
//-------------------------------费用大项开始-----------------------------------------------------
     function refresh_onClick(){
                   var Rowtr= $id("datacell_big").getActiveRow();
                        var en= $id("datacell_big").getActiveEntity();
                    var t = Rowtr.getElementsByTagName("input");
                  t[0].setAttribute("checked","true");    
                 $id("orderchargebigitem_id").value=en.getProperty("id");
                 $id("datacell_small").loadData();
                 $id("datacell_small").refresh();
               
     }
  

      
   
      function setCheckboxStatus_big(value,entity,rowNo,cellNo){

         
    return "<input type='radio'  name='radio_big'   onClick=ClickRow_big(\"" + entity.getProperty("id") + "\");>";
    }
        function ClickRow_big(value){
        $id("orderchargebigitem_id").value = value;  
      $id("datacell_small").loadData();
                 $id("datacell_small").refresh();
                 
    }
  
//-------费用大项结束-----------------------------------------------
  </script>

    <!--费用大项-->
  
        <form action="" id="orderchargebigitemform" method="post">
            <input type="hidden" id="orderchargetransferset_id" name="orderchargetransferset_id" value="${bean.id }">
            <input type="hidden" id="orderchargetransferset_deptid" name="orderchargetransferset_deptid" value="${bean.outdept_id }">
         </form>
         <form action="" id="orderchargemiditemform" method="post">
               <input type="hidden" id="orderchargebigitem_id" name="orderchargebigitem_id" value="">
        </form>
        
        <div style="padding: 8 10 8 8;">
            <div class="xz_title" style="padding-top: 10px">招聘订单费用大项</div> 
          
              <r:datacell id="datacell_big" 
                queryAction="/FAERP/Job_orderchargebigitemAction.do?cmd=listBigData" width="90%" height="138px"
               readonly="true"
                xpath="Job_orderchargebigitemVo" paramFormId="orderchargebigitemform"
               pageSize="-1"
                    >
              <r:toolbar location="bottom" tools="nav,pagesize,info"/>
              <r:field fieldName="id" label="操作" width="100px" onRefreshFunc="setCheckboxStatus_big"  align="center" ></r:field>
              <r:field fieldName="itemname" label="名称" width="100px" ></r:field>    
              <r:field fieldName="itemcode" label="代码" width="100px" ></r:field>    
              <r:field fieldName="formula" label="公式" width="300px" ></r:field>
              
               <r:field fieldName="outdept_id" label="划出部门" width="100px" >
                <r:comboSelect id="outdept_ids" name="outdept_ids"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                       xpath="DepartmentVo"
                       nullText="请选择"  />
                       </r:field>  
                        <r:field fieldName="indept_id" label="划入部门" width="100px" >
                <r:comboSelect id="indept_ids" name="indept_ids"
                       queryAction="/FAERP/Job_orderchargetransfersetAction.do?cmd=getListDepartmentData"
                       textField="dept_name"
                       valueField="id"
                       xpath="DepartmentVo"
                       nullText="请选择"  />
                       </r:field> 
                  <r:field fieldName="iscalculation" label="是否计算" width="100px" >
                  <d:select dictTypeId="TrueOrFalse" name="iscalculations" id="iscalculations" value="1" />
                  </r:field>    
                   <r:field fieldName="isshow" label="是否显示" width="100px" >
                   <d:select dictTypeId="TrueOrFalse" name="isshows" id="isshows" value="1" />
                   </r:field>    
                   <r:field fieldName="description" label="备注" width="100px" ></r:field>    
              </r:datacell>
              
        </div>


<!-- 模板大项的列表 -->



<table width="100%" border="0">
  <tr>
     
    <td style="width: 60%">
        <!--    费用小项-->

   <div style="padding: 8 10 8 8;" >
    

        <div class="xz_title" style="padding-top: 10px">招聘订单费用小项</div> 
       
    
        
          <r:datacell id="datacell_small" 
            queryAction="/FAERP/Job_orderchargemiditemAction.do?cmd=listSmallData" width="100%" height="198px"
         
            xpath="Job_orderchargemiditemVo" paramFormId="orderchargemiditemform"
        readonly="true"
                >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="itemname" label="名称" width="100px" ></r:field>    
          <r:field fieldName="itemcode" label="代码" width="100px" ></r:field>    
          <r:field fieldName="formula"  label="公式" width="150px" ></r:field>
          <r:field fieldName="description" label="备注" width="100px" ></r:field>    
          </r:datacell>
        </div>
    </td>
    
    <td>

     <!-- 服务费参数  -->
 <div style="padding: 8 10 8 8" >
        <div class="xz_title" style="padding-top: 10px">招聘订单服务费参数</div> 
      

          <r:datacell id="datacell_param" 
            queryAction="/FAERP/Job_orderchargeparamAction.do?cmd=listParamData" width="90%" height="198px"
        
            xpath="Job_orderchargeparamVo" paramFormId="orderchargebigitemform"
            readonly="true"
            >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="id" label="" width="0px" ></r:field>
          <r:field fieldName="paramname" label="参数名称" width="100px" ></r:field>    
          <r:field fieldName="paramcode" label="参数代码" width="100px" ></r:field>    
          <r:field fieldName="datatype" label="类型" width="100px" >
            <d:select dictTypeId="DATA_TYPE_DB" extAttr="validateAttr='allowNull=false'"/>
          </r:field>
          <r:field fieldName="defaultvalue" label="默认值" width="100px" ></r:field>    
          <r:field fieldName="description" label="备注" width="100px" ></r:field>    
          </r:datacell>
          </div>
            </td>
    
        </tr>
    </table>



</div>
</fmt:bundle>
</body>
</html>

<script language="javascript">


    $id("datacell_big").onClickRow=function(rowTR,rowIndex,entity,datacell){
       var t = rowTR.getElementsByTagName("input");
        t[0].setAttribute("checked","true");
       if($id("orderchargebigitem_id").value ==entity.getProperty("id")){
       }else{
      
         $id("orderchargebigitem_id").value = entity.getProperty("id");
                 $id("datacell_small").loadData();
                 $id("datacell_small").refresh();
                 }
    }


</script>
</script>
