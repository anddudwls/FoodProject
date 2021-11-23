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


public class CommentDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;
	
	public CommentDAO(){
		try {
			Class.forName(D.DRIVER);
			conn = DriverManager.getConnection(D.URL, D.USERID, D.USERPW);
			System.out.println("CommentDAO 생성, 데이터베이스 연결");
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
	
	
	// 댓글 등록
	public int insertComment(CommentDTO comment) throws SQLException{
		int cnt = 0;
		
		String c_id = comment.getC_id();
		String c_content = comment.getC_content();
		int b_num = comment.getB_num();
		
		int c_num;
		String [] generatedCols = {"c_num"};
		
		try {
			pstmt = conn.prepareStatement(D.SQL_COMMENT_INSERT, generatedCols);
			pstmt.setString(1, c_content);
			pstmt.setString(2, c_id);
			pstmt.setInt(3, b_num);
			
			
			cnt = pstmt.executeUpdate();
			
			if(cnt > 0){
				// auto-generated key 값 가져오기
				rs = pstmt.getGeneratedKeys();
				if(rs.next()){
					c_num = rs.getInt(1);
					comment.setC_num(c_num);
				}
			}		
		}finally {
			close();
		}
		return cnt;
	}//end insertComment();	
	
	// 글 목록 읽기
		// rs -> list
	public List<CommentDTO> buildCommentList(ResultSet rs) throws SQLException{
		List<CommentDTO> list = new ArrayList<>();
		
		while(rs.next()){
			
			int c_num = rs.getInt("c_num");
			int b_num = rs.getInt("b_num");
			String c_id = rs.getString("c_id");
			String c_content = rs.getString("c_content");
			if(c_content == null) c_content = "";
			
			LocalDateTime c_date = rs.getObject("c_date", LocalDateTime.class);
	
			CommentDTO dto = new CommentDTO(c_num, b_num, c_id, c_content, c_date);
			 
			list.add(dto);
		}
		
		return list;
	}

	// 전체 SELECT
	public List<CommentDTO> selectComment(int b_num) throws SQLException {
		List<CommentDTO> list = null;
		try {
			pstmt = conn.prepareStatement(D.SQL_COMMENT_SELECT);
			pstmt.setInt(1, b_num);
			rs = pstmt.executeQuery();
			list = buildCommentList(rs);
		} finally {
			close();
		}
		return list;
	}	
		
		
	// update 에 필요
	public List<CommentDTO> selectCommentByC_num( int b_num, int c_num) throws SQLException {
		List<CommentDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(D.SQL_COMMENT_SELECT_BY_C_NUM);
			pstmt.setInt(1, c_num);
			pstmt.setInt(2, b_num);
			rs = pstmt.executeQuery();
			list = buildCommentList(rs);
		} finally {
			close();
		}
		
		return list;
	} // selectByC_Num	

	// 특정 c_num 글 수정 <- (c_num, b_num, 내용)
	public int updateComment(int b_num, int c_num, String c_content) throws SQLException {
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(D.SQL_COMMENT_UPDATE);
			pstmt.setString(1, c_content);
			pstmt.setInt(2, b_num);
			pstmt.setInt(3, c_num);
			
			cnt = pstmt.executeUpdate();
		} finally {
			close();
		}		
		return cnt;
	} // end update()
	
	// 특정 b_num 글 삭제하기
	public int deleteCommentByC_num(int b_num, int c_num) throws SQLException{
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(D.SQL_COMMENT_DELETE);
			pstmt.setInt(1, b_num);
			pstmt.setInt(2, c_num);
			
			cnt = pstmt.executeUpdate();
		} finally {
			close();
		}
		
		return cnt;
	}
		
	
	
	

}
