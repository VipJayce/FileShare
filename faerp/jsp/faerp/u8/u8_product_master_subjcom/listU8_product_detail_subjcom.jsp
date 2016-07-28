<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.rm.tools.helper.RmVoHelper" %>
<%@ page import="rayoo.u8.u8_product_master_subjcom.vo.U8_product_master_subjcomVo" %>
<%@ page import="rayoo.u8.u8_product_master_subjcom.util.IU8_product_master_subjcomConstants" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<i18n:javascript src="/js/common/variable-i18n.js"/>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
</script>
<%  //判断是否为修改页面
	U8_product_master_subjcomVo resultVo = null;  //定义一个临时的vo变量
	boolean isModify = false;  //定义变量,标识本页面是否修改(或者新增)
	if(request.getParameter("isModify") != null) {  //如果从request获得参数"isModify"不为空
		isModify = true;  //赋值isModify为true
		if(request.getAttribute(IU8_product_master_subjcomConstants.REQUEST_BEAN) != null) {  //如果request中取出的bean不为空
  		    resultVo = (U8_product_master_subjcomVo)request.getAttribute(IU8_product_master_subjcomConstants.REQUEST_BEAN);  //从request中取出vo, 赋值给resultVo
  		}
	}
%>
<html>
<fmt:bundle basename="gap.rm.rm_resource" prefix="gap.rm.">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>codegen</title>
<script language="javascript">
	   function cancel_onClick(){  //取消后返回列表页面
	       form.action="<%=request.getContextPath()%>/U8_product_master_subjcomAction.do?cmd=queryAll&backFlag=true";
	       form.submit();
	   }

       //添加二级科目
       function add_subjcode2() {
          var url="<%=request.getContextPath()%>/jsp/faerp/u8/u8_product_master_subjcom/insertU8_detail_subjcom2.jsp?id=${bean.id}&subjcode=${bean.subjcode}&classtype=${bean.classtype}";
          url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
          showModalCenter(url, window, retCallback, 860, 240, "凭证与二级科目对照设置");  //增加子岗位
       }
         
        function retCallback() {
              $id("celllist1").loadData();
              $id("celllist1").refresh();
              
              $id("v2_ccode").value="";
              $id("parent_id").value="";
              $id("v_bustype").value="";
            
              $id("celllist2").loadData();
              $id("celllist2").refresh();
         }
         
         
         //添加三级科目
         function add_subjcode3() {
            var v2_ccode=$id("v2_ccode").value;
            var v_bustype=$id("v_bustype").value;
            var v_product_id=$id("v_product_id").value;
            var parent_id=$id("parent_id").value;
            
            if(v_bustype==null || v_bustype==""){
                v_bustype="";
                $id("v_bustype").value="";
            }
            
            if(v2_ccode=="" || parent_id==""){
                alert("请选择一条二级科目记录！");
                return;
            }
            
            var url="<%=request.getContextPath()%>/jsp/faerp/u8/u8_product_master_subjcom/insertU8_detail_subjcom3.jsp?id=${bean.id}&subjcode="+v2_ccode+"&v_bustype="+v_bustype+"&v_product_id="+v_product_id+"&parent_id="+parent_id+"&classtype=${bean.classtype}";
            url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            showModalCenter(url, window, retCallback2, 860, 240, "凭证与三级科目对照设置");  //增加子岗位
         }
         
        function retCallback2() {
              $id("celllist2").loadData();
              $id("celllist2").refresh();
         }
         
	   jQuery(function(){
	        $id("celllist2").isQueryFirst = false;
	    }); 
	         
	  function setCheckboxStatus(value,entity,rowNo,cellNo){
	       var id=entity.getProperty("id");
	       var subjcode=entity.getProperty("subjcode");
	       var bustype=entity.getProperty("bustype") ;
	       var product_id=entity.getProperty("product_id");
	       
	       return "<input type='radio'  name='temp'   onClick=ClickRow(\"" + id + "\",\"" + subjcode + "\",\"" + bustype + "\",\"" + product_id + "\");>";
	    }

       function ClickRow(value,subjcode,bustype,product_id){
            $id("parent_id").value = value;
            $id("v2_ccode").value = subjcode;
            $id("v_bustype").value = bustype;
            
            $id("v_product_id").value=product_id;
            $id("celllist2").addParam("parent_id", value);
            $id("celllist2").loadData();
            $id("celllist2").refresh();
        }
        
        
       function toDelete_onClick(val) {
            var t_id="";
            if(val=="2"){
		            var v2_ccode=$id("v2_ccode").value;
		            var parent_id=$id("parent_id").value;
		            t_id=parent_id;
		            if(v2_ccode=="" || parent_id==""){
		                alert("请选择一条记录！");
		                return;
		            }
            }else{
                var entity=choose_row_public("celllist2");
                if(!entity){
	                return ;
	            }
                t_id=entity.getValue("id");
            }
            
           if(!confirm('确定要删除所选择的记录么?')){
               return false;
            }

            var url="<%=request.getContextPath()%>/U8_product_detail_subjcomAction.do?cmd=deleteData&id=" + t_id;
            url=url+"&_ts="+(new Date()).getTime();   //防止IE缓存，在每次打开时加个时间差的参数
            jQuery.post(url,function(data){
                if(data){
                        if(data!=""){
                            alert(data);
                        }else{
                            alert("删除失败！");
                        }
                 }
             });
             
             if(val=="2"){
	             $id("celllist1").loadData();
	             $id("celllist1").refresh();
             }else{
                $id("celllist2").loadData();
                $id("celllist2").refresh();
             }
         }
         
        function replaceyh(str)
		{
		    str=str.replace(/[ ]/g,""); 
		    return str;
		}
		
		function checkForms(obj){
       		var iu;
       		var iuu;
      		var regArray=new Array("!","^","*","(",")","=","[","]","?","~","`","!","→","←","↑","↓","！","@","◎","#","＃","$","…","※","￥","§","×","｛","｝","％","/","\'","\"");
       		iuu=regArray.length;     
            for(iu=1;iu<=iuu;iu++){  
           		if (obj.indexOf(regArray[iu])!=-1){
                	alert("输入内容中不可以包含：" + regArray[iu]);                  
                    return false;
              	}
	       	}
			return true;              
		}
		
        function query_onClick(num){
        	if(num == "2"){
		        var two_ccode_name=replaceyh($id("two_ccode_name").value);
		        var two_product_name=replaceyh($id("two_product_name").value);
		        if(two_ccode_name!=""){
			        if(!checkForms(two_ccode_name)){
			        	return;
			        }
		        }else{
		        	$id("two_ccode_name").value=two_ccode_name;
		        	//return;
		        }
		        $id("two_ccode_name").value=two_ccode_name;
		        if(two_product_name!=""){
			        if(!checkForms(two_product_name)){
			        	return;
			        }
		        }else{
		        	$id("two_product_name").value=two_product_name;
		        	//return;
		        }
		        $id("two_product_name").value=two_product_name;
		        $id("celllist1").loadData();
	            $id("celllist1").refresh();
	        }else{
	        	var three_ccode_name=replaceyh($id("three_ccode_name").value);
	        	var three_product_name=replaceyh($id("three_product_name").value);
		        if(three_ccode_name!=""){
			        if(!checkForms(three_ccode_name)){
			        	return;
			        }
		        }else{
		        	$id("three_ccode_name").value=three_ccode_name;
		        	//return;
		        }
		        $id("three_ccode_name").value=three_ccode_name;
		        if(three_product_name!=""){
			        if(!checkForms(three_product_name)){
			        	return;
			        }
		        }else{
		        	$id("three_product_name").value=three_product_name;
		        	//return;
		        }
		        $id("three_product_name").value=three_product_name;
		        $id("celllist2").loadData();
                $id("celllist2").refresh();
	        } 
		}
		
		//修改二级科目
        function edit_subjcode2() {
            var v2_ccode=$id("v2_ccode").value;
            var parent_id=$id("parent_id").value;
            if(v2_ccode=="" || parent_id==""){
                alert("请选择一条记录！");
                return;
            }
            var datacell = $id("celllist1");
            var dataset1 = datacell.dataset;
            var datasettr1 = dataset1.findEntity("id",parent_id);
            var ccode_name = datasettr1.getValue("ccode_name");
            var product_name = datasettr1.getValue("product_name");
            var url="<%=request.getContextPath()%>/U8_product_detail_subjcomAction.do?cmd=findDate&subjcode=${bean.subjcode}&parent_id="+parent_id+"&ccode_name="+ccode_name+"&product_name="+product_name+"&_ts="+(new Date()).getTime(); 
            url = encodeURI(url);
            //alert(url);
            showModalCenter(url, window, retCallback, 860, 200, "凭证与二级科目对照设置");  //增加子岗位
       }
       
       //修改三级科目
       function edit_subjcode3() {
            var entity=choose_row_public("celllist2");
            if(!entity){
            	return ;
           	}
           	var v2_ccode=$id("v2_ccode").value;
           	if(v2_ccode==""){
                alert("请选择一条二级科目记录！");
                return;
            }
            var id = entity.getValue("id");
            var ccode_name = entity.getValue("ccode_name");
            var product_name = entity.getValue("product_name");
            var url="<%=request.getContextPath()%>/U8_product_detail_subjcomAction.do?cmd=findDate1&subjcode="+v2_ccode+"&id="+id+"&ccode_name="+ccode_name+"&product_name="+product_name+"&_ts="+(new Date()).getTime(); 
            url = encodeURI(url);
          	showModalCenter(url, window, retCallback, 860, 200, "凭证与三级科目对照设置");  //增加子岗位
       }
         
