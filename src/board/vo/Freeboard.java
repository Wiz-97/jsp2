package board.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Freeboard {
	private int idx;
	private String writer;
	private String password;
	private String subject;
	private String content;
	private int readCount;
	private Timestamp wdate;
	private String ip;
	private int commentCount;
}
