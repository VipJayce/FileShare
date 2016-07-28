	Array.prototype.contains = function (elem) {
		for (var i = 0; i < this.length; i++) {
		if (this[i] == elem) {
		return true;
		}
		}
		return false;
	}
	/**
	 * 功能描述：获得多选框对应的行内隐藏主键集合
	 * 参数描述：checkName -- 多选框的名称
	 *					  idName -- 行记录的隐藏主键id;
	 */    
	function findSelections(checkboxName, idName) {  //从列表中找出选中的id值列表
		var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
		var number = 0;  //定义游标
		var ids = null;  //定义id值的数组
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(ids == null) {
					ids = new Array(0);
				}
				ids.push(elementCheckbox[i].value);  //加入选中的checkbox
			}
		}
		return ids;
	}
	
	function findSelectionsEx(tableId,checkboxName,keyName) {  //从列表中找出选中的id值列表
		var objs= getSelectedData(tableId);
		var ids = null;  //定义id值的数组
		for(var i=0;i<objs.length;i++){  //循环checkbox组
				if(ids == null) {
					ids = new Array(0);
				}
				ids.push(objs[i][keyName]);  //加入选中的checkbox
		}
		return ids;
	}
	
	function findSelectdTrEle(viewCode){
    	return jQuery("#"+viewCode+" table tbody tr [name='checkbox_template']:checked").parent().parent();
	}
	
	/***
	 * eg.	var ids = findSelections4Delete();
	 		if(ids == -1)return;
	 	flag = true 只能删除一条
	 	flag = false 或 未定义则可以删除多条
	 */
	function findSelections4Delete(flag){
	   if(flag==undefined)
            flag=false;
		var ids = findSelections("checkbox_template","id");
		if(ids == null)	{
			alert(i18n.please_choose_record_to_delete)
			return -1;
		}
	   if(ids.length > 1&& flag==true) {
            alert(i18n.please_select_a_record)
            return -1;
        }
		if(confirm(i18n.confirm_to_delete_record)) {
			//如果用户在确认对话框按"确定"
			return ids;
		}else{
			return -1;
		}
	}
	
	function findSelections4Modify(flag){
		if(flag==undefined)
			flag=true;
		var ids = findSelections("checkbox_template","id");
		if(ids == null)	{
			alert(i18n.please_choose_a_records_to_modify)
			return -1;
		}
		if(ids.length > 1&& flag==true) {
	  		alert(i18n.can_only_choose_a_record_to_modify)
	  		return -1;
		}
		return ids;
	}
	
	function findSelections4ModifyEx(tableId,keyName,flag){
		if(flag==undefined)
			flag=true;
		var ids = findSelectionsEx(tableId,"checkbox_template",keyName);
		if(ids == null)	{
			alert(i18n.please_choose_a_records_to_modify)
			return -1;
		}
		if(ids.length > 1&& flag==true) {
	  		alert(i18n.can_only_choose_a_record_to_modify)
	  		return -1;
		}
		return ids;
	}	
	
	function findSelections4Zoom(flag){
		if(flag==undefined)
			flag=true;	
		var ids = findSelections("checkbox_template","id");
		if(ids == null)	{
			alert(i18n_dd.please_choose_a_records_to_zoom)
			return -1;
		}
		if(ids.length > 1 && flag==true) {
	  		alert(i18n_dd.can_only_choose_a_record_to_zoom)
	  		return -1;
		}
		return ids;
	}

	function findSelectedValues(table,checkboxName,colNum)
	{
		var elementCheckbox = document.getElementsByName(checkboxName);  //通过name取出所有的checkbox
		var number=0;
		var values=null;
		for(var i=0;i<elementCheckbox.length;i++){  //循环checkbox组
			if(elementCheckbox[i].checked) {  //如果被选中
				number += 1;  //游标加1
				if(values == null) {
					values = new Array(0);
				}
				values.push(table.rows.item(i+1).cells.item(colNum).innerText);
			}
		}
		return values;
		
	}
	
	    /**
     * 获取选择记录ID列表的通用方法
     * @param {} flag true：单选；false/不填：多选
     * @return {} id列表
     * Add by ZTao
     */
     function findSelections4Common(flag){
        if(flag==undefined)
            flag=false;  
        var ids = findSelections("checkbox_template","id");
        if(ids == null) {
            alert(i18n_dd.select_data)
            return -1;
        }
        if(ids.length > 1 && flag==true) {
            alert(i18n_dd.only_select_one_record)
            return -1;
        }
        return ids;
    }
	
	/***
	 * 功能描述：获取列表视图中选中记录的所有数据
	 * 返回结果：包含map的list
	 * eg.	
	 	var objs = getSelectedData();(页面只存在一个列表)
	 	//var objs = getSelectedData("templateListView");（页面存在多个列表）
	 	alert(objs[0].name); 
	 */
	function getSelectedData(viewCode){
		if(viewCode){
			var selectEles = jQuery("#" + viewCode).find("[name='checkbox_template']:checked");
		}else{
			var selectEles = jQuery("[name='checkbox_template']:checked");
		}
		var resultList = new Array();
		if(selectEles.size()==0)return resultList;
		var index = 0;
		selectEles.each(function(){
			resultList[index]=json_parse(selectEles.eq(index).attr("hiddenValues"));
			index++;
		});
		return resultList;
	}
	
		
	function getRowHiddenId(event) {  
		var thisA = event.srcElement?event.srcElement:event.target;  //定义事件来源对象
		var thisTr = thisA.parentNode;  //定义本行的tr对象
		var thisHidden = getObjectByNameRecursive(thisTr, "hiddenId");  //从thisTr递归的取出name是hiddenId的对象
		if(thisHidden != undefined && thisHidden != null) {  //如果thisHidden不为空
			return thisHidden.value;
		} else {
			return null;
		}
	}

	//检查表单内控件的有效性
	function checkForm(obj){
		var checkResult = true;
		rmTempStatusIsAlert = false;
		rmTempStatusIsFocus = false;
		setAllVenusInputsDefault();
		for (var j=0;j<obj.elements.length;j++) {
			var thisInput = obj.elements[j];
			if ( thisInput.type!="hidden" && thisInput.type!="button" && !( thisInput.id.indexOf("TF_")>=0 && thisInput.id.indexOf("_TF")>0 ) ){
				var rtValue = check(thisInput);
				if(checkResult && rtValue == false) {
					checkResult = false;
				}
			}
		}
		return checkResult;
	}	

	//根据bean向form中对应的元素赋值
	function setForms(data,prefix){
		if(prefix==undefined)
			prefix="";
		for(var property in data){
	       dwr.util.setValue(prefix+property, data[property], { escapeHtml:false });
	    }
	}
	
	
	function setFormsEx(data,prefix){
		if(prefix==undefined)
			prefix="";		
		for(var property in data){
			if(data[property]!=null)
			{
				if(jQuery("[name="+prefix+property+"][type=radio]").size()>0)
				{
					jQuery("[name="+prefix+property+"][value="+data[property]+"]").attr("checked",true);
				}else if(jQuery("[name="+prefix+property+"][type=checkbox]").size()>0)
				{
					var values=data[property].split(",");
					jQuery("[name="+prefix+property+"][type=checkbox]").each(function(){
						if(values.contains(jQuery(this).val()))
							jQuery(this).attr("checked",true);
					})
				}else
				{
				   jQuery("[name="+prefix+property+"]").val(data[property]);
				}
			}
		}
	}
	//从form中取值并生成bean
	function getForms(data){
		for(var property in data){ 
		   var value =  dwr.util.getValue(property, { escapeHtml:false });
	       data[property] =value;
	    }
	}
	
	/** 获取列表视图主表的所有数据，以Map结构返回 **/
	function getFormsEx(prefix){
		var record_Map = {};
		if(prefix==undefined)
			prefix="";
		//查找所有以masterTableName为名称开头的元素并封装成Map对象
		jQuery("[name^="+prefix+"]").each(function(){
			if(jQuery(this).filter(":radio").size()>0)
			{
				if(jQuery(this).filter("[:checked").size()>0)
					record_Map[jQuery(this).attr('name')]=jQuery(this).filter(":checked").val();
			}else if(jQuery(this).filter(":checkbox").size()>0)
			{
				if(jQuery(this).filter("[:checked").size()>0)
				{
					var oldValue=record_Map[jQuery(this).attr('name')];
					if(oldValue=="")
						record_Map[jQuery(this).attr('name')]=jQuery(this).filter(":checked").val();
					else	
						record_Map[jQuery(this).attr('name')]=oldValue+","+jQuery(this).filter(":checked").val();
				}
			}
			else
				record_Map[jQuery(this).attr('name')]=jQuery(this).val();
		})
		return record_Map;
	}	

	//从当前行中找到check框，返回其value值
	function getCurRowId(obj) {  
		var thisTr= obj;
		var checkObj = getObjectByNameRecursive(thisTr, "checkbox_template");  //
		if(checkObj != undefined && checkObj != null) { 
			return checkObj.value;
		} else {
			return null;
		}
	}
	
	function getRadioValue(obj)
   {
	    var len=obj.length;   
	    for (var i=0;i<len ;i++ )
	    { 
	    	if( obj[i].checked==true )
	     {
	      	return obj[i].value;
	     }
	    }
   }	
   
	/**
	 * 功能描述：获得多选框对应的行内隐藏主键集合
	 * 参数描述：checkName -- 多选框的名称
	 *					  idName -- 行记录的隐藏主键id;
	 */    
	function getSelectIds(checkName,idName){
		var checkboxall = document.getElementsByName(checkName);
		var data = new Array();//对象集合
		var number = 0;
		for(var i=0;i<checkboxall.length;i++){
			if(checkboxall[i].checked==false){
				continue;
			}
			data[number] = checkboxall[i].value;
			number++;
		}
		return data;
	}   
	
	/**
	* 功能描述：获取当前日期
	*/
	function getDate(){ 
		var d, s =""; // 声明变量。 
		d = new Date(); // 创建 Date 对象。 
		s += d.getYear()+ "-"; // 获取年份。 
		s += (d.getMonth() + 1) + "-"; // 获取月份。 
		s += d.getDate() ; // 获取日。 
		return(s); // 返回日期。 
	}	

	function clearForm(formId)
	{
		jQuery("#"+formId).clearForm();
	}