</script>
</head>
<body>

<form name="form" method="post" id="datacell_formid">
<!-- 主表ID  -->
<input id="product_master_subjcom_id" name="product_master_subjcom_id" type="hidden"  value="" />
<!-- 二级ID  -->
<input id="parent_id" name="parent_id" type="hidden"  value="" />
<!-- 二级科目编码  -->
<input id="v2_ccode" name="v2_ccode" type="hidden"  value="" />

<input id="v_bustype" name="v_bustype" type="hidden"  value="" />
<input id="v_product_id" name="v_product_id" type="hidden"  value="" />

<div id="right">
<script language="javascript">
        writeTableTopFesco("凭证与科目对照设置",'<%=request.getContextPath()%>/');
</script>


 

 
<div id="right">
<div id="ccChild1"     class="box_xinzeng" style="height: 135px">
<div class="xz_title" style="padding-top: 10px">凭证与一级科目对照</div>
<table  width="100%" height="40" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
		<tr>
			<td width="21%" class="td_1" >凭证名称</td>
			<td width="39%" class="td_2 ">${bean.voucher_name}</td>
			<td width="11%" class="td_1" >一级科目名称</td>
			<td width="29%" class="td_2" >${bean.ccode_name}</td>
		</tr>
		<tr>
			<td class="td_1" >对照生效日期</td>
			<td class="td_2"><fmt:formatDate value="${bean.startend }" pattern="yyyy-MM-dd"/></td>
			<td class="td_1" >对照失效日期</td>
			<td class="td_2"><fmt:formatDate value="${bean.enddate }" pattern="yyyy-MM-dd"/></td>
		</tr>
		<tr>
			<td class="td_1" >备注</td>
			<td class="td_2 ">${bean.mark}   <!-- 科目编码：${bean.subjcode} --></td>
			<td colspan="4" class="td_2" align="center">
            <input type="button" class="icon_2" value='<fmt:message key="go_back"/>'  onClick="javascript:cancel_onClick()"/>
			</td>
		</tr>
	</table>
 
   
 
        
