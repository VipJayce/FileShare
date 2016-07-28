function changeObject(parentObject,name) {
	// parentObj:父对象
	this.name=name;
	if (typeof (parentObject) != "object") {
		this.parentObj = document.getElementById(parentObject);
	} else {
		this.parentObj = parentObject;
	}
	this.seperator="#";
	this.mode=1;// 使用模式（1：选择2：转移）
	this.sortitems=0;
	this.multiSelect=false;
	this.showHint=true;
	this.fullName =false;
	this.changePanel=jQuery("<div></div>").get(0);
	this.leftBox=jQuery('<div style="float: left;"></div>').get(0);
	this.rightBox=jQuery('<div style="float: right;"></div>').get(0);
	this.leftTitle=document.createElement("DIV");
	this.rightTitle=document.createElement("DIV");
	this.leftList = document.createElement("DIV");
	this.rightList = document.createElement("DIV");
	this.controlBox = jQuery('<div style="float: left;MARGIN-LEFT: 2px; MARGIN-TOP: 15px;"></div>').get(0);
	this.leftHint= document.createElement("SPAN");
	this.rightHint= document.createElement("SPAN");
	// this.leftTitle.style.height="20px";
	// this.rightTitle.style.height="20px";
	this.leftHint.style.width="200px";
	this.leftHint.id="leftHint";
	this.leftHint.style.wordBreak="break-all";
	this.rightHint.style.width="200px";
	this.rightHint.id="rightHint";
	this.rightHint.style.wordBreak="break-all";
	this.changePanel.style.backgroundColor="#d9e8fb";
	this.changePanel.style.width="460px";
	this.changePanel.style.height="450px";
	this.leftBox.appendChild(this.leftTitle);
	this.leftBox.appendChild(this.leftList);
	this.leftBox.appendChild(this.leftHint);
	this.rightBox.appendChild(this.rightTitle);
	this.rightBox.appendChild(this.rightList);
	this.rightBox.appendChild(this.rightHint);
	// this.controlBox.style.backgroundColor="#d9e8fb";
	this.controlBox.style.padding="20px;5px;20px;5px ";
	this.leftList.innerHTML="<select id='leftSelect' size=14 style='width:204px' onclick='"+eval("name")+".showLeftHint(this)'></select>";
	this.rightList.innerHTML="<select id='rightSelect' size=14 style='width:204px' onclick='"+eval("name")+".showRightHint(this)'></select>";
	var controlStr='';
	controlStr+='<input type="button" class="button_ellipse" style="width:35px" value=" >  " onclick="'+eval("name")+'.leftToRight()" name="B1"/>';
    controlStr+='<br/><input type="button" class="button_ellipse" style="width:35px" value=" <  " onclick="'+eval("name")+'.rightToLeft()" name="B2"/>';
	controlStr+='<br/><input type="button" src="up.gif" class="button_ellipse" style="width:35px" value=" ↑ " onclick="'+eval("name")+'.moveUp()" name="B3"/>';
	controlStr+='<br/><input type="button" class="button_ellipse" style="width:35px" value=" ↓ " onclick="'+eval("name")+'.moveDown()" name="B4"/>';
	this.controlBox.innerHTML=controlStr;
	this.changePanel.appendChild(this.leftBox);
	this.changePanel.appendChild(this.controlBox);
	this.changePanel.appendChild(this.rightBox);
	this.parentObj.innerHTML='';
	this.parentObj.appendChild(this.changePanel);
}

changeObject.prototype.setLeftData=function setLeftData(data,dispName,valueName,condition)
{       
	var leftSelect = this.leftList.firstChild;
	this._setData(leftSelect,data,dispName,valueName,condition,this.showHint);
}

changeObject.prototype.setRightData=function setRightData(data,dispName,valueName,condition)
{       
	var rightSelect = this.rightList.firstChild;
	this._setData(rightSelect,data,dispName,valueName,condition,this.showHint);
}