/** 检查表管理的表名格式：字母开头+字母下划线数字组合 **/
  function isTableName(value,thisInput){
 	var pattern=/^[A-Za-z]+\w*$/;
	if (!pattern.test(value)) {	
		writeValidateInfo (i18n.please_enter_letters_underscore, thisInput);
		return false;
	}

	return true;
}


/**
 * 列表视图相关函数
 * Add By ZTao
 *  **/
function initListViewColor(){
      initTableColor(jQuery("table[viewtype=tableView]"));
}

//根据获得数据填充相应视图内容
function fillTable(data,code){
    jQuery("#"+code).replaceWith(data);
    initListViewColor();
} 

/** 列表视图分页相关函数 **/

function getMapResult(data,code){
	//alert(dwr.util.toDescriptiveString(data.pageObj, 2));
	pageVo.updatePageVo(data.pageObj);
	setPageDetail(jQuery("#"+code+"+ table").find("#pageDetail")[0]);
	setPageDiv(jQuery("#"+code+"+ table").find("#pageDetail")[0]);
	fillTable(data.dataList,code);
} 

function setPageDetail(tdObj){
	if(tdObj==null)return;
	var pageDetail = i18n_dd.page_current+"<span class='page_text01'>"+pageVo.currentPage+"</span>"+i18n_dd.page_page_all+"<span class='page_text01'>"+pageVo.pageCount+"</span>"+i18n.page+"&nbsp;&nbsp;"+i18n_dd.page_per_page+"<span class='page_text01'>"+pageVo.pageSize+"</span>"+i18n_dd.page_number_all+"<span class='page_text01'>"+pageVo.recordCount+"</span>"+i18n_dd.page_number_record+"&nbsp;&nbsp;"+i18n_dd.page_goto;
	var pageNo = jQuery("<input name='VENUS_PAGE_NO_KEY_INPUT' type='text' size='2' maxlength='10' value='' style='border:1px solid #90b3cf; margin-right:4px;'>").get(0);
	//var pageGoButton = tdObj.lastChild;
	if(tdObj.childNodes.length==13){
		jQuery(tdObj).html(pageDetail+jsutils.outerHTML(pageNo)+i18n.page+jsutils.outerHTML(tdObj.childNodes[11]));
	}else{
		jQuery(tdObj).html(pageDetail+jsutils.outerHTML(pageNo)+i18n.page+jsutils.outerHTML(tdObj.lastChild));
	}
	return tdObj;
}

