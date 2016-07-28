<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var jq = jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<%@page import="java.util.Set"%>
<%@page import="rayoo.job.job_chargeetransfertemplate.util.ExcuteFormulaForJobTransUtils;"%>
<html>
<fmt:bundle basename="rayoo.salse.sal_quotation_tpl.sal_quotation_tpl_resource" prefix="rayoo.salse.sal_quotation_tpl.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>定义公式内容</title>
<link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
</style>
<%
boolean isRich = request.getParameter("isRich") == null ? false : true;
boolean fromTpl = request.getParameter("fromTpl") == null ? false : true;
%>
<script language="javascript">

var vpath = "<%=request.getContextPath()%>";
    var start=0;
    var end=0;
     
    

    
    
    function addText(str){
         var textBox = document.getElementById("formula");
         //textBox.focus();
         var pre = textBox.value.substr(0, start);
         var post = textBox.value.substr(end);
         textBox.value = trim(pre + str + post);
         var prestr = pre + str
         start = prestr.length;
         end = start;
       
     }
     function savePos(textBox){
         //如果是Firefox(1.5)的话，方法很简单
         if(typeof(textBox.selectionStart) == "number"){
             start = textBox.selectionStart;
             end = textBox.selectionEnd;
         }
         //下面是IE(6.0)的方法，麻烦得很，还要计算上'\n'
         else if(document.selection){
             var range = document.selection.createRange();
             if(range.parentElement().id == textBox.id){
                 // create a selection of the whole textarea
                 var range_all = document.body.createTextRange();
                 range_all.moveToElementText(textBox);
                 //两个range，一个是已经选择的text(range)，一个是整个textarea(range_all)
                 //range_all.compareEndPoints()比较两个端点，如果range_all比range更往左(further to the left)，则                 //返回小于0的值，则range_all往右移一点，直到两个range的start相同。
                 // calculate selection start point by moving beginning of range_all to beginning of range
                 for (start=0; range_all.compareEndPoints("StartToStart", range) < 0; start++)
                     range_all.moveStart('character', 1);
                 // get number of line breaks from textarea start to selection start and add them to start
                 // 计算一下\n
                 for (var i = 0; i <= start; i ++){
                     if (textBox.value.charAt(i) == '\n')
                         start++;
                 }
                 // create a selection of the whole textarea
                  var range_all = document.body.createTextRange();
                  range_all.moveToElementText(textBox);
                  // calculate selection end point by moving beginning of range_all to end of range
                  for (end = 0; range_all.compareEndPoints('StartToEnd', range) < 0; end ++)
                      range_all.moveStart('character', 1);
                      // get number of line breaks from textarea start to selection end and add them to end
                      for (var i = 0; i <= end; i ++){
                          if (textBox.value.charAt(i) == '\n')
                              end ++;
                      }
                 }
             }
     }
     
     function trim(value){
       var res = String(value).replace(/^[\s]+|[\s]+$/g,'');
       return res;
     }    
     
     function tosetadd(str){      
         if(str==null || str=='' || str == undefined){
             alert('<fmt:message key="choose_num"/>')
             return false;
         }
         addText(str);
     }
     
     function saveformual(){
         var textBox = document.getElementById("formula");
         //jQuery("#formula", window.opener.document).val(textBox.value);
         window.opener.currentFormulaText.value = textBox.value;
         window.close();
     }
</script>
</head>
<body>
<input type="hidden" id="isR2ich2" name="isRi2ch" value="${param.isR2ich }">
<div>



<table width="100%" border="0">
  <tr>
    <td width="50%">
	
		
		
		<div class="zbox" style="float:left;">
  <div class="xz_title" style="margin-top:10px;"><fmt:message key="choose_project"/></div>
  <div>
         <r:datacell 
              id="datacell1"
              width="98%"
              pageSize="100"
              height="180px"
             >
             <r:field fieldName="id" messagekey="bianhao" width="60px">
             </r:field>  
             <r:field fieldName="showName" messagekey="name" width="160px">
             </r:field>         
        </r:datacell>
  </div>