changeObject.prototype._setData=setComboxData;
changeObject.prototype.SortD=function SortD(box)
{
	var temp_opts = new Array();
	var temp = new Object();
	for(var i=0; i<box.options.length; i++)
	{
		temp_opts[i] = box.options[i];
	}
	for(var x=0; x<temp_opts.length-1; x++)
	{
		for(var y=(x+1); y<temp_opts.length; y++)
		{
			if(temp_opts[x].text > temp_opts[y].text)
			{
				temp = temp_opts[x].text;
				temp_opts[x].text = temp_opts[y].text;
				temp_opts[y].text = temp;
				temp = temp_opts[x].value;
				temp_opts[x].value = temp_opts[y].value;
				temp_opts[y].value = temp;
			}
		}
	}
	for(var i=0; i<box.options.length; i++)
	{
		box.options[i].value = temp_opts[i].value;
		box.options[i].text = temp_opts[i].text; 
	}
}
// 处理掉空值option
changeObject.prototype.BumpUp=function BumpUp(box)  
{
	for(var i=0; i<box.options.length; i++)
	{
		if(box.options[i].value == "")
		{
			for(var j=i; j<box.options.length-1; j++)
			{
				box.options[j].value = box.options[j+1].value;
				box.options[j].text = box.options[j+1].text;
			}
			var ln = i;
			break;   
		}
	}
	if(ln < box.options.length)
	{
		box.options.length -= 1;
		BumpUp(box);   
	}
}

changeObject.prototype.leftToRight=function _leftToRight() 
{	
	this._move(this.leftList.firstChild,this.rightList.firstChild);
}

changeObject.prototype.rightToLeft=function _rightToLeft() 
{
			this._move(this.rightList.firstChild,this.leftList.firstChild);
}

changeObject.prototype.showLeftHint=function showLeftHint(obj) 
{
	if(obj.selectedIndex >= 0){
		this.leftHint.innerHTML=obj.options[obj.selectedIndex].text;
	}
}
changeObject.prototype.showRightHint=function showRightHint(obj) 
{
	if(obj.selectedIndex >= 0){
		this.rightHint.innerHTML=obj.options[obj.selectedIndex].text;
	}
}
// 将fbox中的选中项选择或转移到tbox中
changeObject.prototype._move=function move(fbox,tbox) 
{
	var fromcount=0;
	var length=fbox.options.length;
	for(var i=0; i<length; i++) 
	{
		if(fbox.options[i-fromcount].selected && fbox.options[i-fromcount].value != "")
		{
			if(this.mode==1)
			{
				if(fbox==this.rightList.firstChild)// 从右至左
				{
					fbox.options[i-fromcount]=null;
					fromcount++;
				}else// 从左至右
				{
					var no = new Option();
					no.value = fbox.options[i].value;
					// alert(dwr.util.toDescriptiveString(this.leftTitle.firstChild,2));
					if(this.leftTitle.firstChild.options && this.fullName)// 如果leftTitle是下拉框
					{
						no.text = this.leftTitle.firstChild.options[this.leftTitle.firstChild.selectedIndex].text+this.seperator+fbox.options[i].text;
					}else
					{
						no.text = fbox.options[i].text;
					}
					if(this.showHint)
						no.title=no.text;
					tbox.options[tbox.options.length]=no;
				}
			}else if(this.mode==2)
			{
				var no = new Option();
				no.value = fbox.options[i].value;
				no.text = fbox.options[i].text;
				tbox.options[tbox.options.length] = no;
				fbox.options[i-fromcount]=null;
				fromcount++;
			}
		}
	}
	this.BumpUp(fbox);
	if (this.sortitems)
		SortD(tbox);
}

// 将右边列表框中的选中项上移
changeObject.prototype.moveUp=function moveUp(isToTop){
	this._SelectMoveUp(this.rightList.firstChild,isToTop);
}
changeObject.prototype.moveDown=function moveUp(isToTop){
	this._SelectMoveDown(this.rightList.firstChild,isToTop);
}
/*******************************************************************************
 * 功能 ： 使列表框所选中的项目上移 函数名 ： SelectMoveUp 参数1 ： oSelect 源列表框对象 如:
 * document.getElementById("name") 参数2 ： isToTop 是否移至选择项到顶端，其它依次下移
 * true为移动到顶端，false反之，默认为false 说明 ：
 * SelectMoveUp(document.getElementById("name"),true);
 ******************************************************************************/