function changePageSize(tdObj){
	var pageSizeObj = jQuery("<input name='VENUS_PAGE_SIZE_INPUT' type='text' size='2' onblur='pageVo.setPageSize(this.value)' maxlength='10' value=''>");
	var pageDetail = i18n_dd.page_current+"<span class='page_text01'>"+pageVo.currentPage+"</span>"+i18n_dd.page_page_all+"<span class='page_text01'>"+pageVo.pageCount+"</span>"+i18n.page+"&nbsp;&nbsp;"+i18n_dd.page_per_page+"<span class='page_text01'>"+jsutils.outerHTML(pageSizeObj)+"</span>"+i18n_dd.page_number_all+"<span class='page_text01'>"+pageVo.recordCount+"</span>"+i18n_dd.page_number_record+"&nbsp;&nbsp;"+i18n_dd.page_goto;
	var pageNo = jQuery("<input name='VENUS_PAGE_NO_KEY_INPUT' type='text' size='2' maxlength='10' value='' style='border:1px solid #90b3cf; margin-right:4px;'>").get(0);
	//var pageGoButton = tdObj.lastChild;
	jQuery(tdObj).html(pageDetail+jsutils.outerHTML(pageNo)+i18n.page+jsutils.outerHTML(tdObj.childNodes[11]));
	return tdObj;
}

