<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();

function fmoney(s, n)  {   
   n = n > 0 && n <= 20 ? n : 2;   
   s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";   
   var l = s.split(".")[0].split("").reverse(),   
   r = s.split(".")[1];   
   t = "";   
   for(i = 0; i < l.length; i ++ ) {   
      t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");   
   }   
   return t.split("").reverse().join("") + "." + r;   
} 
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
<META HTTP-EQUIV="Expires" CONTENT="0"> 
<title>服务办理</title>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax/gap-ajaxList.js"></script>
<script language="javascript">
    //添加格式化日期函数
    Date.prototype.format = function(format){
         var o = {
	         "M+" : this.getMonth()+1, //month
	         "d+" : this.getDate(),    //day
	         "h+" : this.getHours(),   //hour
	         "m+" : this.getMinutes(), //minute
	         "s+" : this.getSeconds(), //second
	         "q+" : Math.floor((this.getMonth()+3)/3),  //quarter
	         "S" : this.getMilliseconds() //millisecond
         }
         if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
         (this.getFullYear()+"").substr(4 - RegExp.$1.length));
         for(var k in o)if(new RegExp("("+ k +")").test(format))
         format = format.replace(RegExp.$1,
         RegExp.$1.length==1 ? o[k] :
         ("00"+ o[k]).substr((""+ o[k]).length));
         return format;
     }
        
        function setBiaoshi(){
            var datacell = $id("datacell1");
            var dataset = datacell.dataset;//取得页面的datacell
            var fields = datacell.fields;//获得页面所有的列
             var sendpost_id = jQuery("#edit_id").val();
            //后台查询该员工的原订单中对应各社保产品的基数金额等
            jQuery.getJSON(vpath+"/AgentEmpSendPostAction.do?cmd=searchItemChange&date="+new Date()+"",{"id":sendpost_id,"async":false},  function(json){
               for(var j = 0; j < json.saia.length; j++){
                   if(json.saia[j].new_item_id!=null){
                        var type = json.saia[j].change_type;
                        //行循环
                        for(var i=0; i<dataset.getLength(); i++){
                            var datasettr = dataset.get(i);
                            var item_id = datasettr.getProperty("id");
                            if(item_id==json.saia[j].new_item_id){
                                 if(type==1){//基数有变化
                                     var cell = datacell.getCell(i,2);
                                     cell.style.backgroundColor = "yellow";
                                 }
                                 if(type==2){//金额有变化
                                     var cell = datacell.getCell(i,3);
                                     cell.style.backgroundColor = "yellow";
                                 }
                                 if(type==3){//比例有变化
                                     var cell = datacell.getCell(i,6);
                                     cell.style.backgroundColor = "yellow";
                                     var cell1 = datacell.getCell(i,7);
                                     cell1.style.backgroundColor = "yellow";
                                 }
                                 if(type==4){//组有变化
                                     var cell = datacell.getCell(i,1);
                                     cell.style.backgroundColor = "yellow";
                                 }
                                 if(type==5){//新增的产品
                                     var cell = datacell.getCell(i,0);
                                     cell.style.backgroundColor = "yellow";
                                 }
                            }
                        }
                   }
                  
               }
                          
          });
        
        }
        

    function vailform(){
        return true;
    }

    function save_onClick(){  //保存
        var dataset=$id("datacell2").dataset;
        var len=dataset.getLength();

             for(var i=0;i<len;i++){
             if(dataset.get(i).getProperty("status_bd")==2){
              if(""==dataset.get(i).getProperty("remark")||null==dataset.get(i).getProperty("remark")||"null"==dataset.get(i).getProperty("remark")){
                alert("办理受阻时，备注不能为空");
                return;
              }
             } 
     }
  
    if ($id("datacell2").isModefied == true){
      $id("datacell2").submit();   
 }
       returnValue = ["0"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
    
    function cancel_onClick(){  //取消后返回列表页面
        returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
    }
    
    function trunBack_onClick(){
            if(confirm('你确定要退回该委派单？')) {  //如果用户在确认对话框按"确定"
    
        var code = jQuery("#edit_id").val();
       var url="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=trunBackSendPost&id="+code;
      //  form.submit();
          jQuery.post(url,function(data){
                         if(data){
                                if(data==0){
                                    alert("退回失败");
                                }else{
                                  alert("退回成功");
                                }
                          returnValue = ["-1"];
        window.close();
        window.opener.insertcallBack(returnValue);
                         }else{
                            alert("程序出错");
                            return;
                         }
          });
          }
      
    }
    
    //员工订单
    function orderInfo_onClick(belongStatus){ 
        var code = jQuery("#edit_id").val();
        var url="<%=request.getContextPath()%>/AgentEmpSendPostAction.do?cmd=detailPerOrder&id=" + code + "&belongStatus=" + belongStatus;
        window.open(url,'','height=700px,width=1000px,top =100,left=200,help=no,resizable=yes,scrollbars=yes,location=no,status=not,title=员工订单');
    }
    
    function toAdd_onClick() { 
        $id("datacell2").addRow(); 
    }
    
    //自动添加日期
    function setServiceDate(target){
        if (target.value == 1){
	       // var datacell = $id("datacell2");
	        //var rowIndex = datacell.activeRow.rowIndex;
	         var entity1=$id("datacell2").getActiveEntity();
	         entity1.setProperty("service_date",new Date().format('yyyy-MM-dd'));
	      //  var cell = datacell.getCell(rowIndex,5);
            //datacell.setCellValue(cell,new Date().format('yyyy-MM-dd'));
        }
    }
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
    <input type="hidden" name="sendpost_id" id="edit_id" value="${bean.id}">
    <input type="hidden" name="id" id="edit_id" value="${bean.id}">
    <input type="hidden" name="projectbook_id" id="projectbook_id" value="${bean.projectbook_id}">
    <div id="right">
        <script language="javascript">
            writeTableTopFesco('任务单办理','<%=request.getContextPath()%>/');  //显示本页的页眉
        </script>
        <div class="ringht_x">
            <div id="ccChild1" class="box_xinzeng" style="height: 160px;"> 
                <div class="xz_title">基本信息</div>
                <table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
                    <tr>
                        <td  class="td_1" width="23%">客户</td>
                        <td  class="td_2" width="28%">${bean.cust_name}</td>
                        <td  class="td_1" width="23%">唯一号</td>
                        <td  class="td_2" width="28%">${bean.cust_code}</td>
                    </tr>
                    <tr>
                        <td  class="td_1" width="23%">姓名</td>
                        <td  class="td_2" width="28%">${bean.emp_name}</td>
                        <td  class="td_1" width="23%">身份证号</td>
                        <td  class="td_2" width="28%">${bean.emp_idCard}</td>
                    </tr>
                    <tr>
                        <td  class="td_1" width="23%">派工单</td>
                        <td  class="td_2" width="28%">${bean.id}</td>
                        <td  class="td_1" width="23%">电话号码</td>
                        <td  class="td_2" width="28%">${bean.emp_mobile}</td>
                    </tr>
                    <tr>
                        <td  class="td_1" width="23%">派工单备注</td>
                        <td  class="td_2" colspan="3">${bean.remark}</td>
                    </tr>
                </table>
            </div>
            <div id="ccParent1" class="button"> 
                <div class="button_right">
                    <ul>
                        <li class="h_2"><a  onClick="javascript:orderInfo_onClick(${belongStatus});">员工订单</a> </li>
                        <li class="d"><a onClick="javascript:trunBack_onClick();">退回</a></li>
                    </ul>
                </div>
                <div class="clear"></div>           
            </div> 
            
            <!-- 将员工信息中的社保信息移到办理页面中 -->
            <div class="xz_title"> 社保信息</div>
            <div>
                <span style="padding-left: 10px;">金额合计：
                </span>
                <span id="sum_money">
                </span>
            </div>
            <div style="padding: 8 10 8 8;">
                <r:datacell 
                    id="datacell1"
                    queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=querySocialSecurityService&sendpost_id=${bean.id}"
                    width="97%"
                    height="240px"
                    xpath="EpemporderitemVo"
                    submitXpath="EpemporderitemVo"
                    paramFormId="datacell_formid"
                    pageSize="-1"
                    readonly="true"
                    showIndex="false"
                    >
                      <r:field fieldName="product_name" label="产品名称" allowModify="false">
                           <h:text/>   
                       </r:field>    
                      <r:field fieldName="group_name" label="社保组" allowModify="false">
                           <h:text/>   
                       </r:field>    
                      <r:field fieldName="base" label="基数" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="money" label="总金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="e_money" label="企业金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="p_money" label="个人金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="e_ratio" label="企业比例" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'###.###');})">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="p_ratio" label="个人比例" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'###.###');})">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="e_add_money" label="企业附加金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="p_add_money" label="个人附加金额" allowModify="false" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
                        <h:text/>
                      </r:field>
                      <r:field fieldName="frequency_bd" label="收费频率" >
                        <d:select dictTypeId="FREQUENCY_BD" />
                      </r:field>
                      <r:field fieldName="start_date" label="收费开始">
                        <w:date format="yyyy-MM-dd"/>
                      </r:field>
                      <r:field fieldName="end_date" label="收费结束">
                        <w:date format="yyyy-MM-dd"/>
                      </r:field>
                </r:datacell>
            </div>
            
            <div style="padding: 8 10 8 8;">
                <r:datacell id="datacell2" 
                            queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=queryProjectServiceItem&sendPostId=${bean.id}&belongStatus=${belongStatus}"  
                            submitAction="/FAERP/AgentEmpSendPostAction.do?cmd=updateServiceItem"  
                            width="100%" height="200px" xpath="AgentSendPostServiceItemVo" 
                            paramFormId="datacell_formid">
                    <r:field fieldName="id" label="" width="0">
                        <h:text/>
                    </r:field>
                    <r:field fieldName="sendpost_id" label=""  width="0"></r:field>
                    <r:field fieldName="projectbook_id" label=""  width="0"></r:field>
                    <r:field fieldName="service_item_id" label="手续" allowModify="false">
                        <r:comboSelect id="service_idList" name="service_item_id"
                               queryAction="/FAERP/AgentEmpSendPostAction.do?cmd=queryAllProjectServiceItem&projectbookId=${bean.projectbook_id}"
                               valueField="service_item_id"
                               textField="service_item_name"
                               xpath="AgentSendPostServiceItemVo"
                               width="150px"
                               nullText="请选择"
                               validateAttr="message=入职服务名称;allowNull=false"
                            
                        />
                    </r:field>
                    <r:field fieldName="post_belong" label="服务归属" allowModify="false">
                        <d:select dictTypeId="POST_BELONG_BD" />
                    </r:field>
                    <r:field fieldName="status_bd" label="状态" >
                        <d:select dictTypeId="AGENT_SERVICE_STATUS" onchange="setServiceDate(this);"/>
                    </r:field>
                    <r:field fieldName="service_date" label="办理日期" >
                        <w:date allowInput="true" id="service_date" name="service_date" format="YYYY-MM-DD" property="bean/service_date" width="190px" readonly="true"/>
                    </r:field>
                    <r:field fieldName="remark" label="备注">
                        <h:text/>
                    </r:field>
                    <r:field fieldName="finally_date" label="最后处理日期">
                        <w:date allowInput="true" id="finally_date" name="finally_date" format="YYYY-MM-DD" property="bean/finally_date" width="190px" readonly="true"/>
                    </r:field>
                    <r:field fieldName="post_date" label="发布日期">
                        <w:date allowInput="true" id="post_date" name="post_date" format="YYYY-MM-DD" property="bean/post_date" width="190px" disabled="true"/>
                    </r:field>
                </r:datacell>
            </div> 
            
            <div class="mx_button" style="text-align: center; margin-left: 0px;">
                <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick()"/>
                <input type="button" class="icon_2" value='返回' onClick="javascript:cancel_onClick()"/>
            </div>  
        </div>
    </div>     
</form>
</body>
</html>
<script language="javascript">
    var vpath = "<%=request.getContextPath()%>";
    var initedDataCell = 0;
    $id("datacell1").afterRefresh = 
        function(){
            var dc = $id("datacell1");
            var rowCount = dc.getCurrentRowCount();
            var sumMoneyValue = parseFloat("0.00");
            for(var i = 0;i<rowCount;i++){
                sumMoneyValue = sumMoneyValue + parseFloat(dc.getCellValue(dc.getCell(i,3)));
            }
            
            initedDataCell++;
            //列表第一次加载,需要加载变化标识颜色
            if (initedDataCell ==1 ){
                setBiaoshi();
            }
            jQuery("#sum_money").text(fmoney(sumMoneyValue,2));
        };
</script>