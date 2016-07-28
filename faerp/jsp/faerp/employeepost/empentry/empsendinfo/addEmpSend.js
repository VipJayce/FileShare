jQuery(function(__$){
	//保存
	__$("#btn_submit").click(function(){
		var dc_emp = $id("dc_emp");
		var ds = dc_emp.dataset;
		//datacell当前的insertEntities
		var cur_in_entity = ds.getInsertEntities();
		var cur_quo_id = cur_in_entity[0]?cur_in_entity[0].getValue("quo_id"):"";
		//alert(tempInsertArray.length);
		for(var i=0; i<tempInsertArray.length; i++ ){
			
			var emps = tempInsertArray[i].emps;
			//如果当前insertEntities在临时数组存在，则不添加
			if(cur_quo_id == tempInsertArray[i].quo_id){
				continue;
			}
			//将临时数组中的entity加入到当前insertEntities中去，然后全部提交
			for(var j=0; j< emps.length; j++){
				ds.addEntity(emps[j]);
			}
		}
		//重置临时数组
		tempInsertArray = [];
		/*
		var action = vpath+"/EmpSendInfoAction.do?cmd=saveAll";
        var xmlSubmit = ds.toString();
        var myAjax = new Ajax(action);
         myAjax.submitXML(xmlSubmit, 'UTF-8');
         var returnNode = myAjax.getResponseXMLDom();
         if( returnNode ) {
         	alert( myAjax.getValue("root/data/returnValue") );
         	
         }
		 //重新加载右侧员工页面内容
        __$("#h_quo_id").val(cur_quo_id);
        $id("dc_emp").reload();
        $id("dc_emp").endEdit();//不要把光标放在人员detacell的单元格中
		*/
		if(dc_emp.submit()){
			//重新加载右侧员工页面内容
			__$("#h_quo_id").val(cur_quo_id);
            $id("dc_emp").reload();
            $id("dc_emp").endEdit();//不要把光标放在人员detacell的单元格中
		}
	});

	$id("dc_emp").afterSubmit= function(ajax){
        alert(ajax.getProperty("returnValue"));
    }
    
	//添加报价单
	__$("#addbaojia").click(function(){
		var custId = __$("#hid_custID").val();
		var p = "&customer_id=" + custId;
        var quo = viewQuotation(p);
        if(quo){
        	var id = quo[0];
        	var name = quo[1];
        	var code = quo[2];
        	var dc = $id("dc_quo");
        
        	//判断datacell中是否已存在
        	var dataset = dc.dataset;//取得页面的datacell
        	for(var i=0; i<dataset.getLength(); i++){
                if(dataset.get(i).getProperty("quo_id")!=null &&　dataset.get(i).getProperty("quo_id")==id){
                    alert('报价单已存在，不能重复选择');
                    return;
                }
            }
	        var newEntity = new Entity(Entity.STATUS_NEW);
	        newEntity.setProperty("quo_id",id);
	        newEntity.setProperty("quo_code",code);
	        newEntity.setProperty("quo_name",name);
	        
			dc.addRow(newEntity);
        }
        
	});
	
	//删除报价单
	__$("#delbaojia").click(function(){
		var dc_quo = $id("dc_quo");
		var dataset = dc_quo.dataset;
        var quo = dc_quo.getActiveEntity();
        var row_len = dc_quo.getAllRows(true).length;
        if(!row_len){
        	return;
        }
		if(!confirm("是否删除该报价单下的所有员工的派出关系？")){
			return;
		}
		
        var quo_id = quo.getValue("quo_id");
        
        var dc_emp = $id("dc_emp");
        var ds = dc_emp.dataset;
        
        var sendID = __$("#hid_sendID").val();
        __$.post(dir_base + "/EmpSendInfoAction.do?cmd=delByQuoID",{quoId: quo_id, sendID: sendID});
        
        //删除报价单下的员工
        for(var i=0; i<ds.getLength(); i++){
        	var e = ds.get(i);
        	if(quo_id == e.getValue("quo_id")){
        		
        		dc_emp.deleteRow(dc_emp.getRow(i));
        	}
	   	}
	   	dc_emp.reload();
	   	
	   	dataset.removeEntity(quo, true);
	   	dc_quo.refresh();
	});
	
	//联动表格，当选中的报价单变化时，右侧的员工也跟着变
	$id("dc_quo").onClickRow = function(rowTR,rowIndex,entity,datacell){
		//保存上一个报价单下的新增的员工(insertEntities)到页面临时数组中
		saveNewEmp2Page();
		
		//重载员工DATACELL
		__$("#h_quo_id").val(entity.getValue("quo_id"));
		$id("dc_emp").reload();
		
		//追加当前点击的报价单下的未保存的新增员工到dc_emp
		appendEmp2dc_emp(entity.getValue("quo_id"));
		
		$id("dc_emp").endEdit();//不要把光标放在人员detacell的单元格中
	};
	
	$id("dc_emp").afterAdd = function(row){
		$id("dc_emp").getEntity(row)
			.setProperty("quo_id",$id("dc_quo").getActiveEntity().getValue("quo_id"));
	}
	
	//添加员工
	__$("#a_emp_add").click(function(){
		var dc_quo = $id("dc_quo");
		var dc_emp = $id("dc_emp");
		var quo = dc_quo.getActiveEntity();
		var row_len = dc_quo.getAllRows(true).length;
		if(!quo || !row_len){
			alert("请先选择或添加报价单！");
			return;
		}
		dc_emp.addRow();
	});
	
	//删除员工
	__$("#a_emp_del").click(function(){
		var dc_quo = $id("dc_quo");
		var dc_emp = $id("dc_emp");
		
		var emp = dc_emp.getActiveEntity();
		var quo = dc_quo.getActiveEntity();
		var row_len = dc_emp.getAllRows(true).length;
		if(!row_len){
			return;
		}
		
		if(!confirm("是否删除该员工的派出关系？")){
			return;
		}
		var emp_id = emp.getValue("emp_id");
		var quo_id = quo.getValue("quo_id");
		var sendID = __$("#hid_sendID").val();
		__$.post(dir_base + "/EmpSendInfoAction.do?cmd=delByEmpID",{empId: emp_id, sendID: sendID, quoID: quo_id});
		
		dc_emp.deleteRow();//页面删除
		dc_emp.dataset.removeEntity(emp, true);//dataset中删除
		dc_emp.refresh();
		dc_emp.isModefied = true;
		//数组中删除该报价单中的该员工 (2012-11-26陈小佩修改)
		for(var i=0; i<tempInsertArray.length; i++){
            if(quo_id == tempInsertArray[i].quo_id){
            	var emps = tempInsertArray[i].emps;
                for(var j=0; j< emps.length; j++){
                	if(emps[j].getValue("emp_id")==emp_id){
                		emps.splice(j,1);//人员数组中删除该人员
                        tempInsertArray.splice(i,1);//大数组先删除该报价单
                		tempInsertArray.push(new TempSet(quo_id,emps));//大数组再插入新的该报价单
                		
                		break;
                	}
                }
            
            }
        }
	});
	
	//单元格编辑触发函数
	$id("dc_emp").onUpdateCell = function(activeCell,activeEntity, activeFieldName,newValue){
		var dc_emp = $id("dc_emp");
		//编辑之前的证件号码值
		var id_card = activeEntity.getValue("id_card");
        var emp_code = activeEntity.getValue("emp_code");
		//cell为证件号码
		if(activeFieldName == "id_card" && newValue){
			//到后台验证员工信息，并返回员工唯一号，员工姓名，证件号
			if(!checkemp(activeEntity,newValue,1)){
				alert('员工证件号码已经添加，不能重复！');
        	    activeEntity.setProperty("id_card", id_card);//还原回去
        	    
                return false;
			}else{
				checkIdcardServer(activeEntity,newValue);
			}
		}
		//cell为证件类型，并且证件号码不为空，并且编辑后的证件类型为身份证
		else if(activeFieldName == "id_card_type" &&　id_card && newValue==1){
			if(!isChinaIDNo(id_card)){
				alert("身份证格式错误");
				activeEntity.setProperty("id_card", "");
			}else{
			    checkIdcardServer(activeEntity,id_card);
			}
		}
		//操作员手动输入员工唯一号，到后台验证唯一号是否存在
		else if(activeFieldName == "emp_code" &&　newValue){
			if(!checkemp(activeEntity,newValue,2)){
                alert('员工唯一号已经添加，不能重复！');
                activeEntity.setProperty("emp_code", emp_code);//还原回去
                //dc_emp.refreshRow(dc_emp.getActiveRow(),activeEntity);
                return false;
            }else{
            	if(id_card){
                	activeEntity.setProperty("emp_code", newValue);
                    checkIdcardServer(activeEntity,id_card);
            	}
            }
		}
	}
});