function setPageDiv(tdObj){
		if(tdObj==null)return;
		setDivFirstPage();
		setDivUpPage();
		setDivDownPage();
		setDivLastPage();
	}
	function setDivFirstPage(){
		if (pageVo.getCurrentPage() > 1) {
		    jQuery("#divFirstPage").html('<a href="JavaScript:pageVo.firstPage();"><img src="'+webPath+'/images/icon_page_frist.gif" width="10" height="12" border="0" alt="'+i18n.home+'"></a>');
		} else {
			jQuery("#divFirstPage").html('<img src="'+webPath+'/images/icon_page_frist1.gif" width="10" height="12" border="0" alt="'+i18n.home+'">');
		}
	}

	function setDivUpPage(){
		if (pageVo.getCurrentPage() > 1) {
			jQuery("#divUpPage").html('<a href="JavaScript:pageVo.upPage();"><img src="'+webPath+'/images/icon_page_prev.gif" width="7" height="12" border="0" alt="'+i18n.previous+'"></a>');
		}else{
			jQuery("#divUpPage").html('<img src="'+webPath+'/images/icon_page_prev1.gif" width="7" height="12" border="0" alt="'+i18n.previous+'">');
		}
	}
	
	function setDivDownPage(){
		if (pageVo.getPageCount()>=pageVo.getCurrentPage()+1) {
			jQuery("#divDownPage").html('<a href="JavaScript:pageVo.downPage();"><img src="'+webPath+'/images/icon_page_next.gif" width="7" height="12" border="0" alt="'+i18n.next+'"></a>');
		}else{
			jQuery("#divDownPage").html('<img src="'+webPath+'/images/icon_page_next1.gif" width="7" height="12" border="0" alt="'+i18n.next+'">');
		}
	}
	
	function setDivLastPage(){
		if (pageVo.getPageCount()>=pageVo.getCurrentPage()+1) {
			jQuery("#divLastPage").html('<a href="JavaScript:pageVo.lastPage();"><img src="'+webPath+'/images/icon_page_last.gif" width="10" height="12" border="0" alt="'+i18n.last_page+'"></a>');
		}else{
			jQuery("#divLastPage").html('<img src="'+webPath+'/images/icon_page_last1.gif" width="10" height="12" border="0" alt="'+i18n.last_page+'">');
		}
	}
	
	function getRefrence(path, para,callBack) {
		var returnValue = window.showModalDialog(path, para, "status:1;dialogHeight:450px;dialogWidth:300px;dialogTop: " + event.screenY + "px; dialogLeft: " + event.screenX + "px");
		callBack(returnValue);
	}	
	
	function trim (str)
	{
	    return str.replace(/(^\s*)|(\s*$)/g, '');
	}
	
	/***  主子表页面处理相关函数  ***/
	
	/*** 获得当前页面中指定视图的查询条件 *****/
	function getConditions(viewCode,tableName){
		var record_Map = {};
		var isEmpty = true;
		jQuery("#"+viewCode).find("[name^="+tableName+"]").each(function(){
			record_Map[jQuery(this).attr('name')]=jQuery(this).val();
			if(jQuery(this).val()!=""){isEmpty=false};
		})
		//获得虚拟字段内容，虚拟字段参照的ID
		jQuery("#"+viewCode).find("[name^=VS_]").each(function(){
			record_Map[jQuery(this).attr('name')]=jQuery(this).val();
			if(jQuery(this).val()!=""){isEmpty=false};
		})
		//获得虚拟字段参照的内容
		jQuery("#"+viewCode).find("[name^=refrence_]").each(function(){
			record_Map[jQuery(this).attr('name')]=jQuery(this).val();
			if(jQuery(this).val()!=""){isEmpty=false};
		})
		if(isEmpty){
			var result = {};
			result["viewCode"] = viewCode;
			return result;
		};
		//保存查询视图编码
		record_Map["viewCode"] = viewCode;
		return record_Map;
	}

	   
       /**
     * 从当前页面元素中获取数据
     * 1.input
     * 2.radio
     * 3.checkbox value之间用","分隔
     * @param {} dataMap 整个视图所对应的数据集
     * @param {} jEle 页面jQuery元素
     * Add By ZTao
     */
  function getElementValue(dataMap,jEle){
        var name = jEle.attr("name");
        if("radio" == jEle.attr("type")){
               if(dataMap[name] == "" || dataMap[name] == undefined){
                   //第一次处理当前字段
                   dataMap[name] = jEle.parent().find(":checked").val();
               }
        }else if("checkbox" == jEle.attr("type")){
              if(dataMap[name] == "" || dataMap[name] == undefined){
                var values = "";
                jEle.parent().find(":checked").each(function(){
                        var value = jQuery(this).val();
                                       alert(value);
                        if(values == ""){
                            values = values + value;
                        }else{
                            values = values + "," + value;
                        }
                });
                dataMap[name] = values;
              }
        }else{
            dataMap[name]=jEle.val();
        }
    }

	/** 获取列表视图主表的所有数据，以Map结构返回 **/
	function getMasterDataFromPage(masterTableName,isModify){
		var record_Map = {};
		var isEmpty = true;
		//查找所有以masterTableName为名称开头的元素并封装成Map对象
		jQuery("[name^="+masterTableName+"]").each(function(){
            record_Map[jQuery(this).attr('name')]=jQuery(this).val();
            //getElementValue(record_Map,jQuery(this));
			if(jQuery(this).val()!=""){isEmpty=false};
		})
		if(isEmpty){return null};
		//如果是修改状态，获得主表id
		if(isModify == true){
			record_Map["id"]=jQuery("[name=id]")[0].value;
		}
		return record_Map;
	}
	
    
	function getMasterDataFromPageWithCode(viewCode,masterTableName,isModify){
			var record_Map = {};
			var isEmpty = true;
			jQuery("#"+viewCode).find("[name^="+masterTableName+"]").each(function(){
            record_Map[jQuery(this).attr('name')]=jQuery(this).val();
            //getElementValue(record_Map,jQuery(this));
				if(jQuery(this).val()!=""){isEmpty=false};
			})
			//获得虚拟字段内容，虚拟字段参照的ID
			jQuery("#"+viewCode).find("[name^=VS_]").each(function(){
				record_Map[jQuery(this).attr('name')]=jQuery(this).val();
				if(jQuery(this).val()!=""){isEmpty=false};
			})
			//获得虚拟字段参照的内容
			jQuery("#"+viewCode).find("[name^=refrence_]").each(function(){
				record_Map[jQuery(this).attr('name')]=jQuery(this).val();
				if(jQuery(this).val()!=""){isEmpty=false};
			})
			if(isEmpty){return null};
			//如果是修改状态，获得主表id
			if(isModify == true){
				record_Map["id"]=jQuery("[name=id]")[0].value;
			}
			return record_Map;
	}
	
	/** 获取列表视图子表的所有数据，以List<Map>结构返回 **/
	function getSubDataFromPage(subTableViewCode,subTableName,isModify){
		var records_Map = new Array();
		//遍历id为subTableViewCode的每一行
		jQuery("#"+subTableViewCode+" tbody tr").each(function(i){
			var subRecord_Map = {};
			//查找所有以subTableName为名称开头的元素并封装成Map对象
			jQuery(this).find("[name^="+subTableName+"]").each(function(i){
				//以名字为key属性为value
				subRecord_Map[jQuery(this).attr('name')]=jQuery(this).val();
			});
			jQuery(this).find("[name^=VS_]").each(function(){
                subRecord_Map[jQuery(this).attr('name')]=jQuery(this).val();
            })
			//如果是修改状态，则取得每行的Id
			if(isModify == true){
				subRecord_Map["ID"]=jQuery(this).find("[name=checkbox_template]")[0].value;
			}
			//获取每行的隐藏字段值
			var attrValue = jQuery(this).find("[name='checkbox_template']").attr("hiddenvalues");
			if(attrValue == "undefined" || attrValue == null || attrValue == ""){
			}else{
				var json_record = json_parse(jQuery(this).find("[name='checkbox_template']").attr("hiddenvalues"));
				for(var key in json_record){
					if(subRecord_Map[subTableName+"."+key] == "undefined"){
					   subRecord_Map[subTableName+"."+key] = json_record[key];
					}
				}
			}
			records_Map[records_Map.length]=subRecord_Map;
		});
		return records_Map;
	}
	
	/** 获取可编辑的列表视图当前选中行的数据，以List<Map>结构返回 **/
    function getSelectedDataFromEditListView(subTableViewCode,subTableName,isModify){
        var records_Map = new Array();
        //遍历id为subTableViewCode的每一行
        jQuery("#"+subTableViewCode+" tbody tr").each(function(i){
          if(jQuery(this).find("[name='checkbox_template']").attr("checked") == false){
                return true;
          }
            var subRecord_Map = {};
            //查找所有以subTableName为名称开头的元素并封装成Map对象
            jQuery(this).find("[name^="+subTableName+"]").each(function(i){
                //以名字为key属性为value
                subRecord_Map[jQuery(this).attr('name')]=jQuery(this).val();
            });
            jQuery(this).find("[name^=VS_]").each(function(){
                subRecord_Map[jQuery(this).attr('name')]=jQuery(this).val();
            })
            //如果是修改状态，则取得每行的Id
            if(isModify == true){
                subRecord_Map["ID"]=jQuery(this).find("[name=checkbox_template]")[0].value;
            }
            //获取每行的隐藏字段值
            var attrValue = jQuery(this).find("[name='checkbox_template']").attr("hiddenvalues");
            if(attrValue == "undefined" || attrValue == null || attrValue == ""){
            }else{
                var json_record = json_parse(jQuery(this).find("[name='checkbox_template']").attr("hiddenvalues"));
                for(var key in json_record){
                    if(subRecord_Map[subTableName+"."+key] == "undefined"){
                       subRecord_Map[subTableName+"."+key] = json_record[key];
                    }
                }
            }
            records_Map[records_Map.length]=subRecord_Map;
        });
        return records_Map;
    }


	
	function getGrandSubDataFromPage(viewId,tableName,isModify){
		var records_Map = new Array();
		jQuery("#"+viewId+" tbody tr").each(function(i){
			if(i>=1){
				var subRecord_Map = {};
				jQuery(this).find("[name^="+tableName+"]").each(function(i){
					subRecord_Map[jQuery(this).attr('name')]=jQuery(this).val();
				});
				if(isModify == true){
					subRecord_Map["ID"]=jQuery(this).find("[name=grandSubId]:first").val();
				}
				records_Map[records_Map.length]=subRecord_Map;
			}
		});
		return records_Map;
	}
	
	
	/** 删除列表视图中所有选中的行，并重新刷新序号 **/
	function deleteViewTableSelected(viewCode){
		//查找名称为checkbox_template并且选中的checkbox，然后删除其所在的tr
		jQuery("#"+viewCode).find('[name=checkbox_template]:checkbox:[checked=true]').parent().parent().remove();
		refreshTableSeq(viewCode);
	}
	
	function refreshTableSeq(viewCode){
		//查找tr中的第二个td，也就是序号所在列，然后进行内容刷新
		jQuery("#"+viewCode+" tbody tr td:nth-child(2)").each(function(i){
			jQuery(this).text(i+1);
		});
	}
	//
	function deleteSelectedTableDataDto(viewCode,container){
		jQuery("#"+viewCode).find('[name=checkbox_template]:checkbox').each(function(i){
			if(jQuery(this).attr("checked") == true){
				container = container.slice(0,i).concat(container.slice(i+1,container.length));
			}
		});
		return container;
	}

