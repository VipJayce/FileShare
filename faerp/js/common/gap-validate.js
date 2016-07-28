
var ConfigValidateInfoType = "writeAlert";  //支持writeAlert和writePage,"writePage;writeAlert"

var rmTempStatusIsAlert = false;

var rmTempStatusIsFocus = false;

var beginValidate = true;

var set_All_Venus_Inputs_Default = true;

function checkAllForms() {

	var checkResult = true;
	
	rmTempStatusIsAlert = false;
	rmTempStatusIsFocus = false;
	
	setAllVenusInputsDefault();

	for (var i=0;i<document.forms.length;i++) {
		for (var j=0;j<document.forms[i].elements.length;j++) {
			var thisInput = document.forms[i].elements[j];
			if ( thisInput.type!="hidden" && thisInput.type!="button" && !( thisInput.id.indexOf("TF_")>=0 && thisInput.id.indexOf("_TF")>0 ) ){
				/*
				if(validateStr != null && validateStr.length > 0 ){
					if(thisInput.tagName == 'TEXTAREA' && srcstr != '') {
						srcstr = replaceEnter(srcstr);
						if( thisInput.maxLength != null && thisInput.maxLength > 0 ){
							if (getStrLength(srcstr) > thisInput.maxLength){
								writeValidateInfo(thisInput, "焦点处输入长度超长\n请确保输入长度在" +frm.maxLength+"以内");
								return false;
							}
						}
					}
				}
				*/
				var rtValue = check(thisInput);
				if(checkResult && rtValue == false) {
					checkResult = false;
				}
			}
		}
	}
	return checkResult;
}

function check(thisInput) {

	var validateStr = thisInput.getAttribute("validate");
	if(validateStr == null) {
		return true;
	}
	var inputValue = thisInput.value;
	if ( beginValidate ) {
		var validateTemp = new Array();	
		validateTemp = validateStr.split(';');
		for (var i=0;i<validateTemp.length;i++) {
			if(validateTemp[i].length == 0) {
				continue;
			}
			s = replaceSingleQuote(inputValue);
			try{
				var scriptCode = "javascript:" + validateTemp[i];  //"javascript:" + validateTemp[i] + "('" + s + "', " + "thisInput)"
				if(validateTemp[i].indexOf("(") < 0 || validateTemp[i].indexOf(")") < 0) {
					scriptCode = "javascript:" + validateTemp[i] + "(s,thisInput)"
				}
				if (!eval(scriptCode)) {  
					return false;
				}
			} catch(e) {
				alert(i18n.check_function_exception(validateTemp[i]) + e.message );
				return false;
			}
		}
	}
	return true;
}

function setAllVenusInputsDefault() {
	var frmslen = document.forms.length;
   	for (var i=0;i<frmslen;i++) {
		var inslen = document.forms[i].elements.length;		
		for (var j=0;j<inslen;j++) {
			var frm = document.forms[i].elements[j]
			if ( frm.type!="hidden" && frm.type!="button" && !( frm.id.indexOf("TF_")>=0 && frm.id.indexOf("_TF")>0 ) ){
				if(frm.validate != null) {
					setVenusInputDefault(frm);
					writeValidateInfoAfterObject("", frm);
				}
			}
		}
	}
	return true;
}

function setVenusInputDefault(_frm) {
	_frm.style.borderStyle="";
	_frm.style.borderColor="";
	if( _frm.value != null ){
		_frm.style.backgroundColor = "";
		_frm.style.color = "";
	}
}


function replaceEnter(_str) {
	/**替换换行回车字符**/
	var str = _str;

	str = str.replace('\n','')
	str = str.replace('\r','')
	
	//alert(str.indexOf('\n'))
	
	if(str.indexOf('\n')!=-1 &&str.indexOf('\r')!=-1) {	
		return replaceEnter(str);
	} else {
		return str;
	}
}

function replaceSingleQuote(_str) {
	/**替换换行回车字符**/
	var str = _str;
	str = str.replace('\\','\\u005C');
	str = str.replace('\'','\\u0027');	
	str = str.replace('(','\\u0028');
	str = str.replace(')','\\u0029');
	str = str.replace('\"','\\u0022');
	str = str.replace(';','\\u0038');

	str = Jtrim(str);

	return str;
}

