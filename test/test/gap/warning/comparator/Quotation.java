package test.gap.warning.comparator;

import java.util.List;

/**
 * ERP客户报价单
 * @author liuchuanhong
 * @since 2014-4-13
 */
public class Quotation {

	
	
	private String id;			//主键
	
	private String customerCode;	//客户编号
	
	private String customerName;	//客户名称
	
	private String customerId;		//客户ID
	
	private String quotationName;	//报价单名称
	
	private String isValid;			//是否有效  1：有效   0：无效
	
	private String isDel;			//是否删除  1：是        0：否
	
	private List<QuotationItem> quotationItems;		//客户报价单明细

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerId() {
		return customerId;
	}

	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}

	public String getQuotationName() {
		return quotationName;
	}

	public void setQuotationName(String quotationName) {
		this.quotationName = quotationName;
	}

	public String getIsValid() {
		return isValid;
	}

	public void setIsValid(String isValid) {
		this.isValid = isValid;
	}

	public String getIsDel() {
		return isDel;
	}

	public void setIsDel(String isDel) {
		this.isDel = isDel;
	}

	public List<QuotationItem> getQuotationItems() {
		return quotationItems;
	}

	public void setQuotationItems(List<QuotationItem> quotationItems) {
		this.quotationItems = quotationItems;
	}

	public Quotation() {
	}
	
}
