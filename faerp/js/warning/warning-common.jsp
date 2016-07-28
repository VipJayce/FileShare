 <%@ page contentType="text/html; charset=UTF-8" %>
 <%@page import="gap.warning.util.WarningConstants"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
  <fmt:bundle basename="gap.warningsystem.warningsystem_resource" prefix="gap.warningsystem.">
 /*
    此js文件中的所有方法都是为预警平台中相关新增和修改页面服务的，预警平台页面中大量使用这些方法，
    为了便于统一修改，特抽取在一起。
 */

 
  /*根据预警对象的返回值类型确定操作符的option
    此方法在点击参照页面的"确定"按钮时会被回调。
    */
    function setOperators(returnType){
        jQuery('#returnType').val(returnType);
        setThesholdType();
        WarningAjax.getOperators(returnType,setSelectHtml);
    }
    function setSelectHtml(data){//新增时候设置可以的比较符
        jQuery('#operator').empty();
        jQuery('#div2').remove();
        jQuery('#threshold1').val("");
        DWRUtil.addOptions('operator',data);
    }
    function setNotifyType(){
        var checkedNotify = jQuery(":checked[name='notifyTypeTemp']");
        if(checkedNotify.size()==0){
            alert(i18n4WarningSystem.please_select_a_notify_type);
            return false;
         } else{
            var notifyValue = "";
            checkedNotify.each(function(){
                notifyValue = notifyValue + jQuery(this).val() + "<%=WarningConstants.WARNING_SEPARATOR %>";
            });
            notifyValue = notifyValue.substring(0,(notifyValue.length-1));
            jQuery("input[name='notifyType']").val(notifyValue);
            return true;
         }
    }
    function setTheshold(){
        if(jQuery('#threshold2').size()>0){
            var upperLimit = jQuery('#threshold2').val();
            var lowerLimit = jQuery('#threshold1').val();
            var reg1 = new RegExp("-");
            if(!reg1.test(upperLimit)&&!reg1.test(lowerLimit)){//如果阀值不包含“-”，则按数字或小数比较
                if(!isNaN(parseInt(upperLimit))&&!isNaN(parseInt(lowerLimit))){//整数比较
                    upperLimit = parseInt(upperLimit);
                    lowerLimit = parseInt(lowerLimit);
                }
                 if(!isNaN(parseFloat(upperLimit))&&!isNaN(parseFloat(lowerLimit))){//小数比较
                    upperLimit = parseFloat(upperLimit);
                    lowerLimit = parseFloat(lowerLimit);
                }
                if(lowerLimit>=upperLimit){
                    alert(i18n4WarningSystem.upper_limit_threshold_must_be_greater_than_the_lower_limit);
                    return false;
                }
            }else{//如果阀值为日期，则...
               var compareCount = upperLimit.localeCompare(lowerLimit);
               if(compareCount<=0){
                   alert(i18n4WarningSystem.upper_limit_threshold_must_be_greater_than_the_lower_limit);
                    return false;
                }
            }
            jQuery('#threshold').val( jQuery('#threshold1').val()+"<%=WarningConstants.WARNING_SEPARATOR %>"+ jQuery('#threshold2').val());  
         }else{
            jQuery('#threshold').val( jQuery('#threshold1').val());
          }
          return true;
    }
    function setThesholdType(){//当返回值类型为日期型时，需设置日期控件，多出地方需要调用此方法
        jQuery('img[name="img_date"]').remove();
        var inputs =  jQuery('input[type="text"]',jQuery('#thresholdTr'));
        inputs.css('visibility','visible').removeAttr('readonly').removeClass('text_field_reference').addClass('text_field');
        if(jQuery("#returnType").val()=='<%=WarningConstants.INTEGER_TYPE%>'){//整型
            inputs.removeAttr('validate').attr('validate','notNull;isInteger');
        }else if(jQuery("#returnType").val()=='<%=WarningConstants.STRING_TYPE%>'){//字符型
            inputs.removeAttr('validate').attr('validate','notNull;checkInvalidString');
        }else if(jQuery("#returnType").val()=='<%=WarningConstants.BIGDECIMAL_TYPE%>'){//小数型
            
            inputs.removeAttr('validate').attr('validate','notNull;isNumeric');
        }else if(jQuery("#returnType").val()=='<%=WarningConstants.DATE_TYPE %>'){//日期型
            jQuery('#threshold1').attr('readOnly','true').removeClass('text_field').addClass('text_field_reference')
                        .after('<img src="'+contextpath+'/images/icon/reference.gif" name="img_date" onClick="javascript:getYearMonthDayHourMinuteSecond('+"'threshold1'"+','+contextpath+'/)" class="img_1">');
            jQuery('#threshold2').attr('readOnly','true').removeClass('text_field').addClass('text_field_reference')
                        .after('<img src="'+contextpath+'/images/icon/reference.gif" name="img_date" onClick="javascript:getYearMonthDayHourMinuteSecond('+"'threshold2'"+','+contextpath+'/)" class="img_1">');
            inputs.removeAttr('validate').attr('validate','notNull');
        }else if(jQuery("#returnType").val()=='<%=WarningConstants.BOOLEAN_TYPE%>'){//布尔型
            inputs.css('visibility','hidden').removeAttr('validate');
        }
    }
     function changeThreshold(this1){
        setThesholdType();
        if(jQuery(this1).val()=='<%=WarningConstants.BETWEEN %>'){
            if(jQuery('#threshold2').size()==0)
                jQuery("#thresholdTd").append('<div id="div2">～<input name="threshold2"  id="threshold2" type="text" class="text_field temp" inputName="<fmt:message key="jsp.threshold"/>" validate="notNull;isSearch"></div> ');
        }else{
            jQuery('#div2').remove();
        }
        setThesholdType();
    }
    
    function validateIdentifier(){//校验Identifier值是否唯一，参数id是用来判断是新增和修改哪个操作
        //设置成同步        
        DWREngine.setAsync(false);
        var validateIdentifierFlag=false;
        if(jQuery('input[name="identifier"]').val()!=""){
            
            WarningAjax.validateIdentifier(jQuery('input[name="id"]').val(),jQuery('input[name="identifier"]').val(),function(data){
                if(data>0){alert(i18n4WarningSystem.identifier_has_been_used);validateIdentifierFlag=false;jQuery('input[name="identifier"]').focus();jQuery('input[name="identifier"]').select();}else{validateIdentifierFlag=true;}
            });
            return validateIdentifierFlag;
        }else{
            alert(i18n4WarningSystem.identifier_is_null);
        }
        //设置成异步       
        DWREngine.setAsync(true);
    }
  </fmt:bundle>