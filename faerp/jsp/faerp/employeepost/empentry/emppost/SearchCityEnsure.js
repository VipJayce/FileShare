//根据组id判断是否在右上列表中已存在
function findSelection (radioName,id) {  //从radio中找出选中的id值列表
        var elementRadio = document.getElementsByName(radioName);
        var num = 0;
        for(var i=0;i<elementRadio.length;i++){  //循环radio组
                
             if(id==elementRadio[i].value){
                num = 1;
                break;
             }
        }
        return num;
}
    
//yyyy-mm-dd的日期格式字符串比较大小
function dateCompare(a, b) {
    var arr = a.split("-");
    var starttime = new Date(arr[0], arr[1], arr[2]);
    var starttimes = starttime.getTime();

    var arrs = b.split("-");
    var lktime = new Date(arrs[0], arrs[1], arrs[2]);
    var lktimes = lktime.getTime();

    if (starttimes > lktimes) {
        return 1;
    }
    if (starttimes < lktimes) {
        return -1;
    }
    if (starttimes = lktimes) {
        return 0;
    }

}
    
//判断产品checkbox勾选是添加还是删除
function selectTodo(obj){
        if(jQuery(obj).attr("checked")){//选中往母页面插入一条产品
            var group_id = jQuery(obj).parents("tr").find("input[name='group_id']").val();
            AddopenerProduct(jQuery(obj).val(),group_id);
        }else{//勾选去掉，则删除母页面对应的记录
            DelopenerProduct(jQuery(obj).val());
        }
}

//点击左侧radio时，启用快捷设定下拉框
function getShotcutgroup(group_id){
	var tbody = jQuery("#grdGrouptbody");
	var tr = jQuery(tbody).find("input[value='"+group_id+"']").parents("tr");
	var sect = jQuery(tr).find("select[name='select_shortcut']");
	
    //设置其他行下拉框无效，本行启用
    var nTds = jQuery("#grdGrouptbody tr");
    nTds.each(function () {
        var sectntd = jQuery(nTds).find("select[name='select_shortcut']");
        jQuery(sectntd).attr("disabled","disabled");
    });
    jQuery(sect).removeAttr("disabled");
    
	
}

