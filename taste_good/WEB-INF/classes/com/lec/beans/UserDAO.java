package com.lec.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import common.D;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;

	// DAO 객체가 생성될때 Connection 도 생성된다.
	public UserDAO() {
		try {
			Class.forName(D.DRIVER);
			conn= DriverManager.getConnection(D.URL, D.USERID, D.USERPW);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// DB 자원 반납 
	public void close() throws SQLException{
		if(rs != null) rs.close();
		if(stmt != null) stmt.close();
		if(pstmt != null) pstmt.close();			
		if(conn != null) conn.close();
	}
	
	// 회원가입
	public int insert(UserDTO dto) throws SQLException{
		int cnt = 0;
		int u_num;  // auto-generated key 값
		String [] generatedCols = {"u_num"};
		
		StringBuffer query = new StringBuffer();
		query.append("INSERT INTO member").append(
				" (id, pass, name, gender, tel, email, address1, address2) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
		try {
			pstmt = conn.prepareStatement(query.toString(), generatedCols);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getGender());
			pstmt.setString(5, dto.getTel());
			pstmt.setString(6, dto.getEmail());
			pstmt.setString(7, dto.getAddress1());
			pstmt.setString(8, dto.getAddress2());
			cnt = pstmt.executeUpdate();
			System.out.println("cnt: " + cnt);
			
			if(cnt>0) {
				// auto-generated key 값 가져오기
				rs = pstmt.getGeneratedKeys();
				if(rs.next()){
					u_num = rs.getInt(1);
					dto.setU_num(u_num);  
				}
			}
		} finally {
			close();
		}
		
		return cnt;
	}
	
	public int login(String id, String pass) throws SQLException {
		StringBuffer query = new StringBuffer();
		query.append("SELECT pass").append(" FROM member").append(" WHERE id = ?");
		try {
			pstmt = conn.prepareStatement(query.toString());
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if(rs.getString("pass").equals(pass)) {
					return 1;
				} else {
					return 0;
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return -1;
	}
	
	public int checkId(String id) throws SQLException{

		int res = 0;
	
		try {
		    String query = "select id from member where id = ?";
		    pstmt = conn.prepareStatement(query);
		    pstmt.setString(1,  id);
		    rs = pstmt.executeQuery();
		    
		    if(rs.next()) res = 1;
		}finally {
			close();
		}
			return res;
	    }	
	
	public int getU_numById(String id) throws SQLException {
		
		int u_num =	0;
		
		try {
		String query = "SELECT u_num From member WHERE id = ?";
		
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			u_num = rs.getInt("u_num");
			
			}
		} finally {
			close();
		}
		
		return u_num;
		
	}
	
}
