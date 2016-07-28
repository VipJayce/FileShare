/*马啸添加 start*/
    var webModel=null;
    var oldObj=null;
    
    /**当树的节点得到焦点时，节点内容高亮，取消上次选择节点的样式**/
    function treeNodeOnfocus(obj){
        if (oldObj != null) {
            oldObj.className='';
        }
        obj.className='tree_node_onfocus';
        oldObj=obj;
       setButtonForNoDisabled("addButton","addButtonTd", addNode_onClick ,false);
        setButtonForNoDisabled("deleteButton","deleteButtonTd", deleteNode_onClick ,false);
    }

    //设置按钮的disabled属性
    function setButtonForNoDisabled(buttonId,buttonTdId,eventName,flag){
        var obj=document.getElementById(buttonId);
     //   obj.disabled=flag;
        if(flag==false){
        	if(document.getElementById(buttonTdId)!= null )
          document.getElementById(buttonTdId).style.color="#000000";
          jQuery("#"+buttonTdId).live( "click", eventName );
        }else{
        	if(document.getElementById(buttonTdId)!= null )
          document.getElementById(buttonTdId).style.color="#ACA899";
          jQuery("#"+buttonTdId).die( "click" );
        }
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
        alert(i18n.error_message+"："+msg); 
        var div_msg=document.getElementById("msg");
        div_msg.innerHTML=msg;
    } 
    //初始化树
    function initTree(node,divid,paramsMap){
        //获取当前的发布目录
        webModel=form_treebasic.webModel.value;
        DWREngine.setErrorHandler(eh); 
        TreeAjax.initTree(node,beanId,paramsMap,populateDiv);
    }

    //展开所选节点 
    function onExtend(node,imgid){
        var divTree=jQuery("#div_"+node.replace(/\./g,"\\."));//把"."转换为"\.",jQuery对特殊字符不支持(规则引擎业务对象树节点带有.，如gap.use.com.person)
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
            //默认的过滤条件
            var paramsMap={};
            //用户扩展过滤条件
            extendsParamsMap(paramsMap);
            TreeAjax.extendNode(map,beanId,paramsMap,populateDiv);//加载数据
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
        //隐藏新增信息
        divExtend('newTreeNodeDiv',"none");
        //隐藏修改信息
        divExtend('treeNodeDiv',"none");
    }

        //点击新增按钮
    function addNode_onClick(){
        //显示新增信息
        divExtend('newTreeNodeDiv',"block");
        //载入新增页面
        includeAddPage();
        //隐藏修改信息
        divExtend('treeNodeDiv',"none");
    }
    
        //点击新增根节点按钮
    function addRoot_onClick(){
        
        if(form_treebasic.rootFlag.value=="yes"){
            alert(i18n.current_page_has_root_node);
            return true;
        }
        //显示新增根节点信息
        divExtend('newTreeRootDiv',"block");
        //载入新增页面
        includeAddRootPage();
        //隐藏修改信息
        divExtend('treeNodeDiv',"none");
    }
    //点击删除按钮
    function deleteNode_onClick(){
        if(confirm(i18n.confirm_to_delete_node)) {
            nodeDivHide();
            //删除选择的节点
            deleteNode();
        }
    }
    //控制层的显示和隐藏
    function divExtend(divid,style){
        //var divElement=document.getElementById(divid);
        //divElement.style.display=style;
        if(style=="none"){
          jQuery("#"+divid).hide();
        }else{
          jQuery("#"+divid).show();
        }
    }
    //隐藏节点信息 
    function nodeDivHide(){
        //隐藏新增节点保存按钮
        divExtend('newTreeNodeDiv',"none");
        //隐藏修改节点保存按钮
        divExtend('treeNodeDiv',"none");
        //隐藏新增根节点保存按钮
        divExtend('newTreeRootDiv',"none");
        //隐藏用户页面
        divExtend('treeNodeMessageDiv',"none");
    }
    
/*马啸添加 end*/