</div>         


<div class="xz_title" style="padding-top: 10px">凭证与二级科目对照设置</div>
	<div class="button_right" style="padding-left: 8px">
	  <input class="c_3"  id="c_1" type="button"   value="添加二级科目" onclick="add_subjcode2();">
	  <input class="d" type="button"   value="删除" onClick="javascript:toDelete_onClick('2');">
	  <input class="b"  id="b_1" type="button"   value="修改" onclick="edit_subjcode2();">
	</div>   
	<div style="padding-left: 8px">
	二级科目名称：<input name="two_ccode_name" type="text" id="two_ccode_name" value=""/>&nbsp;&nbsp;产品名称：<input name="two_product_name" type="text" id="two_product_name" value=""/>
    <input type="button" class="icon_2" value="查询"  onClick="javascript:query_onClick('2')"/>
    </div>
<div id="values_div2" style="width:100%;height:200px; padding: 5 0 8 8;">
        <r:datacell id="celllist1"
            queryAction="/FAERP/U8_product_detail_subjcomAction.do?cmd=getListByMasterID&MasterID=${bean.id}&subjcode2=2"
            paramFormId="datacell_formid" width="99%" height="304px"
            xpath="U8_product_detail_subjcomVo" readonly="true" pageSize="10">
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
            <r:field fieldName="emp" label="操作" width="50px" onRefreshFunc="setCheckboxStatus" align="center">
            </r:field>   
             <r:field fieldName="subjcode" label="二级科目编码" width="100px">
                <h:text />
            </r:field>
            <r:field fieldName="ccode_name" label="二级科目名称" width="100px">
                <h:text />
            </r:field>
            <r:field fieldName="startend" label="对照生效日期" width="90px">
                <w:date format="yyyy-MM-dd" />
            </r:field>
            <r:field fieldName="enddate" label="对照失效日期" width="90px">
                <w:date format="yyyy-MM-dd" />
            </r:field>
            <r:field fieldName="classtype" label="凭证类型" width="70px">
                <h:select name="classtype1" property="classtype1">
                <h:option value="0" label="借方"></h:option>
                <h:option value="1" label="贷方"></h:option>
                </h:select>
            </r:field>
            <r:field fieldName="ruletype" label="规则类型" width="70px">
                <d:select dictTypeId="RULETYPE_DB"/>
            </r:field>
            <r:field fieldName="product_name" label="产品名称" width="120px">
                <h:text />
            </r:field>
            <r:field fieldName="banktype" label="银行类型" width="70px">
                <d:select dictTypeId="BANK" />
            </r:field>
            <r:field fieldName="bustype" label="业务类型" width="70px">
                <d:select dictTypeId="BUSTYPE_DB" />
            </r:field>
            <r:field fieldName="dept_name" label="部门名称" width="120px">
                <h:text />
            </r:field>
            <r:field fieldName="mark" label="备注" width="200px">
                <h:text />
            </r:field>
        </r:datacell>
        </div>