</div>



	
	</td>
    <td rowspan="3">
		
		
		<!--  右边 部分-->
  <div class="zbox" style="float:right;">
  

 <!--按钮 end-->
  <div class="xz_title" style="margin-top:10px;"><fmt:message key="choose_yunsuanfu"/></div>

  <div style="height:40px;">
  
      
      <table  width="100%" cellspacing="0"  class="datagrid1">
        <tr>
          <th width="10%"><input type="button" name="buttonadd" id="buttonadd" value=" <fmt:message key="add"/>  " onclick="tosetadd('+');"/></th>
          <th width="10%"><input type="button" name="buttonsub" id="buttonsub" value=" <fmt:message key="sub"/>  " onclick="tosetadd('-')"/></th>
          <th width="10%"><input type="button" name="buttonmul" id="buttonmul" value=" <fmt:message key="mul"/>   " onclick="tosetadd('*')"/></th>
          <th width="10%"><input type="button" name="buttondiv" id="buttondiv" value=" <fmt:message key="div"/>  " onclick="tosetadd('/')"/></th>
          <th width="10%"><input type="button" name="buttonleft" id="buttonleft" value="<fmt:message key="left"/>" onclick="tosetadd('(')"/></th>
          <th width="10%"><input type="button" name="buttonright" id="buttonright" value="<fmt:message key="right"/>" onclick="tosetadd(')')"/></th>
          
        </tr>
          
      </table>
  </div>
  
	   <div class="xz_title" style="margin-top:10px;"><fmt:message key="formula_info"/>：</div>
	   <div style="height:200px;">
	 
				<textarea name="formula" style="height:150px;width:400px;" id="formula"
							  onKeydown="savePos(this)" 
							  onKeyup="savePos(this)"
							  onmousedown="savePos(this)" 
							  onmouseup="savePos(this)"
							  onfocus="savePos(this)">
				</textarea>
		 
	   </div>
	 
		<div class="foot_button">
		  <input type="button" class="foot_icon_1" value="<fmt:message key="confirm"/>" onClick="saveformual()">
		  <input type="button" class="foot_icon_1" value="<fmt:message key="close"/>" onClick="javascript:window.close()">
		</div>
		
	  </div>
	
	
	</td>
  </tr>
  <tr>
    <td width="50%">
	
		
		<% if(isRich){ %>
		   
		   <!--    费用小项-->
     <div class="zbox" style="float:left;">
        <div class="xz_title" style="margin-top:10px;"><fmt:message key="small_service"/></div>
        <div>
        <% if(fromTpl){ %>
	        <form action="" id="tpl_sc_item_form" method="post">
	        <input type="hidden" id="orderchargebigitem_id" name="orderchargebigitem_id" value="${param.sc_id }">
	        </form>
	          <r:datacell id="datacell_sc_item" 
	              width="98%"
	            queryAction="/FAERP/Job_orderchargemiditemAction.do?cmd=queryForDatacell" height="160px"
	            submitAction="/FAERP/Job_orderchargemiditemAction.do?cmd=saveList"
	            xpath="Job_orderchargemiditemVo" paramFormId="tpl_sc_item_form"
	            submitXpath="Job_orderchargemiditemVo"
	                >
	          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	          <r:field fieldName="itemname" messagekey="name" width="100px" ></r:field>    
	          <r:field fieldName="itemcode" messagekey="code" width="100px" ></r:field>    
	          <r:field fieldName="formula" messagekey="formula" width="300px" ></r:field>
	          <r:field fieldName="description" label="备注" width="100px" ></r:field>    
	          </r:datacell>
		  <%} else {%>
          
                <form action="" id="sc_item_form" method="post">
	            <input type="hidden" id="orderchargebigitem_id" name="orderchargebigitem_id" value="${param.sc_id }">
	            </form>
	              <r:datacell id="datacell_sc_item" 
		            queryAction="/FAERP/Job_orderchargemiditemAction.do?cmd=queryForDatacell" width="100%" height="160px"
		            submitAction="/FAERP/Job_orderchargemiditemAction.do?cmd=saveList"
		            xpath="Job_orderchargemiditemVo" paramFormId="sc_item_form"
		            submitXpath="Job_orderchargemiditemVo"
		                >
	              <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	              <r:field fieldName="itemname" messagekey="name" width="100px" ></r:field>    
	              <r:field fieldName="itemcode" messagekey="code" width="100px" ></r:field>    
	              <r:field fieldName="formula" messagekey="formula" width="300px" ></r:field>
	              <r:field fieldName="description" label="备注" width="100px" ></r:field>    
	              </r:datacell>
                
                
                
		  <%} %>
          
        </div>
        </div>
          
		  <%} %>
		  
		  
	
	</td>
  </tr>
  <tr>
    <td>
	
	
		<!--  费用参数-->
	     <div class="zbox" style="float:left;">
	  <div class="xz_title" style="margin-top:10px;"><fmt:message key="service_data"/></div>
	  <div>
	  
	 <% if(fromTpl){ %>
	        <form action="" id="tpl_sc_form" method="post">
            <input type="hidden" id="orderchargetransferset_id" name="orderchargetransferset_id" value="${param.tpl_id }">
            
            </form>
	        
	        
	          <r:datacell id="datacell_para" 
            queryAction="/FAERP/Job_orderchargeparamAction.do?cmd=queryForDatacell" width="98%" height="100px"
            submitAction="/FAERP/Job_orderchargeparamAction.do?cmd=saveList"
            xpath="Job_orderchargeparamVo" paramFormId="tpl_sc_form"
            submitXpath="Job_orderchargeparamVo"
            >
          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
          <r:field fieldName="paramname" messagekey="name" width="100px" ></r:field>    
          <r:field fieldName="paramcode" messagekey="code" width="100px" ></r:field>    
          <r:field fieldName="defaultvalue" messagekey="default_value" width="100px" ></r:field>    
          <r:field fieldName="description" label="备注" width="100px" ></r:field>    
          
          </r:datacell>
          
          
          <% } else {%>
	            <form action="" id="sc_form" method="post">
	            <input type="hidden" id="orderchargetransferset_id" name="orderchargetransferset_id" value="${param.tpl_id }">
	            </form>
	            
	            
	              <r:datacell id="datacell_para" 
		            queryAction="/FAERP/Job_orderchargeparamAction.do?cmd=queryForDatacell" width="98%" height="100px"
		            submitAction="/FAERP/Job_orderchargeparamAction.do?cmd=saveList"
		            xpath="Job_orderchargeparamVo" paramFormId="sc_form"
		            submitXpath="Job_orderchargeparamVo"
		            >
	          <r:toolbar location="bottom" tools="nav,pagesize,info"/>
	          <r:field fieldName="paramname" messagekey="name" width="100px" ></r:field>    
	          <r:field fieldName="paramcode" messagekey="code" width="100px" ></r:field>    
	          <r:field fieldName="defaultvalue" messagekey="default_value" width="100px" ></r:field>    
	          <r:field fieldName="description" label="备注" width="100px" ></r:field>    
	          
	          </r:datacell>
	          
	          
          
          <%} %>
          
          
          
	        </div>
	        </div>
	  
	  
	  
	
	
	</td>
  </tr>
