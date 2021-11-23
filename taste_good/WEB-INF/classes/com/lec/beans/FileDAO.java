package com.lec.beans;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import common.D;

public class FileDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;

	// DAO 객체가 생성될때 Connection 도 생성된다.
	public FileDAO() {
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
	
	// 글 update, insert 시 사용됨.
	public int insert(int b_num,  // 첨부될 글 b_num
			List<String> originalFileNames,  // 원본파일명(들)
			List<String> fileSystemNames    // 저장된 파일명(들)
			) throws SQLException{
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(D.SQL_FILE_INSERT);
			
			// batch (일괄작업)사용	
			for(int i = 0; i < originalFileNames.size(); i++) {
				pstmt.setString(1, originalFileNames.get(i));
				pstmt.setString(2, fileSystemNames.get(i));
				pstmt.setInt(3, b_num);
				
				pstmt.addBatch();  
				pstmt.clearParameters();  
			}
			pstmt.executeBatch();  // batch 실행
		} finally {
			close();
		}
		
		return cnt;
	} // end insert()
	

	// 첨부파일 읽어 들이기 ★
	//---------------------------------------------------------------
	// ResultSet --> List로 리턴
	public List<FileDTO> buildList(ResultSet rs) throws SQLException {
		List<FileDTO> list = new ArrayList<>();
		
		while(rs.next()) {
			int f_num = rs.getInt("f_num");
			String source = rs.getString("source");
			String file = rs.getString("file");
			
			FileDTO dto = new FileDTO(f_num, source, file);
			list.add(dto);
		}
		
		return list;
	} // end buildList()


	// 특정 글 (b_num) 의 첨부파일(들) SELECT
	public List<FileDTO> selectFilesByB_num(int b_num) throws SQLException {
		List<FileDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(D.SQL_FILE_SELECT);
			pstmt.setInt(1, b_num);
			rs = pstmt.executeQuery();
			
			list = buildList(rs);
		} finally {
			close();
		}
		
		return list;
	} // end selectFilesByB_num()

	// 특정 첨부파일 (f_num) 한개 SELECT
	public List<FileDTO> selectByF_num(int f_num) throws SQLException {
		List<FileDTO> list = null;
		
		try {
			pstmt = conn.prepareStatement(D.SQL_FILE_SELECT_BY_F_NUM);
			pstmt.setInt(1, f_num);
			rs = pstmt.executeQuery();
			
			list = buildList(rs);
		} finally {
			close();
		}
		
		return list;
	} // end selectByF_num()

	//---------------------------------------------------------------
	// List<FileDTO> 의 물리적인 파일(들) 삭제
	public void deleteFiles(List<FileDTO> list, HttpServletRequest request) {
		
		if(list == null || list.size() == 0 || request == null) return;
		
		// 물리적인 경로
		ServletContext context = request.getServletContext();
		String saveDirectory = context.getRealPath("upload");
		
		for(FileDTO dto : list) {
			File f = new File(saveDirectory, dto.getFile());  // 물리적으로 저장된 파일의 File 객체
			System.out.println("삭제시도 --> " + f.getAbsolutePath());
			
			if(f.exists()) {
				if(f.delete()) {  // 삭제!
					System.out.println("삭제 성공");
				} else {
					System.out.println("삭제 실패");
				}
			} else {
				System.out.println("파일이 존재하지 않습니다");
			}
		} // end for
	} // end deleteFiles()


	// 특정 글 (b_num) 의 첨부파일(들) 삭제
	//1) 물리적인 파일(들) 삭제, 2) DB 삭제
	public int deleteByB_num(int b_num, HttpServletRequest request) throws SQLException{
		int cnt = 0;
		
		List<FileDTO> list = null;
		try {
			// 일단 특정 글(b_num) 의 첨부파일 정보 가져오기 -> List<FileDTO>
			pstmt = conn.prepareStatement(D.SQL_FILE_SELECT);
			pstmt.setInt(1, b_num);
			rs = pstmt.executeQuery();
			
			list = buildList(rs);
			
			// 물리적인 파일(들) 삭제
			deleteFiles(list, request);
			
			// boardFiles 에서 외래키 ON DELETE CASCADE 적용되어 있으면 DB는 자동 삭제
			
			//pstmt.close();
			
			
		} finally {
			close();
		}
		
		return cnt;
	} // end deleteByB_num()


	// 복수개의 f_num 의 파일(들) 제거
	// 글 '수정' 단계 에서 발생함. '글'이 삭제 되는 것은 아니라서, 파일을 개별적으로 삭제해야 함
	public int deleteByF_num(int [] files, HttpServletRequest request) throws SQLException{
		
		if(files == null || files.length == 0 || request == null) return 0;
		
		int cnt = 0;
		
		try {
			// 삭제할 파일 정보들 읽어오기 -> List<FileDTO>
			StringBuffer sql = new StringBuffer("SELECT bf_num f_num, bf_source source, bf_file file FROM boardFiles WHERE b_num IN (");
			
			for(int f_num : files) {
				sql.append(f_num + ",");
			}
			sql.deleteCharAt(sql.lastIndexOf(","));   // 맨끝의 콤마 삭제
			sql.append(")");
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql.toString());
			List<FileDTO> list = buildList(rs);
			
			// 1. 물리적인 파일(들) 삭제
			deleteFiles(list, request);  // 파일 삭제
			
			// 2. boardFiles 테이블 삭제.  '글' 이 삭제되는것이 아니라서, 파일DB를 개별적으로 삭제해야 함.
			sql = new StringBuffer("DELETE FROM boardFiles WHERE bf_num IN (");
			
			for(int f_num : files) {
				sql.append(f_num + ",");
			}
			sql.deleteCharAt(sql.lastIndexOf(","));   // 맨끝의 콤마 삭제
			sql.append(")");
			
			System.out.println("파일삭제: " + sql);
			cnt = stmt.executeUpdate(sql.toString());
			System.out.println(cnt + "개 삭제");
			
		} finally {
			close();
		} 
		
		return cnt;
	} // end deleteByF_num()

	
	
	
}
