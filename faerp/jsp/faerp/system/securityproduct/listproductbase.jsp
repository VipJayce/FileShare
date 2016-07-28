<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<%@ page import="rayoo.sales.costcenter.vo.CostcenterVo" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>设置让利价格</title>
<script language="javascript">
       function setCheckboxStatus(value,entity,rowNo,cellNo){
       return "<input type='hidden'  name='temp'         value=" + entity.getProperty("id") + "   >";//city_idList
    }

        function toAdd_onClick() { 
            $id("datacell1").addRow();
        }
        
        function deleteMulti_onClick(){ 
           if(confirm('确定要删除所选择的数据么！')) { 
                $id("datacell1").deleteRow();
                $id("datacell1").submit();
                alert("删除成功");
	        }
        }
        
        //保存信息
        function save_onClick() {
               var count_error= end_startDate();
               var count_month=check_base_1();
               var count_person=check_base_2();
               var count_company=check_base_3();
               //alert("人 "+count_person+"  公司 "+count_company+"  年月 "+count_month+" 校验"+count_error);
           if(count_person==""&&count_company==""&&count_month==""&&count_error==""){
                $id("datacell1").isModefied = true;
                $id("datacell2").isModefied = true;
                if($id("datacell1").submit()&&$id("datacell2").submit()){
                        alert("保存成功！");
                    }
                }
            if(count_month!=""&&count_month!=null){
                        alert(count_month+" 行有效日期区间错误");
                        return;
            }
            if(count_error!=""&&count_error!=null){
                         alert(count_error+"行起始月应为上次有效终止月的下一月");
                         return;
            }
             if(count_person!=""&&count_person!=null){
                        alert(count_person+" 行个人最高基数应大于最低基数");
                        return;
            } 
             if(count_company!=""&&count_company!=null){
                        alert(count_company+" 行公司最高基数应大于最低基数");
                        return;
            }     
        }  
        
         
        function toReload_onClick() {
             $id("datacell1").reload();
        }
  //最高基数要大于最低基数,如果有终止月则应在起始月之后<siqp添加>
function check_base_1(){
        var loop=document.getElementsByName("temp");
        var enCurEntity="";
        var month_start="";//缴费起始月
        var month_end="";//缴费终止月
        var count_month="";
    for(var i=0;i<loop.length;i++){
      enCurEntity = $id("datacell1").dataset.get(i);
      month_start=enCurEntity.getProperty("start_month");
      month_end=enCurEntity.getProperty("end_month");
   if(month_end!="" && month_end!=null &&parseInt(month_start)>parseInt(month_end)){
           count_month+=" 第"+(i+1);
            }   
        }
        return count_month;
    }
function check_base_2(){
        var loop=document.getElementsByName("temp");
        var enCurEntity="";
        var count_person="";
        var p_max ="";//个人最高
        var p_min="";//个人最低
      for(var i=0;i<loop.length;i++){
	      enCurEntity = $id("datacell1").dataset.get(i);
	      p_max = enCurEntity.getProperty("personal_top_radix");
	      p_min = enCurEntity.getProperty("personal_low_base");
	      if(parseInt(p_max)<parseInt(p_min)){ 
	         count_person +=" 第 "+(i+1);
          }
      }
      return count_person;
    }

function check_base_3(){
     var loop=document.getElementsByName("temp");
     var enCurEntity="";
     var count_company="";
     var e_max ="";//企业最高
     var e_min ="";//企业最低
      for(var i=0;i<loop.length;i++){
      enCurEntity = $id("datacell1").dataset.get(i);
      e_max = enCurEntity.getProperty("company_top_radix");
      e_min = enCurEntity.getProperty("company_low_radix");
     if(parseInt(e_max)<parseInt(e_min)){
         count_company +=" 第 "+(i+1);
          }
      }
      return count_company;
    }
 //如果上一条产品有终止月，则新添加的合同起始月应为上一条产品终止月的下一个月
 function end_startDate(){
     var loop=document.getElementsByName("temp");
     var enCurEntity_f="";//first 实体
     var enCurEntity_s="";//second实体
     var end_f="";//first终止时间
     var start_s="";//second起始时间
     var count_error="";
     for(var i=0;i<loop.length;i++){
     //两条以上的vo就比对前一条的终止时间和后一条的起始时间
        if(i-1>=0){
            enCurEntity_f=$id("datacell1").dataset.get(i-1);
            enCurEntity_s=$id("datacell1").dataset.get(i);
            end_f=enCurEntity_f.getProperty("end_month");
            start_s=enCurEntity_s.getProperty("start_month");
            if(  !((parseInt(start_s)==(parseInt(end_f)+1))  || (parseInt(start_s)==(parseInt(end_f)+89)))  ){
                        count_error+=" 第"+(i+1);
                }
        }
     }
     return count_error;
 }
