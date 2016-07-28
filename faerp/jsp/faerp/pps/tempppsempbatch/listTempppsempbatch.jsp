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
       return "<input type='radio'  name='temp'   );>";
    }
    
     function setCheckboxStatus1(value,entity,rowNo,cellNo){
          var file_name = entity.getProperty("file_name");
          var offID= entity.getProperty("offID");
        if(offID!=null&&offID!=""){
       var url="/FAERP/TempppsempbatchAction.do?cmd=down1&id="+offID;
            return "<a href="+url+">"+file_name+"</a>";
        }
        
        
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
    function save_onClick() {  //从多选框到修改页面
          var product_name = document.getElementsByName("temp");
          var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
          var offID="";
          var imp_remarks="";
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i); 
                      offID += enCurEntity.getProperty("offID"); 
                      imp_remarks+=enCurEntity.getProperty("imp_remarks"); 
              }
           }
        if(offID==null||offID==""){
            alert('请选择一条记录！');
            return;
        }else{
                    var flags=true;
                            jQuery.ajax({
                                url: '<%=request.getContextPath()%>/TempppsempbatchAction.do?cmd=updateRemark&id='+offID+"&date="+new Date()+"&imp_remarks="+encodeURIComponent(imp_remarks),
                                type: 'GET',
                                dataType: 'html',
                                timeout: 10000,
                                error: function(){
                                    alert('Error loading XML document');
                                    return  null;
                                },
                                success: function(text){
                                    if(text!=null){       
                                       if(text=="1"){
                                         alert("操作成功！");
                                        simpleQuery_onClick();
                                       }else if(text=="2"){
                                          alert("操作失败！"); 
                                       }
                                    }
                                    
                                }
                            });return flags;     
        
        }
        
        
        
        
    }  

    function simpleQuery_onClick(){  //简单的模糊查询
        form.cmd.value = "downLoad";
        form.submit();
    }

    function toAdd_onClick() {  //到增加记录页面
        form.action="<%=request.getContextPath()%>/jsp/faerp/pps/tempppsempbatch/insertTempppsempbatch.jsp";
        form.submit();
    }
    
    function imp_onClick(){  //实现转到详细页面

              var product_name = document.getElementsByName("temp");
              var number = 0;  //定义游标
             var ids = null;  //定义id值的数组
              var offID="";
              var imp_remarks="";
             for(var i=0;i<product_name.length;i++){  //循环checkbox组
              if(product_name[i].checked) {  //如果被选中
                         var enCurEntity = $id("datacell1").dataset.get(i); 
                          offID += enCurEntity.getProperty("offID"); 
                          
                  }
               }
            if(offID==null||offID==""){
                alert("请选择一个批次！");
                return;
            }else{
        
                  jQuery("input[name='button_reset1']").attr('disabled','disabled');
                  var flags=true;
                  jQuery.ajax({
                      url: '<%=request.getContextPath()%>/TempppsempbatchAction.do?cmd=imp&id='+offID+"&date="+new Date(),
                      type: 'GET',
                      dataType: 'html',
                      //async: false,
                      error: function(){
                          alert('Error loading XML document');
                          return  null;
                      },
                      success: function(text){
                          if(text!=null){       
                             if(text=="1"){
                               alert("文件不存在！");
                          //    simpleQuery_onClick();
                             }else if(text=="2"){
                                alert("操作成功！"); 
                             }else if(text=="3"){
                                alert("部分数据导入出错，请查看导入结果中的失败原因!"); 
                             }
                          }
                          jQuery("input[name='button_reset1']").removeAttr("disabled");
                      }
                  });
                  return flags;     
        
             }
        
    }
    
       function view_onClick(){  //实现转到详细页面
    
         var product_name = document.getElementsByName("temp");
          var number = 0;  //定义游标
         var ids = null;  //定义id值的数组
          var offID="";
          var imp_remarks="";
         for(var i=0;i<product_name.length;i++){  //循环checkbox组
          if(product_name[i].checked) {  //如果被选中
                     var enCurEntity = $id("datacell1").dataset.get(i); 
                      offID += enCurEntity.getProperty("offID"); 
              }
           }
        if(offID==null||offID==""){
            alert("请选择一条记录！");
            return;
        }else{
               form.action="<%=request.getContextPath()%>/TempppsempdetailAction.do?batch_id=" + offID;
                form.cmd.value = "queryAll1";
                form.submit();
         }
   } 
    
</script>
</head>
<body>

<form name="form"   id="datacell_formid"  method="post" action="<%=request.getContextPath()%>/TempppsempbatchAction.do" >
<input type="hidden" name="cmd" value="simpleQuery">
 <input type="hidden" id="result" name="result" value="0">
 
<div id="right">
<script language="javascript">
    writeTableTopFesco("批量导入ERP员工",'<%=request.getContextPath()%>/');  //显示本页的页眉
</script>
<div class="ringht_s">
 
 
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    




        
        <tr>
            <td/>
          
            <td/>
            <td/>
              <td>
                
                <input name="button_ok" class="icon_4"   type="button" value="下载模板" onClick="javascript:simpleQuery_onClick()">
                <input name="button_reset" class="icon_4" type="button" value="第一步：上传文件" onClick="javascript:toAdd_onClick();">
                <input name="button_reset1" class="icon_4" type="button" value="第二步：导入数据" onClick="javascript:imp_onClick()">
               
            </td>
                <td/>
        </tr>
</table>
</div>


 

                    
<div id="ccParent1" class="button"> 
 <div class="button_right">
                <ul>
                    <li class="a_4">    <a  onClick="javascript:view_onClick();">查看导入结果列表</a> </li>
                    <li class="b">      <a  onClick="javascript:save_onClick();">保存备注</a> </li>
                </ul>
                
         </div>
           <div class="clear"></div>            
</div>
 
 
 
 <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell1"
        queryAction="/FAERP/TempppsempbatchAction.do?cmd=simpleQuery"
        width="99%"
        height="320px"
        xpath="TempppsempbatchVo"
        submitXpath="TempppsempbatchVo"
        paramFormId="datacell_formid"
        >

       <r:toolbar location="bottom" tools="nav,pagesize,info"/>
                
        <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
       </r:field>  
       <r:field width="200" fieldName="file_name" onRefreshFunc="setCheckboxStatus1"   label="原始文件名">
      </r:field>
      
        <r:field fieldName="imp_remarks" label="备注" width="200px">
        <h:text/>
      </r:field>
      <r:field width="150" fieldName="upload_date"  label="文件上传日期" allowModify="false">
       <w:date format="yyyy-MM-dd hh:mm:ss" />
      </r:field>
       <r:field fieldName="name" label="导入人">
      </r:field>
      <r:field width="150" fieldName="execute_date" label="导入日期" allowModify="false">
       <w:date format="yyyy-MM-dd hh:mm:ss" />
      </r:field>
    </r:datacell>
    </div>
 
 

</div>
</div>
</form>

</body>
</html>