changeObject.prototype._SelectMoveUp=function SelectMoveUp( oSelect,isToTop )
{
        if( isToTop == null ) var isToTop = false; // 默认状态不是移动到顶端

        if( oSelect.multiple ) // 如果是多选
        {
                for( var selIndex=0; selIndex<oSelect.options.length; selIndex++ )
                {
                        if(isToTop) // 如果设置了移动到顶端标志
                        {
                                if( oSelect.options[selIndex].selected )
                                {
                                var transferIndex = selIndex;
                                while(transferIndex > 0 && !oSelect.options[transferIndex - 1].selected)
                                {
                                        swapNode(oSelect.options[transferIndex],oSelect.options[transferIndex - 1]);
                                        //oSelect.options[transferIndex].swapNode(oSelect.options[transferIndex - 1]);
                                        transferIndex --;
                                }
                                }
                        }
                        else // 没有设置移动到顶端标志
                        {
                                if(oSelect.options[selIndex].selected)
                                {
                                if(selIndex > 0)
                                {
                                		//show(oSelect.options[selIndex].swapNode,4);
                                        if(!oSelect.options[selIndex - 1].selected){
                                        	swapNode(oSelect.options[selIndex],oSelect.options[selIndex - 1]);
                                        } 
                                        //oSelect.options[selIndex].swapNode(oSelect.options[selIndex - 1]);
                                }
                                }
                        }
                }
        }
        else // 如果是单选
        {
                var selIndex = oSelect.selectedIndex;
                if(selIndex <= 0) return;

                if(isToTop) // 如果设置了移动到顶端标志
                {
                        while(selIndex > 0)
                        {
                                swapNode(oSelect.options[selIndex],oSelect.options[selIndex - 1]);
                                //oSelect.options[selIndex].swapNode(oSelect.options[selIndex - 1]);
                                selIndex --;
                        }
                }
                else // 没有设置移动到顶端标志
                {
                        swapNode(oSelect.options[selIndex],oSelect.options[selIndex - 1]);
                        //oSelect.options[selIndex].swapNode(oSelect.options[selIndex - 1]);
                }
        }
}
/*******************************************************************************
 * 功能 ： 使列表框所选中的项目下移 函数名 ： SelectMoveDown 参数1 ： oSelect 源列表框对象 如:
 * document.all.name 参数2 ： isToBottom 是否移至选择项到底端，其它依次下移
 * true为移动到底端，false反之，默认为false 说明 ： SelectMoveDown(document.all.name,true);
 ******************************************************************************/

changeObject.prototype._SelectMoveDown=function SelectMoveDown( oSelect,isToBottom)
{
        if(isToBottom == null) var isToBottom = false; // 默认状态不是移动到顶端

        var selLength = oSelect.options.length - 1;

        if(oSelect.multiple) // 如果是多选
        {
        for(var selIndex=oSelect.options.length - 1; selIndex>= 0; selIndex--)
        {
                if(isToBottom) // 如果设置了移动到顶端标志
                {
                        if(oSelect.options[selIndex].selected)
                        {
                        var transferIndex = selIndex;
                        while(transferIndex < selLength && !oSelect.options[transferIndex + 1].selected)
                        {
                                swapNode(oSelect.options[transferIndex],oSelect.options[transferIndex + 1]);
                                //oSelect.options[transferIndex].swapNode(oSelect.options[transferIndex + 1]);
                                transferIndex ++;
                        }
                        }
                }
                else // 没有设置移动到顶端标志
                {
                        if(oSelect.options[selIndex].selected)
                        {
                        if(selIndex < selLength)
                        {
                                if(!oSelect.options[selIndex + 1].selected){
                                	swapNode(oSelect.options[selIndex],oSelect.options[selIndex + 1]);
                                	//oSelect.options[selIndex].swapNode(oSelect.options[selIndex + 1]);
                                }
                        }
                        }
                }
        }
        }
        else // 如果是单选
        {
                var selIndex = oSelect.selectedIndex;

                if(selIndex >= selLength - 1) return;

                if(isToBottom) // 如果设置了移动到顶端标志
                {
                        while(selIndex < selLength - 1)
                        {
                                swapNode(oSelect.options[selIndex],oSelect.options[selIndex + 1]);
                                //oSelect.options[selIndex].swapNode(oSelect.options[selIndex + 1]);
                                selIndex ++;
                        }
                }
                else // 没有设置移动到顶端标志
                {
                        swapNode(oSelect.options[selIndex],oSelect.options[selIndex + 1]);
                        //oSelect.options[selIndex].swapNode(oSelect.options[selIndex + 1]);
                }
        }
}
changeObject.prototype.setLeftTitle=function setLeftTitle(title)
{
	if(typeof (title) == "string")	
	{
		this.leftTitle.innerHTML='';
		this.leftTitle.innerHTML=title;
	}
	else
	{
		this.leftTitle.innerHTML='';
		this.leftTitle.appendChild(title);	
	}
		
}

