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

public class WriteDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;
		
	public WriteDAO(){
		try {
			Class.forName(D.DRIVER);
			conn = DriverManager.getConnection(D.URL, D.USERID, D.USERPW);
			System.out.println("WriteDAO 생성, 데이터베이스 연결");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void close() throws SQLException {
		if(rs != null) rs.close();
		if(stmt != null) stmt.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
	
	// 새글 작성
	public int insert(WriteDTO dto,
			List<String> originalFileNames,
			List<String> fileSystemNames
			) throws SQLException {
		
		FileDAO fileDAO = new FileDAO();
		
		int cnt = 0;

		String subject = dto.getSubject();
		String content = dto.getContent();
		String id = dto.getId();
		String kind = dto.getKind();
		int u_num = dto.getU_num();
		
		int b_num; // auto-generated key 
		String [] generatedCols = {"b_num"};
		
		try {
			pstmt = conn.prepareStatement(D.SQL_WRITE_INSERT, generatedCols);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, kind);
			pstmt.setInt(4, u_num); // u_num로 받기
			
			cnt = pstmt.executeUpdate();
			
			if(cnt > 0){
				// auto-generated key 값 가져오기
				rs = pstmt.getGeneratedKeys();
				if(rs.next()){
					b_num = rs.getInt(1);
					System.out.println("WriteDAO 생성, 데이터베이스 연결");
					dto.setB_num(b_num);
					fileDAO.insert(b_num, originalFileNames, fileSystemNames);
				}
			}		
		}finally {
			fileDAO.close();
			close();
		}
		return cnt;
	}
	
	
	// 글 목록 읽기
	// rs -> list
	public List<WriteDTO> buildList(ResultSet rs) throws SQLException{
		List<WriteDTO> list = new ArrayList<>();
		
		while(rs.next()){
			int b_num = rs.getInt("b_num");
			String kind = rs.getString("kind");
			String subject = rs.getString("subject");
			String id = rs.getString("id");
			String content = rs.getString("content");
			if(content == null) content = "";
			int viewcnt = rs.getInt("viewcnt");
			
			
			LocalDateTime regDate = rs.getObject("regdate", LocalDateTime.class);
	
			WriteDTO dto = new WriteDTO(b_num, kind, subject, content, id, viewcnt, regDate);
			 
			list.add(dto);
		}
		
		return list;
	}
	
	// 전체 SELECT
		public List<WriteDTO> select() throws SQLException {
			List<WriteDTO> list = null;
			try {
				pstmt = conn.prepareStatement(D.SQL_WRITE_SELECT);
				rs = pstmt.executeQuery();
				list = buildList(rs);
			} finally {
				close();
			}
			return list;
		}

		
		
	// update 에 필요
		public List<WriteDTO> selectByB_num(int b_num) throws SQLException {
			List<WriteDTO> list = null;
			
			try {
				pstmt = conn.prepareStatement(D.SQL_WRITE_SELECT_BY_B_NUM);
				pstmt.setInt(1, b_num);
				rs = pstmt.executeQuery();
				list = buildList(rs);
			} finally {
				close();
			}
			
			return list;
		} // selectByB_Num
		
		
	// 특정 b_num 글 하나 SELECT + 조회수 증가 : view.jsp
	// viewcnt 로 +1 증가해야 하고, 글 하나 읽어와야 한다, 트랜잭션 처리
	// -> List<DTO> 로 리턴 
		public List<WriteDTO> readByB_num(int b_num) throws SQLException {
			List<WriteDTO> list = null;
			int cnt = 0;
			
			try {
				// 트랜잭션 처리
				conn.setAutoCommit(false);
				
				pstmt = conn.prepareStatement(D.SQL_WRITE_INC_VIEWCNT);
				pstmt.setInt(1, b_num);
				cnt = pstmt.executeUpdate();
				
				pstmt.close();
				
				pstmt = conn.prepareStatement(D.SQL_WRITE_SELECT_BY_B_NUM);
				pstmt.setInt(1, b_num);
				rs = pstmt.executeQuery();
				list = buildList(rs);
				
				conn.commit();
			} catch(SQLException e) {
				conn.rollback();
				throw e;
			} finally {
				close();
			}
			
			return list;
		} // end readByB_num
		
		
		// 특정 b_num 글 수정 <- (b_num, 제목, 내용)
		public int update(int b_num, String kind, String subject, String content ) throws SQLException {
			int cnt = 0;
			
			try {
				pstmt = conn.prepareStatement(D.SQL_WRITE_UPDATE);
				pstmt.setString(1, kind);
				pstmt.setString(2,  subject);
				pstmt.setString(3, content);
				pstmt.setInt(4, b_num);
				cnt = pstmt.executeUpdate();
			} finally {
				close();
			}		
			return cnt;
		} // end update()
		
		// 특정 b_num 글 삭제하기
		public int deleteByB_num(int b_num) throws SQLException{
			int cnt = 0;
			
			try {
				pstmt = conn.prepareStatement(D.SQL_WRITE_DELETE_BY_B_NUM);
				pstmt.setInt(1, b_num);
				cnt = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return cnt;
		}
		
		
		//----------------------------------------------------------------------
		//---PAGING-------------------------------------------------------------
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




























