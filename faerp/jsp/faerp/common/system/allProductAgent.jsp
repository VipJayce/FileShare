<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="rayoo.system.product.vo.ProductVo" %>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<html>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/interface/AjaxControl.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwrsample/util.js'></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">

 function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='checkbox'  name='checkbox_template'  value=" + entity.getProperty("id") + " />";
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
    function select_onClick(){
      var ids = findSelections("checkbox_template","id");
        if(ids.length == 0){
            alert("请至少选择一条记录!");
            return;
        }
        window.returnValue=ids;
        window.close();
}
function simpleQuery_onClick(){
   $id("datacell1").loadData();
   $id("datacell1").refresh();
}
    /**
     * 功能描述：动态生成产品大类下拉菜单的内容
     * 参数：  selectId --下拉框id;
     *              key -- 填充时作为option value的对象属性
     *              value -- 填充时作为option展示的对象属性
     */   
    function getAllBigType(selectObject,key,value,selectvalue){
        if (selectObject == null){
            return;
        }else if(selectObject.length==1) {
            AjaxControl.getBigTypeId("big_type_id",{callback:function(data){
                    if (data != null && typeof data == 'object') 
                    {
                        setSelectForBean(selectObject.id,data,key,value,selectvalue);
                    }
  
                }
            });
        }
    }
    /**
     * 功能描述：动态生成产品小类下拉菜单的内容
     * 参数：selectObject --下拉框对象;
                    targetId         -- 下拉框目标对象;
     *              key -- 填充时作为option value的对象属性
     *              value -- 填充时作为option展示的对象属性
     */    
    function getAllSmallType(selectObject,targetId,key,value,selectvalue){
    
       var big_type_id=document.form.big_type_id.value;

        AjaxControl.getSmallTypeId(selectObject.value,{callback:function(data){
                if (data != null && typeof data == 'object') 
                {
                    DWRUtil.removeAllOptions(targetId); //移除id为company_name的select的内容
                    DWRUtil.addOptions(targetId,{000:'--请选择--'});
                    setSelectForBean(targetId,data,key,value,selectvalue);
                  
                }
                 
            }
        });
    }
</script>
</head>
<body>

<form name="form" method="post"  id="datacell_formid">
<div id="right">
<div class="ringht_s">
 
 
<div id="ccChild0" class="search">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
            <td width="140" rowspan="3" style="padding-top:0;"><div class="search_title">查询条件</div> </td>
        </tr>
                
        <tr>
        
               <td align="right">产品大类&nbsp;</td>
          <td align="left" ><select id="big_type_id" name="big_type_id" style="width:155px" onChange="javascript:getAllSmallType(this,'small_type_id','code','name','resultVo.getSmall_type_id() ')">
          <option value="">--请选择--</option></select></td>  
      
       <td  align="right">产品小类</td>
            <td align="left">
            <select id="small_type_id" name="small_type_id"  >
            <option value="">--请选择--</option>
            </select>        </td>
          
        </tr>
        <tr>
         <td align="right">产品名称&nbsp;</td>
          <td align="left">
            <input type="text" name="productname1"  inputName="产品名称" maxLength="50" width="100px"/>
          </td>
          <td align="left" colspan="2" >
                 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;<input name="button_ok2" class="icon_1"   type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                &nbsp;&nbsp;&nbsp;
                <input name="button_reset2" class="icon_1" type="button" value='<fmt:message key="reset"/>' onClick="javascript:this.form.reset();">
           </td>
        </tr>
</table>
</div>
    <div id="ccParent1" class="button">
    <div class="button_right">
    <ul>
        <li class="g"><a onClick="javascript:select_onClick();"><fmt:message key="confirm" /> </a></li>
    </ul>
    </div>
           <div class="clear"></div>            
</div>
<r:datacell id="datacell1"
            queryAction="/FAERP/ProductAction.do?cmd=simpleQueryProduct" 
            isCount="false"
            width="100%" 
            xpath="ProductVo" 
            readonly="true"
            paramFormId="datacell_formid"
            height="325px"
            >
            <r:toolbar location="bottom" tools="nav,pagesize,info" />
          <r:field fieldName="id" label="操作" width="50px" onRefreshFunc="setCheckboxStatus"  align="center" ></r:field>
             <r:field fieldName="big_type_id" width="130px" label=" 产品大类"  >
            <d:select dictTypeId="big_type_id"></d:select>
           </r:field>
           <r:field fieldName="small_type_id" label="产品小类">
               <d:select dictTypeId="big_type_id"></d:select>
           </r:field>
            <r:field fieldName="product_name" width="260px" label="产品名称" >
            </r:field>
              <r:field fieldName="scheme_type" width="70px" label="方案类型" >       
            </r:field> 
             <r:field fieldName="product_price" width="70px" label=" 标准价格"  >
            </r:field>
            <r:field fieldName="effect_date" label="生效时间"><w:date format="yyyy-MM-dd"></w:date> </r:field>
              <r:field fieldName="lapse_date" label="失效时间"><w:date format="yyyy-MM-dd"></w:date> </r:field>
           

        </r:datacell>

</div>
</div>
</form>
</fmt:bundle>

</body>
</html>
<script language="javascript">

   //页面加载后产品大类下拉框填充
      getAllBigType(document.form.big_type_id,'code','name',' ');

</script>