//判断员工是否已经添加(2012-11-27陈小佩修改)
function checkemp(activeEntity,newValue,datatype){
	var sign =true;
    
    var dc_emp = $id("dc_emp");
    
	//判断唯一号或证件号码是否在数组中已存在，如果已存在则不能重复添加(2012-11-27陈小佩修改)
        for(var i=0; i<tempInsertArray.length; i++){
                var emps = tempInsertArray[i].emps;
                for(var j=0; j< emps.length; j++){
                    if(datatype==2 && emps[j].getValue("emp_code")==newValue){
                        
                        return false;
                    }
                    if(datatype==1 && emps[j].getValue("id_card")==newValue){
                        return false;

                    }
                }
        }
        //判断唯一号或证件号码是否在datacell中已存在，如果已存在则不能重复添加(2012-11-27陈小佩修改)
        var dataset = dc_emp.dataset;//取得页面的datacell
        for(var i=0; i<dataset.getLength(); i++){
            if(datatype==2 && dataset.get(i).getProperty("emp_code")!=null &&　dataset.get(i).getProperty("emp_code")==newValue){
                
                return false;
            }
            if(datatype==1 && dataset.get(i).getProperty("id_card")!=null &&　dataset.get(i).getProperty("id_card")==newValue){
                return false;
            }
        }
        return sign;
}