</script>
</head>
<body>
<form name="datacell_formid" id="datacell_formid" method="post"> 
<div id="right">
         <!--<w:panel id="panel1" title="设置让利价格">-->
         <div  id="div1" style="margin:5px 0px 0px 10px;">
                            <r:datacell 
                            queryAction="/FAERP/SecurityproductitemAction.do?cmd=searchDataBySecurityProductID&security_product_id=${param.security_product_id}"
                            submitAction="/FAERP/SecurityproductitemAction.do?cmd=saveDataBySecurityProductID&security_product_id=${param.security_product_id}"
                            id="datacell1"
                            paramFormId="datacell_formid" 
                            width="98%" height="190px" 
                            xpath="SecurityproductitemVo"
                            >
                          <r:toolbar location="bottom" tools="nav,edit:add del reload,pagesize,info"/>
                          
                          <r:field fieldName="id" label="" width="0px"
                         onRefreshFunc="setCheckboxStatus" align="center">
                     </r:field>
                          
                          <r:field fieldName="start_month" label="有效起始月">
                          <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=false;"/>
                          </r:field>
                          <r:field fieldName="end_month" label="有效终止月">
                            <h:text validateAttr="type=formatStr;regExpr=^[12]\d{3}(0\d|1[0-2])$;message=年月格式不正确;allowNull=true;" />
                          </r:field>
                          <r:field fieldName="company_fixed_radix" label="企业固定基数">
                            <h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=true"/>
                          </r:field>
                          <r:field fieldName="personal_fixed_radix" label="个人固定基数">
                            <h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=true"/>
                          </r:field>
                          <r:field fieldName="social_average_salary" label="社会平均工资">
                            <h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
                          </r:field>
                          <r:field fieldName="personal_top_radix" label="个人最高基数">
                            <h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
                          </r:field>
                          <r:field fieldName="personal_low_base" label="个人最低基数">
                            <h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
                          </r:field>
                          <r:field fieldName="company_top_radix" label="企业最高基数">
                            <h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
                          </r:field>
                          <r:field fieldName="company_low_radix" label="企业最低基数">
                            <h:text validateAttr="totalDigit=8;fracDigit=4;maxLength=10;type=float;allowNull=false"/>
                          </r:field>
                        </r:datacell>
            </div>
            <!--</w:panel> searchDataByCityID  -->
           <div  id="div1" style="margin:5px 0px 0px 10px;">
                            <r:datacell 
                            queryAction="/FAERP/SecurityproductitemAction.do?cmd=searchRelDataBySecurityProductID&security_product_id=${param.security_product_id}"
                            submitAction="/FAERP/SecurityproductitemAction.do?cmd=saveRelDataBySecurityProductID&security_product_id=${param.security_product_id}"
                            id="datacell2"
                            paramFormId="datacell_formid" 
                            width="98%" height="190px" 
                            xpath="SecuritygrouprelVo"
                            >
                          <r:toolbar location="bottom" tools="nav,edit:add del reload,pagesize,info"/>
                          <r:field fieldName="security_group_id" label="所属社保组" width="200px">
                          <r:comboSelect id="service_List" name="service_id"
		                       queryAction="/FAERP/SecurityproductitemAction.do?cmd=searchDataByCityID&city_id=${param.city_id}"
		                       valueField="id"
		                       textField="group_name"
		                       xpath="SecuritygroupVo"
		                       width="200px"
		                       nullText="请选择"  validateAttr="allowNull=false"/>
                          </r:field>
                        </r:datacell>
            </div>
            <div class="mx_button" style="text-align: center;padding-top:5px;">
        <input type="button" class="icon_2" value='保存' onClick="javascript:save_onClick();" />
        <input type="button" class="icon_2" value='关闭'  onClick="javascript:window.close();"/>
        </div>
</div>     
  </div>

</form>
</body>
</html>
