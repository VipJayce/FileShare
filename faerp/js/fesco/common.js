//�����ɫ��ʽ
		function add_event(tr){
			tr.onmouseover = function(){
				tr.className += ' hover';
			};
			tr.onmouseout = function(){
				tr.className = tr.className.replace(' hover', '');
			};
		}

		function stripe(table) {
			var trs = table.getElementsByTagName("tr");
			for(var i=1; i<trs.length; i++){
				var tr = trs[i];
				tr.className = i%2 != 0? 'odd' : 'even';
				add_event(tr);
			}
		}

		window.onload = function(){
			var tables = document.getElementsByTagName('table');
			for(var i=0; i<tables.length; i++){
				var table = tables[i];
				if(table.className == 'datagrid1' || table.className == 'datagrid2'
					|| table.className == 'datagrid3' || table.className == 'datagrid4'){
					stripe(tables[i]);
				}
			}
		}



//����ҳ��
var MyWin = new Win();
var imgfile = "../images/";//����ͼƬ·������Ի��Զ���
var imgname=new Array();
var img = new Array();
//Ԥ�ȼ���ͼƬ
imgname[0] = imgfile+"clo.gif";
imgname[1] = imgfile+"b1.png";
imgname[2] = imgfile+"l1.png";
imgname[3] = imgfile+"l2.png";
imgname[4] = imgfile+"r1.png";
imgname[5] = imgfile+"r2.png";
imgname[6] = imgfile+"t1.png";
imgname[7] = imgfile+"t2.png";
imgname[8] = imgfile+"t3.png";
//Ԥ��ͼƬ
for (i=0;i<=imgname.length-1;i++)
{
   img[i] = new Image();
   img[i].src = imgname[i];
}//��ӭ����վ����Ч��b���ǵ���ַ��www.zzjs.net���ܺüǣ�zzվ����js����js��Ч����վ�ռ�����������js���룬���������������ء�
var zIndex = 0;
var Winid  = 0;
var Ie = /msie/i.test(navigator.userAgent);
function $(Id){return(document.getElementById(Id))}
function Win()
{//��ӭ��c��վ����Ч�����ǵ���ַ��www.zzjs.net���ܺüǣ�zzվ����js����js��Ч����վ�ռ�����������js���룬���������������ء�
 this.Create = function(mask,title, wbody, w, h, l, t)
 {
  Winid++;
  mask = mask;
  title = title || "վ����Ч������С�";
  wbody = wbody || " <p align='center'>�������롭</p>";
  w = w || 350;
  h = h || 150;
  cw = document.documentElement.clientWidth;
  ch = document.documentElement.clientHeight;
  sw = document.documentElement.scrollWidth;
  sh = document.documentElement.scrollHeight;
        st = (document.documentElement.scrollTop || document.body.scrollTop);
  if (w > cw)
  ww = 0;
  else
  ww = (cw - w)/2;
  if (h > ch)
  hh = 0;
  else
  hh = (st + (ch - h)/2);
  l = l || ww;
  t = t || hh;
        if (mask != "no"){
    var ndiv = document.createElement("DIV");
    ndiv.setAttribute("id", "ndiv"+ Winid);
    ndiv.style.cssText = "width:"+ sw +"px;height:"+ sh +"px;left:0px;top:0px;position:absolute;overflow:hidden;background:#999;filter:alpha(opacity=80); opacity:0.2;-moz-opacity:0.2;";
    document.body.appendChild(ndiv);
    if (Ie)
    {
    var niframe = document.createElement("iframe");
    niframe.style.width = sw;
    niframe.style.height = sh;
          niframe.style.top = "0px";
          niframe.style.left = "0px";
          niframe.style.visibility = "inherit";
          niframe.style.filter = "alpha(opacity=0)";
          niframe.style.position = "absolute";
          niframe.style.zIndex = -1;
    ndiv.insertAdjacentElement("afterBegin",niframe);
    }
        }
  var mywin = document.createElement("DIV");
  mywin.setAttribute("id", "win"+ Winid);
  mywin.style.cssText = "width:"+ w +"px;height:"+ h +"px;left:0px;top:0px;position:absolute;overflow:hidden;padding:0px;font-family:Arial, ����";
  mywin.style.zIndex = ++zIndex;
  document.body.appendChild(mywin);
  var mytie = document.createElement("DIV");
  var myboy = document.createElement("DIV");
  var mybom = document.createElement("DIV");
  mytie.style.cssText = "overflow:hidden;height:30px;font-weight:bold;font-size:14px;width:100%";
  myboy.style.cssText = "overflow:hidden;width:100%";
  mybom.style.cssText = "overflow:hidden;height:30px;width:100%";
  mywin.appendChild(mytie);
  mywin.appendChild(myboy);
  mywin.appendChild(mybom);
  var wintag = [[mytie, 30, 15, "t1"], [mytie, 30, w-32, "t2"], [mytie, 30, 15, "t3"], [myboy, h-45, 15, "l1"], [myboy, h-47, w-32], [myboy, h-45, 15, "r1"], [mybom, 15, 15, "l2"], [mybom, 15, w-32, "b1"], [mybom, 15, 15, "r2"]];
  for (var i = 0; i < 9; i++)
  {
   var temp = document.createElement("DIV");
   temp.setAttribute("Fid", "win"+ Winid);
   wintag[i][0].appendChild(temp);
      if (wintag[i][3])
   {
    temp.style.cssText = "float:left;height:"+ wintag[i][1] +"px;width:"+ wintag[i][2] +"px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+imgfile+""+ wintag[i][3] +".png', sizingMethod='scale');background:url('"+imgfile+""+ wintag[i][3] +".png') !important;background:;";
   }
   else
   {
    temp.style.cssText = "float:left;filter:alpha(Opacity=95,style=0);opacity:0.95;height:"+ wintag[i][1] +"px;width:"+ wintag[i][2] +"px;background:#f7f7f7;border:1px solid #666;overflow:hidden;padding:0px";
   }
  }
  mytie.childNodes[1].innerHTML = "<div style=\"position:absolute;overflow:hidden;height:15px;top:12px;padding-left:4px;padding-right:4px;\"></div><div style=\"position:absolute;background:url('"+imgfile+"clo.gif');overflow:hidden;width:43px;height:17px;top:7px !important;right:15px\" title=\"\" onclick=\"MyWin.Close('win"+ Winid +"',5); MyWin.ndiv('ndiv"+ Winid +"',5);\"></div>";
  this.Title("win"+ Winid, title);
  this.Body("win"+ Winid, wbody);
  this.Move_e("win"+ Winid, l, t, 0, 0);
  return(mywin);
 }
 this.Title = function(Id, title)
 {
     if (Id == null) return;
     var o = $(Id);
     if (!o) return;
     o.childNodes[0].childNodes[1].childNodes[0].innerHTML = title;
 }
 this.Body = function(Id, wbody)
 {
     if (Id == null) return;
     var o = $(Id);
        if (!o) return;
        if (wbody.slice(0, 4) == "[pg]")
            o.childNodes[1].childNodes[1].innerHTML = "<iframe onfocus=\"MyWin.Show('"+ Id +"',this)\" src='"+ wbody.slice(4) +"' frameBorder='0' marginHeight='0' marginWidth='0' scrolling='no' width='100%' height='100%'></iframe>";
        else
            o.childNodes[1].childNodes[1].innerHTML = wbody;
 }
 this.Show = function(Id)
    {
     if (Id == null) return;
     var o = $(Id);
        if (!o) return;
     o.style.zIndex = ++zIndex;
    }
    this.Move_e = function(Id, l , t, ll, tt)
    {
     if (typeof(window["ct"+ Id]) != "undefined") clearTimeout(window["ct"+ Id]);
     var o = $(Id);
     if (!o) return;
      o.style.left = l +"px";
      o.style.top = t +"px";
     window["ct"+ Id] = window.setTimeout("MyWin.Move_e('"+ Id +"', "+ l +" , "+ t +", "+ ll +", "+ tt +")", 1);
    }
    this.Close = function(Id, Opacity)
    {
     if (typeof(window["et"+ Id]) != "undefined") clearTimeout(window["et"+ Id]);
     var o = $(Id);
     if (!o) return;
     if (Opacity == 10) o.childNodes[0].childNodes[1].innerHTML = "";
     if (Ie)
     {
      o.style.filter = "alpha(opacity="+ Opacity +",style=0)";
     }
     else
     {
      o.style.opacity = Opacity / 10;
     }
     if (Opacity > 20)
      Opacity -= 10;
     else
      Opacity--;
     if (Opacity <= 0)
     {
         if (o.getElementsByTagName("IFRAME").length != 0)
         {
             o.getElementsByTagName("IFRAME").src = "about:blank";
         }
         o.innerHTML = "";
      document.body.removeChild(o);
      return;
     }
     window["et"+ Id] = window.setTimeout("MyWin.Close('"+ Id +"', "+ Opacity +")", 1);
    }
    this.ndiv = function(Id, Opacity)
    {
     var o = $(Id);
     if (!o) return;
     o.innerHTML = "";
  document.body.removeChild(o);
  return;
    }
}
//���˵�����
function  abc(url){
parent.frames["mainFrame"].document.location=url;
}