//初始化页面（type=0）和点击左侧列表（type=1）时，ajax加载快捷设定下拉框内容
function getShotcutgroup1(group_id,type){
    var tbody = jQuery("#grdGrouptbody");
    var tr = jQuery(tbody).find("input[value='"+group_id+"']").parents("tr");
    var sect = jQuery(tr).find("select[name='select_shortcut']");
    
    //设置其他行下拉框无效，本行启用
    var nTds = jQuery("#grdGrouptbody tr");
    nTds.each(function () {
        var sectntd = jQuery(nTds).find("select[name='select_shortcut']");
        jQuery(sectntd).attr("disabled","disabled");
    });
    
    //点击左侧列表加载时，需要启用
    if(type=='1'){
        jQuery(sect).removeAttr("disabled");
    }
   
    var myAjax = new Ajax(vpath+"/EmppostAction.do?cmd=getShortcut");
    myAjax.addParam("group_id", group_id);
    myAjax.submit();
    var returnNode = myAjax.getResponseXMLDom();
    var dataset1 = Dataset.create(returnNode ,"root/data/SecuritygroupShortcutVo","dataset1");
    if (dataset1 != null && dataset1.getLength()>0) {
        jQuery(sect).append("<option value=''></option>");
        for(var i=0; i<dataset1.getLength(); i++){
             var shortid = dataset1.get(i).getProperty("id");
             var shortname = dataset1.get(i).getProperty("group_shortcut_name");
             jQuery(sect).append("<option value='"+shortid+"'>"+shortname+"</option>");
             
        }        
    }    
    

    
    
       
}

    
//点击左侧查询出来的组，如该组在列表中已存在，则页面均无变化
//否则右上已选组列表增加一行，其radio为选中状态
//同时右下社保公积金产品列表加入该组的产品，默认所有选中且显示
//同时往母页面的组ul中插入该组记录
//同时往母页面的社保公积金产品列表插入该组的所有产品行
$id("citypro_init").onClickRow  = function(rowTR,rowIndex,entity,datacell){
    var group_id=entity.getProperty("id");//取得组ID
    //2016-04-14如果选择的收费起始日期为2016-04-01以前，则不能选择综保
    var charge_start_date = jQuery("#charge_start_date_hidden", window.opener.document).val();
    if(group_id=='1099110700000000641' && charge_start_date!=null && charge_start_date!='' && dateCompare(charge_start_date,'2016-04-01')>=0){
    	alert('收费起始日期从2016-04-01之后不能选择上海综合！');
    }else{
        //判断组在列表中是否已存在
        if (group_id!=null &&　findSelection("select_group_id",group_id)==0) {
            //获得被点击的组信息
            var city_id=entity.getProperty("city_id");
            var group_name=entity.getProperty("group_name");
            
            var tbody = jQuery("#grdGrouptbody");
            var tbody1 = jQuery("#grdProducttbody");
            
            //1.右上组列表插入行
            jQuery(tbody).find(":radio").attr("checked",false);//清空单选框所选

            var tr = jQuery("<tr></tr>");
            var td0 = jQuery("<td></td>");
            var html = jQuery("<input type='radio' checked name='select_group_id' value='' />");
            jQuery(html).attr("value",group_id);
            //jQuery(html).attr("onclick", "GetCityProduct();");
            jQuery(td0).append(html);
            jQuery(tr).append(td0);

            var td1 = jQuery("<td></td>");
            jQuery(td1).append(city_id);
            jQuery(tr).append(td1);

            var td2 = jQuery("<td></td>");
            jQuery(td2).append(group_name);
            jQuery(tr).append(td2);
            
            var td3 = jQuery("<td></td>");
            //var html1 = jQuery("<r:comboSelect id='combo_shortcut' name='select_shortcut' queryAction='EmppostAction.do?cmd=getShortcut&group_id='"+group_id+"' textField='group_shortcut_name' valueField='id' xpath='SecuritygroupShortcutVo' width='200px' nullText='请选择' />");
            var html1 = jQuery("<select name='select_shortcut'></select>");
            jQuery(td3).append(html1);
            jQuery(tr).append(td3);
            
            jQuery(tbody).append(tr);
            
            getShotcutgroup1(group_id,'1');
            
            //2.右下社保产品列表插入所有行，使用ajax查询组对应的产品信息
            jQuery("#grdProducttbody tr").hide();
            jQuery.getJSON(vpath+"/EmppostAction.do?cmd=searchProductByGroup&date="+new Date()+"",{"group_id":group_id},  function(json){
                 for(var i = 0; i < json.saia.length; i++){
                 	var isondate=json.saia[i].isondate;//该产品比例是否当前时间有效
                 	var ck='';
                 	if(isondate!=null && isondate!=''){
                 		ck="checked";
                 	}
                    tr = jQuery("<tr></tr>");
                    jQuery(tr).attr("style","display:table-row");
                    td0 = jQuery("<td></td>");
                    html = jQuery("<input type='checkbox' "+ck+" name='security_product_id' value=''>");
                    jQuery(html).attr("value",json.saia[i].id);
                    //jQuery(html).attr("onclick", "selectTodo(this);");
                    jQuery(td0).append(html);
                    var html1 = jQuery("<input type='hidden' name='group_id' value=''>");
                    jQuery(html1).attr("value",json.saia[i].group_id);
                    jQuery(td0).append(html1);
                    var html2 = jQuery("<input type='hidden' name='product_id' value='' />");
                    jQuery(html2).attr("value",json.saia[i].product_id);
                    jQuery(td0).append(html2);
                    jQuery(tr).append(td0);
        
                    td1 = jQuery("<td></td>");
                    jQuery(td1).append(json.saia[i].product_name);
                    jQuery(tr).append(td1);
        
                    jQuery(tbody1).append(tr);
                    
                    //3.回设母页面社保公积金产品列表，添加该组的产品进去
                    if(isondate!=null && isondate!=''){
                        AddopenerProduct(json.saia[i].id,json.saia[i].group_id);
                    }
                }
            }); 
            
            //4.回设母页面社保公积金组div
            window.opener.jQuery("#selectgroups").append("<div style=\"display:inline\" id=\""+group_id+"\" align=\"left\"><input type=\"hidden\" name=\"select_group_id\" value=\""+group_id+"\">"
                            +"<input type=\"hidden\" name=\"select_city_id\" value=\""+city_id+"\">"
                            +"<input type=\"hidden\" name=\"select_group_name\" value=\""+group_name+"\">"
                            +group_name+"</div>");
            
            
            //var ttbody = window.opener.document.getElementById("selectgroups");
            //var div = jQuery("<div></div>");
            //jQuery(div).attr("id",group_id);
            //var htmldiv = jQuery("<input type=\"hidden\" name=\"select_group_id\" value=\""+group_id+"\">"
            //                +"<input type=\"hidden\" name=\"select_city_id\" value=\""+city_id+"\">"
            //                +"<input type=\"hidden\" name=\"select_group_name\" value=\""+group_name+"\">"
            //                +group_name);
            //jQuery(div).append(htmldiv);
            //jQuery(ttbody).append(div);
            
            //var cellnum = ttbody.cells.length;
            //var newtd = ttbody.insertCell(cellnum);
            //newtd.setAttribute("id",group_id);
            //newtd.innerHTML="<input type=\"hidden\" name=\"select_group_id\" value=\""+group_id+"\">"
            //                +"<input type=\"hidden\" name=\"select_city_id\" value=\""+city_id+"\">"
            //               +"<input type=\"hidden\" name=\"select_group_name\" value=\""+group_name+"\">"
            //                +group_name;
            
        }
} 
} 

