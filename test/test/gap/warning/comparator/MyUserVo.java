package test.gap.warning.comparator;

import java.util.List;


public class MyUserVo   implements Cloneable {

	public MyUserVo(){
		
	}
	
	public MyUserVo myuservo ;
	
	private String value ;
	private String count ;
	private List<MyUserVo> listvalue ;
	
	public List<MyUserVo> getListvalue() {
		return listvalue;
	}
	public void setListvalue(List<MyUserVo> listvalue) {
		this.listvalue = listvalue;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public MyUserVo getMyuservo() {
		return myuservo;
	}
	public void setMyuservo(MyUserVo myuservo) {
		this.myuservo = myuservo;
	}

}
