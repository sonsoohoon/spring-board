<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp" %>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div><!-- col-lg-12 end -->
</div><!-- row end -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default"></div>
			<div class="panel-heading">Board Read Page</div>
			<div class="panel-body" style="padding : 0;">
			
					<div class="form-group">
						<label>Bno</label>
						<input class="form-control" name='bno'
							value='<c:out value="${board.bno}"/>' readonly="readonly">
					</div><!-- form-group end -->
					
					<div class="form-group">
						<label>Title</label>
						<input class="form-control" name='title'
							value='<c:out value="${board.title}" />' readonly="readonly">
					</div><!-- form-group end -->
					
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name='content'
							 readonly="readonly" ><c:out value="${board.content}" />
						</textarea>
					</div><!-- form-group end -->	

					<div class="form-group">
						<label>Writer</label>
						<input class="form-control" name='writer'
							value='<c:out value="${board.writer}" />' readonly="readonly">
					</div>
					
					<button data-oper='modify' class="btn btn-default">
						Modify
					</button>
					<button data-oper='list' class="btn btn-info">
						List
					</button>
					
					<!-- page 이동을 위한 폼 -->
					<form id="openForm" action="${pageContext.request.contextPath}/board/modify" method="get">
						<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
						<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
						<input type="hidden" id="amount" name="amount" value='<c:out value="${cri.amount}"/>'>
						<input type="hidden" id="type" name="type" value='<c:out value="${cri.type}"/>'>
						<input type="hidden" id="keyword" name="keyword" value='<c:out value="${cri.keyword}"/>'>
					</form>
				
			</div><!-- panel-body end -->
	</div><!-- col-lg-12 end -->
</div><!-- row end -->


<!-- 버튼 이벤트 처리 -->
<script type="text/javascript">
	$(document).ready(function() {
		var openForm = $("#openForm");
		$("button[data-oper='modify']").on("click", function(e) {
			openForm.attr("action", "${pageContext.request.contextPath}/board/modify").submit();
		}); /* $("button[data-oper='modify']") end */
		
		$("button[data-oper='list']").on("click", function(e) {
			openForm.find("#bno").remove();
			openForm.attr("action", "${pageContext.request.contextPath}/board/list").submit();
		});

	}); /* ready end */
	
	
</script>


<%@ include file="../includes/footer.jsp" %>