//tab�л�
	function setTab03Syn ( i )
	{
		selectTab03Syn(i);
	}
	
	function selectTab03Syn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon1").style.display="block";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("font1").style.color="#ffffff";
			document.getElementById("font2").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="block";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#ffffff";
			break;
		}
	}

//tab�л�
	function setTab09Syn ( i )
	{
		selectTab09Syn(i);
	}
	
	function selectTab09Syn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon3").style.display="block";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("fonta").style.color="#ffffff";
			document.getElementById("fontb").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="block";
			document.getElementById("fonta").style.color="#000000";
			document.getElementById("fontb").style.color="#ffffff";
			break;
		}
	}
	
//tab�л�
	function setTab01Syn ( i )
	{
		selectTab01Syn(i);
	}
	
	function selectTab01Syn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon1").style.display="block";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("TabCon5").style.display="none";
			document.getElementById("font1").style.color="#ffffff";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#000000";
			document.getElementById("font5").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="block";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("TabCon5").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#ffffff";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#000000";
			document.getElementById("font5").style.color="#000000";
			break;
			case 3:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="block";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("TabCon5").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#ffffff";
			document.getElementById("font4").style.color="#000000";
			document.getElementById("font5").style.color="#000000";
			break;
			case 4:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="block";
			document.getElementById("TabCon5").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#ffffff";
			document.getElementById("font5").style.color="#000000";
			break;
			case 5:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("TabCon5").style.display="block";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#000000";
			document.getElementById("font5").style.color="#ffffff";
			break;
		}
	}

