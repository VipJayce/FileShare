<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<h:script src="/js/CommonCheck.js"/>
<h:script src="/js/caculateMoney.js"/>
<script type="text/javascript">
jQuery.noConflict();
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<fmt:bundle basename='rayoo.customerservice.custservice.security.empsecurity.listSecuritySupplyItem_resource' prefix='auto.'>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key='listSecuritySupplyItem0000'/></title>
<script language="javascript">
    var reg=dialogArguments[0];
    var datasetPassed = reg[0];
    var countMonth=reg[1];
    var base = reg[2]
    function deleteMulti_onClick(){ 
        $id("datacell").deleteRow();
    }
    //删除一行
    function deleteMulti_onClick2(){ 
            $id("datacell2").deleteRow();
        }
    //添加一行
    function toAdd_onClick() { 
            $id("datacell2").addRow();
        }
</script>
</head>
<body>
<form name="form" method="post" id="datacell_formid" >
<input type="hidden" name="security_group_id" id="security_group_id" value="${param.security_group_id }">
    <div class="button_right">
                <ul>
                <c:if test="${param.isModify=='1'}">
                    <li class="c"><a onClick="javascript:toAdd_onClick();"><fmt:message key="insert"/> </a></li>
                    <li class="d"><a onClick="javascript:deleteMulti_onClick();"><fmt:message key="delete"/> </a> </li>
                    </c:if>
                </ul>
         </div>
    <div style="padding: 8 10 8 8;">
    <r:datacell 
        id="datacell"
        queryAction="#" 
        submitAction="/FAERP/EmpsecurityAction.do?cmd=applySecurity" width="95%"
        xpath="EmpsecuritysupplyitemVo"
        submitXpath="EmpsecuritysupplyitemVo"
        paramFormId="datacell_formid" height="210px"
        >
      <r:field fieldName="product_name" messagekey='listSecuritySupplyItem0001' width="80px" allowModify="false">
      </r:field>
      
      <r:field fieldName="base" messagekey='listSecuritySupplyItem0002' width="80px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
        <c:if test="${param.isModify=='1'}">
        <h:text onchange="javascript:calMoneyAgain();"/>
        </c:if>
      </r:field>
      
      <r:field fieldName="money" messagekey='listSecuritySupplyItem0003' width="80px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
        <c:if test="${param.isModify=='1'}">
        <h:text onchange="javascript:calAllmoney();"/>
        </c:if>
      </r:field>
      
      <r:field fieldName="e_money" messagekey='listSecuritySupplyItem0004' width="80px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
            <c:if test="${param.isModify=='1'}">
            <h:text onchange="javascript:calMoneyAgain1();"/>
            </c:if>
      </r:field>
      
      <r:field fieldName="p_money" messagekey='listSecuritySupplyItem0005' width="80px" onRefreshFunc="(false||function(cellText, entity, rn, cn, cur){return formatNumber(cellText,'#,###.##');})">
            <c:if test="${param.isModify=='1'}">
            <h:text onchange="javascript:calMoneyAgain1();"/>
            </c:if>
      </r:field>
      
      <r:field fieldName="e_ratio" messagekey='listSecuritySupplyItem0006' width="80px" allowModify="false">
      </r:field>
      
      <r:field fieldName="p_ratio" messagekey='listSecuritySupplyItem0007' width="80px" allowModify="false">
      </r:field>
      
      <r:field fieldName="" messagekey='listSecuritySupplyItem0008' width="80px" allowModify="false">
      </r:field>
      
      <r:field fieldName="" messagekey='listSecuritySupplyItem0009' width="80px" allowModify="false">
      </r:field>
    </r:datacell>
    </div>