//点击已选社保公积金组的radio,ajax查询该组对应的所有产品
//循环所有产品，循环列表中已有产品，发现有缺失的产品，则append进去，且设为未勾选
//其他的已有产品display显示即可
GetCityProduct = function () {
        var group_id = jQuery("input[name='select_group_id']:checked").val();
        var tbody = jQuery("#grdProducttbody");
        getShotcutgroup(group_id);//把改行的快捷设定下拉框启用
        
        var gtbody = jQuery("#grdGrouptbody");
        var tr = jQuery(gtbody).find("input[value='"+group_id+"']").parents("tr");
        var shotcut_group_id = jQuery(tr).find("select[name='select_shortcut']").val();
        //快捷设定已有选定非空值时
        if(shotcut_group_id!=null && shotcut_group_id!=''){
        	changeProduct();
        }else{//切换到别的社保组，加载产品列表
            //所有的全部隐藏
            jQuery("#grdProducttbody tr").hide();
            jQuery.getJSON(vpath+"/EmppostAction.do?cmd=searchProductByGroup&date="+new Date()+"",{"group_id":group_id},  function(json){
                 for(var i = 0; i < json.saia.length; i++){
                    //循环右下列表中已存在的对应该组的产品行
                    var nTds = jQuery("#grdProducttbody tr");
                    var isexist=0;
                    nTds.each(function () {
                        var security_id = jQuery(this).find("td :checkbox").val();//取得社保产品ID
                        var product_id = jQuery(this).find("input[name='product_id']").val();
                        var bd_group_id = jQuery(this).find("input[name='group_id']").val();
                        if(security_id==json.saia[i].id){//相同社保产品已存在，或者产品ID一致的不同社保产品已存在
                            //把该tr显示
                            jQuery(this).show();
                            isexist = 1;
                        }else if(bd_group_id==json.saia[i].group_id &&　product_id==json.saia[i].product_id　){
                            //把该tr显示
                            jQuery(this).show();
                            isexist = 1;
                        }
                    });
                    
                    if(isexist==0){//不存在的情况
                        var tr = jQuery("<tr></tr>");
                        jQuery(tr).attr("style","display:table-row");
                        var td0 = jQuery("<td></td>");
                        var html = jQuery("<input type='checkbox' name='security_product_id' value=''>");
                        jQuery(html).attr("value",json.saia[i].id);
                        jQuery(td0).append(html);
                        var html1 = jQuery("<input type='hidden' name='group_id' value=''>");
                        jQuery(html1).attr("value",json.saia[i].group_id);
                        jQuery(td0).append(html1);
                        var html2 = jQuery("<input type='hidden' name='product_id' value='' />");
                        jQuery(html2).attr("value",json.saia[i].product_id);
                        jQuery(td0).append(html2);
                        jQuery(tr).append(td0);
            
                        var td1 = jQuery("<td></td>");
                        jQuery(td1).append(json.saia[i].product_name);
                        jQuery(tr).append(td1);
            
                        jQuery(tbody).append(tr);
                        
                    }
                
                }
            }); 
        }
    
}

