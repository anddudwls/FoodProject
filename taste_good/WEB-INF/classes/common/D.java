package common;

public class D {
	public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	public static final String URL = "jdbc:mysql://localhost:3306/mysql"; // DB URL, DB info
	public static final String USERID = "fooddb";
	public static final String USERPW = "1111";
	
	
	
	public static final String SQL_WRITE_INSERT = 
			"INSERT INTO board" + 
			"(subject, content, kind, u_num) " + 
			"VALUES(?, ?, ?, ?)"; //TODO U_num ������
	
	public static final String SQL_WRITE_INC_VIEWCNT = 
			"UPDATE board SET viewcnt = viewcnt + 1 WHERE b_num = ?";
	
	public static final String SQL_WRITE_SELECT_BY_B_NUM = 
			"SELECT " +
			"m.id AS id, " +
			"b.subject AS subject, b.b_num AS b_num, b.kind AS kind, " +
			"b.viewcnt AS viewcnt, b.content AS content, b.u_num AS u_num, b.regdate AS regdate " + 
			"FROM member m " + 
			"JOIN board b ON m.u_num = b.u_num " + 
			"WHERE(b_num=?)";

	public static final String SQL_WRITE_SELECT= 
			"SELECT " +
			"m.id AS id, " +
			"b.subject AS subject, b.b_num AS b_num, b.kind AS kind, " +
			"b.viewcnt AS viewcnt, b.content AS content, b.u_num AS u_num, b.regdate AS regdate " + 
			"FROM member m " + 
			"JOIN board b ON m.u_num = b.u_num " + 
			"ORDER BY b_num DESC";
	
	public static final String SQL_WRITE_UPDATE = 
			"UPDATE board SET kind = ?, subject = ?, content = ? WHERE b_num = ?";
	
	public static final String SQL_WRITE_DELETE_BY_B_NUM = 
			"DELETE FROM board WHERE b_num = ?";	
	
	public static final String SQL_WRITE_COUNT_ALL = 
			"SELECT count(*) FROM board";
	
	public static final String SQL_WRITE_SELECT_FROM_ROW = 
			"SELECT "+
			"m.id AS id, b.subject AS subject, b.b_num AS b_num, " +
			"b.kind AS kind, b.content AS content, " +
			"b.viewcnt AS viewcnt, b.regdate AS regdate " +
			"FROM member m " +
			"JOIN board b ON m.u_num = b.u_num " +
			"ORDER BY b_num DESC " + "LIMIT ?, ?"
			;
	
	public static final String SQL_WRITE_SELECT_U_NUM =
			"SELECT m.u_num AS u_num FROM MEMBER m " +
			"JOIN board b ON m.u_num = b.u_num " +
			"WHERE m.id = ?"
			;
	
	//=============================================================
	
	
	public static final String SQL_FILE_INSERT = 
			"INSERT INTO boardFiles"
			+ "(bf_source, bf_file, b_num) "
			+ "VALUES"
			+ "(?, ?, ?)";
	
	public static final String SQL_FILE_SELECT = 
			"SELECT bf_num f_num, bf_source source, bf_file file FROM boardFiles "
			+ "WHERE b_num = ? "
			+ "ORDER BY bf_num DESC";
	
	public static final String SQL_FILE_SELECT_BY_F_NUM = 
			"SELECT bf_num f_num, bf_source source, bf_file file FROM boardFiles "
			+ "WHERE bf_num = ? ";
	
	public static final String SQL_FILE_DELETE_BY_F_NUM = 
			"DELETE FROM boardFiles WHERE bf_num = ?";
	
	public static final String SQL_FILE_DELETE_BY_B_NUM = 
			"DELETE FROM boardFiles WHERE b_num = ?";


	
	//==============================================================
	
	public static final String SQL_COMMENT_INSERT =
			"INSERT INTO comment(c_content, c_id, b_num)"+
			"VALUES (?, ?, ?)"
			;
	
	public static final String SQL_COMMENT_SELECT =
			"SELECT c.c_num AS c_num, c.c_id AS c_id, c.c_date AS c_date, " +
			"c.c_content AS c_content, b.b_num AS b_num "+
			"FROM comment c "+
			"JOIN board b ON c.b_num = b.b_num WHERE b.b_num = ? "+
			"ORDER BY c_num DESC;"
			;

	public static final String SQL_COMMENT_SELECT_BY_C_NUM =
			"SELECT c.c_num AS c_num, c.c_id AS id, c.c_date AS c_date, "+
			"c.c_content AS c_content, b.b_num AS b_num "+
			"FROM comment c " +
			"JOIN board b ON c.b_num = b.b_num " +
			"WHERE c_num = ? AND b.b_num = ?" +
			"ORDER BY c_num DESC"
			;

	public static final String SQL_COMMENT_SELECT_BY_C_ID =
			"SELECT c.c_num AS c_num, c.c_id AS id, c.c_date AS c_date, "+
			"c.c_content AS c_content, b.b_num AS b_num "+ 
			"FROM comment c "+ 
			"JOIN board b ON c.b_num = b.b_num "+
			"WHERE c_id = 'frencine1' AND b.b_num = 2 "+
			"ORDER BY c.c_num DESC"
			;
		
	public static final String SQL_COMMENT_UPDATE = 
			"UPDATE comment SET c_content = ? "+
			"WHERE b_num = ? AND c_num = ?"
			;

	public static final String SQL_COMMENT_DELETE = 
			"DELETE FROM comment " +
			"WHERE b_num = ? AND c_num = ?"
			;

}





































