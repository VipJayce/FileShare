jQuery(document).ready(function(){
		//查找编辑视图元素的必填项并渲染
		jQuery("[viewType=editView]").find("td:has(*[validate*=notNull])").prev().each(function(){
			if(jQuery(this).find("div").size()>0){
				jQuery(this).find("div").prepend("<span class='style_required_red'>* </span>");
			}else{
				jQuery(this).prepend("<span class='style_required_red'>* </span>");
			}
		});
		//jQuery("[viewType=editView]").find("td:has(select[validate*=notNull])").prev().prepend("<span class='style_required_red'>* </span>");
		//查找列表视图元素的必填项并渲染
		//alert(jQuery("#ORDERLIST td:has(input[validate*=notNull])").size());
		jQuery("[viewType=tableView] table").find("th[validate*=notNull]").prepend("*");
		//jQuery("[viewType=tableView] table").find("td:has(input[validate*=notNull][class*=text_field_reference]) div").prepend("*");
		//jQuery("[viewType=tableView] table").find("input[validate*=notNull][class*=text_field_reference]").parent("div").prepend("*");
		//jQuery("[viewType=tableView] table").find("input[validate*=notNull]").not("[class*=text_field_reference]").parent("td").prepend("*");
		//jQuery("[viewType=tableView] table").find("td:has(select[validate*=notNull])").prepend("<span class='style_required_red'>* </span>");
		//alert(dwr.util.toDescriptiveString(jQuery(".img_1").prev().prev().attr("class"), 2))
		//jQuery(".img_1").prev().prev().attr('readOnly',true);
});

function isInteger(str,thisInput) {  //整数判断函数
	if(str.length==0)
		return true;
	var reg = /^[-\+]?\d+$/;
	if (!reg.test(str)) {
		writeValidateInfo(i18n_dd.enter_integer,thisInput);
		return false;
	} else {
		return true;
	}
}


function isDouble(str,thisInput) {// 浮点数判断函数
	if(str.length==0)
		return true;
	var reg = /^[-\+]?\d+\.\d{2}$/;
	if (!reg.test(str)) {
		writeValidateInfo(i18n_dd.enter_float(2),thisInput);
		return false;
	} else {
		return true;
	}
}
function isAmt(str,thisInput) {//金额判断函数
	if(str.length==0)
		return true;
	var reg = /^[-\+]?\d+\.\d{2}$/;
	if (!reg.test(str)) {
		writeValidateInfo(i18n_dd.enter_money(2),thisInput);
		return false;
	} else {
		return true;
	}
}

function uploadFile(name,filePath) {//到增加记录页面
         var obj = window.showModalDialog(webPath+'/jsp/common/uploadfile/fileframe.jsp?filePath='+filePath,'','dialogHeight:130px;dialogWidth:450px;center:yes;help:no;resizable:yes;scroll:yes;status:no;');
         if(obj) {
			jQuery("input[name="+name+"]").val(obj[2]);
			jQuery("input[name=refrence_"+name+"]").val(obj[0]);
			jQuery("div[name=link_"+name+"]").html("<a target='_self' href='"+webPath+"/jsp/common/downloadfile/downloadfile.jsp?fileName="+obj[0]+"&fileUrl="+obj[2]+"'style='text-decoration:underline'>"+obj[0]+"</a>");
         }
         return;
}



function testFunc(str,thisInput)
{
	alert(str);
}



