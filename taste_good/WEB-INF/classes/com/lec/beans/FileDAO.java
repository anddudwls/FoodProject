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

	// DAO ��ü�� �����ɶ� Connection �� �����ȴ�.
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

	// DB �ڿ� �ݳ� 
	public void close() throws SQLException{
		if(rs != null) rs.close();
		if(stmt != null) stmt.close();
		if(pstmt != null) pstmt.close();			
		if(conn != null) conn.close();
	}
	
	// �� update, insert �� ����.
	public int insert(int b_num,  // ÷�ε� �� b_num
			List<String> originalFileNames,  // �������ϸ�(��)
			List<String> fileSystemNames    // ����� ���ϸ�(��)
			) throws SQLException{
		int cnt = 0;
		
		try {
			pstmt = conn.prepareStatement(D.SQL_FILE_INSERT);
			
			// batch (�ϰ��۾�)���	
			for(int i = 0; i < originalFileNames.size(); i++) {
				pstmt.setString(1, originalFileNames.get(i));
				pstmt.setString(2, fileSystemNames.get(i));
				pstmt.setInt(3, b_num);
				
				pstmt.addBatch();  
				pstmt.clearParameters();  
			}
			pstmt.executeBatch();  // batch ����
		} finally {
			close();
		}
		
		return cnt;
	} // end insert()
	

	// ÷������ �о� ���̱� ��
	//---------------------------------------------------------------
	// ResultSet --> List�� ����
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


	// Ư�� �� (b_num) �� ÷������(��) SELECT
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

	// Ư�� ÷������ (f_num) �Ѱ� SELECT
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
	// List<FileDTO> �� �������� ����(��) ����
	public void deleteFiles(List<FileDTO> list, HttpServletRequest request) {
		
		if(list == null || list.size() == 0 || request == null) return;
		
		// �������� ���
		ServletContext context = request.getServletContext();
		String saveDirectory = context.getRealPath("upload");
		
		for(FileDTO dto : list) {
			File f = new File(saveDirectory, dto.getFile());  // ���������� ����� ������ File ��ü
			System.out.println("�����õ� --> " + f.getAbsolutePath());
			
			if(f.exists()) {
				if(f.delete()) {  // ����!
					System.out.println("���� ����");
				} else {
					System.out.println("���� ����");
				}
			} else {
				System.out.println("������ �������� �ʽ��ϴ�");
			}
		} // end for
	} // end deleteFiles()


	// Ư�� �� (b_num) �� ÷������(��) ����
	//1) �������� ����(��) ����, 2) DB ����
	public int deleteByB_num(int b_num, HttpServletRequest request) throws SQLException{
		int cnt = 0;
		
		List<FileDTO> list = null;
		try {
			// �ϴ� Ư�� ��(b_num) �� ÷������ ���� �������� -> List<FileDTO>
			pstmt = conn.prepareStatement(D.SQL_FILE_SELECT);
			pstmt.setInt(1, b_num);
			rs = pstmt.executeQuery();
			
			list = buildList(rs);
			
			// �������� ����(��) ����
			deleteFiles(list, request);
			
			// boardFiles ���� �ܷ�Ű ON DELETE CASCADE ����Ǿ� ������ DB�� �ڵ� ����
			
			//pstmt.close();
			
			
		} finally {
			close();
		}
		
		return cnt;
	} // end deleteByB_num()


	// �������� f_num �� ����(��) ����
	// �� '����' �ܰ� ���� �߻���. '��'�� ���� �Ǵ� ���� �ƴ϶�, ������ ���������� �����ؾ� ��
	public int deleteByF_num(int [] files, HttpServletRequest request) throws SQLException{
		
		if(files == null || files.length == 0 || request == null) return 0;
		
		int cnt = 0;
		
		try {
			// ������ ���� ������ �о���� -> List<FileDTO>
			StringBuffer sql = new StringBuffer("SELECT bf_num f_num, bf_source source, bf_file file FROM boardFiles WHERE b_num IN (");
			
			for(int f_num : files) {
				sql.append(f_num + ",");
			}
			sql.deleteCharAt(sql.lastIndexOf(","));   // �ǳ��� �޸� ����
			sql.append(")");
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql.toString());
			List<FileDTO> list = buildList(rs);
			
			// 1. �������� ����(��) ����
			deleteFiles(list, request);  // ���� ����
			
			// 2. boardFiles ���̺� ����.  '��' �� �����Ǵ°��� �ƴ϶�, ����DB�� ���������� �����ؾ� ��.
			sql = new StringBuffer("DELETE FROM boardFiles WHERE bf_num IN (");
			
			for(int f_num : files) {
				sql.append(f_num + ",");
			}
			sql.deleteCharAt(sql.lastIndexOf(","));   // �ǳ��� �޸� ����
			sql.append(")");
			
			System.out.println("���ϻ���: " + sql);
			cnt = stmt.executeUpdate(sql.toString());
			System.out.println(cnt + "�� ����");
			
		} finally {
			close();
		} 
		
		return cnt;
	} // end deleteByF_num()

	
	
	
}
