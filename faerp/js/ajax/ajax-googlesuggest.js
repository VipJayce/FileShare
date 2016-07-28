<!--

// script by blueDestiny
// email : blueDestiny [at] 126 . com

// Object: jsAuto
// browser: ie, mf.
// example:

// step1 : 
// create autocomplete container, return object and bind event to the object, and 
///create a new jsAuto instance:
// <div id="divautocomplete"></div>
// var autocomplete = new jsAuto("autocomplete","divautocomplete")
// handle event:
// autocomplete.handleEvent(value, returnObjectID)
// <input id="rautocomplete" onkeyup="autocomplete.handleEvent(this.value,"ratocomplete",event)>

// step2 :
// add autocompete item:
// autocomplete.item(string)
// string must be a string var, you can split the string by ","
// autocomplete.item("blueDestiny,never-online,csdn,blueidea")

// http://www.never-online.com

function jsAuto(instanceName,objID)
{
	this._msg = [];
	this._x = null;
	this._o = document.getElementById( objID );
	if (!this._o) return;
	this._f = null;
	this._i = instanceName;
	this._r = null;
	this._c = 0;
	this._s = false;
	this._v = null;
	this._o.style.visibility = "hidden";
	this._o.style.position = "absolute";
	this._o.style.zIndex = "9999";
	return this;
};

jsAuto.prototype.directionKey=function() { with (this)
{
	var e = _e.keyCode ? _e.keyCode : _e.which;
	var l = _o.childNodes.length;
	(_c>l-1 || _c<0) ? _s=false : "";

	if( e==40 && _s )
	{
		_o.childNodes[_c].className="mouseout";
		(_c >= l-1) ? _c=0 : _c ++;
		_o.childNodes[_c].className="mouseover";
	}
	if( e==38 && _s )
	{
		_o.childNodes[_c].className="mouseout";
		_c--<=0 ? _c = _o.childNodes.length-1 : "";
		_o.childNodes[_c].className="mouseover";
	}
	if( e==13 )
	{
		if(_o.childNodes[_c] && _o.style.visibility=="visible")
		{
		//不带结果start
			//_r.value = _x[_c];
		//不带结果end
		
		//带结果start
			_r.value = _x[_c].split("&$")[0];
		//带结果end
			_o.style.visibility = "hidden";
		}
	}
	if( !_s )
	{
		_c = 0;
		_o.childNodes[_c].className="mouseover";
		_s = true;
	}
}};

// mouseEvent.
jsAuto.prototype.domouseover=function(obj) { with (this)
{
	_o.childNodes[_c].className = "mouseout";
	_c = 0;
	obj.tagName=="DIV" ? obj.className="mouseover" : obj.parentElement.className="mouseover";
}};
jsAuto.prototype.domouseout=function(obj)
{
	obj.tagName=="DIV" ? obj.className="mouseout" : obj.parentElement.className="mouseout";
};
jsAuto.prototype.doclick=function(msg) { with (this)
{
	if(_r)
	{
		//不带结果start
		//_r.value = msg;
		//不带结果end
		
		//带结果start
		_r.value = msg.split("&$")[0];
		//带结果end
		_o.style.visibility = "hidden";
	}
	else
	{
		alert("javascript autocomplete ERROR :\n\n can not get return object.");
		return;
	}
}};
function ltrim(s){
return s.replace(/(^s*)/g, "");
}

// object method;
jsAuto.prototype.item=function(msg)
{
	if( msg.indexOf(",")>0 )
	{
		var arrMsg=msg.split(", ");
		for(var i=0; i<arrMsg.length; i++)
		{
			//s.replace(/(^s*)/g, "");
			arrMsg[i] ? this._msg.push(ltrim(arrMsg[i])) : "";
			//alert("("+ltrim(arrMsg[i])+")");
		}
	}
	else
	{
		this._msg.push(msg);
	}
	this._msg.sort();
};
jsAuto.prototype.append=function(msg) { with (this)
{
	_i ? "" : _i = eval(_i);
	_x.push(msg);
	var div = document.createElement("DIV");

	//bind event to object.
	div.onmouseover = function(){_i.domouseover(this)};
	div.onmouseout = function(){_i.domouseout(this)};
	div.onclick = function(){_i.doclick(msg)};
	var re  = new RegExp("(" + _v + ")","i");
	div.style.lineHeight="140%";
	div.className = "mouseout";
	//不带结果start
	if (_v) div.innerHTML = msg.replace(re , "<strong>$1</strong>");
	//不带结果end
	//带结果start
	//var msg2= msg.split("&$")[0];
	//var msgNum= msg.split("&$")[1];
	//var msgNum= 1;
	//if (_v)div.innerHTML = "<span class='leftspan'>" + msg2.replace(re, "<strong>$1</strong>") + "</span><span class='rightspan'>"+msgNum+"结果</span>";
	//带结果end
	div.style.fontFamily = "verdana";

	_o.appendChild(div);
}};
jsAuto.prototype.display=function() { with(this)
{
	if(_f&&_v!="")
	{
		_o.style.width = _r.offsetWidth;
		_o.style.left = getLeft(_r);  // 设定显示区域的位罄1�7
		_o.style.top = getTop(_r)+ _r.offsetHeight;
		_o.style.visibility = "visible";
	}
	else
	{
		_o.style.visibility="hidden";
	}
}};
jsAuto.prototype.changeposition=function(x,y) { with(this)
{
		_o.style.left = x;
		_o.style.top = y;
		//_o.style.left = _r.offsetLeft;
		//_o.style.width = _r.offsetWidth;
		//_o.style.top = _r.offsetTop + _r.offsetHeight;
		//alert("_r.offsetLeft = "+_r.offsetLeft+" _r.offsetWidth = "+_r.offsetWidth+" _o.style.top = "+_o.style.top);
}};

jsAuto.prototype.handleEvent=function(fValue,fID,event) { with (this)
{
	var re;
	_e = event;
	var e = _e.keyCode ? _e.keyCode : _e.which;
	_x = [];
	_f = false;
	_r = document.getElementById( fID );
	_v = fValue;
	_i = eval(_i);
	re = new RegExp("^" + fValue + "", "i");
	_o.innerHTML="";

	for(var i=0; i<_msg.length; i++)
	{
		if(re.test(_msg[i]))
		{
			_i.append(_msg[i]);
			_f = true;
		}
	}

	_i ? _i.display() : alert("can not get instance");

	if(_f)
	{
		if((e==38 || e==40 || e==13))
		{
			_i.directionKey();
		}
		else
		{
			_c=0;
			_o.childNodes[_c].className = "mouseover";
			_s=true;
		}
	}
}};
window.onerror=new Function("return true;");
//-->

