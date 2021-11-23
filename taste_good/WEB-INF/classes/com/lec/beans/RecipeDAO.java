package com.lec.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import common.D;

public class RecipeDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;

	public RecipeDAO() {
		try {
			Class.forName(D.DRIVER);
			conn = DriverManager.getConnection(D.URL, D.USERID, D.USERPW);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void close() throws SQLException {
		if (rs != null)
			rs.close();
		if (stmt != null)
			stmt.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}

	// 새글 작성
	public int insert(RecipeDTO dto, List<String> originalFileNames, List<String> fileSystemNames) throws SQLException {

		myfood_FileDAO fileDAO = new myfood_FileDAO();

		int cnt = 0;

		String subject = dto.getSubject();
		String content = dto.getContent();
		String id = dto.getId();
		String kinds = dto.getKinds();
		int u_num = dto.getU_num();

		int m_num; // auto-generated key
		String[] generatedCols = { "m_num" };

		try {
			pstmt = conn.prepareStatement("INSERT INTO myfood (subject, content, kinds, u_num) VALUES(?, ?, ?, ?)",
					generatedCols);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, kinds);
			pstmt.setInt(4, u_num); // u_num로 받기

			cnt = pstmt.executeUpdate();

			if (cnt > 0) {
				// auto-generated key 값 가져오기
				rs = pstmt.getGeneratedKeys();
				if (rs.next()) {
					m_num = rs.getInt(1);
					System.out.println("WriteDAO 생성, 데이터베이스 연결");
					dto.setM_num(m_num);
					fileDAO.insert(m_num, originalFileNames, fileSystemNames);
				}
			}
		} finally {
			fileDAO.close();
			close();
		}
		return cnt;
	}

	// 글 목록 읽기
	// rs -> list
	public List<RecipeDTO> buildList(ResultSet rs) throws SQLException {
		List<RecipeDTO> list = new ArrayList<>();

		while (rs.next()) {
			int m_num = rs.getInt("m_num");
			String kinds = rs.getString("kinds");
			String subject = rs.getString("subject");
			String id = rs.getString("id");
			String content = rs.getString("content");
			int good = rs.getInt("good");
			if (content == null)
				content = "";

			RecipeDTO dto = new RecipeDTO(m_num, kinds, subject, content, id, good);

			list.add(dto);
		}

		return list;
	}
	
	public List<RecipeDTO> buildList_withFiles(ResultSet rs) throws SQLException{
		List<RecipeDTO> list = new ArrayList<>();
		
		while(rs.next()) {
			int m_num = rs.getInt("m_num");
			String kinds = rs.getString("kinds");
			String subject = rs.getString("subject");
			String id = rs.getString("id");
			String content = rs.getString("content");
			int good = rs.getInt("good");
			if (content == null)
				content = "";
			String ff_file = rs.getString("ff_file");
			
			RecipeDTO dto = new RecipeDTO(m_num, kinds, subject, content, id, ff_file, good);
			
			list.add(dto);
		}
		
		return list;
	}

	// 전체 SELECT
	public List<RecipeDTO> select() throws SQLException {
		List<RecipeDTO> list = null;
		try {
			pstmt = conn.prepareStatement(
					"SELECT mf.m_num m_num, mf.kinds kinds, mf.subject subject, m.id id, mf.content content, mf.good good, ff.ff_file ff_file from member m inner join myfood mf on mf.u_num = m.u_num inner join foodFiles ff on mf.m_num = ff.m_num ORDER BY mf.m_num DESC"
					);
			
			/*					"SELECT m.id AS id, mf.subject AS subject, mf.m_num AS m_num,"
			+ " mf.kinds AS kinds, mf.content AS content, mf.u_num AS u_num FROM member m "
			+ "JOIN myfood mf ON m.u_num = mf.u_num ORDER BY mf.m_num DESC" 	*/
			
			rs = pstmt.executeQuery();
			list = buildList_withFiles(rs);
		} finally {
			close();
		}
		return list;
	}

	// update 에 필요
	public List<RecipeDTO> selectByM_num(int m_num) throws SQLException {
		List<RecipeDTO> list = null;

		System.out.println("m_num in selectByM_num for updating share :" + m_num);
		
		try {
			pstmt = conn.prepareStatement(
					"SELECT m.id AS id, mf.subject AS subject, mf.m_num AS m_num, mf.kinds AS kinds, "
							+ " mf.content AS content, mf.good good, mf.u_num AS u_num FROM member m "
							+ "JOIN myfood mf ON m.u_num = mf.u_num WHERE m_num = ? ");
			pstmt.setInt(1, m_num);
			rs = pstmt.executeQuery();
			list = buildList(rs);
		} finally {
			close();
		}

		return list;
	} // selectByB_Num
	
	public List<RecipeDTO> selectByU_num(int u_num) throws SQLException{
		List<RecipeDTO> list = null;
		
		try {
//			pstmt = conn.prepareStatement("SELECT m.id AS id, mf.subject AS subject, mf.m_num AS m_num, mf.kinds AS kinds, " 
//					+ "	mf.content AS content FROM member m JOIN myfood mf WHERE mf.u_num = ?");
			pstmt = conn.prepareStatement(
					"SELECT mf.m_num m_num, mf.kinds kinds, mf.subject subject, m.id id, mf.content content, mf.good good, ff.ff_file ff_file from member m inner join myfood mf on mf.u_num = m.u_num inner join foodFiles ff on mf.m_num = ff.m_num where mf.u_num = ? ORDER BY mf.m_num DESC"
					);
			pstmt.setInt(1,  u_num);
			rs = pstmt.executeQuery();
			list = buildList_withFiles(rs);
		}finally {
			close();
		}
		
		return list;
	}

	// 특정 b_num 글 하나 SELECT + 조회수 증가 : view.jsp
	// viewcnt 로 +1 증가해야 하고, 글 하나 읽어와야 한다, 트랜잭션 처리
	// -> List<DTO> 로 리턴
	public List<RecipeDTO> readByM_num(int m_num) throws SQLException {
		List<RecipeDTO> list = null;
		int cnt = 0;

		try {
			// 트랜잭션 처리
			conn.setAutoCommit(false);

			pstmt = conn.prepareStatement(
					"SELECT m.id AS id, mf.subject AS subject, mf.m_num AS m_num, mf.kinds AS kinds, "
							+ "mf.content AS content, mf.u_num AS u_num, mf.good good FROM member m "
							+ "JOIN myfood mf ON m.u_num = mf.u_num WHERE m_num=?");

			pstmt.setInt(1, m_num);
			rs = pstmt.executeQuery();
			list = buildList(rs);

			conn.commit();
		} catch (SQLException e) {
			conn.rollback();
			throw e;
		} finally {
			close();
		}

		return list;
	} // end readByM_num

	// 특정 m_num 글 수정 <- (m_num, 제목, 내용)
	public int update(int m_num, String kinds, String subject, String content) throws SQLException {
		int cnt = 0;

		try {
			pstmt = conn.prepareStatement("UPDATE myfood SET kinds = ?, subject = ?, content = ? WHERE m_num = ?");
			pstmt.setString(1, kinds);
			pstmt.setString(2, subject);
			pstmt.setString(3, content);
			pstmt.setInt(4, m_num);
			cnt = pstmt.executeUpdate();
		} finally {
			close();
		}
		return cnt;
	} // end update()

	// 특정 m_num 글 삭제하기
	public int deleteByM_num(int m_num) throws SQLException {
		int cnt = 0;

		try {
			pstmt = conn.prepareStatement("DELETE FROM myfood WHERE m_num = ?");
			pstmt.setInt(1, m_num);
			cnt = pstmt.executeUpdate();
		} finally {
			close();
		}

		return cnt;
	}

	public int updategood(int m_num) throws SQLException {
		
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement("UPDATE myfood SET good = good + 1 WHERE m_num = ?");
			pstmt.setInt(1,  m_num);
			cnt = pstmt.executeUpdate();
		}finally {
			close();
		}
		
		return cnt;
	}

	// ----------------------------------------------------------------------
	// ---PAGING-------------------------------------------------------------
//		public List<WriteDTO> getList(int startRow, int endRow) throws SQLException{
//			
//			List<WriteDTO> list = null;
//			
//			try {
//				// 트랜잭션 처리
//				conn.setAutoCommit(false);
//				
//				pstmt = conn.prepareStatement(D.SQL_WRITE_SELECT_FROM_ROW);
//				pstmt.setInt(1, startRow);
//				pstmt.setInt(2, endRow);
//				
//				rs = pstmt.executeQuery();
//				
//				
//				
//				
//			
//			}finally {
//				close();
//			}
//			return list;
//		}

}