function isContains(_validateStr,_validator) {
	for (var i=0;i<_validateStr.length;i++)
	{
		if(_validateStr[i] == _validator)
			return true;
	}
	
	return false;
}

function writeValidateInfo(info, thisObj) {
    var inputName = jQuery(thisObj).attr("inputName");
    inputName = inputName ? inputName :  jQuery(thisObj).attr("name");//如果控件沒有inputName屬性，則使用name屬性
	info = inputName +" " + i18n.input_is_wrong + info;
	if(ConfigValidateInfoType.indexOf("writePage") >= 0) {
		writeValidateInfoAfterObject(info, thisObj);
	}
	if(ConfigValidateInfoType.indexOf("writeAlert") >= 0) {
		writeValidateInfoAlert(info, thisObj);
	}
	if(!rmTempStatusIsFocus) {
		setVenusInputError(thisObj);
		rmTempStatusIsFocus = true;
	}
}

function setVenusInputError(_frm) {
	try {
		//_frm.click();  // click会导致文件上传错误
		_frm.focus();
		//_frm.select();
		_frm.style.borderStyle="dashed";
		_frm.style.borderColor="rgb(255,50,0)";
		if( _frm.value != null && _frm.value.length > 0 ){
			_frm.style.backgroundColor = "highlight";
			_frm.style.color = "white";
		} 
	} catch(e) {
		alert(e.message);
	}
}

function writeValidateInfoAlert(info, thisObj) {
	if(!rmTempStatusIsAlert) {
		alert(info);
		rmTempStatusIsAlert = true;
	}
}

function writeValidateInfoAfterObject(info, thisObj) {  //写校验信息
	var validateInfoObj = null;
	thisObj = getValidatePosition(thisObj);
	
	if(jQuery("#charaterLimitSpan").size()==0)
	   jQuery(thisObj).after("<font></font><span id='charaterLimitSpan' class=font_remain_prompt></span>");
	validateInfoObj = jQuery("#charaterLimitSpan")[0];
	if(validateInfoObj.innerHTML.length > 0 || info.length > 0) {
		validateInfoObj.innerHTML = info;
	}
}

function getValidatePosition(thisObj) {
	if(thisObj.nextSibling != null && thisObj.nextSibling.className == "refButtonClass") {
		thisObj = getValidatePosition(thisObj.nextSibling);
	} else if(thisObj.nextSibling != null && thisObj.nextSibling.type == "hidden"){
		thisObj = getValidatePosition(thisObj.nextSibling);
	}
	return thisObj;
}

function getInputNameFromObject(thisInput) {
	var inputName = thisInput.inputName ;
	if ( inputName == null || inputName.length == 0 ){
		inputName = thisInput.name;
		if ( inputName == null || inputName.length == 0 ){
			inputName = "";
		}
	}
	return inputName;
}

function getStrLength(str){
	var len = 0;
	for(var i=0;i<str.length;i++){
		if (str.charCodeAt(i) > 255)
			len += 2;
		else
			len ++;
	}
	return len;
}

/**********************************************************************
*ranmin validate
***********************************************************************/
function notNull(s, thisInput) {  //不能为空
	if ( s.length == 0){
		writeValidateInfo(i18n.can_not_be_blank_or_spaces, thisInput);
		return false;
	}  
	var s = Jtrim(s);	 
	if ( s.length == 0){
		writeValidateInfo(i18n.can_not_be_blank_or_spaces, thisInput);
		return false;
	}  
	return true;
}

function isMobile(s, thisInput) {  //是手机号码：必须以数字开头，除数字外，可含有“-” 

	if(s.length ==0 ) {
		return true;
	}
	
	var patrn=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/; 
	
	if (!patrn.exec(s)) {
		writeValidateInfo(i18n.please_enter_valid_mobile_phone_number, thisInput);
		return false;
	}		
	return true;
}

