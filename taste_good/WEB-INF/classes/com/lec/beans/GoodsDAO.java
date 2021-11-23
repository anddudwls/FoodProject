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

//DAO : Data Access Object
//특정 데이터 리소스(ex: DB) 에 접속하여 트랜잭션등을 전담하는 객체
//데이터 리소스별로 작성하거나, 
//혹은 기능별로 작성가능 (ex: 게시판용 DAO, 회원관리용 DAO, ...)
public class GoodsDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;

	// DAO 객체가 생성될때 Connection 도 생성된다.
	public GoodsDAO() {
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

	// 글 목록 읽기
	// ResultSet --> List 로 리턴
	public List<GoodsDTO> buildList(ResultSet rs) throws SQLException{
		List<GoodsDTO> list = new ArrayList<>();
		
		while(rs.next()){
			int gbsnum = rs.getInt("gbsnum");
			String gbsname = rs.getString("gbsname");
			int gbsprice = rs.getInt("gbsprice");
			String gbsdes = rs.getString("gbsdes");
			String picture = rs.getString("picture");
			
	
			GoodsDTO dto = new GoodsDTO(gbsnum, gbsname, gbsprice, gbsdes, picture);
			
			list.add(dto);
		}
		
		return list;
	}
	
	// 전체 SELECT
	public List<GoodsDTO> select() throws SQLException{
		List<GoodsDTO> list = null;
		try {
			pstmt = conn.prepareStatement("SELECT * FROM goods");
			rs=pstmt.executeQuery();
			list = buildList(rs);
		}finally {
			close();
		}
		return list;
	}
	
	// 랜덤으로 생성된 gbsnum에 대해 List<GoodsDTO> 리턴
	public List<GoodsDTO> selectByGbsnum(int gbsnum) throws SQLException {
		List<GoodsDTO> list = null;
		try {
			pstmt = conn.prepareStatement("SELECT * FROM goods WHERE gbsnum=?");
			pstmt.setInt(1, gbsnum);
			rs = pstmt.executeQuery();
			list = buildList(rs);
		} finally {
			close();
		}
		return list;
	}

	
} // end DAO

