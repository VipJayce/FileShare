	function switchTab(tabpage,tabid){ 
		var oItem=document.getElementById(tabpage);         
	  	for(var i=0;i<oItem.children.length;i++){   
	  		var x = oItem.children[i];   
	  		x.className="";   
	  		var y=x.getElementsByTagName('a');   
	  		y[0].style.color="#333333";   
	  	}
	  	document.getElementById(tabid).className="Selected";   
	  	var dvs=document.getElementById("cnt").childNodes; 
	  	for(var i=0;i<dvs.length;i++){
	  	//马啸修改 firefox认为"\n"也是一个子节点,节点名称叫做"textNode"
	  	    if(dvs[i].nodeType==3)
	  	        continue;   
	  	//马啸修改结束
      		if(dvs[i].id==('d'+tabid)  )   
        		dvs[i].style.display='block';   
      		else   
          		dvs[i].style.display='none';   
  		}  
  		if(typeof(onTabChange)!="undefined") 
  		{
  			onTabChange(tabid);
  		}
  	} 