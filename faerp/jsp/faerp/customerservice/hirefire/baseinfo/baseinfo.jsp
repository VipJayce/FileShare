<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="./css/baseinfo/baseinfo-style.css" type="text/css" rel="stylesheet" />
        <link href="./css/baseinfo/jquery-ui-1.7.2.custom.css" rel="stylesheet" type="text/css" />
        <link href="./css/baseinfo/jquery.cropzoom.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="./js/baseinfo/jquery.js"></script>
        <script type="text/javascript" src="./js/baseinfo/jquery-ui-1.8.12.custom.min.js"></script>
        
        <script type="text/javascript" src="./js/baseinfo/jquery.cropzoom1.0.4.js"></script>
        <!--<script type="text/javascript" src="./js/baseinfo/jquery.cropzoom1.2.js"></script>-->
        
        <style media="print">
            .Noprint{display:none;}
        </style>
    </head>
    <body>
        <table align="center" border="0" class="baseinfo_table"
            cellspacing="0" cellpadding="0">
            <tr style="height: 35px;">
                <td colspan="6">
                    <div align="center" class="baseinfo_table_td_div">
                        个人基本信息采集(变更)表
                    </div>
                </td>
            </tr>
            <tr style="height: 30px;">
                <td colspan="6">
                </td>
            </tr>
            <tr style="height: 35px;">
                <td colspan="6">
                    <span> 单位名称 </span> :
                    <input type="text" class="underline_orgname" value="${baseinfo.ORG_NAME }"
                        size="60%" />
                    ( 盖 章 )
                </td>
            </tr>
            <tr style="height: 50px;">
                <td colspan="2" class="orgNum_td">
                    <span class="orgNum_label">组织机构代码:</span> 
                </td>
                <td colspan="4">
                    <table class="org_table" cellspacing="0" cellpadding="0">
                        <tr style="height: 50px;">
                            <td>
                                <table border="1" class="org_num_table" cellspacing="0"
                                    cellpadding="0">
                                    <tr>
                                        <td class="org_num" id="org_no1" onclick="document.getElementById('100').focus()">
                                            <input id="100" type="text" class = "num" value="${orgNoArr[0] }" onkeyup="nextAutoInput('org',this);"><!--  -->
                                        </td>
                                        <td class="org_num" id="org_no2" onclick="document.getElementById('101').focus()">
                                            <input id="101" type="text" class = "num" value="${orgNoArr[1] }" onkeyup="nextAutoInput('org',this);">
                                        </td>
                                        <td class="org_num" id="org_no3" onclick="document.getElementById('102').focus()">
                                            <input id="102" type="text" class = "num" value="${orgNoArr[2] }" onkeyup="nextAutoInput('org',this);">
                                        </td>
                                        <td class="org_num" id="org_no4" onclick="document.getElementById('103').focus()">
                                            <input id="103" type="text" class = "num" value="${orgNoArr[3] }" onkeyup="nextAutoInput('org',this);">
                                        </td>
                                        <td class="org_num" id="org_no5" onclick="document.getElementById('104').focus()">
                                            <input id="104" type="text" class = "num" value="${orgNoArr[4] }" onkeyup="nextAutoInput('org',this);">
                                        </td>
                                        <td class="org_num" id="org_no6" onclick="document.getElementById('105').focus()">
                                            <input id="105" type="text" class = "num" value="${orgNoArr[5] }" onkeyup="nextAutoInput('org',this);">
                                        </td>
                                        <td class="org_num" id="org_no7" onclick="document.getElementById('106').focus()">
                                            <input id="106" type="text" class = "num" value="${orgNoArr[6] }" onkeyup="nextAutoInput('org',this);">
                                        </td>
                                        <td class="org_num_last" id="org_no8" onclick="document.getElementById('106').focus()">
                                            <input id="107" type="text" class = "num" value="${orgNoArr[7] }" onkeyup="nextAutoInput('org',this);" maxlength="1">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="40px">
                                <hr style="margin-left: 5px;margin-right: 5px;">
                            </td>
                            <td width="445px" style="margin-left: 5px;">
                                <table border="1" class="org_last_num_table" cellspacing="0"
                                    cellpadding="0">
                                    <tr>
                                        <td class="org_last" onclick="document.getElementById('108').focus()">
                                             <input id="108" type="text" class = "num" value="${orgNoArr[8] }" onkeyup="nextAutoInput('org',this);">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="300px">
                                <span style="font-size: 19px; font-family: '宋体';">照片编号(<input type="text" style="border: 0;width: 45%;font-size: 19px;font-family: '华文仿宋';" value="">)</span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table align="center" border="1" class="main_table" cellspacing="0"
            cellpadding="0">
            <tr style="height: 35px;">
                <td colspan="2" class="main_table_td">
                    <div align="center">
            姓名
                    </div>
                </td>
                <td colspan="3" class="main_table_3col_t_td">
                    <table border="1" cellspacing="0" cellpadding="0" class="main_table_3col_t">
                        <tr height="35px">
                            <td width="198px" class="main_table_3col_t_td_1">
                                <input type="text" style="border: 0;width: 90%;font-size: 19px;font-family: '宋体'; margin-left: 5px;" value="${baseinfo.EMP_NAME }">
                            </td>
                            <td width="98px" class="main_table_3col_t_td_1">
                                <div align="center">
                            曾用名
                                </div>
                            </td>
                            <td width="" class="main_table_3col_t_td_2">
                                <input type="text" style="border: 0;width: 90%;font-size: 19px;font-family: '宋体';margin-left: 5px;" value="">
                            </td>
                        </tr>
                    </table>
                </td>
                <td rowspan="5" class="main_table_td_pic">
                    <div align="center">
                        粘贴照片
                    </div>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td colspan="2" class="main_table_td">
                    <div align="center">
                        身份证号码
                    </div>
                </td>
                <td colspan="3" class="main_table_id_td" style="border: 1px;">
                    <table border="1" cellspacing="0" cellpadding="0" class="main_table_id">
                        <tr>
                            <td class="main_table_td" id="card_no1" onclick="document.getElementById('200').focus()">
                                 <input id="200" type="text" class="numcardid" value="${idCardArr[0] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no2" onclick="document.getElementById('201').focus()">
                                    <input id="201" type="text" class="numcardid" value="${idCardArr[1] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no3" onclick="document.getElementById('202').focus()">
                                    <input id="202" type="text" class="numcardid" value="${idCardArr[2] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no4" onclick="document.getElementById('203').focus()">
                                    <input id="203" type="text" class="numcardid" value="${idCardArr[3] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no5" onclick="document.getElementById('204').focus()">
                                    <input id="204" type="text" class="numcardid" value="${idCardArr[4] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no6" onclick="document.getElementById('205').focus()">
                                    <input id="205" type="text" class="numcardid" value="${idCardArr[5] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no7" onclick="document.getElementById('206').focus()">
                                <input id="206" type="text" class="numcardid" value="${idCardArr[6] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no8" onclick="document.getElementById('207').focus()">
                                <input id="207" type="text" class="numcardid" value="${idCardArr[7] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no9" onclick="document.getElementById('208').focus()">
                                <input id="208" type="text" class="numcardid" value="${idCardArr[8] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no10" onclick="document.getElementById('209').focus()">
                                <input id="209" type="text" class="numcardid" value="${idCardArr[9] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no11" onclick="document.getElementById('210').focus()">
                                <input id="210" type="text" class="numcardid" value="${idCardArr[10] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no12" onclick="document.getElementById('211').focus()">
                                <input id="211" type="text" class="numcardid" value="${idCardArr[11] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no13" onclick="document.getElementById('212').focus()">
                                <input id="212" type="text" class="numcardid" value="${idCardArr[12] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no14" onclick="document.getElementById('213').focus()">
                                <input id="213" type="text" class="numcardid" value="${idCardArr[13] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no15" onclick="document.getElementById('214').focus()">
                                <input id="214" type="text" class="numcardid" value="${idCardArr[14] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no16" onclick="document.getElementById('215').focus()">
                                <input id="215" type="text" class="numcardid" value="${idCardArr[15] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td" id="card_no17" onclick="document.getElementById('216').focus()">
                                <input id="216" type="text" class="numcardid" value="${idCardArr[16] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                            <td class="main_table_td_right" id="card_no18" onclick="document.getElementById('217').focus()">
                                <input id="217" type="text" style="border: 0;width: 12px;font-size: 18px;font-family: '华文仿宋';margin-left: 5px;text-align: center;" value="${idCardArr[17] }" onkeyup="nextAutoInput('card',this);">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 35px;" >
                <td colspan="2" class="main_table_td">
                    <div align="center" class="main">
            性别
                    </div>
                </td>
                
                <td colspan="3" class="main_table_3col_t_td">
                    <table border="1" cellspacing="0" cellpadding="0" class="main_table_3col_t">
                        <tr id="sex" height="35px">
                            <td width="198px" class="main_table_3col_t_td_1">
                            <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 50px;">
                                <!--  class="<c:if test="${baseinfo.EMP_SEX=='1' }">checked</c:if>" onclick="deleteImg(this,'sex');"  -->
                                <img id="man" src="<c:if test="${baseinfo.EMP_SEX=='1' }">images/choose.png</c:if>
                                    <c:if test="${baseinfo.EMP_SEX!='1' }">images/unchoose.png</c:if>"  onclick="deleteImg(this,'sex');"/>
                            </div>
                            <label style="float: left;margin-left: 5px;">男</label>
                            
                            <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px;">
                                <!-- class="<c:if test="${baseinfo.EMP_SEX=='0' }">checked</c:if>" onclick="deleteImg(this,'sex');"  -->
                                <img id="woman" src="<c:if test="${baseinfo.EMP_SEX=='0' || empty baseinfo.EMP_SEX}">images/choose.png</c:if>
                                    <c:if test="${baseinfo.EMP_SEX!='0' && not empty baseinfo.EMP_SEX }">images/unchoose.png</c:if>" onclick="deleteImg(this,'sex');" />
                            </div>
                            <label style="float: left;margin-left: 5px;">女</label>
                                    <!--<div style="float: left; border: 1px solid #000000; width: 20px;" class = "checked"></div>男
                                    <div style="float: left; border: 1px solid #000000; width: 20px;height: 20px;" <c:if test="${baseinfo.EMP_SEX == '0' }">class = "checked"</c:if>></div>女-->
                                    <!--<input type="checkbox" value="" <c:if test="${baseinfo.EMP_SEX=='1' }">checked="checked" </c:if> style="border:0px;width: 28px;height: 28px;">男-->
                                     <!--<input type="checkbox" value=""  <c:if test="${baseinfo.EMP_SEX=='0' }">checked="checked"</c:if> style="border: 0px;width: 28px;height: 28px;">女-->
                            </td>
                            <td width="98" class="main_table_3col_t_td_1">
                                <div align="center">
                   民族
                                </div>
                            </td>
                            <td width="" class="main_table_3col_t_td_2">
                                <input type="text" class="underline_name" style="margin-left: 5px;" <c:if test="${empty baseinfo.NATIONALITY}">value="汉"</c:if>
                                <c:if test="${not empty baseinfo.NATIONALITY}"> value="${baseinfo.NATIONALITY }"</c:if>>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td colspan="2" class="main_table_td">
                    <div align="center">
                        政治面貌
                    </div>
                </td>
                
                <td id="zzmm" colspan="3" class="main_table_td_right">
                        <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px;" >
                            <!-- class="<c:if test="${baseinfo.POCICY_BD == '0' || baseinfo.POCICY_BD == '1' || baseinfo.POCICY_BD == '5'}">checked</c:if>" onclick="deleteImg(this,'zzmm');" -->
                            <img id="zgdy" src="<c:if test="${baseinfo.POCICY_BD == '0' || baseinfo.POCICY_BD == '1' || baseinfo.POCICY_BD == '5'}">images/choose.png</c:if>
                                    <c:if test="${baseinfo.POCICY_BD != '0' && baseinfo.POCICY_BD != '1' && baseinfo.POCICY_BD != '5'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'zzmm');"/>
                        </div>
                        <label style="float: left;margin-left: 5px;">中共党员</label>
                        
                        <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px;" >
                            <!-- class=" <c:if test="${baseinfo.POCICY_BD == '2'}">checked</c:if>" onclick="deleteImg(this,'zzmm');"-->
                            <img id="gqty" src="<c:if test="${baseinfo.POCICY_BD == '2'}">images/choose.png</c:if>
                                   <c:if test="${baseinfo.POCICY_BD != '2'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'zzmm');"/>
                        </div>
                        <label style="float: left;margin-left: 5px;">共青团员</label>
                        
                        <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px;">
                            <!-- class="<c:if test="${empty baseinfo.POCICY_BD || baseinfo.POCICY_BD == '4'}">checked</c:if>" onclick="deleteImg(this,'zzmm');" -->
                            <img id="qz" src="<c:if test="${empty baseinfo.POCICY_BD || baseinfo.POCICY_BD == '4'}">images/choose.png</c:if><c:if test="${not empty baseinfo.POCICY_BD && baseinfo.POCICY_BD != '4'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'zzmm');"/>
                        </div>
                        <label style="float: left;margin-left: 5px;">群众</label>
                        
                        <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px;" >
                           <!-- class="<c:if test="${baseinfo.POCICY_BD == '3'}">checked</c:if>" onclick="deleteImg(this,'zzmm');" -->
                           <img id="mzdp" src="<c:if test="${baseinfo.POCICY_BD == '3'}">images/choose.png</c:if>
                                   <c:if test="${baseinfo.POCICY_BD != '3'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'zzmm');"/>
                        </div>
                        <label style="float: left;margin-left: 5px;">民主党派</label>
                        
                        <div align="right" style="float: left; width: 100px;border-bottom: 1px solid #000; height: 18px; overflow: hidden; margin-left: 10px;">
                             <input align="right" type="text" style="border: 0;width: 100px;font-size: 19px;">
                        </div>
                        <!-- 
                        <input type="checkbox" name="checkbox" value="" 
                            <c:if test="${baseinfo.POCICY_BD == '0' || baseinfo.POCICY_BD == '1' || baseinfo.POCICY_BD == '5'}">checked="checked"</c:if>>中共党员 
                        
                        <input type="checkbox" name="checkbox2" value=""
                            <c:if test="${baseinfo.POCICY_BD == '2'}">checked="checked"</c:if>>共青团员 
                        
                        <input type="checkbox" name="checkbox3" value=""
                            <c:if test="${empty baseinfo.POCICY_BD || baseinfo.POCICY_BD == '4'}">checked="checked" </c:if>>群众 
                        
                        <input type="checkbox" name="checkbox4" value=""
                            <c:if test="${baseinfo.POCICY_BD == '3'}">checked="checked"</c:if>>民主党派
                        
                        <input type="text" style="border: 0;border-bottom: 1px solid #000;width: 100px;font-size: 19px;">
                         -->
                </td>
            </tr>
            <tr style="height: 35px;">
                <td height="60px" colspan="2" class="main_table_td">
                    <div align="center">
                        受教育程度
                    </div>
                </td>
                <td colspan="3" class="main_table_td_right">
                        <span id="jycd1">
                            <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px;">
                               <!-- class="<c:if test="${baseinfo.EDUCATION_BD == '1' || baseinfo.EDUCATION_BD == '2'} ">checked</c:if>" onclick="deleteImg(this,'jycd1');" -->
                               <img id="yjs" src="<c:if test="${baseinfo.EDUCATION_BD == '1' || baseinfo.EDUCATION_BD == '2'} ">images/choose.png</c:if>
                                   <c:if test="${baseinfo.EDUCATION_BD != '1' && baseinfo.EDUCATION_BD != '2'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'jycd1');"/>
                            </div>
                            <label style="float: left;margin-left: 5px;">研究生</label>
                        
                            <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px; ">
                               <!-- class="<c:if test="${empty baseinfo.EDUCATION_BD || baseinfo.EDUCATION_BD == '3'}">checked</c:if>" onclick="deleteImg(this,'jycd1');" -->
                               <img id="benke" src="<c:if test="${empty baseinfo.EDUCATION_BD || baseinfo.EDUCATION_BD == '3'}">images/choose.png</c:if>
                                   <c:if test="${not empty baseinfo.EDUCATION_BD && baseinfo.EDUCATION_BD != '3'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'jycd1');"/>
                            </div>
                            <label style="float: left;margin-left: 5px;">本科</label>
                            
                            <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px; ">
                               <!--class="<c:if test="${baseinfo.EDUCATION_BD == '4'} ">checked</c:if>" onclick="deleteImg(this,'jycd1');"-->
                               <img id="dazhuan" src="<c:if test="${baseinfo.EDUCATION_BD == '4'}">images/choose.png</c:if>
                                   <c:if test="${baseinfo.EDUCATION_BD != '4'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'jycd1');"/>
                            </div>
                            <label style="float: left;margin-left: 5px;">大专(高等职校)</label>
                        </span>
                        <p style="clear: both;width: 100%; height: 5px; overflow: hidden;margin-top: 0px;margin-bottom: 0px;"></p>
                        <span id="jycd2" style="clear: both;">
                            <div style="clear: both;float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px;">
                               <!-- class="<c:if test="${baseinfo.EDUCATION_BD == '5' || baseinfo.EDUCATION_BD == '6' || baseinfo.EDUCATION_BD == '7' || baseinfo.EDUCATION_BD == '8'}">checked</c:if>" onclick="deleteImg(this,'jycd2');" -->
                               <img id="gongzhong" src="<c:if test="${baseinfo.EDUCATION_BD == '5' || baseinfo.EDUCATION_BD == '6' || baseinfo.EDUCATION_BD == '7' || baseinfo.EDUCATION_BD == '8'}">images/choose.png</c:if>
                                   <c:if test="${baseinfo.EDUCATION_BD != '5' && baseinfo.EDUCATION_BD != '6' && baseinfo.EDUCATION_BD != '7' && baseinfo.EDUCATION_BD != '8'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'jycd2');"/>
                            </div>
                            <label style="float: left;margin-left: 5px;">高中(中专、职校、技校)</label>
                            
                            <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 8px;">
                              <!-- class="<c:if test="${baseinfo.EDUCATION_BD == '9'}">checked</c:if>" onclick="deleteImg(this,'jycd2');"-->
                               <img id="chuzhong" src="<c:if test="${baseinfo.EDUCATION_BD == '9'}">images/choose.png</c:if>
                                   <c:if test="${baseinfo.EDUCATION_BD != '9'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'jycd2');"/>
                            </div>
                            <label style="float: left;margin-left: 5px;">初中</label>
                            
                            <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 8px;">
                              <!-- class="<c:if test="${baseinfo.EDUCATION_BD == '10'}">checked</c:if>" onclick="deleteImg(this,'jycd2');"-->
                              <img id="xiaoxue" src="<c:if test="${baseinfo.EDUCATION_BD == '10'}">images/choose.png</c:if>
                                   <c:if test="${baseinfo.EDUCATION_BD != '10'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'jycd2');"/>
                            </div>
                            <label style="float: left;margin-left: 5px;">小学</label>
                            
                            <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 8px;">
                             <!-- class="<c:if test="${baseinfo.EDUCATION_BD == '11'}">checked</c:if>" onclick="deleteImg(this,'jycd2');"-->
                             <img id="wenmang" src="<c:if test="${baseinfo.EDUCATION_BD == '11'}">images/choose.png</c:if>
                                   <c:if test="${baseinfo.EDUCATION_BD != '11'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'jycd2');"/>
                            </div>
                            <label style="margin-left: 5px;margin-right: -30px;">文盲或半文盲</label>
                        </span>
                    <!-- 
                        <div id="yjs" style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; ">
                             <c:if test="${baseinfo.EDUCATION_BD == '1' || baseinfo.EDUCATION_BD == '2'} "><img src="images/choose.png" /></c:if>
                        </div>
                        <label style="float: left;margin-left: 5px;">研究生</label>
                    
                        <div id="bk" style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; ">
                             <c:if test="${empty baseinfo.EDUCATION_BD || baseinfo.EDUCATION_BD == '3'}"><img src="images/choose.png" /></c:if>
                        </div>
                        <label style="float: left;margin-left: 5px;">本科</label>
                        
                        <div id="dz" style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; ">
                             <c:if test="${baseinfo.EDUCATION_BD == '4'} "><img src="images/choose.png" /></c:if>
                        </div>
                        <label style="margin-left: 5px;">大专(高等职校)</label>
                        
                        <div id="gz" style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; ">
                             <c:if test="${baseinfo.EDUCATION_BD == '5' || baseinfo.EDUCATION_BD == '6' || baseinfo.EDUCATION_BD == '7'  || baseinfo.EDUCATION_BD == '8'}  ">
                             <img src="images/choose.png" /></c:if>
                        </div>
                        <label style="float: left;margin-left: 5px;">高中(中专、职校、技校)</label>
                        
                        <div id="cz" style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; ">
                             <c:if test="${baseinfo.EDUCATION_BD == '9'} "><img src="images/choose.png" /></c:if>
                        </div>
                        <label style="float: left;margin-left: 5px;">初中</label>
                        
                        <div id="xx" style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; ">
                             <c:if test="${baseinfo.EDUCATION_BD == '10'} "><img src="images/choose.png" /></c:if>
                        </div>
                        <label style="float: left;margin-left: 5px;">小学</label>
                    
                        <div id="wm" style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; ">
                             <c:if test="${baseinfo.EDUCATION_BD == '11'} "><img src="images/choose.png" /></c:if>
                        </div>
                        <label style="float: left;margin-left: 5px;">文盲或半文盲</label>
                         -->
                     <!-- 
                    <div style="margin-bottom: 10px;">
                        <input type="checkbox" value="" 
                            <c:if test="${baseinfo.EDUCATION_BD == '1' || baseinfo.EDUCATION_BD == '2'} ">checked="checked"</c:if>>研究生
                        
                        <input type="checkbox" value=""
                           <c:if test="${empty baseinfo.EDUCATION_BD || baseinfo.EDUCATION_BD == '3'}">checked="checked"</c:if>>本科
                        
                        <input type="checkbox" value=""
                           <c:if test="${baseinfo.EDUCATION_BD == '4'} ">checked="checked"</c:if>>大专(高等职校)
                    </div>
                    <div>
                        <input type="checkbox" value=""
                            <c:if test="${baseinfo.EDUCATION_BD == '5' || baseinfo.EDUCATION_BD == '6' || baseinfo.EDUCATION_BD == '7'  || baseinfo.EDUCATION_BD == '8'}  ">checked="checked"</c:if>>高中(中专、职校、技校)
                        
                        <input type="checkbox" value=""
                           <c:if test="${baseinfo.EDUCATION_BD == '9'} ">checked="checked"</c:if>>初中
                        
                        <input type="checkbox" value=""
                           <c:if test="${baseinfo.EDUCATION_BD == '10'} ">checked="checked"</c:if>>小学
                        
                        <input type="checkbox" value=""
                           <c:if test="${baseinfo.EDUCATION_BD == '11'} ">checked="checked"</c:if>>文盲或半文盲
                    </div>
                     -->
                </td>
            </tr>
            <tr style="height: 35px;">
                <td colspan="2" class="main_table_td">
                    <div align="center">
                        户籍地址
                    </div>
                </td>
                <td colspan="4" class="main_table_td_right">
                    <div style="padding-top: 10px;">
                        <input type="text" style="float:left;border: 0;width: 180px;font-size: 19px;font-family: '宋体';text-align: right;margin-top: -1px;" value=""><label style="float:left;margin-left: 5px;margin-right: 10px;">省（直辖市、自治区）</label>
                        <input type="text" style="float:left;border: 0;width: 180px;font-size: 19px;font-family: '宋体';text-align: right;margin-top: -1px;" value=""><label style="float:left;margin-left: 5px;margin-right: 2px;">市（区、县）</label>
                    </div>
                        <div style="clear: both;height: 5px;"></div>
                    <div>
                        <label style="clear: both;float:left;margin-left: 30px;margin-right: 10px;margin-top: 1px;">详细地址</label>
                        <input name="textfield" type="text" class="underline_detailAddress" style="float: left;margin-bottom: 5px;" value="${baseinfo.RESIDENT_ADDRESSS }"/>
                        <!--<hr align="center" width="85%" size="1" style="float: left;clear: both;margin-left: 60px;" noshade>-->
                    </div>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td colspan="2" class="main_table_td">
                    <div align="center">
                        户籍类别
                    </div>
                </td>
                <td colspan="4" class="main_table_td_right">
                    <div id="hjlb">
                        <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden;margin-left: 210px;" >
                            <!-- class="<c:if test="${baseinfo.RESIDENT_TYPE_BD == '2'}">checked</c:if>" onclick="deleteImg(this,'hjlb');" -->
                            <img id="fcz" src="<c:if test="${baseinfo.RESIDENT_TYPE_BD == '2'}">images/choose.png</c:if>
                                   <c:if test="${baseinfo.RESIDENT_TYPE_BD != '2'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'hjlb');"/>
                        </div>
                        <label style="float: left;margin-left: 5px;">非城镇</label>
                    
                        <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden;margin-left: 50px; " >
                                <!--  class="<c:if test="${ empty baseinfo.RESIDENT_TYPE_BD || baseinfo.RESIDENT_TYPE_BD == '1'}">checked</c:if>" onclick="deleteImg(this,'hjlb');" -->
                                 <img id="cz" src="<c:if test="${ empty baseinfo.RESIDENT_TYPE_BD || baseinfo.RESIDENT_TYPE_BD == '1'}">images/choose.png</c:if>
                                   <c:if test="${ not empty baseinfo.RESIDENT_TYPE_BD && baseinfo.RESIDENT_TYPE_BD != '1'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'hjlb');"/>
                        </div>
                        <label style="float: left;margin-left: 5px;">城镇</label>
                
                        <!-- 
                        <input type="checkbox" name="" value=""  style="margin-left: 210px;"
                            <c:if test="${baseinfo.RESIDENT_TYPE_BD == '2'}">checked="checked"</c:if>>非城镇
                        
                        <input type="checkbox" name="" value=""  style="margin-left: 50px;"
                            <c:if test="${ empty baseinfo.RESIDENT_TYPE_BD || baseinfo.HEALTH_STATUS_BD == '1'}">checked="checked"</c:if>>城镇
                          -->
                      </div>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td colspan="2" class="main_table_td">
                    <div align="center">
              本市居住地地址
                    </div>
                </td>
                <td colspan="4" class="main_table_td_right">
                    <div>
                        <input type="text" style="float:left;border: 0;width: 150px;font-size: 19px;font-family: '宋体';text-align: right;margin-top: -2px;" value="黄浦">
                        <label style="float:left;margin-left: 5px;margin-right: 2px;">区（县）</label>
                        
                        <input type="text" style="float:left;border: 0;width: 150px;font-size: 19px;font-family: '宋体';text-align: right;margin-top: -2px;" value="中山南">
                        <label style="float:left;margin-left: 5px;margin-right: 2px;">路</label>
                        
                        <input type="text" style="float:left;border: 0;width: 50px;font-size: 19px;font-family: '宋体';text-align: right;margin-top: -2px;" value="">
                        <label style="float:left;margin-left: 5px;margin-right: 2px;">弄（村）</label>
                        
                        <input type="text" style="float:left;border: 0;width: 50px;font-size: 19px;font-family: '华文仿宋';text-align: right;margin-top: -2px;" value="28">
                        <label style="float:left;margin-left: 5px;margin-right: 2px;">号</label>
                        
                        <input type="text" style="float:left;border: 0;width: 50px;font-size: 19px;font-family: '华文仿宋';text-align: right;margin-top: -2px;" value="">
                        <label style="float:left;margin-left: 5px;margin-right: 2px;">室</label>
                    </div>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td colspan="2" class="main_table_td">
                    <div align="center">
                        联系电话
                    </div>
                </td>
                <td colspan="4" class="main_table_3col_t_td">
                    <table border="1" cellspacing="0" cellpadding="0" class="main_table_3col_t">
                        <tr height="35px">
                            <td width="370px" class="main_table_3col_t_td_1">&nbsp;
                                <input type="text" style="border: 0;width: 40%;font-size: 19px;font-family: '华文仿宋';" value="63589999">
                            </td>
                            <td width="120px" class="main_table_3col_t_td_1">
                                <div align="center">
                                    邮政编码
                                </div>
                            </td>
                            <td width="200px" class="main_table_3col_t_td_2">&nbsp;
                                    <input type="text" style="border: 0;width: 40%;font-size: 19px;font-family: '华文仿宋';" value="200010">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td colspan="2" class="main_table_td">
                    <div align="center">
                        居住地街道
                    </div>
                </td>
                <td colspan="4" class="main_table_3col_t_td">
                    <table border="1" cellspacing="0" cellpadding="0" class="main_table_3col_t">
                        <tr height="35px">
                            <td width="370px" class="main_table_3col_t_td_1">&nbsp;
                                <input type="text" style="border: 0;width: 40%;font-size: 19px;font-family: '宋体';" value="小东门街道">
                            </td>
                            <td width="120px" class="main_table_3col_t_td_1">
                                <div align="center">
                                    其他联系方式
                                </div>
                            </td>
                            <td width="200px" class="main_table_3col_t_td_2">&nbsp;
                                <input type="text" style="border: 0;width: 90%;font-size: 19px;font-family: '华文仿宋';" value="">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td width="40px" rowspan="3" class="main_table_td">
                    <p align="center">
                        婚育<br/>
                        情况
                    </p>
                </td>
                <td width="89px" class="main_table_td">
                    <div align="center">
                        婚育状况
                    </div>
                </td>
                <td colspan="4" class="main_table_3col_t_td">
                    <table border="1" cellspacing="0" cellpadding="0" class="main_table_3col_t">
                        <tr height="35px">
                            <td id="hyzk" width="370px" class="main_table_3col_t_td_1">
                                <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 40px;" >
                                     <!-- class="<c:if test="${baseinfo.MARRIAGE_STATUS_BD == '1' || empty baseinfo.MARRIAGE_STATUS_BD}">checked</c:if>" onclick="deleteImg(this,'hyzk');" -->
                                     <img id="wh" src="<c:if test="${baseinfo.MARRIAGE_STATUS_BD == '1' || empty baseinfo.MARRIAGE_STATUS_BD}">images/choose.png</c:if>
                                   <c:if test="${baseinfo.MARRIAGE_STATUS_BD != '1' && not empty baseinfo.MARRIAGE_STATUS_BD}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'hyzk');"/>
                                </div>
                                <label style="float: left;margin-left: 5px;">未婚</label>
                            
                                <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px; ">
                                    <!-- class="<c:if test="${baseinfo.MARRIAGE_STATUS_BD == '2'}">checked</c:if>" onclick="deleteImg(this,'hyzk');" -->
                                    <img id="yh" src="<c:if test="${baseinfo.MARRIAGE_STATUS_BD == '2'}">images/choose.png</c:if>
                                       <c:if test="${baseinfo.MARRIAGE_STATUS_BD != '2'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'hyzk');"/>
                                </div>
                                <label style="float: left;margin-left: 5px;">已婚</label>
                                
                                <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px;">
                                   <!-- class="<c:if test="${baseinfo.MARRIAGE_STATUS_BD == '4'}">checked</c:if>" onclick="deleteImg(this,'hyzk');"-->
                                   <img id="sangou" src="<c:if test="${baseinfo.MARRIAGE_STATUS_BD == '4'}">images/choose.png</c:if>
                                       <c:if test="${baseinfo.MARRIAGE_STATUS_BD != '4'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'hyzk');"/>
                                </div>
                                <label style="float: left;margin-left: 5px;">丧偶</label>
                            
                                <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 10px; " >
                                    <!-- class="<c:if test="${baseinfo.MARRIAGE_STATUS_BD == '3'}">checked</c:if>" onclick="deleteImg(this,'hyzk');" -->
                                     <img id="ly" src="<c:if test="${baseinfo.MARRIAGE_STATUS_BD == '3'}">images/choose.png</c:if>
                                       <c:if test="${baseinfo.MARRIAGE_STATUS_BD != '3'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'hyzk');"/>
                                </div>
                                <label style="float: left;margin-left: 5px;">离异</label>
                                <!-- 
                                 <input type="checkbox" name="" value=""  style="margin-left: 40px;"
                                    <c:if test="${baseinfo.MARRIAGE_STATUS_BD == '1' || empty baseinfo.MARRIAGE_STATUS_BD}">checked="checked"</c:if>>未婚
                                 
                                 <input type="checkbox" name="" value="" 
                                    <c:if test="${baseinfo.MARRIAGE_STATUS_BD == '2'}">checked="checked"</c:if> style="margin-left: 5px;">已婚
                                 
                                 <input type="checkbox" name="" value="" 
                                    <c:if test="${baseinfo.MARRIAGE_STATUS_BD == '4'}">checked="checked" </c:if> style="margin-left: 5px;">丧偶 
                                 
                                 <input type="checkbox" name="" value="" 
                                    <c:if test="${baseinfo.MARRIAGE_STATUS_BD == '3'}">checked="checked"</c:if> style="margin-left: 5px;">离异
                                  -->
                            </td>
                            <td width="120px" class="main_table_3col_t_td_1">
                                <div align="center">
                                    配偶姓名
                                </div>
                            </td>
                            <td width="200px" class="main_table_3col_t_td_2">&nbsp;
                                <input type="text" style="border: 0;width: 90%;font-size: 19px;font-family: '宋体';" value="">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td class="main_table_td">
                    <div align="center">
                        子女数
                    </div>
                </td>
                <td colspan="4" class="main_table_3col_t_td">
                    <table border="1" cellspacing="0" cellpadding="0" class="main_table_3col_t">
                        <tr height="35px">
                            <td width="370px" class="main_table_3col_t_td_1">&nbsp;
                                <input type="text" style="border: 0;width: 40px;font-size: 19px;font-family: '华文仿宋';" value="">
                            </td>
                            <td width="120px" class="main_table_3col_t_td_1">
                                <div align="center" style="font-size: 18px; font-family: '宋体';">
                            配偶是否本市<br/>户籍
                                </div>
                            </td>
                            <td id="posfbshj"  width="200px" class="main_table_3col_t_td_2">
                                <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 50px; ">
                                   <!-- class="" onclick="deleteImg(this,'posfbshj');" -->
                                   <img id="yes" src="images/unchoose.png"  onclick="deleteImg(this,'posfbshj');"/>
                                </div>
                                <label style="float: left;margin-left: 5px;">是</label>
                                
                                <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 30px; ">
                                   <!-- class="" onclick="deleteImg(this,'posfbshj');" -->
                                   <img id="no" src="images/unchoose.png"  onclick="deleteImg(this,'posfbshj');"/>
                                </div>
                                <label style="float: left;margin-left: 5px;">否</label>
                                <!-- 
                                    <input type="checkbox" name="checkbox22" value=""  style="margin-left: 50px;">是
                                    <input type="checkbox" name="checkbox22" value="" style="margin-left: 30px;">否
                                  -->
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td class="main_table_td">
                    <p align="center" style="font-size: 18px; font-family: '宋体';">
            配偶身份证<br/>号码
                    </p>
                </td>
                <td colspan="4" class="main_table_3col_t_td">
                    <table border="1" cellspacing="0" cellpadding="0" class="main_table_3col_t">
                        <tr>
                            <td class="main_table_3col_t_td_1" id="peiou_no1" onclick="document.getElementById('300').focus()">&nbsp;
                                <input id="300" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no2" onclick="document.getElementById('301').focus()">&nbsp;
                                <input id="301" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no3" onclick="document.getElementById('302').focus()">&nbsp;
                                <input id="302" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no4" onclick="document.getElementById('303').focus()">&nbsp;
                                <input id="303" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no5" onclick="document.getElementById('304').focus()">&nbsp;
                                <input id="304" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no6" onclick="document.getElementById('305').focus()">&nbsp;
                                <input id="305" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no7" onclick="document.getElementById('306').focus()">&nbsp;
                                <input id="306" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no8" onclick="document.getElementById('307').focus()">&nbsp;
                                <input id="307" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no9" onclick="document.getElementById('308').focus()">&nbsp;
                                <input id="308" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no10" onclick="document.getElementById('309').focus()">&nbsp;
                                <input id="309" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no11" onclick="document.getElementById('310').focus()">&nbsp;
                                <input id="310" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no12" onclick="document.getElementById('311').focus()">&nbsp;
                                <input id="311" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no13" onclick="document.getElementById('312').focus()">&nbsp;
                                <input id="312" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no14" onclick="document.getElementById('313').focus()">&nbsp;
                                <input id="313" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no15" onclick="document.getElementById('314').focus()">&nbsp;
                                <input id="314" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no16" onclick="document.getElementById('315').focus()">&nbsp;
                                <input id="315" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_1" id="peiou_no17" onclick="document.getElementById('316').focus()">&nbsp;
                                <input id="316" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                            <td class="main_table_3col_t_td_2" id="peiou_no18" onclick="document.getElementById('317').focus()">&nbsp;
                                <input id="317" type="text" class="numcardid" value="" onkeyup="nextAutoInput('pcard',this);">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td colspan="2" class="main_table_td">
                    <div align="center" class="main">
                        健康状况
                    </div>
                </td>
                <td id="jkzk" colspan="4" style="border-left: 0px; border-top: 0px; border-right: 0px;">
                         <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 235px;">
                                <!-- class="<c:if test="${baseinfo.HEALTH_STATUS_BD == '1' || empty baseinfo.HEALTH_STATUS_BD}">checked</c:if>" onclick="deleteImg(this,'jkzk');" -->
                                <img id="lh" src="<c:if test="${baseinfo.HEALTH_STATUS_BD == '1' || empty baseinfo.HEALTH_STATUS_BD}">images/choose.png</c:if>
                                   <c:if test="${baseinfo.HEALTH_STATUS_BD != '1' && not empty baseinfo.HEALTH_STATUS_BD}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'jkzk');"/>
                         </div>
                         <label style="float: left;margin-left: 5px;">良好</label>
                     
                         <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 90px; ">
                               <!--  class="<c:if test="${baseinfo.HEALTH_STATUS_BD == '2' || baseinfo.HEALTH_STATUS_BD == '3' || baseinfo.HEALTH_STATUS_BD == '4' || baseinfo.HEALTH_STATUS_BD == '5'}">checked</c:if>" onclick="deleteImg(this,'jkzk');" -->
                                <img id="yb" src="<c:if test="${baseinfo.HEALTH_STATUS_BD == '2' || baseinfo.HEALTH_STATUS_BD == '3' || baseinfo.HEALTH_STATUS_BD == '4' || baseinfo.HEALTH_STATUS_BD == '5'}">images/choose.png</c:if>
                                   <c:if test="${baseinfo.HEALTH_STATUS_BD != '2' && baseinfo.HEALTH_STATUS_BD != '3' && baseinfo.HEALTH_STATUS_BD != '4' && baseinfo.HEALTH_STATUS_BD != '5'}">images/unchoose.png</c:if>"  onclick="deleteImg(this,'jkzk');"/>
                         </div>
                         <label style="float: left;margin-left: 5px;">一般</label>
                         
                         <!-- 
                        <input type="checkbox" name="" value="" style="margin-left: 230px;" 
                         <c:if test="${baseinfo.HEALTH_STATUS_BD == '1' || empty baseinfo.HEALTH_STATUS_BD}">checked="checked"</c:if>>良好
                        <input type="checkbox" name="" value=""  style="margin-left: 80px;" 
                         <c:if test="${baseinfo.HEALTH_STATUS_BD == '2' || baseinfo.HEALTH_STATUS_BD == '3' || baseinfo.HEALTH_STATUS_BD == '4' || baseinfo.HEALTH_STATUS_BD == '5'}">checked="checked"</c:if>>一般
                          -->
                </td>
            </tr>
            <tr style="height: 35px;">
                <td colspan="2" class="main_table_td">
                    <div align="center">
            居住证申领情况
                    </div>
                </td>
                <td colspan="4" class="main_table_3col_t_td">
                    <table border="1" cellspacing="0" cellpadding="0" class="main_table_3col_t">
                        <tr height="35px">
                            <td id="slqk" width="370px" class="main_table_3col_t_td_1">
                                <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 40px;">
                                       <!-- class="" onclick="deleteImg(this,'slqk');"-->
                                       <img id="ysl" src="images/unchoose.png"  onclick="deleteImg(this,'slqk');"/>
                                 </div>
                                 <label style="float: left;margin-left: 5px;">已申领</label>
                             
                                 <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 85px; ">
                                         <!--  class="" onclick="deleteImg(this,'slqk');" -->
                                     <img id="wsl" src="images/choose.png"  onclick="deleteImg(this,'slqk');"/>
                                 </div>
                                 <label style="float: left;margin-left: 5px;">未申领</label>
                                <!-- 
                                    <input type="checkbox" name="" value="" style="margin-left: 50px;">已申领
                                    <input type="checkbox" name="" value="" checked="checked" style="margin-left: 55px;">未申领
                                 -->
                            </td>
                            <td width="120px" class="main_table_3col_t_td_1">
                                <div align="center">
                    居住证号码
                                </div>
                            </td>
                            <td width="200px" class="main_table_3col_t_td_2">&nbsp;
                                    <input type="text" style="border: 0;width: 90%;font-size: 19px;font-family: '华文仿宋';" value="">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td colspan="2" class="main_table_td">
                    <div align="center" class="main">
                        居住证类别
                    </div>
                </td>
                <td id="jzzlb" colspan="4" style="border-left: 0px; border-top: 0px; border-right: 0px;">
                      <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 40px;">
                                    <!-- class="" onclick="deleteImg(this,'jzzlb');"-->
                           <img id="yjrcl" src="images/unchoose.png"  onclick="deleteImg(this,'jzzlb');"/>
                      </div>
                      <label style="float: left;margin-left: 5px;">引进人才类</label>
                  
                      <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 47px; ">
                           <!-- class="" onclick="deleteImg(this,'jzzlb');" -->
                               <img id="cyl" src="images/unchoose.png"  onclick="deleteImg(this,'jzzlb');"/>
                      </div>
                      <label style="float: left;margin-left: 5px;">从业类</label>
                      
                      <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left: 30px; " >
                              <!--class="" onclick="deleteImg(this,'jzzlb');"  -->
                              <img id="tjjl" src="images/unchoose.png"  onclick="deleteImg(this,'jzzlb');"/>
                      </div>
                      <label style="float: left;margin-left: 5px;">投亲、就读、进修类</label> 
                      
                      <div style="float: left; border: 1px solid #000000; width: 18px; height: 18px; overflow: hidden; margin-left:30px; ">
                             <!--  class="" onclick="deleteImg(this,'jzzlb');"-->
                              <img id="lsjzzl" src="images/unchoose.png"  onclick="deleteImg(this,'jzzlb');"/>
                      </div>
                      <label style="float: left;margin-left: 5px;">临时居住证件</label>
                      
                      <!-- 
                        <input type="checkbox" name="checkbox22" value="" style="margin-left: 50px;">引进人才类
                        <input type="checkbox" name="checkbox22" value="" style="margin-left: 20px;">从业类
                        <input type="checkbox" name="checkbox22" value="" style="margin-left: 20px;">投亲、就读、进修类
                        <input type="checkbox" name="checkbox22" value="" style="margin-left: 20px;">临时居住证件
                       -->
                </td>
            </tr>
            <tr style="height: 60px;">
                <td colspan="6"
                    style="border-left: 0px; border-top: 0px; border-right: 0px; border-bottom: 0px;padding-top: 11px;">
                        <span class="main">
                            <label style="float: left;margin-left: 45px;">以上项目真实填写，若与实际情况不符，愿承担相关责任。</label>
                            <div style="clear: both;margin-bottom: 10px;font-size: 19px;font-family: '宋体';"></div>
                            <label style="float: left;margin-left: 155px;margin-right: 10px;font-size: 19px;font-family: '宋体';"> 签名: </label>
                            <input type="text" style="border: 0;width: 150px;font-size: 19px;font-family: '宋体';float: left;margin-right: 150px;" value="${baseinfo.EMP_NAME }">
                            <label style="float: left;margin-right: 19px;">日期:</label>
                            <input type="text" class = "date" value="${year }" size="4"><label style="float: left;font-size: 19px;font-family: '宋体';">&nbsp;&nbsp;年</label>
                            <input type="text" class = "date" value="${month }" size="2"><label style="float: left;font-size: 19px;font-family: '宋体';">&nbsp;&nbsp;月</label>
                            <input type="text" class = "date" value="${day }" size="2"><label style="float: left;font-size: 19px;font-family: '宋体';">&nbsp;&nbsp;日</label>
                        </span>
                </td>
            </tr>
        </table>
        <table align="center" border="0" style="width: 900px; height: 35px;"
            cellspacing="0" cellpadding="0">
            <tr style="height: 35px;">
                <td style="border-left: 0px; border-top: 0px; font-size: 19px;">
                    注：请按本表背面填表说明填写。
                </td>
                <td style="border-left: 0px; border-top: 0px; font-size: 19px;">
                    
                        <center class="Noprint" >
                                <OBJECT  id="WebBrowser"  classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"  height="0"  width="0">
                                </OBJECT>
                                <c:if test="${not empty cardPicPath && cardPicPath != 'default'}">
	                                <input type="button" id="picAbutton" value="选择身份证正面图片" onclick="openNewDiv('a');" >
	                                <input type="button" id="picBbutton" value="选择身份证反面图片" onclick="openNewDiv('b');"  >
                                </c:if>
                                <input  type="button"  value="预览" onclick="document.getElementById('WebBrowser').ExecWB(7,1)">
                                <input  type="button"  value="打印" onclick="delFile();">
                                <input  type="button"  value="打印设置"  onclick="document.getElementById('WebBrowser').ExecWB(8,1)">
                        </center>
                    
                </td>
            </tr>
        </table>
         <table align="center" border="0" style="width: 900px; height: 300px;">
            <tr>
                <td>
                    <table border="1"
                        style="width: 440px; border-color: #000000;font-family: '宋体';font-size: 19px;"
                       <tr style="height: 300px;">
                            <td width="440px" style="border:0px;">
                                   <div id="text_a" align="center" class="upload" style="display: block;">
                                       <c:if test="${hasAPic == true && empimage.card_pic_a != null}">
                                           <img style="width: 440px;height: 290px;"  id="default_a_pic" src="<%=request.getContextPath()%>/BaseinfoAction.do?cmd=getPic&cardId=${baseinfo.ID_CARD }&picType=A"/>
                                       </c:if>
                                       <c:if test="${hasBPic == false}">
                                            <p>
                                               身份证复印件粘贴处
                                           </p>
                                           <p>
                                               （正面）
                                           </p>
                                      </c:if>
                                   </div>
                                   <div id="pic_a" align="center" class="upload" style="display: none;"></div>
                               </td>
                           </tr>
                    </table>
                </td>
                <td>
                    <table border="1"
	                    style="width: 440px; border-color: #000000;font-family: '宋体';font-size: 19px;"
	                   <tr style="height: 300px;">
	                        <td width="440px" style="border:0px;">
	                               <div id="text_b" align="center" class="upload" style="display: block;">
	                                   <c:if test="${hasBPic == true && empimage.card_pic_b != null}">
	                                       <img style="width: 440px;height: 290px;"  id="default_b_pic" src="<%=request.getContextPath()%>/BaseinfoAction.do?cmd=getPic&cardId=${baseinfo.ID_CARD }&picType=B"/>
	                                   </c:if>
	                                   <c:if test="${hasBPic == false}">
	                                        <p>
	                                           身份证复印件粘贴处
	                                       </p>
	                                       <p>
	                                           （反面）
	                                       </p>
	                                  </c:if>
	                               </div>
	                               <div id="pic_b" align="center" class="upload" style="display: none;"></div>
	                           </td>
	                       </tr>
	                </table>
                </td>
            </tr>
         </table>
        </div>
        <div id="choosePic" class="tip" style="display:none;">
            <div align="right" style="margin-right: 10px;">
                <a href="javascript:void(0)" onClick="closeDiv();">返回</a>
            </div>
            <div id="crop_container2" style="float: left;border: solid 3px blue;"></div>
            <div class="btn" align="center" style="margin-top: 20px;">
                <input type="button" class="btn" id="crop" value="剪切照片" /><br/>
                <input type="button" class="btn" id="restore" value="重置图片" style="margin-top: 20px;" />
                <!--<input type="button" class="btn" id="sure" value="确定" />-->
            </div>
        </div>
        
        <script type="text/javascript">
             function deleteImg(obj,tagId){
                    var checked='images/choose.png';
                    var unchecked = 'images/unchoose.png';
             
                   if(tagId == "jycd1"){
	                   var tagObj1 = document.getElementById("jycd2");
	                   var tagChildren1 = tagObj1.getElementsByTagName("img");
	                    for(var i=0;i<tagChildren1.length;i++){
	                       var srcValue1 = $("#"+tagChildren1[i].id).attr("src").replace(/^\s\s*/, '' ).replace(/\s\s*$/, '' );
                           if(srcValue1 == checked){
	                           $("#"+tagChildren1[i].id).attr("src",unchecked);
	                       }
                        }
                        
                        var thisSrc1 = $("#"+obj.id).attr("src").replace(/^\s\s*/, '' ).replace(/\s\s*$/, '' );
                        if(thisSrc1 == checked){
                            $("#"+obj.id).attr("src",unchecked);
                        }else{
                            $("#"+obj.id).attr("src",checked);
                        }
	                }else if(tagId == "jycd2"){
	                   var tagObj2 = document.getElementById("jycd1");
                       var tagChildren2 = tagObj2.getElementsByTagName("img");
                        for(var i=0;i<tagChildren2.length;i++){
                            var srcValue2 = $("#"+tagChildren2[i].id).attr("src").replace(/^\s\s*/, '' ).replace(/\s\s*$/, '' );
                           if(srcValue2 == checked){
                               $("#"+tagChildren2[i].id).attr("src",unchecked);
                           }
                        }
                        
                         var thisSrc2 = $("#"+obj.id).attr("src").replace(/^\s\s*/, '' ).replace(/\s\s*$/, '' );
                        if(thisSrc2 == checked){
                            $("#"+obj.id).attr("src",unchecked);
                        }else{
                            $("#"+obj.id).attr("src",checked);
                        }
                        
	                }else{
	                   var parentObj = document.getElementById(tagId);
	                   var children = parentObj.getElementsByTagName("img");
	                   var check_state = "";
	                
	                   for(var i=0;i<children.length;i++){
	                        check_state = $("#"+children[i].id).attr("src").replace(/^\s\s*/, '' ).replace(/\s\s*$/, '' );
	                        if(children[i].id == obj.id){
	                            if(check_state == checked){
	                                $("#"+obj.id).attr("src",unchecked);
	                            }else{
	                                $("#"+obj.id).attr("src",checked);
	                            }
	                        }else{
	                           if(check_state == checked){
	                                $("#"+children[i].id).attr("src",unchecked);
	                            }
	                        }
	                    }
	                }
             }
             
            var picType = "";
            //弹出层中使用到的js代码
             var cropzoom = "";
             window.onload = (function() {
                cropzoom = $('#crop_container2').cropzoom({
                    width: 1200,
                    height: 600,
                    bgColor: '#CCC',
                    enableRotation: true,
                    enableZoom: false,
                    zoomSteps: 0,
                    rotationSteps: 1,
                    selector: {
                        centered: true,
                        w: 200,
                        h: 100,
                        borderColor: 'red',
                        borderColorHover: 'green',
                        showPositionsOnDrag: true,
                        showDimetionsOnDrag: true,
                        hideOverlayOnDragAndResize: true
                    },
                    image: {
                        source:'<%=request.getContextPath()%>/${cardPicPath}',
                        width: ${width},
                        height: ${height},
                        minZoom: 100,
                        maxZoom: 300,
                        startZoom: 100,
                        useStartZoomAsMinZoom:true//,
                        //snapToContainer: true //图片 边界不能移出容器边界
                    }
                });
                

                $('#crop').click(function() {
                    document.getElementById('choosePic').style.display="none";
                    if(picType == "a"){
                        $('#text_a').find('img').remove();
                        document.getElementById("picAbutton").value = "修改身份证正面图片";
                        document.getElementById('text_a').style.display = "none";
                        document.getElementById('pic_a').style.display="block";
                    }else{
                         $('#text_b').find('img').remove();
                        document.getElementById("picBbutton").value = "修改身份证反面图片";
                        document.getElementById('text_b').style.display = "none";
                        document.getElementById('pic_b').style.display="block";
                    }
                    document.body.removeChild(docEle('mask'));
                    cropzoom.send('<%=request.getContextPath()%>/jsp/faerp/customerservice/hirefire/baseinfo/crop.jsp', 'POST', {id_card:'${baseinfo.ID_CARD}',emp_code:'${baseinfo.EMP_CODE}',picType:picType,fullPath:'${fullPath}'},
                    function(rta) {
                        if(picType == "a"){
                            $('#pic_a').find('img').remove();
                            var img = $('<img style=\"width: 430px;height: 290px;\"/>').attr('src', rta);
                            $('#pic_a').append(img);
                        }else{
                            $('#pic_b').find('img').remove();
                             var img = $('<img style=\"width: 430px;height: 290px;\"/>').attr('src', rta);
                            $('#pic_b').append(img);
                        }
                    });
                });
                
                $('#restore').click(function(){
                    cropzoom.restore();
                });
                
                $('#sure').click(function(){
                    document.getElementById('choosePic').style.display="none";
                    if(picType == "a"){
                        document.getElementById('text_a').style.display = "none";
                        document.getElementById('pic_a').style.display="block";
                    }else{
                        document.getElementById('text_b').style.display = "none";
                        document.getElementById('pic_b').style.display="block";
                    }
                    document.body.removeChild(docEle('mask'));
                });
                
            });
            
            
            var docEle = function(){
                return document.getElementById(arguments[0]) || false;
            }
            
            function openNewDiv(type){
                picType = type;
                cropzoom.restore();
                var m = "mask";
                if (docEle(m)) document.body.removeChild(docEle(m));
                //mask遮罩层
                var newMask = document.createElement("div");
                newMask.id = m;
                newMask.style.position = "absolute";
                newMask.style.zIndex = "1";
                _scrollWidth = Math.max(document.body.scrollWidth,document.documentElement.scrollWidth);
                _scrollHeight = Math.max(document.body.scrollHeight,document.documentElement.scrollHeight);
                newMask.style.width = _scrollWidth + "px";
                newMask.style.height = _scrollHeight + "px";
                newMask.style.top = "0px";
                newMask.style.left = "0px";
                newMask.style.background = "#33393C";
                newMask.style.filter = "alpha(opacity=40)";
                newMask.style.opacity = "0.40";
                document.body.appendChild(newMask);
                
                var newDivObj = document.getElementById('choosePic');
                newDivObj.style.display = "block";
                newDivObj.style.top = (document.body.scrollTop + document.body.clientHeight/64) + "px";
                if(document.all){
                    window.attachEvent("onscroll",newDivCenter);
                }else{
                    window.addEventListener('scroll',newDivCenter,false);
                }
            }

            //关闭新图层和mask遮罩层
            function closeDiv(type){
                document.getElementById('choosePic').style.display = "none";
                document.body.removeChild(docEle('mask'));
            }
            
            function newDivCenter(){
                var newDivObj = document.getElementById('choosePic');
                newDivObj.style.top = (document.body.scrollTop + document.body.clientHeight/64) + "px";
            }
            
            function disabledMouseWheel() {
                if (document.addEventListener) {
                    document.addEventListener('DOMMouseScroll', scrollFunc, false);
                }
                window.onmousewheel = document.onmousewheel = scrollFunc;//IE/Opera/Chrome
            }
            
            function scrollFunc(evt) {
                evt = evt || window.event;
                if(evt.preventDefault) {
                    // Firefox
                    evt.preventDefault();
                    evt.stopPropagation();
                } else {
                    // IE
                    evt.cancelBubble=true;
                    evt.returnValue = false;
                }
                return false;
            }
        
        // 身份证图片剪切后删除由pdf转好的图片
        function delFile(){
            var imgPath="${cardPicPath}";
            if(imgPath != ""){
                jQuery.ajax( {
	               url : "<%=request.getContextPath()%>/BaseinfoAction.do?cmd=delFile",
	               type : 'POST',
	               dataType : 'json',
	               data : {imgPath:imgPath}
	            });
            }
            document.getElementById('WebBrowser').ExecWB(6,1);
        }
        
        function nextAutoInput(type,obj){
	          var id = obj.id;
	          var idInt = parseInt(id);
	          
	          //按删除按钮时  Backspace 或 Delete
	          if(event.keyCode==8 || event.keyCode==46){
	        //if((event.keyCode==8 || event.keyCode==46) && document.getElementById(idInt) == ""){
	             var nextObj = "";
	              if(document.getElementById(idInt).value == ""){
	                   nextObj = document.getElementById(idInt-1);
	              }else{
	                   nextObj = document.getElementById(idInt);
	              }
	              var val = nextObj.value;
	              if(idInt != 100 || idInt != 200 || idInt != 300){
	                  nextObj.focus();
	                  nextObj.value = "";     
	                  nextObj.value = val;
	              }
	          }else{//顺次输入时
	               if(event.keyCode!=37 && event.keyCode!=39){
	                   if(event.keyCode == 9){
	                       var nextObj = document.getElementById(idInt+1);
	                       var val = nextObj.value;
		                      if(idInt != 108 || idInt != 217 || idInt != 317){
		                          nextObj.focus();
		                          nextObj.value = "";     
		                          nextObj.value = val;
		                      }
	                   }else{
	                       var nextObj = document.getElementById(idInt+1);
	                       //if(id=="108" || id=="217" || id=="317"){
                           var objval = obj.value;
	                           objval = objval.substring(objval.length-1,objval.length);
	                           document.getElementById(id).value = objval; 
	                      //}
	                      //document.getElementById(idInt+1).value = ""; 
	                       var val = nextObj.value;
	                      if(idInt != 108 || idInt != 217 || idInt != 317){
	                          nextObj.focus();
	                          nextObj.value = "";     
	                          nextObj.value = val;
                      }
	                   }
	               }
	          }
        }
        </script>
    </body>
</html>
