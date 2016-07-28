/*树相关脚本 start*/
	var webModel=null;
	var oldObj=null;
	var updateNodesstatus;
	/**当树的节点得到焦点时，节点内容高亮，取消上次选择节点的样式**/
	function treeNodeOnfocus(obj){
		if (oldObj != null) {
			oldObj.className='';
		}
		obj.className='tree_node_onfocus';
		oldObj=obj;
		setButtonForNoDisabled("addButton",false);
		setButtonForNoDisabled("deleteButton",false);
	}
	/**当树的节点失去焦点时，判断当前获得焦点的控件名称是否为'SPAN'，是，取消节点的样式**/
	function treeNodeOnblur(obj){
		if (document.activeElement.tagName == 'SPAN') {
			oldObj.className='';
		}
	}
	//设置按钮的disabled属性
	function setButtonForNoDisabled(buttonId,flag){
		var obj=document.getElementById(buttonId);
		obj.disabled=flag;
	}
	
	//DWR回调函数，在SPAN中显示节点名
	function populateSpan(data){
		var nodeSpan=document.getElementById(data.span_id);
		nodeSpan.innerHTML=data.name;
	}
	//DWR回调函数，在层中显示组装好的HTML语句
	function populateDiv(data){   
		var divTree=document.getElementById(data.divid);
		if(data.treevalue!=""){
			divTree.innerHTML="<ul class='baseNode'>"+data.treevalue+"</ul>";
		}else{
			divTree.innerHTML=data.treevalue;
		}
		if(data.rootFlag!=null){
			form_treebasic.rootFlag.value=data.rootFlag;
		}
	} 
		//删除节点后，隐藏树节点的显示
	function setUlOrLiForDisabled(data){
		var obj=document.getElementById(data.treeLabel);
		obj.style.display="none";
	}
	//改变节点的显示图片，节点的属性
	function changeNodeAttribute(data){
		if(data.imgId!=null){
			changeImages(data.nodeType,data.imgId);
			changeNodeDiv(data);
		}
	}
	//改变节点层的属性
	function changeNodeDiv(data){
		var divTree=document.getElementById(data.divid);
		divTree.open=data.divOpen;
		divTree.style.display=data.divStyple;
		divTree.data=data.divData;
		divTree.type=data.nodeType;
	}
	//改变图片
	function changeImages(type,imgid){
	var img=document.getElementById(imgid);
		if(type=='base'|| type=="root"){
			img.src=webModel+"/images/tree/folderopen.gif";
		}else{
			img.src=webModel+"/images/tree/file.gif";
		}
	}
	
	//节点展开,图片变化
	function extendImages(type,imgid){
		if(type=='base'|| type=="root"){
			var img=document.getElementById(imgid);
			img.src=webModel+"/images/tree/folderopen.gif";
		}
	}
	//节点回收,图片变化 
	function callbackImages(type,imgid){
		if(type=='base'|| type=="root"){
			var img=document.getElementById(imgid);
			img.src=webModel+"/images/tree/folder.gif";
		}
	}
	
	
	//错误信息处置
	function eh(msg) { 
		alert("错误信息："+msg); 
		//var div_msg=document.getElementById("msg");
  		//div_msg.innerHTML=msg;
	} 
	
	//初始化树
	function initTree(node,divid){
		//获取当前的发布目录
		webModel=form_treebasic.webModel.value;
		DWREngine.setErrorHandler(eh); 
		TreeControl.initTree(node,beanId,{},populateDiv);
	}

	//展开所选节点 
	function onExtend(node,imgid){
		var divTree=document.getElementById("div_"+node);
		if(jQuery(divTree).attr("open")=="false"&& jQuery(divTree).attr("data")=="true") {//数据已加载，节点为收缩状态
			extendImages(jQuery(divTree).attr("type"),imgid);
			if(jQuery(divTree).attr("type")=="base" || jQuery(divTree).attr("type")=="root"){
				jQuery(divTree).show();
			}
			jQuery(divTree).attr("open","true");
			return;
		}
		if(jQuery(divTree).attr("open")=="false"&& jQuery(divTree).attr("data")=="false"){//数据没有加载，节点为收缩状态
			DWREngine.setErrorHandler(eh); 
			var map={"id":node,"divid":"div_"+node};
			TreeControl.extendNode(map,beanId,{},populateDiv);//加载数据
			extendImages(jQuery(divTree).attr("type"),imgid);//变化节点显示图片 
			jQuery(divTree).attr("open","true");
			jQuery(divTree).attr("data","true");
			if(jQuery(divTree).attr("type")=='base'|| jQuery(divTree).attr("type")=='root'){jQuery(divTree).show();}
			return;
		}
		if(jQuery(divTree).attr("open")=="true"&& jQuery(divTree).attr("data")=="true"){//数据已加载，节点为展开状态
			callbackImages(jQuery(divTree).attr("type"),imgid);
			jQuery(divTree).hide();
			jQuery(divTree).attr("open","false");
			return;
		}
	}
/*树相关脚本 end*/

/*业务信息相关脚本	start*/
		//点击新增按钮
	function addNode_onClick(){
		//载入新增页面
		TreeControl.getInclude(getDetailPage(),function(data) {
			dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
			});		
		editFlag="add";
		updateNodesstatus=document.getElementById("updateNodes").disabled;
		setButtonForNoDisabled("deleteButton",true);
		setButtonForNoDisabled("updateNodes",false);
	}
	
	function saveNode_onClick(){
		//载入新增页面
		if(editFlag=="add")
		{
			addNode();
		}else if(editFlag="modify")
		{
			updateNode();
		}
		//setButtonForNoDisabled("updateNodes",updateNodesstatus);
	}

		//点击新增根节点按钮
	function addRoot_onClick(){
		
		if(form_treebasic.rootFlag.value=="yes"){
			alert("当前页面已经有根节点");
			return true;
		}
		//显示新增根节点信息
		document.getElementById('newTreeRootDiv').style.display="block";
		//载入新增页面
		includeAddRootPage();
		//隐藏修改信息
		document.getElementById('treeNodeDiv').style.display="none";
	}
	//点击删除按钮
	function deleteNode_onClick(){
		if(confirm("是否彻底删除该节点？"))
		{
			editFlag="edit";
			//删除选择的节点
			deleteNode();
		}
	}
	
	function displayNode(nodeId,divid){
		editFlag="modify";
		//显示详细信息页面
		//document.getElementById("rightPanel").style.display="block";
		jQuery("#rightPanel").show();
		
		//document.getElementById("default").style.display="none";
		jQuery("#default").hide();
		//载入修改页面
		TreeControl.getInclude(getDetailPage(),function(data) {
			dwr.util.setValue('treeNodeMessageDiv', data, { escapeHtml:false });
			DWREngine.setErrorHandler(eh); 
			//document.getElementById("id").value=nodeId;
			jQuery("#id").val(nodeId);
			//document.getElementById("divid").value=divid;
			jQuery("#id").val(divid);
			TreeControl.getNodeMessage(nodeId,beanId,function(data){
				curData=data;
				if(data.isLeaf==0)
				{
					document.getElementById("deleteButton").disabled=true;
				}else
				{
					document.getElementById("deleteButton").disabled=false;
				}
				if(data.levelNum==1)
				{
					document.getElementById("updateNodes").disabled=true;
					//document.getElementById("treeNodeMessageDiv").disabled=true;
				}else
				{
					document.getElementById("updateNodes").disabled=false;
					//document.getElementById("treeNodeMessageDiv").disabled=false;
				}	
				setForms(data);
				});
			});
	}


/*业务信息相关脚本	end*/	
	
	
	
