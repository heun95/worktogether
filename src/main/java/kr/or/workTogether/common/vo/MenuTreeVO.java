package kr.or.workTogether.common.vo;

//메뉴구조도(MENU_TREE)
public class MenuTreeVO {
	private String menuId;                  //메뉴코드
	private String topMenuId;               //상위메뉴코드
	private int menuLevel;                  //메뉴레벨
	private String menuName;                //메뉴이름
	
	public MenuTreeVO() {}
	
	public String getMenuId() {
		return menuId;
	}
	public String getTopMenuId() {
		return topMenuId;
	}
	public int getMenuLevel() {
		return menuLevel;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public void setTopMenuId(String topMenuId) {
		this.topMenuId = topMenuId;
	}
	public void setMenuLevel(int menuLevel) {
		this.menuLevel = menuLevel;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	
	@Override
	public String toString() {
		return "MenuTreeVO [menuId=" + menuId + ", topMenuId=" + topMenuId + ", menuLevel=" + menuLevel + ", menuName="
				+ menuName + "]";
	}
	
}