</table>





      


    
</div>
</fmt:bundle>
</body>
</html>

<script language="javascript">

    jQuery(function () {
    
        //从母页面带已输入的公式自动加载
        var formulavalue = window.opener.currentFormulaText.value;
        addText(formulavalue);
        
        setTimeout("initUtilsMethodDatacell()",10);

    });
    
    window.onload = function(){
    
        //initUtilsMethodDatacell();
    }

    function initUtilsMethodDatacell(){
    
        var data = [
        <%
        Set<String> methods = ExcuteFormulaForJobTransUtils.EXCUTE_FORMULA_FOR_JOBTRANS_UTILS_MHTHOD.keySet();
        String[] methodsArray = new String[methods.size()];
        methods.toArray(methodsArray);
        for (int i = 0; i < methodsArray.length; i++) {
            String name = methodsArray[i];
            //String methodJava = ExcuteFormulaForSalQuotationUtils.EXCUTE_FORMULA_FOR_SALQUOTATION_UTILS_MHTHOD.get(name);
        %>
            {"showName":"<%=name%>"}
            <%if(methodsArray.length-1 != i){%>,<%}%>
        <%}%>
            ];
        
        for (var i = 0; i < data.length; i++) {
            var datacell = $id("datacell1");
            var newEntity = datacell.styleEntity.clone(true);// 只克隆行样式，不带值
            newEntity.setProperty("id", i+1);
            newEntity.setProperty("showName", data[i].showName);
            datacell.addRow(newEntity);
        }
    }
    //双击左侧列表，将薪资项写入右侧公式文本域、
    $id("datacell1").onDblClickRow  = function(rowTR,rowIndex,entity,datacell){
        var value=entity.getProperty("showName");//取得薪资项ID
        addText(''+value+'');
    } 
    
    $id("datacell_sc_item").onDblClickRow  = function(rowTR,rowIndex,entity,datacell){
        var value=entity.getProperty("itemcode");//取得薪资项ID
        addText(''+value+'');
    } 
    $id("datacell_para").onDblClickRow  = function(rowTR,rowIndex,entity,datacell){
  
        var value=entity.getProperty("paramcode");//取得薪资项ID
        addText(''+value+'');
    } 
    
</script>