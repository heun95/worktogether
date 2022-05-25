package kr.or.workTogether.common.vo;

//홈화면즐겨찾기(HOME_BOOKMARK)
public class HomeBookmarkVO {
	private String empId;                   //직원아이디
	private String menuId;                  //메뉴코드
	private int homeBoxNum;                 //홈화면박스번호
	
	public HomeBookmarkVO() {}
	
	public String getEmpId() {
		return empId;
	}
	public String getMenuId() {
		return menuId;
	}
	public int getHomeBoxNum() {
		return homeBoxNum;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public void setHomeBoxNum(int homeBoxNum) {
		this.homeBoxNum = homeBoxNum;
	}

	@Override
	public String toString() {
		return "HomeBookmarkVO [empId=" + empId + ", menuId=" + menuId + ", homeBoxNum=" + homeBoxNum + "]";
	}

}
