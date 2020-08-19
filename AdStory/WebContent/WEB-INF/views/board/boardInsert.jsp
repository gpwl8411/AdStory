<%@page import="oracle.net.aso.b"%>
<%@page import="board.model.vo.BoardCategory"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="board.model.vo.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery-3.5.1.js"></script>
<%
	List<BoardCategory> categoryList = (List<BoardCategory>) request.getAttribute("categoryList");
%>
<style>
#drop {
	border: 10px dashed #ccc;
	width: 300px;
	height: 300px;
}

#thumbnails {
	width: 100%;
	height: 100%;
}

.drag-over {
	background-color: grey;
}

.thumb {
	width: 200px;
	padding: 5px;
	float: left;
}

.thumb>img {
	width: 100%;
}

.thumb>.close {
	position: absolute;
	background-color: red;
	cursor: pointer;
}
</style>

<div class="m-12">
	<p class="text-3xl border-b-2 mb-10">게시글 작성</p>

	<!-- 	<button id="btnSubmit">메인이미지 등록</button> -->

	<form id="boardInsertFrm"
		action="<%=request.getContextPath()%>/board/insert" method="post"
		enctype="multipart/form-data">
		<input type="file" name="upMainImage" id="upMainImage"
			style="display: none;"> <input type="hidden" name="userKey"
			value="<%=memberLoggedIn.getKey()%>" /> <input type="hidden"
			name="memberId" value="<%=memberLoggedIn.getMemberId()%>" /> <input
			type="hidden" name="userPoint" value="<%=memberLoggedIn.getPoint()%>" />
		<div class="inline-block relative w-64">
			<select
				class="block appearance-none w-full bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline"
				name="categoryKey" id="">
				<%
					for (BoardCategory b : categoryList) {
				%>
				<option value="<%=b.getKey()%>"><%=b.getCategoryName()%></option>
				<%
					}
				%>
			</select>
			<div
				class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
				<svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 20 20">
					<path
						d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" /></svg>
			</div>
		</div>
		<div class="flex flex-wrap -mx-3 mb-6">

			
				<label
					class="block uppercase tracking-wide text-gray-700 text-xl font-bold mb-2"
					for="grid-last-name"> 제목 </label> <input
					class="appearance-none block w-full bg-gray-200 text-gray-700 border border-gray-200 rounded py-3 px-4 leading-tight focus:outline-none focus:bg-white focus:border-gray-500"
					type="text" name="title" required placeholder="제목을 입력해주세요">
			
		</div>
	
		<table id="tbl-board-view">

			<tr>
				<th>이미지</th>
				<td>
					<div id="drop">
						메인이미지 drag & drop
						<div id="thumbnails"></div>
					</div>
				</td>
			</tr>

			<tr>
				<th>제 목</th>
				<td><input type="text" name="title" required></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name=""
					value="<%=memberLoggedIn.getName()%>" readonly /></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td><input type="file" name="upFile"></td>
			</tr>
			<tr>
				<th>내 용</th>
				<td><textarea rows="5" cols="40" name="content"></textarea></td>
			</tr>
			<tr>
				<th>가격</th>
				<td><input type="text" name="point" /></td>
			<tr>
				<th>단가</th>
				<td><select name="clickPrice">
						<option value="10">10원</option>
						<option value="20">20원</option>
						<option value="30">30원</option>
				</select></td>
			</tr>
			<tr>
				<th>url</th>
				<td><input type="text" name="url" /></td>
			</tr>
			<tr>

				<th colspan="2"><input type="submit" value="등록하기"
					onclick="return boardValidate();"></th>
			</tr>
		</table>
	</form>
</div>
<script>
	var uploadFile;
	var $drop = $("#drop");
	console.log("droptext", $drop.html());

	$(function() {
		$drop.on("dragenter", function(e) { //드래그 요소가 들어왔을떄
			$(this).addClass('drag-over');
		}).on("dragleave", function(e) { //드래그 요소가 나갔을때
			$(this).removeClass('drag-over');
		}).on("dragover", function(e) {
			e.stopPropagation();
			e.preventDefault();
		}).on('drop', function(e) { //드래그한 항목을 떨어뜨렸을때
			e.preventDefault();
			$(this).removeClass('drag-over');
			uploadFile = e.originalEvent.dataTransfer.files; //드래그&드랍 항목
			$("#upMainImage").prop("files", uploadFile);
			preview(uploadFile[0]); //미리보기 만들기
		});
	});

	function preview(file) {
		var reader = new FileReader();
		reader.onload = (function(f) {
			return function(e) {
				var div = '<div class="thumb"> \
<div class="close" data-idx="' + 0 + '">X</div> \
<img src="'
						+ e.target.result
						+ '" title="'
						+ escape(f.name)
						+ '"/> \
</div>';
				$("#thumbnails").html(div);
			};
		})(file);
		reader.readAsDataURL(file);
	}
	$("#thumbnails").on("click", ".close", function(e) {
		var $target = $(e.target);
		var idx = $target.attr('data-idx');
		uploadFile = [];//삭제된 항목은 업로드하지 않기 위해 플래그 생성
		$target.parent().remove(); //프리뷰 삭제
	});
	function boardValidate(e) {
		//내용을 작성하지 않은 경우에 대한 유효성 검사하세요.
		//공백만 작성한 경우도 폼이 제출되어서는 안됨.
		var $boardTitle = $("[name=title]");
		var $boardContent = $("[name=content]");
		//formData = $('#boardInsertFrm');
		//console.log($('#boardInsertFrm').serialize());

		//formData = formElement.getFormData();
		console.log($('#boardInsertFrm').serializeArray());

		if (/^.+$/.test($boardTitle.val()) == false) {
			alert("제목을 입력하세요.");
			return false;
		}
		if (/^(.|\n)+$/.test($boardContent.val()) == false) {
			alert("내용을 입력하세요.");
			return false;
		}

		return true;
	}
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>