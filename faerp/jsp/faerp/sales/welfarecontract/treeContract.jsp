<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
String flag = request.getParameter("flag");
System.out.println("flag:"+flag);
%>
<fmt:bundle basename="rayoo.salse.salcontract.salcontract_resource" prefix="rayoo.salse.salcontract.">
<br />
<table class="table_div_content" align="left" width="100%">
    <tr>
            <td align="left" ><fmt:message key="name"/></td>
            <td align="left">
                <%if("insert".equals(flag)  || "update".equals(flag)) {%>
                <input type="text" class="text_field" name="contract_template_item_name" inputName="合同模板明细名称" value="" maxLength="150" validate="notNull;"  />
                <%}else{ %>
                <input type="text" class="text_field" name="contract_template_item_name" inputName="合同模板明细名称" value="" maxLength="150" validate="notNull;" readonly="readonly"/>
                <%} %>
            </td>
            
        </tr>
        <tr>
            <td align="left" ><fmt:message key="content"/></td>
            <td align="left" >
            <%if("insert".equals(flag)  || "update".equals(flag)) {%>
                <textarea class="textarea_limit_words" style=" width:500px;"     rows="5" name="contract_template_item_content" inputName="合同模板明细内容" maxLength="1000" lang="1000"></textarea>
            <%}else{ %>
                <textarea class="textarea_limit_words" style=" width:500px;"     rows="5" name="contract_template_item_content" inputName="合同模板明细内容" maxLength="1000" lang="1000" readonly="readonly"></textarea>
             <%} %>
            </td>
        </tr>
        <tr>
            <td align="left"><fmt:message key="en_name"/></td>
            <td  align="left" >
             <%if("insert".equals(flag)  || "update".equals(flag)) {%>
               <input type="text" class="text_field" name="english_name" inputName="合同模板条款英文名称" value="" maxLength="50" />
            <%}else{ %>
                <input type="text" class="text_field" name="english_name" inputName="合同模板条款英文名称" value="" maxLength="50"  readonly="readonly"/>
             <%} %>
            </td>
         
        </tr>
        <tr>
            <td align="left"><fmt:message key="en_content"/></td>
            <td align="left" >
            <%if("insert".equals(flag)  || "update".equals(flag)) {%>
               <textarea class="textarea_limit_words" style=" width:500px;" rows="5" name="english_content" inputName="合同模板条款英文内容" maxLength="1000"></textarea>
            <%}else{ %>
                <textarea class="textarea_limit_words" style=" width:500px;" rows="5" name="english_content" inputName="合同模板条款英文内容" maxLength="1000"   readonly="readonly"></textarea>
             <%} %>
            </td>
        </tr>
   
        <tr>
            <td  align="left" ><fmt:message key="display_order"/></td>
            <td  align="left" >
            <%if("insert".equals(flag)  || "update".equals(flag)) {%>
               <input type="text" class="text_field" name="serial_no" inputName="serial_no" maxLength="19" integerDigits="18" decimalDigits="0"/>
            <%}else{ %>
                 <input type="text" class="text_field" name="serial_no" inputName="serial_no" maxLength="19" integerDigits="18" decimalDigits="0"  readonly="readonly"/>
             <%} %>
            </td>
       
        </tr>

           
      
   
</table>
</fmt:bundle>