function PageContainer(){
	this.list = new Array();
}

PageContainer.prototype.findDto = function(id){
	for(var i=0;i<this.list.length;i++){
		if(id == this.list[i].getId())return this.list[i];
	}
	return null;
}

PageContainer.prototype.deleteDto = function(id){
	for(var i=0;i<this.list.length;i++){
		if(id == this.list[i].getId())
		this.list = this.list.slice(0,i).concat(this.list.slice(i+1,this.list.length));
	}
}

PageContainer.prototype.replace = function(data){
	var flag = false;
	for(var i=0;i<this.list.length;i++){
		var tempDto = this.list[i];
		if(tempDto.getId() == data.getId()){
			this.list[i] = data;
			flag = true;
		}
	}
	if(flag == false){
		this.list[this.list.length]=data;
	}
}

PageContainer.prototype.addToList = function(data){
	this.list[this.list.length]=data;
}

PageContainer.prototype.getList = function(){
	return this.list;
}

PageContainer.prototype.show = function(){
	show(this.list,4);
}

function TableDataDto(){
	this.key = -1; 
	this.updateFlag = 0;
	this.tableData = "";
	this.subTable = new Array();
}

TableDataDto.prototype.setMap = function(map){
	var result = "";
	for(i in map){
		if(result.length==0){
			result = i+"#"+map[i]
		}else{
			result = result+"+"+i+"#"+map[i]
		}
	}
	this.tableData = result;
}