//快捷设定下拉框二级组有变化时
changeProduct = function () {
	var group_id = jQuery("input[name='select_group_id']:checked").val();
	
	var gtbody = jQuery("#grdGrouptbody");
	var tbody = jQuery("#grdProducttbody");
	
	var tr = jQuery(gtbody).find("input[value='"+group_id+"']").parents("tr");
	var shotcut_group_id = jQuery(tr).find("select[name='select_shortcut']").val();
	
	jQuery("#grdProducttbody tr").hide();
	
    //1.右下页面，把该社保组对应的产品的删除
    var nTds = jQuery("#grdProducttbody tr");
    nTds.each(function () {
        var bd_group_id = jQuery(this).find("input[name='group_id']").val();
        if(group_id==bd_group_id){
        	jQuery(this).remove();
        	
        	//2.把母页面对应该组的所有产品移除
        	DelopeneGroup(group_id);
        }
    });
    
    //3.右下页面，把该社保组下，选中的快捷设定二级组旗下的产品加入，并打勾(如果选的是空，则把非快捷设定的产品加入)
    jQuery.getJSON(vpath+"/EmppostAction.do?cmd=searchProductByshotCutGroup&date="+new Date()+"",{"shotcut_group_id":shotcut_group_id,"group_id":group_id},  function(json){
         for(var i = 0; i < json.saia.length; i++){
                
     	        var isondate=json.saia[i].isondate;//该产品比例是否当前时间有效
                var ck='';
                if(isondate!=null && isondate!=''){
                    ck="checked";
                }
                var tr = jQuery("<tr></tr>");
                jQuery(tr).attr("style","display:table-row");
                var td0 = jQuery("<td></td>");
                var html = jQuery("<input type='checkbox' "+ck+" name='security_product_id' value=''>");
                jQuery(html).attr("value",json.saia[i].id);
                jQuery(td0).append(html);
                var html1 = jQuery("<input type='hidden' name='group_id' value=''>");
                jQuery(html1).attr("value",json.saia[i].group_id);
                jQuery(td0).append(html1);
                var html2 = jQuery("<input type='hidden' name='product_id' value='' />");
                jQuery(html2).attr("value",json.saia[i].product_id);
                jQuery(td0).append(html2);
                jQuery(tr).append(td0);
    
                var td1 = jQuery("<td></td>");
                jQuery(td1).append(json.saia[i].product_name);
                jQuery(tr).append(td1);
    
                jQuery(tbody).append(tr);
                
                //4.把母页面对应的产品加进去
                if(isondate!=null && isondate!=''){
                    AddopenerProduct(json.saia[i].id,json.saia[i].group_id);
                }
        }
    }); 
    
}
    
//根据社保产品ID，从母页面社保公积金产品列表移除对应条目
DelopenerProduct = function (security_product_id) {
       var datacell = window.opener.$id("grdCityEnsureTbody");
       var dataset = datacell.dataset;//取得母页面的datacell
       dataset.removeEntity(dataset.findEntity("id",security_product_id), true);
          
       datacell.refresh();
       //datacell.getField(1).sorted = '';
       //datacell.doSort(datacell.getField(1));         
}

//根据社保组ID，从母页面把该组的社保公积金产品列表移除对应条目
DelopeneGroup = function (group_id) {
       var datacell = window.opener.$id("grdCityEnsureTbody");
       var dataset = datacell.dataset;//取得母页面的datacell
       
       var ids = null;  //定义id值的数组
       for(var i=0; i<dataset.getLength(); i++){
            //把对应该组的所有产品ID存到数组
            if(dataset.get(i).getProperty("group_id")!=null &&　dataset.get(i).getProperty("group_id")==group_id){
                if(ids == null) {
                    ids = new Array(0);
                }
                ids.push(dataset.get(i).getProperty("id"));
            }
       }
       
       //根据产品ID数组删除母页面产品列表
       if(ids!=null){
           for(var j=0;j<ids.length;j++){
                dataset.removeEntity(dataset.findEntity("id", ids[j]), true);
           }
       }
            
       datacell.refresh();
}
    
