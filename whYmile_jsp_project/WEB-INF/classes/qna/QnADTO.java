package qna;

public class QnADTO {
	private int no;
	private String question, answer;
	
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getQuestion() {
		return question;
	}
	
	public String getReplaceQuestion() {
		// html���� ���� �� Ư������ ó���� ���� replace getter
		return question.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>").replaceAll(" ", "&nbsp;");
	}
	
	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}
	
	public String getReplaceAnswer() {
		// html���� ���� �� Ư������ ó���� ���� replace getter
		return answer.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>").replaceAll(" ", "&nbsp;");
	}
	
	public void setAnswer(String answer) {
		this.answer = answer;
	}

}
