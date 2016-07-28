<%@ page language="java" pageEncoding="utf-8"%>
<%@page import="rayoo.customerservice.hirefire.baseinfo.util.*"%>
<%@page import="java.util.*"%>
<%
    String id_card = request.getParameter("id_card");//身份证号码
    String emp_code = request.getParameter("emp_code");//员工唯一号
    String picType = request.getParameter("picType").toUpperCase();//身份证图片类型，A<fmt:message key='crop0000'/>B<fmt:message key='crop0001'/>
    System.out.println("<fmt:message key='crop0002'/>" + id_card);
    System.out.println("<fmt:message key='crop0003'/>" + emp_code);
    String imageSource = request.getParameter("fullPath");//图片源
    String fileWebroot = pageContext.getServletContext().getRealPath("/");
    String imageW = request.getParameter("imageW");//图片宽
    String imageH = request.getParameter("imageH");//图片高
    String imageX = request.getParameter("imageX");//图片X<fmt:message key='crop0004'/>
    String imageY = request.getParameter("imageY");//图片Y<fmt:message key='crop0004'/>
    String imageRotate = request.getParameter("imageRotate");
    String viewPortW = request.getParameter("viewPortW");
    String viewPortH = request.getParameter("viewPortH");
    String selectorX = request.getParameter("selectorX");//选中区<fmt:message key='crop0004'/>X
    String selectorY = request.getParameter("selectorY");//选中区<fmt:message key='crop0004'/>Y
    String selectorW = request.getParameter("selectorW");//选中区<fmt:message key='crop0004'/>宽
    String selectorH = request.getParameter("selectorH");//选中区<fmt:message key='crop0004'/>高

    /*
    String suffix = imageSource.substring(imageSource.lastIndexOf(".") + 1);
    String cutImg = System.currentTimeMillis()+"."+suffix;
    System.out.println("imageSource = " + imageSource);
    System.out.println("suffix = " + suffix);
    System.out.println("imageRotate = " + imageRotate);//图片的翻转角度
    System.out.println("viewPortW = " + viewPortW);
    System.out.println("viewPortH = " + viewPortH);
    System.out.println("fileWebroot = " + fileWebroot);
    */
    
    System.out.println("imageW = " + imageW);
    System.out.println("imageH = " + imageH);
    System.out.println("imageX = " + imageX);
    System.out.println("imageY = " + imageY);
    System.out.println("selectorX = " + selectorX);
    System.out.println("selectorY = " + selectorY);
    System.out.println("selectorW = " + selectorW);
    System.out.println("selectorH= " + selectorH);
   
    
    
    int IntImageX = 0;
    int IntSelectorX = 0;
    int IntImageY = 0;
    int IntSelectorY = 0;
    int IntSelectorW = 0;
    int IntSelectorH = 0;
    
    if(imageX.indexOf(".")>0){
        float imageXf=Float.parseFloat(imageX);
        IntImageX = (int)imageXf;
    }else{
        IntImageX = Integer.parseInt(imageX);
    }
    
    if(selectorX.indexOf(".")>0){
        float selectorXf=Float.parseFloat(selectorX);
        IntSelectorX = (int)selectorXf;
    }else{
        IntSelectorX = Integer.parseInt(selectorX);
    }
    
    if(imageY.indexOf(".")>0){
        float imageYf=Float.parseFloat(imageY);
        IntImageY = (int)imageYf;
    }else{
        IntImageY = Integer.parseInt(imageY);
    }
    
    if(selectorY.indexOf(".")>0){
        float selectorYf=Float.parseFloat(selectorY);
        IntSelectorY = (int)selectorYf;
    }else{
        IntSelectorY = Integer.parseInt(selectorY);
    }
    
    if(selectorW.indexOf(".")>0){
        float selectorWf=Float.parseFloat(selectorW);
        IntSelectorW = (int)selectorWf;
    }else{
        IntSelectorW = Integer.parseInt(selectorW);
    }
    
    if(selectorH.indexOf(".")>0){
        float selectorHf=Float.parseFloat(selectorH);
        IntSelectorH = (int)selectorHf;
    }else{
        IntSelectorH = Integer.parseInt(selectorH);
    }
    
    
    int cutX = 0, cutY = 0;
    cutX = Math.abs(IntSelectorX - IntImageX);
    cutY= Math.abs(IntSelectorY - IntImageY);
    System.out.println("cutX="+cutX);
    System.out.println("cutY="+cutY);
    /* 
    ImageUtils img = ImageUtils.load(imageSource, Integer.parseInt(imageRotate));//加载源图
    int iSrcWidth = img.getImageWidth();
    int iSrcHeight = img.getImageHeight();
    img.zoomTo(IntSelectorW, IntSelectorH);//缩放源图
    img.cutTo(cutX, cutY,IntSelectorW, IntSelectorH, suffix, id_card, emp_code, picType,iSrcWidth,iSrcHeight);//裁剪图片
    */ 
    ImageUtils.imgCut(imageSource,Integer.parseInt(imageRotate),cutX,cutY,IntSelectorW,IntSelectorH, id_card, emp_code, picType);
 
    String uuid = UUID.randomUUID().toString();
    String actionString = request.getContextPath() + "/BaseinfoAction.do?cmd=getPic&cardId=" + id_card + "&picType=" + picType+"&uuid="+uuid;
    out.print(actionString);
%>
