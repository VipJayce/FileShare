<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js" />
<script type="text/javascript">
var _jQuery = window.jQuery, _$ = window.$;
jQuery.noConflict();
var venusbase = "<%=request.getContextPath()%>";
</script>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<fmt:bundle basename="rayoo.ibd.ibdcredentialstep.ibdcredentialstep_resource" prefix="rayoo.ibd.ibdcredentialstep.">
    <head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>IBD证件关系维护</title>
    <script language="javascript">
    function simpleQuery_onClick(){  //简单的模糊查询'
        $id("datacell1").loadData();
        $id("datacell1").refresh();
    }
    
    function setRadioStatus(value,entity,rowNo,cellNo){
        return "<input type='radio' name='checkbox_template' value='"+value+"' >";
    }
    
    //从列表中找出选中的id值列表
    function update() {  
        var id = getCheckItem();
        if(id == '') {
            alert('请选择一条记录。');
            return;
        }else{
            var url="<%=request.getContextPath()%>/IbdCredentialStepAction.do?cmd=find&id=" + id;
            showModalCenter(url, window, simpleQuery_onClick, 750, 210, "修改页面"); 
        }
    }
    
     //从列表中找出选中的id值列表
    function delete_onClick() {  
        var id = getCheckItem();
        if(id == '') {
            alert('请选择一条记录。');
            return;
        }else{
            var url="<%=request.getContextPath()%>/IbdCredentialStepAction.do?cmd=deleteMulti&ids=" + id;
            jQuery.post(url,function(msg){
                if(msg==""){
                    alert("删除成功！");
                    simpleQuery_onClick();
                }else{
                    alert(msg);
                    return;
                }
            });
        }
    }
    
   function insert_onClick(){  //插入单条数据
        var url="<%=request.getContextPath()%>/jsp/faerp/ibd/ibdcredentialstep/insertIbdCredentialStep.jsp";
        showModalCenter(url, window, simpleQuery_onClick, 750, 210, "增加页面"); 
    }
    
    //获取选中的节点
    function getCheckItem(){
       var id = "";
        var dc = $id("datacell1");
        _$("input[type='radio']").each(function(i) {
            if (_$(this).attr("checked")) {
                var row = dc.table.tBodies[0].rows[i];
                var entity = dc.getEntity(row);
                id = entity.getValue("id");
            }
        });
        return id;
    }
</script>
    </head>
    <body>

    <form name="form" method="post" id="datacell_formid">
    <input type="hidden" name="cmd" value="">
    <div id="right">
            <div class="right_title_bg"><div class=" right_title"> 证件关系维护</div>
            </div>
            <div class="ringht_s">
          <div id="ccChild0" class="search">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="174" rowspan="10" style="padding-top: 0;">
                        <div class="search_title">查询条件</div>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">证件名称</td>
                        <td align="left">
                             <input type="text" class="text_field" name="credentials_name" id="credentials_name" inputName="证件名称" value="" maxLength="50" />
                         </td>
                         <td align="left">
                              <input name="button_ok" class="icon_1" type="button" value='<fmt:message key="query"/>' onClick="javascript:simpleQuery_onClick()">
                              <input type="reset" class="icon_1" type="button" value="重置">
                    </tr>
                </table>
            </div>
            <!--查询 end-->
            <!--按钮-->
                <div class="button">
                    <div class="button_right">
                        <ul>
                          <li class="c"><a onClick="javascript:insert_onClick();">新增</a></li>
                          <li class="b"><a onClick="javascript:update();">修改</a></li>
                          <li class="d"><a onClick="javascript:delete_onClick();">删除</a></li>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
                <!--按钮 end-->
                <!--表格 -->
                <div style="padding: 8 10 8 8;">
                       <r:datacell id="datacell1" height="320px" xpath="IbdCredentialStepVo" submitXpath="IbdCredentialStepVo" paramFormId="datacell_formid"
                                 queryAction="/FAERP/IbdCredentialStepAction.do?cmd=simpleQuery" width="100%" showIndex="false">
                                <r:toolbar location="bottom" tools="nav,pagesize,info" />
                                <r:field fieldName="id" label="操作" width="35px" sortAt="none" onRefreshFunc="setRadioStatus"  align="center"></r:field>
                                <r:field fieldName="previous_name" width="250px" label="前置证件"></r:field>
                                <r:field fieldName="credentials_name" width="250px" label="证件名称"></r:field>
                                <r:field fieldName="remark" width="300px" label="备注"></r:field>
                        </r:datacell>
                </div>
                <!--表格 end-->
            </div>
        </div>
    </form>
</fmt:bundle>
<script language="javascript">
    writeTableBottomFesco('<%=request.getContextPath()%>/');  //显示本页的页脚
</script>
</body>
</html>