TableDataDto.prototype.getMap = function(){
	var	values = this.tableData.split("+");
	var result = {};
	for(i=0;i<values.length;i++){
		var temps = values[i].split("#");
		result[temps[0]]=temps[1];
	}
	return result;
}

TableDataDto.prototype.getId = function(){
	var map = this.getMap();
	return map["ID"];
}

TableDataDto.prototype.addToSubTable = function(data){
	this.subTable[this.subTable.length]=data;
}
function show(data){
	show(data,2);
}

function show(data,level){
	if(typeof(dwr) != "undefined"){
		alert(dwr.util.toDescriptiveString(data,level));
	}else{
		alert(data);
	}
}

/**
*	功能：查询出数据后，往页面中指定子表表格中填写数据
*	参数说明：
*	dataMap:从数据库查询得到的Map。key为字段名称，value为字段内容
*	tableName:页面中指定视图对应的表格名称。
*	idKey:页面中存储id的隐藏元素的id名称。
*	idValue:id的值。
*	hasTableName:指dataMap中的数据是否包含表名
**/
function writeSubTable(dataMap,tableName,idKey,idValue,hasTableName){
	//查找名称以tableName开头的所有元素
	jQuery("[name^="+tableName+"]").each(function(){
		//获得tableName.fieldName的fieldName并从map中取值然后设置对应页面元素的值
		var keyName = jQuery(this).attr('name').split(".")[1];
		if(hasTableName==true){
			keyName = jQuery(this).attr('name');
		}
		jQuery(this).val(dataMap[keyName]);
	})
	jQuery("#"+idKey).val(idValue);
}