/**
 * 临时数组，用来保存各个报价单下新增的员工
 * 以便切换报价单时，新增的员工在保存前不会丢失
 */
var tempInsertArray = new Array();
/**
 * 自定义的类，用来保存报价单和员工的对应关系，数据结构参考如下：
 * 以便切换报价单时，新增的员工在保存前不会丢失
 * var temp = new TempSet("123",[{empcode:"123123",empname:"nisi"},{empcode:"7789789",empname:"lusc"}]);
 * alert(temp.quo_id+temp.emps[0].empname);
 */
function TempSet(quo_id,emps){
	this.quo_id = quo_id;
	this.emps = emps;
}
/**
 * 保存新增的员工到页面临时数组中
 */
function saveNewEmp2Page(){
	var dc_emp = $id("dc_emp");
	var ds = dc_emp.dataset;
	var newEmps = ds.getInsertEntities();
	//如果有新增的员工
	if(newEmps.length > 0){
		var quo_id = newEmps[0].getValue("quo_id");
		//移除上次保存的员工
		removeAllByQuoId(quo_id);
		//重新保存新增员工
		tempInsertArray.push(new TempSet(quo_id,newEmps));
	}
}
/**
 * 根据报价单ID移除上一次保存的临时新增员工
 */
function removeAllByQuoId(quo_id){
	for(var i=0; i<tempInsertArray.length; i++){
		if(quo_id == tempInsertArray[i].quo_id){
			tempInsertArray.splice(i,1);
		}
	}
}
/**
 * 追加当前点击的报价单下的未保存的新增员工到dc_emp
 */
function appendEmp2dc_emp(quo_id){
	for(var i=0; i<tempInsertArray.length; i++){
		if(quo_id == tempInsertArray[i].quo_id){
			var emps = tempInsertArray[i].emps;
			for(var j=0; j< emps.length; j++){
				$id("dc_emp").addRow(emps[j]);
			}
		}
	}
}
/**
 * 校验身份证准确性及有效性
 */
function f_check_checkIdcard(obj){
	var dc_emp = $id("dc_emp");
	var id_card = obj.value;
	var id_card_type = dc_emp.getActiveEntity().getValue("id_card_type");
	//证件类型是身份证，才做校验
	if(id_card_type == 1){
		if(!isChinaIDNo(obj)){
			f_alert(obj,"证件格式错误");
			return false;
		}
	}
	return true;
}
/**
 * 服务器端校验证件号码
 */
function checkIdcardServer(activeEntity,newValue){//2012-11-27陈小佩修改
	var type = activeEntity.getValue("id_card_type");
	//编辑之前的证件号码值
	var id_card = activeEntity.getValue("id_card");
	var emp_name = activeEntity.getValue("emp_name");
	var emp_code = activeEntity.getValue("emp_code");
	
	var dc_emp = $id("dc_emp");
	jQuery.post(dir_base + "/EmpSendInfoAction.do?cmd=checkEmp",
        		{empName:emp_name, empCode:emp_code, empCardType:type, cardCode:newValue},      
	            function(data){
	                if(data){
	                	var empName = data.emp_name;
	                    var empCode = data.emp_code;
	                    var cardCode = data.id_card;
	                    var empCardType = data.id_card_type_bd;
	                    var emp_status = data.emp_status;//1未报入职2在职3离职
	                    var msg = data.msg;
	                    if(msg == "MSG_IDCARD_ERROR"){
	                       alert("身份证格式错误！");
	                    }else if(msg == "MSG_EMP_EXSIT"){
	                       alert("该员工已派出或已在职，不能重复派出！");
                           activeEntity.setProperty("id_card", id_card);//还原回去
                           dc_emp.refreshRow(dc_emp.getActiveRow(),activeEntity);
	                    }else if(msg == "MSG_OK"){
	                    	if(emp_status==3||emp_status==0){
		                    	//回填员工姓名
	                    		activeEntity.setProperty("emp_name", empName);
		                    	//回填员工编号
	                    		activeEntity.setProperty("emp_code", empCode);
		                    	//回填证件号码,如果输入的是15位的身份证时,自动回填18位的
	                    		activeEntity.setProperty("id_card_type", empCardType);
	                    		activeEntity.setProperty("id_card", cardCode);
	                    		//刷新行
	                    		dc_emp.refreshRow(dc_emp.getActiveRow(),activeEntity);
	                    	}else if(newValue.length==15){
	                    		//回填证件号码,输入的是15位的身份证时,自动回填18位的
	                    		activeEntity.setProperty("id_card", cardCode);
	                    		//刷新行
	                    		dc_emp.refreshRow(dc_emp.getActiveRow(),activeEntity);
	                    	}
	                    }
	                    
	                }
	            },
	            "json"
        	);
}