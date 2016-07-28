//层的收缩
function slideUpOrDown(idMap){
	jQuery.each( idMap, function(i, n){
		jQuery("#"+i).toggle(
		  function () {
		    jQuery('#'+n).slideUp('slow');
		  },
		  function () {
		   jQuery('#'+n).slideDown("slow"); 
		  }
		);
	}); 
}

//根据selectid获取双列表的值
function getListBoxBySelectid(selectid){
		var selectVal=new Array();
		jQuery("#"+selectid+" option").each(function(i){
		   selectVal.push(this.value);
		 }); 
		 return selectVal;
}

//根据name获取被选中的复选框的个数（支持单选框）
function getCheckBoxSizeByName(name){
	return (jQuery(":checked[name='"+name+"']")).size();
}
//根据name获取被选中的复选框的值，值之间以","相隔
function getCheckBoxValByName(name){
		var elementCheckbox="";
		jQuery(":checked[name='"+name+"']").each(function(){ elementCheckbox=elementCheckbox+","+jQuery(this).val();});
		elementCheckbox=elementCheckbox.substring(1);
		return elementCheckbox;
}
//根据name获取被选中的单选框的值
function getRadioValByName(name){
	var elementRadio=jQuery(":checked[name='"+name+"']").val();
	return elementRadio;
}