</div>
</div>
<div class="foot_button">
<input type="button" class="foot_icon_1" value='<fmt:message key='listSecuritySupplyItem0010'/>'  onclick="javascript:back_onClick();" />
</div>
</form>
<script language="javascript">
    //jQuery.ready{function(
        var dc1 = $id("datacell");
        dc1.dataset = datasetPassed;
        dc1.refresh();
        
    //)};
    $id("datacell").beforeLoadData = function(){
        return false;
    }
    
    function back_onClick(){  //返回列表页面
        //datasetPassed=$id("datacell").dataset.clone(true);
        window['returnValue'] = $id("datacell").dataset;
        window.close();
        
    }
    
    //重新计算
    //$id("datacell").afterEdit=function(newValue,oldValue){
    //    calMoneyAgain();
    //}
    
    //重新计算<fmt:message key='listSecuritySupplyItem0003'/>
    function calMoneyAgain(){

        var curCell=$id("datacell").activeCell;
        var curCellNum = $id("datacell").activeRow.rowIndex;
        //alert(curCellNum);
        var entCur=$id("datacell").getEntityByCell(curCell);
        //if (curCellNum == 1){
        if(entCur.getProperty("base")!=null && entCur.getProperty("base")!=''){
            var base    = getNumber(entCur.getProperty("base"));//<fmt:message key='listSecuritySupplyItem0002'/>
            var money   = getNumber(entCur.getProperty("money"));//<fmt:message key='listSecuritySupplyItem0003'/>
            var e_money = getNumber(entCur.getProperty("e_money"));//<fmt:message key='listSecuritySupplyItem0004'/>
            var p_money = getNumber(entCur.getProperty("p_money"));//<fmt:message key='listSecuritySupplyItem0005'/>
            var e_ratio = getNumber(entCur.getProperty("e_ratio"));//企业比列
            var p_ratio = getNumber(entCur.getProperty("p_ratio"));//个人比列
            var e_caculate_type = entCur.getProperty("e_caculate_type_bd");//企业舍入
            var p_caculate_type = entCur.getProperty("p_caculate_type_bd");//个人舍入
            var e_precision = entCur.getProperty("e_precision_bd");//企业精度
            var p_precision = entCur.getProperty("p_precision_bd");//个人精度
            sum_e = calInsurance(getNumber(base),e_ratio,0,e_precision,e_caculate_type);
            sum_p = calInsurance(getNumber(base),p_ratio,0,p_precision,p_caculate_type);
            sum = sum_e+sum_p;
            entCur.setProperty("e_money",floatRound(sum_e*countMonth,2).toFixed(2));
            entCur.setProperty("p_money",floatRound(sum_p*countMonth,2).toFixed(2));
            entCur.setProperty("money",floatRound(sum*countMonth,2).toFixed(2));
            //alert(countMonth);
        }
    }
    
    //自定义总<fmt:message key='listSecuritySupplyItem0003'/>，个人和<fmt:message key='listSecuritySupplyItem0004'/>平分
    function calAllmoney(){
        var curCell=$id("datacell").activeCell;
        var entCur=$id("datacell").getEntityByCell(curCell);
        var money   = getNumber(entCur.getProperty("money"));//<fmt:message key='listSecuritySupplyItem0003'/>
        sum = money/2;
         entCur.setProperty("e_money",floatRound(sum,2).toFixed(2));
         entCur.setProperty("p_money",floatRound(sum,2).toFixed(2));
    }
    
    
     //重新计算总额
    function calMoneyAgain1(){

        var curCell=$id("datacell").activeCell;
        var curCellNum = $id("datacell").activeRow.rowIndex;
        //alert(curCellNum);
        var entCur=$id("datacell").getEntityByCell(curCell);
        //if (curCellNum == 1){
            //var base    = getNumber(entCur.getProperty("base"));//<fmt:message key='listSecuritySupplyItem0002'/>
            var money   = getNumber(entCur.getProperty("money"));//<fmt:message key='listSecuritySupplyItem0003'/>
            var e_money = getNumber(entCur.getProperty("e_money"));//<fmt:message key='listSecuritySupplyItem0004'/>
            var p_money = getNumber(entCur.getProperty("p_money"));//<fmt:message key='listSecuritySupplyItem0005'/>
            
            sum = e_money+p_money;
            
            entCur.setProperty("money",floatRound(sum,2).toFixed(2));
            //alert(countMonth);
        
    }
    
</script>
</body>
</fmt:bundle>
</html>
<script>
    //$id("datacell").afterDel = function (row){
        //alert(row);
        //$id("datacell").dataset.removeEntity($id("datacell").getEntity(row), true);
        
        //return true;
    //}
    
    function toAdd_onClick() {
        var ds  = $id("datacell").dataset;
        var product_ids="";
        //alert(ds.getLength());
        for(var i=0;i<ds.getLength();i++){
            if(ds.get(i).status!=3&&ds.get(i).status!=4){
                product_ids+=ds.get(i).getProperty("product_id")+",";
            }
        }
        //alert(product_ids);
        var security_group_id = $name("security_group_id").value;
        var url="<%=request.getContextPath()%>/jsp/faerp/customerservice/security/empsecurity/productList.jsp?security_group_id="
            +security_group_id+"&product_ids="+product_ids;
        showModalCenter(url, window,toaddProductlistrollback,230,260,"<fmt:message key='listSecuritySupplyItem0011'/>");
    }
    
    function toaddProductlistrollback(obj){
        if(obj!=null&&obj!=""){
            var security_product_id=obj;
            var security_group_id = $name("security_group_id").value;
	        var myAjax = new Ajax("<%=request.getContextPath()%>/EmpsecurityAction.do?cmd=queryAddSupplyProductItem");
	        myAjax.addParam("security_product_id", security_product_id);
	        myAjax.addParam("security_group_id", security_group_id);
	        myAjax.submit();
	        var xmlDom = myAjax.retDom;
	        var dataset1 = Dataset.create(xmlDom,"root/data/EmpsecuritysupplyitemVo","EmpsecuritysupplyitemVo");
            for(var i=0;i<dataset1.getLength();i++){
                var oldEntity =  datasetPassed.addBlankEntity();
                //var newEntity =  $id("datacell").styleEntity.clone(true);//只克隆行样式，不带值
                var newEntity = oldEntity.clone(true);
                datasetPassed.removeEntity(oldEntity, true);
                newEntity.setProperty("product_name", dataset1.get(i).getProperty("product_name"));
                newEntity.setProperty("product_id", dataset1.get(i).getProperty("product_id"));
                newEntity.setProperty("e_ratio", dataset1.get(i).getProperty("e_ratio"));
                newEntity.setProperty("p_ratio", dataset1.get(i).getProperty("p_ratio"));
                newEntity.setProperty("p_money", dataset1.get(i).getProperty("p_money"));
                newEntity.setProperty("e_caculate_type_bd", dataset1.get(i).getProperty("e_caculate_type_bd"));
                newEntity.setProperty("p_caculate_type_bd", dataset1.get(i).getProperty("p_caculate_type_bd"));
                newEntity.setProperty("e_precision_bd", dataset1.get(i).getProperty("e_precision_bd"));
                newEntity.setProperty("p_precision_bd", dataset1.get(i).getProperty("p_precision_bd"));
                if(base!=null&&base!=""){
                    newEntity.setProperty("base", base);
                }
                $id("datacell").addRow(newEntity);
                calMoneyAgain();
            }
        }
        
    }
    
    //$id("datacell").afterAdd=function(row){
    //    calMoneyAgain();
    //}
    
</script>




