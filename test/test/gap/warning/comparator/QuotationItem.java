package test.gap.warning.comparator ;

/**
 * ERP客户报价单明细
 * @author liuchuanhong
 * @since 2014-4-13
 */
public class QuotationItem {
	
	private String id;			//主键
	
	private String productId;	//产品ID
	
	private String productName;	//产品名称
	
	private Integer count;		//产品数量
	
	private Double productPrice;	//产品价格
	
	private String productDetailDesc;	//产品描述

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Double getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(Double productPrice) {
		this.productPrice = productPrice;
	}

	public String getProductDetailDesc() {
		return productDetailDesc;
	}

	public void setProductDetailDesc(String productDetailDesc) {
		this.productDetailDesc = productDetailDesc;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public QuotationItem() {
	}
	
}
