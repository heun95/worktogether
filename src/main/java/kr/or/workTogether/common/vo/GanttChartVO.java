package kr.or.workTogether.common.vo;

public class GanttChartVO {
	
	private String id;
	private String label;
	private String rowId;
	private String start;
	private String end;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getRowId() {
		return rowId;
	}
	public void setRowId(String rowId) {
		this.rowId = rowId;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	@Override
	public String toString() {
		return "GanttChartVO [id=" + id + ", label=" + label + ", rowId=" + rowId + ", start=" + start + ", end=" + end
				+ "]";
	}
	
	
	
	

}
