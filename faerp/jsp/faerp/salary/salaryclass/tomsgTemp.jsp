<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="gap.rm.tools.helper.*" %>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>定义短信模板</title>
<link href="<venus:base/>/css/gap-css.jsp" type="text/css" rel="stylesheet" charset="UTF-8">
<style type="text/css">
tr.odd{background: #fff;}
tr.even{background: #f9fcfd;}
.box tr:hover,tr.hover{background:#c4e7f8;}
.box tr:selected,tr.selected{background-color:#eef8ff; border-bottom-color:#daf1ff;border-right-color:#daf1ff;}
</style>
<script language="javascript">

    var vpath = "<%=request.getContextPath()%>";
    var start=0;
    var end=0;
    jQuery(function(){
        var sa_class_id = jQuery("#sa_class_id").val();
        jQuery.post("<%=request.getContextPath()%>/SalaryclassAction.do?cmd=findMsgTemp&sa_class_id="+sa_class_id,function(data){
            jQuery("#formula").val(data);
         });
         
         
    });
    
    function addText(str){
         var textBox = document.getElementById("formula");
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
             alert('请选择运算符号！')
             return false;
         }
         addText(str);
     }
     
     function saveformual(){
         var textBox = document.getElementById("formula").value;
         var sa_class_id = $id("sa_class_id").value;
         var textBox = encodeURI(textBox);
         jQuery.post("<%=request.getContextPath()%>/SalaryclassAction.do?cmd=insertMsgTemp&sa_class_id="+sa_class_id+"&mt="+textBox,function(data){
            if(data>0){
                alert("保存成功！");
            }
         });
     }
</script>
</head>
<body>
<form id="msgForm" method="post">
<input type="hidden" id="sa_class_id" name="salary_class_id" value="${param.sa_class_id }">
<div>
<div class="zbox" style="float:left; width:48%">
  <div class="xz_title" style="margin-top:10px;">选择薪资项目（双击记录行）</div>
  <div>
         <r:datacell 
              id="datacell1"
              queryAction="/FAERP/SaleryitemAction.do?cmd=seachSalaery"
	          width="98%" xpath="SaleryitemVo" submitXpath="SaleryitemVo"
	          paramFormId="msgForm"
	          pageSize="100"
	          height="500px"
             >
             <r:toolbar location="bottom" tools="nav,pagesize,info" />
             <r:field fieldName="item_serial_new_id" label="编号" width="60px">
             </r:field>  
             <r:field fieldName="sa_item_name" label="名称" width="160px">
             </r:field>         
             <r:field fieldName="data_source" label="数据来源" width="80px" allowModify="false">
	             <h:select property="data_source">
	                      <h:option value="1" label="公式"/>
	                      <h:option value="2" label="固定值"/>
	                      <h:option value="3" label="手输"/>
	                      <h:option value="4" label="上月项目"/>
	                      <h:option value="5" label="合同数据"/>
	               </h:select>
	         </r:field>
        </r:datacell>
  </div>
</div>
</form>
  <div class="zbox" style="float:right; width:48%;">

   <div class="xz_title" style="margin-top:10px;">短信模板：</div>
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
      <input type="button" class="foot_icon_1" value="确定" onClick="saveformual()">
      <input type="button" class="foot_icon_1" value="关闭" onClick="javascript:window.close()">
    </div>
    
  </div>
  
    
</div>
</fmt:bundle>
</body>
</html>

<script language="javascript">

    //双击左侧列表，将薪资项写入右侧公式文本域、
    $id("datacell1").onDblClickRow  = function(rowTR,rowIndex,entity,datacell){
        var item_id=entity.getProperty("id");//取得薪资项ID
        var sa_item_name=entity.getProperty("sa_item_name");//取得薪资项ID
        addText('|'+sa_item_name+'|');
    } 
    
    $id("datacell1").onComplete = function (){
          var newEntity = new Entity(Entity.STATUS_NEW);
          newEntity.setProperty("item_serial_new_id","01");
          newEntity.setProperty("sa_item_name","员工姓名");
          newEntity.setProperty("data_source","2");
          
          var newEntity2 = new Entity(Entity.STATUS_NEW);
          newEntity2.setProperty("item_serial_new_id","02");
          newEntity2.setProperty("sa_item_name","工资年月");
          newEntity2.setProperty("data_source","2");
            
          this.addRow(newEntity);
          this.addRow(newEntity2);
    }
        
    
</script>