changeObject.prototype.setRightTitle=function setRightTitle(title)
{
	if(typeof (title) == "string")	
	{
		this.rightTitle.innerHTML='';
		this.rightTitle.innerHTML=title;
	}else
	{
		this.rightTitle.innerHTML='';
		this.rightTitle.appendChild(title);
	}
}

changeObject.prototype.setSort=function setSort(flag)
{
	this.sortitems=flag;
}

changeObject.prototype.getRightData=function getRightData(beanFunc,valueName,dispName,sortName,param)
{
	var rightSelect = this.rightList.firstChild	;
	var dataList = new Array();
	for(var i=0;i<rightSelect.options.length;i++)
	{
		var bean = beanFunc(param);
		if(dispName)
			bean[dispName]=rightSelect.options[i].text;
		if(valueName)
			bean[valueName]=rightSelect.options[i].value;
		if(sortName)
			bean[sortName]=i;
		// alert(dwr.util.toDescriptiveString(rightSelect.options[i].data,3));
		dataList[dataList.length]=bean;	
	}
	return dataList;
}

changeObject.prototype.getRightSelect=function getRightSelect()
{
	var rightSelect = this.rightList.firstChild;
	return rightSelect;
}

changeObject.prototype.setMultiSelect=function setMultiSelect(mode)
{
	this.multiSelect=mode;
	if(this.multiSelect)
	{
		this.leftList.firstChild.multiple="multiple";
		this.rightList.firstChild.multiple="multiple";
	}else
	{
		this.leftList.firstChild.multiple="";
		this.rightList.firstChild.multiple="";
	}
}


//为combox填充数据
function setComboxData(box,data,dispName,valueName,condition,showHint)
{
	 //alert(dwr.util.toDescriptiveString(data,2));
	box.options.length=0;
	if(dispName!=""&&valueName!="")
	{
		var size = data.length;
		for(var i=0;i<size;i++)
		{
			var bean= data[i];
			var item = new Option();
			if(condition)
			{
				var arr = condition.split('==');
				if(eval("bean."+arr[0])!=arr[1])
					continue;
			}
			if(valueName)
			{
			var valueNames = valueName.split('+');
			if(valueNames.length)
			{
				for(var j=0;j<valueNames.length;j++)
				{
					if(j==valueNames.length-1)
						item.value=item.value+eval("bean."+valueNames[j]);
					else
						item.value=item.value+eval("bean."+valueNames[j])+'#';
				}
				
			}}else
			{
				item.value=bean;
			}
			//alert(dwr.util.toDescriptiveString(item.value));
			if(dispName)
			{
				var dispNames = dispName.split('+');			
				if(dispNames.length)
				{
					for(var j=0;j<dispNames.length;j++)
					{
						if(j==dispNames.length-1)
							item.text=item.text+eval("bean."+dispNames[j]);
						else
							item.text=item.text+eval("bean."+dispNames[j])+'#';
					}
				}
			}
			else
				item.text=bean;
			if(showHint)
				item.title=item.text;				
			box.options[box.options.length]=item;
		}
	}else
	{
		for (var i = 0; i < data.length; i++) {
			var attr = data[i];
			if (attr.length) {
				attr.value = attr[0] || "";
				attr.text = attr[1] || "";
			}
			var item = new Option();
			item.value=attr.value;
			item.text=attr.text;
			item.data=attr;
			box.options[box.options.length]=item;
		}	
	}
}