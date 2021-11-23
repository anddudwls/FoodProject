<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%-- 위에서 필요한 트랜잭션이 마무리 되면 페이지에 보여주기 --%>
<c:choose>
	<c:when test="${ fileResult != 0}">
		<c:choose>
			<c:when test="${result == 0 }">
				<script>
					alert("레시피 등록 실패");
					history.back();
				</script>
			</c:when>
			<c:otherwise>
				<script>
					alert("레시피 등록 성공");
					location.href = "myfood_view.do?m_num=${dto.m_num}";
				</script>
			</c:otherwise>
		</c:choose>
	</c:when>
<c:otherwise>
	<script>
		alert("최소 한개의 이미지는 첨부해야합니다.");
		history.back();
	</script>
</c:otherwise>
</c:choose>