//删除已选社保公积金组
//同步删除右下产品列表中属于该组的产品
//同步删除母页面中的该组div
//同步删除社保公积金产品列表中属于该组的产品条目
deleteGroup = function(){
        var group_id = jQuery("input[name='select_group_id']:checked").val();
        
        var tbody = jQuery("#grdGrouptbody");
        jQuery(tbody).find("input[value='"+group_id+"']").parents("tr").remove();
        
        var tbody1 = jQuery("#grdProducttbody");
        jQuery(tbody1).find("input[value='"+group_id+"']").parents("tr").remove();
        
        var tbody2 = jQuery("#selectgroups", window.opener.document);
        jQuery(tbody2).find("div[id='"+group_id+"']").remove();
        
        DelopeneGroup(group_id);
}
    
    
//页面初始化时从母页面抓取社保组和产品列表
jQuery(function () {
	//抓取城市id和名称
	var cityId = jQuery("#city_id", window.opener.document).val();
	//$id("city_idList_search").setValue(cityId);
	$id("citypro_init").addParam("city_id", cityId+"");
	$id("citypro_init").loadData();
    $id("citypro_init").refresh();
    
	
    //抓取已选社保公积金组
    var tbody = jQuery("#grdGrouptbody");
    var openergrd = jQuery("#selectgroups div", window.opener.document);
    if (jQuery("#selectgroups div", window.opener.document).length > 0) {
             
            jQuery(openergrd).each(function () {
                if(jQuery(this).find("input[name='select_group_id']").val()!=null){
                    var group_id = jQuery(this).find("input[name='select_group_id']").val();//取得组ID
                    var city_id=jQuery(this).find("input[name='select_city_id']").val();//取得城市名称
                    var group_name=jQuery(this).find("input[name='select_group_name']").val();//取得组名称
                    
                    var tr = jQuery("<tr></tr>");
                    var td = jQuery("<td></td>");
                    var html = jQuery("<input type='radio' name='select_group_id' value='' />");
                    jQuery(html).attr("value",group_id);
                    //$(html).attr("onclick", "GetCityProduct();");
                    jQuery(td).append(html);
                    jQuery(tr).append(td);
    
                    td = jQuery("<td></td>");
                    jQuery(td).append(city_id);
                    jQuery(tr).append(td);
    
                    td = jQuery("<td></td>");
                    jQuery(td).append(group_name);
                    jQuery(tr).append(td);
                    
                    td = jQuery("<td></td>");
                    var html1 = jQuery("<select name='select_shortcut' disabled='disabled'></select>");
                    jQuery(td).append(html1);
                    jQuery(tr).append(td);
                    
                    jQuery(tbody).append(tr);
                    
                    getShotcutgroup1(group_id,'0');
                }
            });
    }
    
    //抓取社保公积金产品列表
    var tbody1 = jQuery("#grdProducttbody");
    var datacell1 = window.opener.$id("grdCityEnsureTbody");
    var dataset1 = datacell1.dataset;//取得母页面的datacell
    for(var i=0; i<dataset1.getLength(); i++){
        if(dataset1.get(i).getProperty("id")!=null){
                
                    var security_product_id=dataset1.get(i).getProperty("id");//取得社保产品ID
                    var group_id=dataset1.get(i).getProperty("group_id");//取得组ID
                    var product_name=dataset1.get(i).getProperty("product_name");//取得产品名称
                    var product_id=dataset1.get(i).getProperty("product_id");//取得产品ID
                    
                    var tr = jQuery("<tr></tr>");
                    var td = jQuery("<td></td>");
                    var html = jQuery("<input type='checkbox' checked name='security_product_id' value='' />");
                    jQuery(html).attr("value",security_product_id);
                    //$(html).attr("onclick", "selectTodo(this);");
                    jQuery(td).append(html);
                    var html1 = jQuery("<input type='hidden' name='group_id' value='' />");
                    jQuery(html1).attr("value",group_id);
                    jQuery(td).append(html1);
                    var html2 = $("<input type='hidden' name='product_id' value='' />");
                    jQuery(html2).attr("value",product_id);
                    jQuery(td).append(html2);
                    jQuery(tr).append(td);
    
                    td = jQuery("<td></td>");
                    jQuery(td).append(product_name);
                    jQuery(tr).append(td);
    
                    
                    jQuery(tbody1).append(tr);
                }
    }
});