//н��֧��
function setTab02Syn ( i )
	{
		selectTab02Syn(i);
	}
	
	function selectTab02Syn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon1").style.display="block";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("font1").style.color="#ffffff";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="block";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#ffffff";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#000000";
			break;
			case 3:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="block";
			document.getElementById("TabCon4").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#ffffff";
			document.getElementById("font4").style.color="#000000"
			break;
			case 4:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("TabCon4").style.display="block";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			document.getElementById("font4").style.color="#ffffff";
			break;
		}
	}



//����֯��ϵ�л�
	function setTabSyn ( i )
	{
		selectTabSyn(i);
	}
	
	function selectTabSyn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon1").style.display="block";
			document.getElementById("TabCon2").style.display="none";
			//document.getElementById("TabCon3").style.display="none";
			document.getElementById("font1").style.color="#075587";
			document.getElementById("font2").style.color="#000000";
			//document.getElementById("font3").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="block";
			//document.getElementById("TabCon3").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#075587";
			//document.getElementById("font3").style.color="#000000";
			break;
			//case 3:
			//document.getElementById("TabCon1").style.display="none";
			//document.getElementById("TabCon2").style.display="none";
			//document.getElementById("TabCon3").style.display="block";
			//document.getElementById("font1").style.color="#000000";
			//document.getElementById("font2").style.color="#000000";
			//document.getElementById("font3").style.color="#075587";
			//break;
		}
	}
//����֯��ϵ�л�


//������˺Ź���
	function setTab001Syn ( i )
	{
		selectTab001Syn(i);
	}
	
	function selectTab001Syn ( i )
	{
		switch(i){
			case 1:
			document.getElementById("TabCon1").style.display="block";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("font1").style.color="#FFFFFF";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#000000";
			break;
			case 2:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="block";
			document.getElementById("TabCon3").style.display="none";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#FFFFFF";
            document.getElementById("font3").style.color="#000000";
			break;
			case 3:
			document.getElementById("TabCon1").style.display="none";
			document.getElementById("TabCon2").style.display="none";
			document.getElementById("TabCon3").style.display="block";
			document.getElementById("font1").style.color="#000000";
			document.getElementById("font2").style.color="#000000";
			document.getElementById("font3").style.color="#FFFFFF";
			break;
		}
	}
//������˺Ź����л�



//�����б��¼ȫѡ�ͷ�ѡ
function CheckAll(value,obj)  {
	var form=document.getElementsByTagName("form")
 	for(var i=0;i<form.length;i++){
		for (var j=0;j<form[i].elements.length;j++){
			if(form[i].elements[j].name!="checkbox"){ 
			var e = form[i].elements[j]; 
			e.checked=!e.checked;
			//if (value=="selectAll"){e.checked=obj.checked}     
			//else{e.checked=!e.checked;} 
			   }
		}
 	}
}

//����ɾ���ж�ֻ��ѡ��һ�����
function DelSite(){
	var num=0;
	var form=document.getElementsByTagName("form")
 	for(var i=0;i<form.length;i++){
		for (var j=0;j<form[i].elements.length;j++){
			if(form[i].elements[j].type=="checkbox"){ 
			var e = form[i].elements[j]; 
			if (e.checked)num++;    
			}
		}
 	}
	if(num==0){
		alert("\u8bf7\u9009\u62e9\u4e00\u6761\u8bb0\u5f55\uff01");
	}else if(num>1){
		alert("\u53ea\u80fd\u9009\u62e9\u4e00\u6761\u8bb0\u5f55\uff01");
	}else{
		if (window.confirm("\u60a8\u786e\u5b9a\u8981\u5220\u9664\u6240\u9009\u62e9\u7684\u8bb0\u5f55\u5417\uff1f")){
			return;
		}
	}
	return;
}

//���в鿴�͸����ж�ֻ��ѡ��һ�����
function ReadAndUpdate(url){
	var num=0;
	var form=document.getElementsByTagName("form")
 	for(var i=0;i<form.length;i++){
		for (var j=0;j<form[i].elements.length;j++){
			if(form[i].elements[j].type=="checkbox"){ 
			var e = form[i].elements[j]; 
			if (e.checked)num++;    
			}
		}
 	}
	if(num==0){
		alert("\u8bf7\u9009\u62e9\u4e00\u6761\u8bb0\u5f55\uff01");
	}else if(num>1){
		alert("\u53ea\u80fd\u9009\u62e9\u4e00\u6761\u8bb0\u5f55\uff01");
	}else{
		document.location.href=url;
	}
	return;
}