function writeSubTableWithCode(viewCode,dataMap,tableName,idKey,idValue,hasTableName){
	//查找名称以tableName开头的所有元素
	jQuery("#"+viewCode).find("[name^="+tableName+"]").each(function(){
		//获得tableName.fieldName的fieldName并从map中取值然后设置对应页面元素的值
		var keyName = jQuery(this).attr('name').split(".")[1];
		if(hasTableName==true){
			keyName = jQuery(this).attr('name');
		}
		jQuery(this).val(dataMap[keyName]);
	})
	//处理虚拟字段和参照字段
	jQuery("#"+viewCode).find("[name^=VS_]").each(function(){
		jQuery(this).val(dataMap[jQuery(this).attr('name')]);
	});
	jQuery("#"+viewCode).find("[name^=refrence_]").each(function(){
		//if(jQuery(this).attr('name').split(".").length == 2){
			//非虚拟字段的参照，包含表名称
		//	jQuery(this).val(dataMap[jQuery(this).attr('name')]);
		//}else{	
		//}
		jQuery(this).val(dataMap[jQuery(this).attr('name')]);
	});
	jQuery("#"+idKey).val(idValue);
}

function writeGrandSubTable(grandDtoList,viewId,tableName,hasTableName){
	jQuery("#"+viewId+" table tbody tr").each(function(i){
		if(i>=1){//跳过表头
			var grandDto = grandDtoList[i-1];
			var grandData = grandDto.getMap();
			jQuery(this).find("[name^="+tableName+"]").each(function(){
				var keyName = jQuery(this).attr('name').split(".")[1];
				if(hasTableName==true){
					keyName = jQuery(this).attr('name');
				}
				jQuery(this).val(grandData[keyName]);
			});
			jQuery(this).find("[name=grandSubId]:first").val(grandData["ID"]);
		}
	});
}

function writeGrandSubTableWithMap(grandDataMapList,viewId,tableName,hasTableName){
	jQuery("#"+viewId+" table tbody tr").each(function(i){
		if(i>=1){//跳过表头
			var grandData = grandDataMapList[i-1];
			jQuery(this).find("[name^="+tableName+"]").each(function(){
				var keyName = jQuery(this).attr('name').split(".")[1];
				if(hasTableName==true){
					keyName = jQuery(this).attr('name');
				}
				jQuery(this).val(grandData[keyName]);
			});
			jQuery(this).find("[name=grandSubId]:first").val(grandData["ID"]);
		}
	});
}

/**
*	根据指定div的id，清空对应div中元素的值
**/
function clearDivValues(divId){
	//TODO:处理其他类型元素
	jQuery("#"+divId+" :input").val("");
}

/**
*	清除form中表单内容，包含参照和下拉列表
*	selected 为true表示清空下拉内容同时设置默认值为"-请选择-"
*	selected 为false表示不清空下拉内容
**/
function clearForm(formId){
	//清除form中所有字段内容
	jQuery("#"+formId).clearForm();
	//清除form中参照对应的隐藏字段内容
	jQuery("#"+formId).find("[name^=refrence_]").each(function(){
		jQuery(this).parent().find("input").val("");
	})
    //设置form中所有下拉默认内容
    jQuery("#"+formId).find("select").each(function(){
          jQuery(this).val(jQuery(this).find("option").val());//"-请选择-" 
    });
}

function clearForm4QueryView(){
	clearForm("ccChild0");
}

/**
*	清空指定ID元素所包含的所有子元素的disabled属性。
*   如果ID为“”，则清除当前页面的所有元素的disabled属性。
**/
function clearDisabled(elementId){
	//TODO:need to confirm other element
	if(elementId == ""){
		jQuery("input").removeAttr("disabled");
		jQuery("select").removeAttr("disabled");
		jQuery("textarea").removeAttr("disabled");
	}else{
		jQuery("#"+elementId+" input").removeAttr("disabled");
		jQuery("#"+elementId+" select").removeAttr("disabled");
		jQuery("#"+elementId+" textarea").removeAttr("disabled");
	}
}

