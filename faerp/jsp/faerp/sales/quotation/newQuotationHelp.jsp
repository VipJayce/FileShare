<%@ page contentType="text/html; charset=UTF-8" %>
<%@include file="/common/common.jsp"%>
<%
       String type = request.getParameter("type");
       request.setAttribute("type",type);
%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>
<html>
<head>
	<style type="text/css">
	   .font_title1{
	       font-family: '黑体';
	       font-size: 20px;
	       font-weight: bold;
	   }
	   .font_title2{
           font-family: '宋体';
           font-size: 12px;
       }
       .font_proname{
           font-family: '微软雅黑';
           font-size: 20px;
           font-weight: bold;
       }
       .td1{
           font-family: '黑体';
           font-size: 15px;
           font-weight: bold;
       }
	   .td2{
	       font-family: "宋体";
	       font-size: 15px;
	   }
	</style>
</head>
<body>
        <div id="helpA" style="display: none;width: 100%;">
            <table border="1" style="margin: auto;line-height:25px;line-height:25px;" align="center">
	            <tr>
	                <td colspan="5" align="center" style="background-color: #218868;">
	                   <font class="font_title1">员工管理及人事服务（必选）</font></br>
	                   <font class="font_title2">特别声明：以下内容遇有第三方收费需另行支付</font>
	                </td>
	                <td rowspan="2" align="center" width="150px">
	                <font class="font_proname">ERP对应产</br>品名称</font>
	                </td>
	            </tr>
	            <tr>
	                <td align="center" width="35px"><font class="td1">序号</font></td>
	                <td colspan="2" align="center" width="100px"><font class="td1">服务项目</font></td>
	                <td align="center" width="500px"<font class="td1">服务内容概要</font></td>
	                <td align="center" width="80px"><font class="td1">收费金额</br>人/月</font></td>
	            </tr>
	            <tr>
	                <td rowspan="6" align="center" class ="td1">1</td>
	                <td rowspan="6" align="center" class="td1">员工</br>管理</td>
	                <td align="center" class="td2">入离职</td>
	                <td class="td2">
	                    1) 与员工签定劳动合同；</br>
	                    2) 转接各类人事档案，办理录用手续；</br>
	                    3) 转接社会保险、住房公积金等社会保险；</br>
	                    4) 转接党团关系；</br>
	                    5) 为离职员工办理档案转出手续，办理社保、公积金、党团</br>关系等转移手续；</br>
	                    6) 提供离职员工就业咨询等服务；</br>
	                </td>
	                <td rowspan="7" align="center" class="td2">280.00</td>
	                <td rowspan="7" align="center" class ="td2">
	                    1、服务费</br>
	                    2、存档费
	                </td>
	            </tr>
	            <tr>
	                <td align="center" class="td2">档案</td>
	                <td class="td2">
	                    7) 为员工办理工龄审定/退休手续；</br>
	                    8) 依据档案出具各类人事证明；   </br>                                                                                           
	                    9）协助员工办理职称评定、公证等服务；  </br>                                                                                                                        
	                    10）档案管理（含档案管理费）；</br>
	                </td>
	            </tr>
	            <tr>
	                <td align="center" class="td2">社会</br>保障</td>
	                <td class="td2">
	                    11) 为员工办理国家规定的各项社会保险缴纳、账户管理、查询等</br>
	                    12) 为员工办理国家规定的住房公积金缴纳、管理等手续</br>
	                    13) 为员工提供各项补充福利保障，并提供配套服务</br>
	                </td>
	            </tr>
	            <tr>
	                <td align="center" class="td2">劳动</br>关系</td>
	                <td class="td2">
	                    14) 员工劳动合同管理：变更、到期提醒、续签等</br>
	                    15) 提供劳动法规基础咨询，协助解决聘用纠纷</br>
	                </td>
	            </tr>
	            <tr>
	                <td align="center" class="td2">户籍</br>管理</td>
	                <td class="td2">
	                    16）为符合条件的员工办理“留学归国人员接收”手续 ； </br>                                                                  
	                    17) 为符合条件的员工办理“解决夫妻分居”的接收手续；    </br>                                                               
	                    18）为符合条件的员工办理“引进人才居住证”转“上海市户籍”</br>手续；   </br>                                                   
	                    19）为符合条件的员工办理“非上海生源应届毕业生落户”手续；</br>
	                </td>
	            </tr>
	            <tr>
	                <td align="center" class="td2">证件</br>办理</td>
	                <td class="td2">20) 为符合条件的员工办理“上海市工作居住证”</td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">2</td>
	                <td colspan="2" align="center" class="td1">招聘支持</td>
	                <td class="td2">
	                    1)  在FESCOAdecco上海网站上定向发布代理招聘职位</br>
	                    2)  在51Job网站上免费发布招聘职位（12个免费职位/年；3</br>个月使用时效/职位）</br>
	                </td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">3</td>
	                <td colspan="2" align="center" class="td1">工资发放</td>
	                <td class="td2">为员工发放工资、代扣代缴个人所得税；代办招行金卡（在职</br>期间内免年费）</td>
	                <td align="center" class="td2">50.00</td>
	                <td align="center" class ="td2">代发工资服务费</td>
	            </tr>
	            <tr>
	                <td colspan="4" align="center" class="td2"><u>员工管理及人事服务月缴费小计</u></td>
	                <td align="center" class="td2"><u>330.00</u></td>
	                <td align="center" class ="td2">--</td>
	            </tr>
	        </table>
	        </br></br></br></br></br>
	       <table border="1" style="margin: auto;line-height:25px;" align="center">
	            <tr>
	                <td colspan="5" align="center" style="background-color: #218868;">
	                    <font class ="font_title1">员工福利保障（任选）</font></br>
	                    <font class ="font_title2">特别声明：以下员工福利项目需按国家财税政策规定另加收5.65%的营业税</font>
	                </td>
	                <td rowspan="2" align="center" width="150px"><font class ="font_proname">ERP对应产</br>品名称</font></td>
	            </tr>
	            <tr>
	                <td align="center" width="35px" class ="td1">序号</td>
	                <td colspan="2" align="center" width="100px" class ="td1">福利名称</td>
	                <td align="center" width="500px" class ="td1">福利概要</td>
                    <td align="center" width="80px" class ="td1">收费金额</br>人/月</td>
	            </tr>
	            <tr>
	                <td rowspan="4" align="center" class ="td1">1</td>
	                <td colspan="2" align="center" class="td1">
            人身意外保障</br>（最高可购买</br>2.5份）</td>
	                <td align="left" class ="td2">
	         （1）全球人身意外伤亡保障最高赔付40万元人民币；</br>
	         （2）中国大陆疾病死亡保障赔付10万元人民币；</br>
	                </td>
	                <td align="center" class="td2">40.00</td>
	                <td align="left" class ="td2">
	                    1、人身意外保障</br>40万</br>
	                    2、疾病身故保障</br>10万（价格请写0）
	                </td>
	            </tr>
	            <tr>
	                <td rowspan="3" align="center" class="td1">补充</br>医疗</br>保障</td>
	                <td align="center" class="td1">A类</td>
	                <td align="left" class ="td2">
            参加国家法定社会保险的员工本人除社保规定自费部分以外的</br>
            门、急诊费用报销100%、住院费用报销100%，无封顶（包括二</br>
            十五种重大疾病门急诊/住院费用；及分类自负的乙类药品）</br>
            赠送：</br>
	                    1、员工入职体检：新员工可在指定医院进行入职体检(价格60</br>元/人）</br>
	                    2、女员工生育保障：符合国家社保报销规定报销100%,封顶人民</br>币8000元/年。</br>
	                </td>
	                <td align="center" class="td2">120.00</td>
	                <td align="left" class ="td2">
		                1、补医保100%</br>
		                2、生育报销8000</br>元不扣津贴（价格</br>请写0）
	                </td>
	            </tr>
	            <tr>
	                <td align="center" class="td1">B类</td>
	                <td align="left" class ="td2">
	          参加国家法定社会保险的员工本人除社保规定自费部分以外</br>
	          的门、急诊费用报销90%、住院费用报销100%,无封顶（包括二十</br>
	          五种重大疾病门急诊/住院费用；及分类自负的乙类药品）</br></br>
	          赠送：</br>
	                    1、员工入职体检：新员工可在指定医院进行入职体检(价格60</br>元/人）</br>
	                    2、女员工生育保障：符合国家社保报销规定报销100%,封顶人民</br>币8000元/年。</br>
	                </td>
	                <td align="center" class="td2">110.00</td>
	                <td align="left" class ="td2">
	                    1、补医保90%</br>
	                    2、生育报销8000</br>元不扣津贴（价格</br>请写0）
	                </td>
	            </tr>
	            <tr>
	                <td align="center" class="td1">C类</td>
	                <td align="left" class ="td2">
	          参加国家法定社会保险的员工本人除社保规定自费部分以外的</br>
	          门、急诊费用报销80%、住院费用报销100%,无封顶（包括二十</br>
	          五种重大疾病门急诊/住院费用；及分类自负的乙类药品）</br></br>
	          赠送：</br>
	                    1、员工入职体检：新员工可在指定医院进行入职体检(价格60</br>元/人）</br>
	                    2、女员工生育保障：符合国家社保报销规定报销100%,封顶人民</br>币8000元/年。</br>
	
	                </td>
	                <td align="center" class="td2">100.00</td>
	                <td align="left" class ="td2">
	                    1、补医保80%</br>
	                    2、生育报销8000</br>元不扣津贴（价格</br>请写0）
	                </td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">2</td>
	                <td colspan="2" align="center" class="td1">独生子女福利</td>
	                <td align="left" class ="td2">
	                    1）员工18周岁以下符合国家计划生育政策的独生子女除社保规</br>
            定自费部分以外的门、急诊、住院费用报销50%(包括：检查费,</br>
            化验费, 药费, 输血费, 手术费), 无自负额、无封顶</br>
	                    2)  独生子女托儿补助费每月人民币50元</br>
	                    3)  独生子女费每月人民币5元</br>
	                    4)  每年为员工14周岁以下的独生子女发放 “六一儿童节” 精</br>美礼品</br>
	                </td>
	                <td align="center" class="td2">45.00</td>
	                <td align="left" class ="td2">
	                    1、子女医疗50%</br>
	                    2、独生子女福利</br>发放（价格请写0）
	                </td>
	            </tr>
	        </table>
	        </br></br></br></br></br>
	        <table border="1" style="margin: auto;line-height:25px;" align="center">
	            <tr>
	                <td colspan="5" align="center" style="background-color: #218868;">
			             <font class ="font_title1">补充福利保障(任选)</font></br>
			             <font class ="font_title2">特别声明：以下员工福利项目需按国家财税政策规定另加收5.65%的营业税</font>
	                </td>
	                <td rowspan="2" align="center" width="150px"><font class ="font_proname">ERP对应产</br>品名称</font></td>
	            </tr>
	            <tr>
	                <td align="center" width="35px" class ="td1">序号</td>
	                <td colspan="2" align="center" width="100px" class ="td1">福利名称</td>
	                <td align="center" width="500px" class ="td1">福利概要</td>
	                <td align="center" width="80px" class ="td1">收费金额</br>人/月</td>
	            </tr>
	            <tr>
	                <td rowspan="2" align="center" class ="td1">1</td>
	                <td rowspan="2" align="center" class ="td1">体检</td>
	                <td align="center" class ="td1">A类</td>
	                <td align="left">定制化体检方案：根据客户对体检项目及体检机构的需求,单独</br>设计体检方案；</td>
	                <td align="center">单独报价</td>
	                <td align="center">无需建入报价单</br>项目</td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">B类</td>
	                <td align="left">连续缴费满1年的客户, 其员工可享受在指定的专业体检中心/</br>医疗体检机构进行健康体检；</td>
	                <td align="center">30.00</td>
	                <td align="center">年度体检</td>
	            </tr>
	            <tr>
	                <td rowspan="3" align="center" class ="td1">2</td>
	                <td rowspan="3" align="center" class ="td1">住院</br>补贴</td>
	                <td align="center" class ="td1">A类</td>
	                <td align="left">
	          选择该项福利，且连续缴费满30天后患病住院的员工，可享受</br>FESCOAdecco提供的住院补贴：</br>
	                    1)  人民币100元/天,每一公历年度内累计保障期限为180天</br>
	                    2)  住院补贴金额 = 人民币100元 * (每次实际住院天数 － 3</br>天)</br>
	                    注: 因人身意外住院按实际天数计算
	                </td>
	                <td align="center">20.00</td>
	                <td align="center">住院津贴100元</td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">B类</td>
	                <td align="left">
	          选择该项福利，且连续缴费满30天后患病住院的员工，可享受</br>
	                    FESCOAdecco提供的住院补贴：</br>
	                    1)  人民币150元/天,每一公历年度内累计保障期限为180天</br>
	                    2)  住院补贴金额 = 人民币150元 * (每次实际住院天数 － 3</br>天)</br>
	                    注: 因人身意外住院按实际天数计算
	                </td>
	                <td align="center">30.00</td>
	                <td align="center">住院津贴150元</td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">C类</td>
	                <td align="left">
	          选择该项福利，且连续缴费满30天后患病住院的员工，可享受</br>
	                    FESCOAdecco提供的住院补贴：</br>
	                    1)  人民币200元/天,每一公历年度内累计保障期限为180天</br>
	                    2)  住院补贴金额 = 人民币200元 * (每次实际住院天数 － 3</br>天)</br>
	                    注: 因人身意外住院按实际天数计算
	                </td>
	                <td align="center">40.00</td>
	                <td align="center">住院津贴200元</td>
	            </tr>
	            <tr>
	                <td rowspan="2" align="center" class ="td1">3</td>
	                <td rowspan="2" align="center" class ="td1">重大</br>疾病</br>救助</br>金</td>
	                <td align="center" class ="td1">A类</td>
	                <td align="left">
	           选择该项福利，且连续缴费满30天后患病（特指二十五种重大</br>
	                  疾病）的员工，可享受FESCOAdecco提供的重大疾病救助金，金</br>
	           额为人民币5万元
	                </td>
	                <td align="center">15.00</td>
	                <td align="center">重大疾病保障5万</td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">B类</td>
	                <td align="left">
	           选择该项福利，且连续缴费满30天后患病（特指二十五种重大</br>
	                  疾病）的员工，可享受FESCOAdecco提供的重大疾病救助金，金</br>
	           额为人民币10万元
	                </td>
	                <td align="center">30.00</td>
	                <td align="center">重大疾病保障10</br>万</td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">4</td>
	                <td align="center" class ="td1">弹性</br>福利</td>
	                <td colspan="2" align="left">
	          员工使用公司购买的福利积分，在FESCOAdecco我来网上选择包括食品百</br>
	          货，健康保险，娱乐文化，生活服务，家电数码，机票旅游，培训考证等</br>
	                    1000多种产品：</br>
	                    1） 全国一站，福利共享</br>
	                    2） 品质产品，贴心服务</br>
	                    3） 在线平台，选择自主</br>
	                    4） 活动丰富，缤纷多彩
	                </td>
	                <td align="center">
	                    50.00</br>100.00</br>150.00</br>定制化
	                </td>
	                <td align="center">弹性福利</td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">5</td>
	                <td align="center" class ="td1">家庭</br>财产</br>保障</td>
	                <td colspan="2" align="left">
	           根据员工在FESCOAdecco登记的家庭住址(发生理赔事件前), 提供最高</br>
	           限额人民币2.5万元的家庭财产保障（全国投保，无地区限定）
	                </td>
	                <td align="center">
	                    10.00
	                </td>
	                <td align="center">家财险2.5万</td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">6</td>
	                <td align="center" class ="td1">健康</br>保障</td>
	                <td colspan="2" align="left">
                    （1）可直接来FESCOAdecco上海医保中心领用常用药品，限额10元/人/</br>月；</br>
                    （2）为20人以上的公司建立“常用小药箱”；</br>
                            *（1）和（2）不可同时享受；
	                </td>
	                <td align="center">
	                    10.00
	                </td>
	                <td align="center">健康小卫士</td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">7</td>
	                <td align="center" class ="td1">员工</br>活动</td>
	                <td colspan="2" align="left">
	                    1)  指定影院电影通兑券, 每人每季1张</br>
	                    2)  员工可享受参与FESCOAdecco各项体育赛事的优先报名权，并以优惠</br>
	                    价格参加FESCOAdecco各俱乐部</br>
	                    3)  中秋节慰问礼物</br>
	                    4)  生日慰问</br>
	                    5） 每年可获得水果兑换券1张
	                </td>
	                <td align="center">
	                    50.00
	                </td>
	                <td align="center">员工活动A</td>
	            </tr>
	            <tr>
	                <td align="center" class ="td1">8</td>
	                <td align="center" class ="td1">重疾</br>安康</td>
	                <td colspan="2" align="left">
	                    1）社保报销范围外的自费药90%报销，封顶人民币10万元</br>
	                    2）员工出院后可领取人民币100元/天的康复补助，累计保障期限45天</br>
	                    3）员工住院治疗及出院康复期间，可获得人民币1000元/月看护津贴，</br>
	                    保障期1年</br>
	                    4）员工住院治疗期间，员工可享受RMB200元/天床位补助，累计保障期</br>
	            限为180天</br>
	                    5）员工由于二十五种重大疾病不幸身故，员工受益人可获得人民币10万</br>
	            元家属抚慰金</br>
	                    （针对以上五项，最高封顶赔付25万）
	                </td>
	                <td align="center">
	                    40.00
	                </td>
	                <td align="center">重疾安康保障</td>
	            </tr>
	            <tr>
	                <td colspan="2" align="center" class ="td1">备注：</td>
	                <td colspan="3" align="center" class ="td1">
						以上各项福利，具体按各实施办法执行。</br>
						合同履行每满一年，甲乙双方就员工福利保障报价重新进行协商，若无法达成一致，</br>则福利保障终止。
	                </td>
	                <td align="center">&nbsp;</td>
	            </tr>
	            <tr>
	                <td colspan="2" align="center" class ="td1"><u>营业税小</br>计</u></td>
	                <td colspan="3" align="left">
	                    * 员工福利保障需按国家财税政策规定另加收5.65%的营业税</br>
	                    * 计算公式：营业税=“员工福利保障”费用总和/(1-5.65%) — “员工福利保障”费</br>用总和
	                </td>
	                <td align="center">营业税</td>
	            </tr>
	        </table>
        </div>
        
        <div id="helpB" style="display: none;">
            <table border="0" style="margin: auto;line-height:25px;" align="center">
                <tr>
                    <td><h2>新建报价单注意点:</h2></td>
                </tr>
                <tr>
                    <td class="td2" style="padding-left: 50px;">
                        1、  ERP中选择的产品项目名称需要与上述指引中的名称完全一致，如果名称有多加括号、数字、字母等都意</br>
                                    &nbsp;&nbsp;&nbsp;&nbsp;味着那是另外一种产品</br>
		                2、  任何非标准的报价单新建时，请寻求你的team leader指导</br>
		                3、  营业税需要根据福利总额自行计算后录入系统</br>
                    </td>
                </tr>
            </table>
        </div>
	        
	        <div id="helpC" style="display: none;"  align="center">
	           <table border="0" style="margin: auto;line-height:25px;" align="center">
	                <tr>
	                    <td><h2>常见Q&A   :</h2></td>
	                </tr>
	                <tr>
	                    <td class="td1" style="padding-left: 50px;">
                            Q1： 我的客户的服务费是含档的，那么存档费还需要单列吗？
	                    </td>
	                </tr>
	                <tr>
                        <td class="td2" style="padding-left: 50px;">
                            A：需要，ERP系统报价单中的存档费项目会直接影响后续员工的调档手续和报销。因此，如果客户的纸质报价单</br>
                中，服务费和存档费是分开报价的，请新建报价单时分别选择服务费和存档费项目和价格；如果客户的纸质报价单</br>
                中，服务费是含档的，<u>请新建报价单时也需要分别选择服务费和存档费项目，但是存档费价格请设为0。</u>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td class="td1" style="padding-left: 50px;">
                            Q2： 为什么新建报价单需要选择合同，而不是选择客户？
                        </td>
                    </tr>
                    <tr>
                        <td class="td2" style="padding-left: 50px;">
                            A：ERP的是依据最真实的业务流程设计的，实际上是一份商务合同一份报价单。如果你的客户存在派遣和委托两</br>
                种业务的模式，<u>请相应建立两份报价单。</u>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td class="td1" style="padding-left: 50px;">
                            Q3：我的代发工资服务费是和社保费用一起收取的，工资是单独收取的，如何实现？
                        </td>
                    </tr>
                    <tr>
                        <td class="td2" style="padding-left: 50px;">
                            <u>A：请将代发工资服务费的金额并入服务费项目，同时代发工资服务费价格调为0</u>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td class="td1" style="padding-left: 50px;">
                            Q4： 补医保项目赠送入职体检，这个如何在报价单中体现？
                        </td>
                    </tr>
                    <tr>
                        <td class="td2" style="padding-left: 50px;">
                            A：目前公司默认所有的补医保项目都赠送入职体检，<u>因此不需要在报价单中体现</u>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td class="td1" style="padding-left: 50px;">
                            Q5： 我的商保项目是年付费定制的，该选哪个项目？
                        </td>
                    </tr>
                    <tr>
                        <td class="td2" style="padding-left: 50px;">
                            A：请和福利管理中心联系。
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td class="td1" style="padding-left: 50px;">
                            Q6： 为什么选择的某些项目价格要写0？
                        </td>
                    </tr>
                    <tr>
                        <td class="td2" style="padding-left: 50px;">
                            A：因为福利管理中心在投保的时候需要根据报价单中的选项投保相关保险产品，因此必须要选择改产品，但是为</br>
                了不让该产品影响账单的呈现，使得整个账单表头很长，因此系统设置了价格为0的产品不会在收费单中体现。
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td class="td1" style="padding-left: 50px;">
                            Q7： 为什么员工活动产品后面都跟着英文字母
                        </td>
                    </tr>
                    <tr>
                        <td class="td2" style="padding-left: 50px;">
                            A：现在有很多客户的员工活动项目都是定制的，不同的英文字母代表的项目不一样，<u>请一定根据客户购买的产品</br>
                特性选择正确的员工活动项目</u>，否则会导致员工应有的福利无法生成，或者公司成本的浪费。
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
	            </table>
	        
		        <table border="1" style="width:40%;margin-left: -180px;" algin="left">
		            <tr>
		                <td align="center" class="td2"><font style="color: red;">产品名称</font></td>
		                <td align="center" class="td2"><font style="color: red;">电影票</font></td>
		                <td align="center" class="td2"><font style="color: red;">蛋糕券</font></td>
		                <td align="center" class="td2"><font style="color: red;">中秋月饼</font></td>
		                <td align="center" class="td2"><font style="color: red;">水果券</font></td>
		            </tr>
		            <tr>
		                <td align="center" class="td2">员工活动A</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">Y</td>
		            </tr>
		            <tr>
		                <td align="center" class="td2">员工活动B</td>
		                <td align="center" class="td2">&nbsp;</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">Y</td>
		            </tr>
		            <tr>
		                <td align="center" class="td2">员工活动C</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">&nbsp;</td>
		            </tr>
		            <tr>
		                <td align="center" class="td2">员工活动D</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">&nbsp;</td>
		                <td align="center" class="td2">&nbsp;</td>
		            </tr>
		            <tr>
		                <td align="center" class="td2">员工活动E</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">&nbsp;</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">Y</td>
		            </tr>
		            <tr>
		                <td align="center" class="td2">员工活动F</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">&nbsp;</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">&nbsp;</td>
		            </tr>
		            <tr>
		                <td align="center" class="td2">员工活动G</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">&nbsp;</td>
		                <td align="center" class="td2">&nbsp;</td>
		                <td align="center" class="td2">Y</td>
		            </tr>
		            <tr>
		                <td align="center" class="td2">员工活动H</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">&nbsp;</td>
		                <td align="center" class="td2">&nbsp;</td>
		                <td align="center" class="td2">&nbsp;</td>
		            </tr>
		            <tr>
		                <td align="center" class="td2">员工活动J</td>
		                <td align="center" class="td2">&nbsp;</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">Y</td>
		                <td align="center" class="td2">&nbsp;</td>
		            </tr>
		            <tr>
		                <td align="center" class="td2"><font style="color: red;">员工活动K</font></td>
		                <td align="center" class="td2">&nbsp;</td>
		                <td align="center" class="td2"><font style="color: red;">Y</font></td>
		                <td align="center" class="td2">&nbsp;</td>
		                <td align="center" class="td2">&nbsp;</td>
		            </tr>
		        </table>
        </div>
    <script language="javascript">
        //初始化页面，控制显示哪一个帮助文档。
        //type：A为helpA文档（A.   公司标准报价单对应的ERP报价单中的产品名称）
        //type：B为helpB文档（B. 新建报价单注意点）
        //type：C为helpC文档（C. 常见Q&A）
        $(function(){
            var type = "${type}";
            if(type == "A"){
                document.getElementById("helpA").style.display="block";
                document.getElementById("helpB").style.display="none";
                document.getElementById("helpC").style.display="none";
            }else if(type == "B"){
                document.getElementById("helpA").style.display="none";
                document.getElementById("helpB").style.display="block";
                document.getElementById("helpC").style.display="none";
            }else{
                document.getElementById("helpA").style.display="none";
                document.getElementById("helpB").style.display="none";
                document.getElementById("helpC").style.display="block";
            }
		});
    </script>
    </body>
</html>