</div>  


<div class="xz_title" style="padding-top: 10px">凭证与三级科目对照设置</div>
    <div class="button_right" style="padding-left: 8px">
      <input class="c_3"  id="c_1" type="button"   value="添加三级科目" onclick="add_subjcode3();">
      <input class="d" type="button"   value="删除" onClick="javascript:toDelete_onClick('3');">
      <input class="b"  id="b_1" type="button"   value="修改" onclick="edit_subjcode3();">
    </div>   
	<div style="padding-left: 8px">
	三级科目名称：<input name="three_ccode_name" type="text" id="three_ccode_name" value=""/>&nbsp;&nbsp;产品名称：<input name="three_product_name" type="text" id="three_product_name" value=""/>
    <input type="button" class="icon_2" value="查询"  onClick="javascript:query_onClick('3')"/>
    </div>
<div id="values_div3" style="width:100%;height:200px; padding: 5 0 8 8;">
        <r:datacell id="celllist2"
            queryAction="/FAERP/U8_product_detail_subjcomAction.do?cmd=getListByMasterID&MasterID=${bean.id}"
            paramFormId="datacell_formid" width="99%" height="304px"
            xpath="U8_product_detail_subjcomVo" readonly="true" pageSize="10">
            <r:toolbar location="bottom" tools="nav,pagesize,info"/>
             <r:field fieldName="subjcode" label="三级科目编码" width="100px">
                <h:text />
            </r:field>
            <r:field fieldName="ccode_name" label="三级科目名称" width="100px">
                <h:text />
            </r:field>
            <r:field fieldName="startend" label="对照生效日期" width="90px">
                <w:date format="yyyy-MM-dd" />
            </r:field>
            <r:field fieldName="enddate" label="对照失效日期" width="90px">
                <w:date format="yyyy-MM-dd" />
            </r:field>
            <r:field fieldName="classtype" label="凭证类型" width="70px">
                <h:select name="classtype1" property="classtype1">
                <h:option value="0" label="借方"></h:option>
                <h:option value="1" label="贷方"></h:option>
                </h:select>
            </r:field>
            <r:field fieldName="ruletype" label="规则类型" width="70px">
                <d:select dictTypeId="RULETYPE_DB"/>
            </r:field>
            <r:field fieldName="product_name" label="产品名称" width="120px">
                <h:text />
            </r:field>
            <r:field fieldName="banktype" label="银行类型" width="90px">
                <d:select dictTypeId="BANK" />
            </r:field>
            <r:field fieldName="bustype" label="业务类型" width="90px">
                <d:select dictTypeId="BUSTYPE_DB" />
            </r:field>
            <r:field fieldName="dept_name" label="部门名称" width="120px">
                <h:text />
            </r:field>
            <r:field fieldName="mark" label="备注" width="200px">
                <h:text />
            </r:field>
        </r:datacell>
        </div>
</div>  
    

</form>
</fmt:bundle>
<script language="javascript">
	writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>

<script language="javascript">
<%  //取出要修改的那条记录，并且回写表单
	if(isModify) {  //如果本页面是修改页面
		out.print(RmVoHelper.writeBackMapToForm(RmVoHelper.getMapFromVo(resultVo)));  //输出表单回写方法的脚本
  	}
%>
</script>