function isPostalCode(s, thisInput) {  //是邮政编码
	if(s.length ==0 ) 
		return true;
	var patrn=/^[a-zA-Z0-9 ]{3,12}$/; 
	if (!patrn.exec(s)) {
		writeValidateInfo(i18n.please_enter_the_correct_zip_code, thisInput);
		return false;
	}
	return true;
} 


function isTel(s,thisInput) {  //是电话普通电话、传真号码：可以“+”开头，除数字外，可含有“-” 

	if(s.length ==0 ) 
		return true;
	var patrn=/^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/; 
	if (!patrn.exec(s)) {
		writeValidateInfo(i18n.please_enter_valid_phone_number,thisInput);
		return false
	} 
	return true;
}

function isChinese(s,thisInput) {  //是中文

	if(s.length ==0 ) 
		return true;
	var ret = ischinese(s);
	
	if(!ret){
		writeValidateInfo(i18n.please_enter_chinese, thisInput);
		return ret;
	}
	return ret;
}

function notChinese(s,thisInput) {  //不含中文

	if(s.length ==0 ) 
		return true;
	var ret = ischinese(s);
	
	if(ret){
		writeValidateInfo(i18n.can_not_input_chinese,thisInput);
		return false;
	}
	return true;
}

function isNum(s,thisInput) {  //是数字 
	var digits = "0123456789";
	var i = 0;
	var sLength = s.length;

	while ((i < sLength)) {
		var c = s.charAt(i);
		if (digits.indexOf(c) == -1){
			
			writeValidateInfo (i18n.please_enter_the_numbers,thisInput);		
			return false;
		}
		i++;
	}
	return true;
}

function isEmail(s,thisInput) {  //是电子邮件

	if(s.length ==0 ) 
		return true;	

	if (s.length > 100)	{
		writeValidateInfo(i18n.please_enter_valid_email_address,thisInput);
       	return false;
	}

	var regu = /^(([0-9a-zA-Z]+)|([0-9a-zA-Z]+[_.0-9a-zA-Z-]*[0-9a-zA-Z]+))@([a-zA-Z0-9-]+[.])+([a-zA-Z]{2}|net|NET|com|COM|gov|GOV|mil|MIL|org|ORG|edu|EDU|int|INT)$/;

	if (regu.exec(s)) {		
		return true;
	} else {
		writeValidateInfo (i18n.please_enter_valid_email_address,thisInput);
		return false;
	}
}

function isIP() {  //是IP
		
	var patrn=/^[0-9.]{1,20}$/; 
	if (!patrn.exec(s)){
		writeValidateInfo(i18n.please_enter_ip_address,thisInput);
		return false
	}  
	return true;
}


/**********************************************************************
*Venus Web JavaScript Code:HTC 校验notNull
***********************************************************************/
function notNullWithoutTrim(s,thisInput) {  //是""
	if ( s.length == 0){
		writeValidateInfo(i18n.can_not_be_blank_or_spaces,thisInput);
		return false;
	}  
	return true;
}

function isInteger(str,thisInput) {  //是整数
	if(str.length ==0 ) 
		return true;
	
	var reg = "0123456789";
	for (var i=0;i<str.length;i++){
		var m = str.charAt(i);
		if (reg.indexOf(m) == -1) {
			writeValidateInfo(i18n.please_enter_integer,thisInput);
			return false;
		}
	}
	return true;
}
function isNormalStrOnWeb(s,thisInput) {  //是普通字符(非html标记)

	if (s.substring(0,1) == "<" || s.substring(0,1) == "\>" || s.substring(0,1) == " "){
			writeValidateInfo(i18n.can_not_begining_with_blank,thisInput);
			return false;
	}

	if (!HoldCode(s)){
		writeValidateInfo(i18n.can_not_enter_fullwidth_character,thisInput);
		return false;
	}
	if (s.length > 0){
		if (s.indexOf("\"") > -1){
			writeValidateInfo(i18n.can_not_enter_double_quotes,thisInput);
			return false;
		}
		if (s.indexOf("\'") > -1){
			writeValidateInfo(i18n.can_not_enter_single_quotes,thisInput);
			return false;
		}
		if (s.indexOf("\\") > -1){
			writeValidateInfo(i18n.can_not_enter,thisInput);
			return false;
		}
	}
	return true;
}




