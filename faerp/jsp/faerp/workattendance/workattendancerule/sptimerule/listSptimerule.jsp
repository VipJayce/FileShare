<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
    <title>考勤期间</title>
<script type="text/javascript">
          //客户名称
          function rtnFuncCustomer_s(arg){
            var lookup = $id("cust_name_s");
            lookup.value = arg[2];
            lookup.displayValue = arg[2];
            $id("cust_id").value =arg[0] ;
            $id("cust_name").value =  arg[2];
            return false;
        }
        
         function toinsert_pop()
        {
             
              //判断是否该客户已经添加过规则
            var cust_id = $id("cust_id").value ;
             var cust_name = $id("cust_name").value
            if (cust_id ==null||cust_id==''){
                alert("请先选择客户进行新增规则") ;
                return false ;
            }
            var url ="<%=request.getContextPath()%>/SptimeruleAction.do?cmd=isInsertByCust&cust_id="+cust_id ;
            jQuery.ajax({
                   url: url,
                  type: 'post',
                  dataType: 'html',
                  timeout: 80000,
                  error: function(){
                      alert('系统编译错误！');
                      return  null;
                  },
                  success: function(text){
                      if(text=='no'){       
                                   var datacell_formid = $id("datacell_formid") ;
						            datacell_formid.action ="<%=request.getContextPath()%>/jsp/faerp/workattendance/workattendancerule/sptimerule/insertSptimerule.jsp?cust_name="+encodeURI(cust_name)+"&cust_id="+encodeURI(cust_id);
						            datacell_formid.submit();    
                      }else {
                            alert("该客户已经添加过规则，如果要修改请到修改页面") ;
                            return false ;
                      }
                  }
                  });

        }
        
        
        function toupdate_pop()
        {
             var dc = $id("datacell");
	        var clz = dc.getActiveEntity();
	        if(!clz){
	            alert("请先选择一条记录");
	            return ;
	        }
	        var timerule_id = clz.getValue("id");
	        var datacell_formid = $id("datacell_formid") ;
	        datacell_formid.action ="<%=request.getContextPath()%>/SptimeruleAction.do?cmd=detail&id="+timerule_id;
	        datacell_formid.submit();    
    }
    
      function search_onclick() {
        $id("datacell").reload() ;
    }
    
    
     function delete_onclick() {
        var dc = $id("datacell");
        var clz = dc.getActiveEntity();
        if(!clz){
            alert("请先选择一条记录");
            return ;
        }
         if(confirm('您确定删除这条数据吗?')) {
               var timerule_id = clz.getValue("id");
		        var datacell_formid = $id("datacell_formid") ;
		        datacell_formid.action ="<%=request.getContextPath()%>/SptimeruleAction.do?cmd=delete&id="+timerule_id;
		        datacell_formid.submit();    
         }
    }
    </script>
</head>
<body>
<form name="form" method="post" id="datacell_formid">
<div id="right">
    <script language="javascript">
        writeTableTopFesco('考勤规则设置','<%=request.getContextPath()%>/');  //显示本页的页眉
    </script>
<div class="ringht_s">
<div id="ccChild0" class="search"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="146" valign="top"><div class="search_title">查询条件</div></td>
        <td width="99">客户名称</td>
        <td width="200"> <w:lookup onReturnFunc="rtnFuncCustomer_s" readonly="true" id="cust_name_s" name="cust_name_s" lookupUrl="/CustomersimpleAction.do?cmd=getAllCustomerByCondition" dialogTitle="选择客户" height="440" width="600"  style="width:170px"/> 
           <input type="hidden" name="cust_id" id="cust_id">
           <input type="hidden" name="cust_name" id="cust_name">
           </td>
        <td width="218"><input name="submit2" type="button" class="icon_1" value="查询" onclick="search_onclick() ;"/>&nbsp;&nbsp;&nbsp;<input name="submit3" type="reset" class="icon_1" value="重置" /></td>
      </tr>
      </table>
</div>


<div class="button">
            <div class="button_right">
                <ul>
                  <li class="c"><a onClick="javascript:toinsert_pop();">新增</a></li>
                  <li class="b"><a onClick="javascript:toupdate_pop();">修改</a></li>
                  <li class="d"><a onClick="javascript:delete_onclick();">删除</a></li>                      
                </ul>
            </div>
            <div class="clear"></div>
        </div>

<div style="padding: 5 0 8 8;">
       <r:datacell 
        id="datacell"
        paramFormId="datacell_formid"
        queryAction="/FAERP/SptimeruleAction.do?cmd=queryAll"
        width="98%"
        height="318px"
        xpath="SptimeruleVo"
        readonly="true"
        >
      <r:toolbar location="bottom" tools="nav,pagesize,info" />
            <r:field fieldName="customer_name" label="客户名称" width="200px">
            </r:field>
            <r:field fieldName="customer_code" label="客户编号" width="200px">
            </r:field>
            <r:field fieldName="timedecimal" label="考勤小数位" width="150px">
            </r:field>
            <r:field fieldName="daytohour" label="工作日折算" width="100px">
            </r:field>  
            <r:field fieldName="chuchaidisp" label="出差显示值" width="100px">
            </r:field>              
            <r:field fieldName="xiujiadisp" label="休假显示值" width="130px">
            </r:field>        
              <r:field fieldName="absentdisp" label="矿工显示值" width="130px">
            </r:field>   
             <r:field fieldName="earlydisp" label="早退显示值" width="130px">
            </r:field>    
           <r:field fieldName="latedisp" label="迟到显示值" width="130px">
            </r:field>    
            <r:field fieldName="gxdisp" label="公休显示值" width="130px">
            </r:field>    
            <r:field fieldName="overtmruletype" label="加班类别" width="130px">
            </r:field>    
            <r:field fieldName="normaldisp" label="正常显示值" width="130px">
            </r:field>    
    </r:datacell>
</div>
</div>
</div>
</form>
</fmt:bundle>
</body>
</html>

