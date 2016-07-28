/**
 * 字段名称:MyTest
 */
package test.gap.warning.comparator;

import junit.framework.TestCase;

/*************************************
 * @(C)Copyright 北京瑞友科技股份有限公司上海分公司. 2013
 * @作者: 谭彦军
 * @创建时间：2013-6-24 上午02:14:16
 * @文件名：MyTest.java
 * @描述： 
 *************************************/
public class MyTest extends TestCase {

    
       public void test(){
           StringBuilder GET_AGENT_BILLITEM_BY_BILLID = new StringBuilder()
           .append("with  lp  as (select *  from agent_fin_bill_item_mod modv where modv.BILLID = ?  ) ")
           .append("select emp_id,  emp_name,  bill_id, service_year_month, emp_post_id,  emp_code, ")
           .append("LISTAGG(product_id || '~' || product_name || '~' || product_type || '~' || ")
           .append("nvl(to_char(e_base, 'FM9999999.0099'), '^') || '~' || ")
           .append("nvl(to_char(amount, 'FM9999999.0099'), '^') || '~' || ")
           .append("nvl(to_char(p_ratio, 'FM9999999.0099'), '^') || '~' || ")
           .append("nvl(to_char(p_money, 'FM9999999.0099'), '^') || '~' || ")
           .append("nvl(to_char(e_ratio, 'FM9999999.0099'), '^') || '~' || ")
           .append("nvl(to_char(e_money, 'FM9999999.0099'), '^') || '~' || ")
           .append("nvl(to_char(0), '^') || '~' || nvl(to_char(city_name), '^') || '~' || ")
           .append("nvl(to_char(is_sum), '^'), ")
           .append(" '~') WITHIN GROUP(ORDER BY product_type, serial_no) pro ")
           .append("from (select alluser.*, t3.e_base, t3.amount,  t3.p_ratio, t3.p_money,t3.e_ratio, t3.e_money,   t3.is_sum,  t3.city_name ")
           .append("from (select distinct emp_id, emp_name,  emp_code, service_year_month, product_type, product_id, product_name, serial_no, billid bill_id, emp_post_id  from lp) alluser ")
           .append("left join (select t4.*, sp2.city_name  from lp t4   left join (select sp.*, pb.city_name from pb_security_product sp ")
           .append("left join pb_city pb on pb.id = sp.city_id) sp2 on sp2.id =  t4.security_product_id) t3  ")
           .append("on alluser.emp_id = t3.emp_id ")
           .append("and alluser.emp_post_id = t3.emp_post_id and alluser.product_id = t3.product_id  ")
           .append("and alluser.service_year_month = t3.service_year_month ")
          .append(" )   where is_sum !='0'     group by emp_id, emp_name, emp_code, service_year_month, bill_id, emp_post_id");
           System.out.println(GET_AGENT_BILLITEM_BY_BILLID.toString());
       }
}