//基本函数列表
function Jtrim(str) {  //去空隔函数
	var i = 0;
	var len = str.length;
	if ( str == "" ) return( str );
	var j = len -1;
	var flagbegin = true;
	var flagend = true;
	while ( flagbegin == true && i< len) {
		if ( str.charAt(i) == " " ) {
			i=i+1;
			flagbegin=true;
		} else {
			flagbegin=false;
		}
	}

	while  (flagend== true && j>=0)	{
		if (str.charAt(j)==" ")	{
			j=j-1;
			flagend=true;
		} else {
			flagend=false;
		}
	}

	if ( i > j ) 
		return ("");

	var trimstr = str.substring(i,j+1);
	return trimstr;
}

function isNumber(s) {  //数字判断函数
	var digits = "0123456789";
	var i = 0;
	var sLength = s.length;

	while ((i < sLength)) {
		var c = s.charAt(i);
		if (digits.indexOf(c) == -1) {
			return false;		
		}
		i++;
	}
	return true;
}

function ischinese(s) {  //判断是否中文函数
	var ret=true;
	for(var i=0;i<s.length;i++)
		ret=ret && (s.charCodeAt(i)>=10000);
	return ret;
}

/**********************************************************************
*Venus Web JavaScript Code:HTC 表单通用检验(完善中)
***********************************************************************/
function HoldCode(str){
	for(var i=0;i<str.length;i++){
		if (str.charCodeAt(i) == 8212 || str.charCodeAt(i) == 183){
			return false;
		}
	}
	return true;
}


function validateForm(current_form) {
	for (var i=0;i<current_form.length;i++){
		if (current_form[i].type =="text" || current_form[i].type == "radio"){
			if (current_form[i].value.substring(0,1) == "<" || current_form[i].value.substring(0,1) == "\>" || current_form[i].value.substring(0,1) == " "){
					alert(i18n.can_not_begining_with_blank);
					current_form[i].focus();
					current_form[i].select();
					return false;
			}

			if (getStrLength(current_form[i].value) > current_form[i].maxLength){
					alert(i18n.input_too_long(current_form[i].maxLength));
					current_form[i].focus();
					current_form[i].select();
					return false;
			}
			if (!HoldCode(current_form[i].value)){
				alert(i18n.can_not_enter_fullwidth_character);
				current_form[i].focus();
				current_form[i].select();
				return false;
			}
			if (!is_empty(current_form[i].value)){
				if (current_form[i].name == "scriptDefine"){
					return true;
				}
				if (current_form[i].value.indexOf("\"") > -1){
					alert(i18n.can_not_enter_double_quotes);
					current_form[i].focus();
					current_form[i].select();
					return false;
				}
			}
		}
	}
	return true;
}

	
function checkNumber(s, inputName) {
	var thisObj = event.srcElement;
	var maxLength = thisObj.integerDigits;
	var scale = thisObj.decimalDigits;
	return checkNumberImpl(s, maxLength, scale);
}

function checkNumberImpl(s, maxLength, scale) {  //校验运行里程,小数,整数部分最多为10-2
	if(s == "") {
		return true;
	}
	if(scale == undefined) {
		scale = 0;
	}
	if(maxLength == undefined) {
		maxLength = 38;
	}
	if(!isFloatNumber(s)) {
		return false;
	}
	if(s.indexOf(".") >0) {
		if(s.indexOf(".") <= maxLength && (Math.round(s*(pow(10,scale)))<(pow(10,(maxLength + scale))))) {
			return true;
		} else {
			alert(i18n.integral_part_of_a_maximum(maxLength - scale));
			return false;
		}
	} else {
		if(s.length <= maxLength) {
			return true;
		} else {
			alert(i18n.integral_part_of_a_maximum(maxLength));
			return false;
		}
	}
}

function isFloatNumber(s,inputName) {  //判断是否
	var digits = "0123456789.";
	var i = 0;
	var sLength = s.length;

	while ((i < sLength)) {
		var c = s.charAt(i);
		if (digits.indexOf(c) == -1){
			writeValidateInfo(i18n.please_enter_the_numbers, inputName);		
			return false;
		}
		i++;
	}
	if(s.indexOf(".") != s.lastIndexOf(".")) {
		alert(i18n.decimal_point_error_enter_number);
		return false;
	} else {
		return true;
	}
}

