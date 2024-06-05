package board;
// DB에 있는 데이터를 DTO로 가져옴
public class BoardDTO {
	private int no, viewCount; // 게시판 번호, 조회수
	private String title, content, writer, writeDate; // 제목, 내용, 작성자, 작성일
	private String imgName, imgRealName;
	//.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>").replaceAll(" ", "&nbsp;");
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}
	
	public String getReplaceTitle() {
		// html에서 엔터 및 특수문자 처리를 위한 replace getter
		return title.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>").replaceAll(" ", "&nbsp;");
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}

	public String getReplaceContent() {
		// html에서 엔터 및 특수문자 처리를 위한 replace getter
		return content.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>").replaceAll(" ", "&nbsp;");
	}
	
	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	
	public String getImgName() {
		return imgName;
	}

	public void setImgName(String imgName) {
		this.imgName = imgName;
	}

	public String getImgRealName() {
		return imgRealName;
	}

	public void setImgRealName(String imgRealName) {
		this.imgRealName = imgRealName;
	}
}