/**
*	根据元素本身打开日期参照，解决数据字典列表视图中多日期参照定位失效的问题
**/
function getDate(event,textDate,path){
	var returnAry;
	if(path == undefined) {
		path = "../../";
	}
	var returnAry = window.showModalDialog(path + "js/calendar/calendar.jsp","日期参照","status:1;dialogHeight:230px;dialogWidth:300px;dialogTop: "+event.screenY+"px; dialogLeft: "+event.screenX+"px");
	//修正在日期控件为空产生校验后不能正确匹配的问题（IE失效，因为多了个span和input）
    var tagElement = jQuery(textDate).parent().children().eq(0);//chrom
	if (typeof(returnAry) == "undefined") {
       tagElement.val("");
	} else if (returnAry != null) {
		tagElement.val(returnAry);
        focus();
	}
}

function getRefrence(textRefrence, path, param,event,beforeRef,afterRef) {
	var returnVal;
	var condition="";
	if (path == undefined) {
		path = "../../";
	}
	paramObj =json_parse(param);
	if(beforeRef!=undefined)
	{
		condition=beforeRef();
	}
	returnVal = window.showModalDialog(path, [paramObj,condition], "status:1;dialogHeight:450px;dialogWidth:300px;dialogTop: " + event.screenY + "px; dialogLeft: " + event.screenX + "px");
	if (typeof (returnVal) == "undefined" && paramObj.editable=="0") {
			jQuery(textRefrence).parent().find("*:first").val("");		
	} else {
		if(afterRef!=undefined)
			afterRef(returnVal);
		if (returnVal != null) {
			var dispValue="";
			if(paramObj.dispField=="")
				dispValue=returnVal["name"];
			else
				dispValue=returnVal[paramObj.dispField];
			if(paramObj.editable=="1")
			{
				if(paramObj.editMode=="1")
				{
					jQuery(textRefrence).parent().find("*:first").val(jQuery(textRefrence).parent().find("*:first").val()+dispValue);
				}else
				{
					jQuery(textRefrence).parent().find("*:first").val(dispValue);	
				}
			}
			else	
			{
				jQuery(textRefrence).parent().find("*:first").val(dispValue);
				jQuery(textRefrence).parent().find("input:last").val(returnVal.code);
			}
			focus();
		}
	}
}

function initSpecialTable(viewCode,columnNum){
	var myTrStyle = "Z-INDEX: 3;POSITION: relative;TOP: expression(this.offsetParent.scrollTop)";
	var trEle = jQuery("#"+viewCode+" table thead tr");
	trEle.attr("style",myTrStyle);
	var myThStyle = "Z-INDEX: 1;POSITION: relative;LEFT: expression(this.parentElement.offsetParent.scrollLeft)";
	trEle.find("th").each(function(index){
		if(index < columnNum){
			jQuery(this).attr("style",myThStyle);
		}
	});
	var myTdStyle = "Z-INDEX: 2;POSITION: relative; LEFT: expression(this.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.offsetParent.scrollLeft)";
	var tbodyTrEle = jQuery("#"+viewCode+" table tbody tr");
	tbodyTrEle.each(function(){
		jQuery(this).find("td").each(function(index2){
			if(index2 < columnNum){
				jQuery(this).attr("style",myTdStyle);
			}
		});
	});
}
	
/*******跨浏览器相关函数*******/
function swapNode(node1,node2){
	var parent = node1.parentNode;//父节点
	var t1 = node1.nextSibling;//两节点的相对位置
	var t2 = node2.nextSibling;
	if(t1){
		parent.insertBefore(node2,t1);
	}else{
		parent.appendChild(node2);
	}
	if(t2){
		parent.insertBefore(node1,t2);
	}else{
		parent.appendChild(node1);
	}
}
/*******工作流相关JS函数*******/

//历史记录查询时工具栏监控按钮的实现
function monitor(){
	var ids = findSelections4Modify();
	if(ids == -1)return;
	var index = ids.toString().lastIndexOf(";");
	if( index == -1){
	    alert("此记录没有对应的流程实例，不能监控！");
	    return false;
	}
	var businessID = ids.toString().substring(0, index);
	form.action="<%=request.getContextPath()%>/ApplyequipmentAction.do?cmd=monitor&id=" + businessID;
	form.submit();
}
	
//jQuery插件
jQuery(function(){
	jQuery.fn.extend({
		"outerHTML":function(){
				return jQuery(jQuery("<div></div>").html(this.clone())).html();
			}
	})
});
//数据字典JS助手类
function JSUtils(){
}

JSUtils.prototype.outerHTML = function(obj){
	return jQuery(jQuery('<div></div>').html(jQuery(obj).clone())).html();
}
jsutils = new JSUtils();

