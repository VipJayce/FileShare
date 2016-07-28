<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="gap.authority.helper.LoginHelper"%>
<%@include file="/common/common.jsp"%>
<h:script src="/js/jquery/jquery-1.7.2.min.js"/>

<%@include file="/common/skins/skin0/component.jsp"%>
<%@include file="/jsp/faerp/finance/common.jsp"%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>委派单指南</title>


</head>
<body>

<div id="right">
<div class="ringht_x">
<div id="ccChild1" class="box_xinzeng" style="width: 100%;height :100%;"> 
<div class="box_3">
    <!-- 委派单指南-->
    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#c5dbe2">
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">条目</td>
          <td class="td_1" style="text-align:center;width:45%;" >填写指引</td>
          <td class="td_1"  style="text-align:center;width:45%;">注意点</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">合同</td>
          <td class="td_2" style="text-align:left;width:45%;" >选择正确的合同</td>
          <td class="td_2"  style="text-align:left;width:45%;">影响员工的属性（派遣或委托）</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">委派单名称</td>
          <td class="td_2" style="text-align:left;width:45%;" >注明委派单基本要素，如：委托苏州单立户</td>
          <td class="td_2"  style="text-align:left;width:45%;"></td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">成本中心</td>
          <td class="td_2" style="text-align:left;width:45%;" >选择本委派单对应的成本中心</td>
          <td class="td_2"  style="text-align:left;width:45%;">成本中心会影响账单；<br>
                                                                                            客户的两个成本中心有派员工在同一个城市，需要建两张委派单</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">派出公司</td>
          <td class="td_2" style="text-align:left;width:45%;" >上海自主户填写北京外企德科人力资源服务上海有限公司；<br>
																							北京委托户填写北京外企德科人力资源服务有限公司
																							</td>
          <td class="td_2"  style="text-align:left;width:45%;">影响系统对上海自主户和北京委托户的统计区分</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">接收公司</td>
          <td class="td_2" style="text-align:left;width:45%;" >选择实际为员工操作福利的公司</td>
          <td class="td_2"  style="text-align:left;width:45%;">需要和城市对应，会影响Xpress后续的任务指派；<br>
																							选择错误会导致员工信息无法传递到实际为员工操作福利的公司
																							</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">收款方</td>
          <td class="td_2" style="text-align:left;width:45%;" >上海自主户填写北京外企德科人力资源服务上海有限公司；<br>
																							北京委托户填写北京外企德科人力资源服务有限公司
																							          </td>
          <td class="td_2"  style="text-align:left;width:45%;">影响账单的生成，选择错误会导致无法生成账单或者错误生成账单</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">账单方</td>
          <td class="td_2" style="text-align:left;width:45%;" >上海自主户填写北京外企德科人力资源服务上海有限公司；<br>
																							北京委托户填写北京外企德科人力资源服务有限公司
																							          </td>
          <td class="td_2"  style="text-align:left;width:45%;">影响账单的生成，选择错误会导致无法生成账单或者错误生成账单</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">账单日</td>
          <td class="td_2" style="text-align:left;width:45%;" >根据与客户约定实际账单日填写</td>
          <td class="td_2"  style="text-align:left;width:45%;">影响账单生成时刻的账单数据：<br>
				在当月账单日之前生成账单，ERP和Xpress只能获取到生成时刻之前的当月实做数据；<br>
				在当月账单日或者之后生成账单，ERP和Xpress能获取到账单日之后的当月实做数据；<br>
				</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">账单年月</td>
          <td class="td_2" style="text-align:left;width:45%;" >一般情况请选择“收当月”；<br>
                                                                                          如果与客户约定当月核对上月的账单，且通过账期审批后，可选择“收上月” </td>
          <td class="td_2"  style="text-align:left;width:45%;">影响当月账单中生成的营收数据</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">接单客服</td>
          <td class="td_2" style="text-align:left;width:45%;" >默认无法更改</td>
          <td class="td_2"  style="text-align:left;width:45%;"></td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">是否有入职通知</td>
          <td class="td_2" style="text-align:left;width:45%;" >需要上海call center通知收取材料，请选“是”<br>
																						不需要上海call center通知收取材料，请选“否”
																						</td>
          <td class="td_2"  style="text-align:left;width:45%;">此选项仅针对福利做上海的员工有效</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">社保福利办理方</td>
          <td class="td_2" style="text-align:left;width:45%;" >上海自主户派上海以我司名义交社保请选择“上海公司大库”；<br>
																								北京委托户派上海以我司名义交社保请选择“财务外包公司大库”；<br>
																								上海自主户派外地以我司名义交社保请选择“外地大库”；<br>
																								所有派上海或外地，只要以客户名义交社保都请选择“单立户”；<br>
																						</td>
          <td class="td_2"  style="text-align:left;width:45%;">影响员工的实际交社保的单位</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">用退工福利办理方</td>
          <td class="td_2" style="text-align:left;width:45%;" >上海自主户派上海以我司名义交社保请选择“上海公司大库”；<br>
																								北京委托户派上海以我司名义交社保请选择“财务外包公司大库”；<br>
																								上海自主户派外地以我司名义交社保请选择“外地大库”；<br>
																								所有派上海或外地，只要以客户名义交社保都请选择“单立户”；<br>
																						</td>
          <td class="td_2"  style="text-align:left;width:45%;">影响员工的用工的单位</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">是否月付残保金</td>
          <td class="td_2" style="text-align:left;width:45%;" >与客户约定上海员工的残保金每月随账单收取，请选“是”；<br>
                                                                                            与客户约定上海员工的残保金每年一次性收取，请选“否”；</td>
          <td class="td_2"  style="text-align:left;width:45%;">此选项仅针对福利做上海的员工有效；影响账单中费用的准确性</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">收费属性</td>
          <td class="td_2" style="text-align:left;width:45%;" >与客户约定上海员工的社保公积金费用根据客户HR每月派单数据收取费用，请选“预收”；<br>
                                                                                        与客户约定上海员工的社保公积金费用根据员工福利实际汇缴成功与否而收取费用，请选“实收”</td>
          <td class="td_2"  style="text-align:left;width:45%;">此选项仅针对福利做上海的员工有效；影响账单中费用的准确性</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">社保纳入应收总额</td>
          <td class="td_2" style="text-align:left;width:45%;" >如果客户社保是做大库，请选“是”；<br>
																						如果客户社保是做单立户，且每月通过我司代为汇缴社保费用，请选“是”；<br>
																						如果客户社保是做单立户，且每月自行向社保账户汇缴社保费用，请选“否”；
																						</td>
          <td class="td_2"  style="text-align:left;width:45%;">此选项仅针对福利做上海的员工有效；影响账单中合计费用的准确性</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">公积金纳入应收总额</td>
          <td class="td_2" style="text-align:left;width:45%;" >如果客户公积金是做大库，请选“是”；<br>
																							如果客户公积金是做单立户，且每月通过我司代为汇缴公积金费用，请选“是”；<br>
																							如果客户公积金是做单立户，且每月自行向银行汇缴公积金费用，请选“否”；</td>
          <td class="td_2"  style="text-align:left;width:45%;">此选项仅针对福利做上海的员工有效；影响账单中合计费用的准确性</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">工资纳入应收总额</td>
          <td class="td_2" style="text-align:left;width:45%;" >如果客户的员工工资通过我司发放，请选“是”；<br>
																						如果客户的员工工资不通过我司发放，但是需要将工资数据显示在账单中请选“否”；
																						</td>
          <td class="td_2"  style="text-align:left;width:45%;">影响账单中合计费用的准确性</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">税金纳入应收总额</td>
          <td class="td_2" style="text-align:left;width:45%;" >如果客户的个税通过我司大库申报，请选“是”；<br>
																						如果客户的个税以客户名义直接申报，且每月通过我司代为汇缴个税费用至税务局，请选“是”；<br>
																						如果客户的个税以客户名义直接申报，但每月客户自行向税局汇缴个税费用，请选“否”；
																						</td>
          <td class="td_2"  style="text-align:left;width:45%;">影响账单中合计费用的准确性</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">省市</td>
          <td class="td_2" style="text-align:left;width:45%;" >员工实际的福利地</td>
          <td class="td_2"  style="text-align:left;width:45%;">影响Xpress中实际的福利缴纳地，影响账单中显示的福利城市</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">是否FESCO报税</td>
          <td class="td_2" style="text-align:left;width:45%;" >根据实际报税信息填写：<br>
																						如果不需要我司提供报税服务，请选“不用报税”；<br>
																						如果需要我司提供报税服务，是在客户的单立户名义下进行申报，请选择“FA客户报税”；<br>
																						如果需要我司提供报税服务，是在外地供应商的名义下进行申报，请选择“FESCO全国报税”；<br>
																						如果需要我司提供报税服务，是在我司上海FESCO Adecco名义下进行申报，请选择“FA上海报税”；
																						          </td>
          <td class="td_2"  style="text-align:left;width:45%;">影响实际为员工申报个人所得税的单位，非常重要，请谨慎选择。<br>
																						一旦选错，可能会影响员工办理居住证、落户、购房购车等。
																						</td>
        </tr>
        <tr>
          <td class="td_1" style="text-align:center;width:10%;">补医保开始日期规则</td>
          <td class="td_2" style="text-align:left;width:45%;" >如果客户是按照整月支付补医保费用，请选“与社保开始日期一致”；<br>
                                                                                            如果客户是按照实际在职天数支付补医保费用，请选“与入职日期一致”； </td>
          <td class="td_2"  style="text-align:left;width:45%;">影响员工能够实际开始享受福利的具体日期；<br>
																						影响账单中的补医保收费</td>
        </tr>
        
    </table>
</div>

</div>
</div>
</div>


</body>
</html>