function isSearch(s,thisInput) {  //不能输入非法字符
	if(s.length == 0 ) 
		return true;
	var patrn=/^[^`~!@#$%^&*()+=|\\\][\]\{\}:;'\,.<>/?]{1}[^`~!@$%^&()+=|\\\][\]\{\}:;'\,.<>?]{0,19}$/; 
	var patrn2 = /[^\{\|\.\\,<>"'_}/]/;
	if (!patrn.exec(s) || !patrn2.exec(s)){
		writeValidateInfo(i18n.please_enter_valid_characters,thisInput);
		return false;	
	}
	return true ;
}


//===============================================================================================
/**
 * 验证数字(正整数或者包含小数的数字).
 */
function isNumeric(value, thisInput) {
 	var reg = /^\d+(\.\d+)?$/;

	if (!reg.test(value)) {			
		writeValidateInfo (i18n.please_enter_positive_integer_or_decimal, thisInput);
		return false;
	}

	return true;
}

/**
 * 验证数字(整数位最大为10位,可以带小数)
 */
function validateNumericAndLength(value, thisInput) {
 	var reg = /^\d{1,10}(\.\d+)?$/;

	if (!reg.test(value)) {			
		writeValidateInfo (i18n.please_enter_positive_integer_or_decimal_10_max, thisInput);		
		return false;
	}

	return true;
}

/**
 * 验证Email.
 */
function checkEmail(value, thisInput) {
	var reg  = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;

	if (!reg.test(value)) {
		writeValidateInfo (i18n.please_enter_valid_email_address, thisInput);
		return false;
	}

	return true;
}

/**
 * 验证身份证(15位或者18位身份证).
 */
function checkIdCard(value, thisInput) {
	var reg  = /^\d{15}(\d{2}[A-Za-z0-9])?$/;

	if (!reg.test(value)) {
		writeValidateInfo (i18n.please_enter_valid_identity_card_number, thisInput);
		return false;
	}

	return true;
}

/**
 * 验证邮政编码.
 */
function checkPostCode(value, thisInput) {
	var reg  = /^[1-9]\d{5}$/;

	if (!reg.test(value)) {
		writeValidateInfo (i18n.please_enter_the_correct_zip_code, thisInput);
		return false;
	}

	return true;
}

/**
 * 验证是否为中文字符.
 */
function checkChinese(value, thisInput) {
	var reg  = /^[\u0391-\uFFE5]+$/;

	if (!reg.test(value)) {
		writeValidateInfo (i18n.please_enter_chinese, thisInput);
		return false;
	}

	return true;
}

/**
 * 验证是否为非法字符.
 */
function checkInvalidString(value, thisInput) {
    var reg  = /^[^`~!@#$%^&*()+=|\\\][\]\{\}:;'\,.<>/?]*$/;

    if (!reg.exec(value)) {
        writeValidateInfo (i18n.please_enter_valid_characters, thisInput);
        return false;
    }

    return true;
}
/**
*验证货币类型
*/
function   checkCurrency(val,thisInput) 
{ 
var   cash   =   val.replace(",",""); 
var   reg   =   /(^\d+$)|(^\d+.\d+$)/g 
/*var reg = /^[0-9]{1,3}(,[0-9]{3})*(\.[0-9]{1,2})?$/*/

    if (!reg.test(cash)) {         
        writeValidateInfo (i18n.please_enter_valid_Currency_characters, thisInput);
        return false;
    }
    return true;
}

/**
 * 校验day为1--31 
*/

function isValidDay(val,thisInput){
	if(val.length ==0 ) 
        return true;
    if(!isNumber(val)||val.length>2){
    	writeValidateInfo (i18n.please_enter_valid, thisInput);
        return false;
    }
    day   = parseInt(val,10);
    if ( day < 1 || day > 30 ){
        writeValidateInfo (i18n.please_enter_valid, thisInput);
        return false;
     }
     return true;
}


