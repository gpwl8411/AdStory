<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath()%>/js/jquery-3.5.1.js"></script>
<meta charset="UTF-8">
<title>File API</title>
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

</head>
<body>
	<input type="button" id="btnSubmit" value="업로드" />
	<div id="drop">
		메인이미지 drag & drop
		<div id="thumbnails"></div>
	</div>
	<script>
		var uploadFile;
		var $drop = $("#drop");
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
			/* for (var i = 0; i < files.length; i++) {
				var file = files[i];
				var size = uploadFiles.push(file); //업로드 목록에 추가
			} */
				preview(uploadFile[0]); //미리보기 만들기
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
		$("#btnSubmit").on("click", function() {
			var formData = new FormData();
				if (uploadFile[0].upload != 'disable'){ //삭제하지 않은 이미지만 업로드 항목으로 추가
					formData.append('upload-file', uploadFile[0],uploadFile[0].name);
			//console.log("저장됨");
				}
			/* $.each(uploadFiles, function(i, file) {
			}); */
			/* $.ajax({
				url : '/api/etc/file/upload',
				data : formData,
				type : 'post',
				contentType : false,
				processData : false,
				success : function(ret) {
					alert("완료");
				}
			}); */
		});
		$("#thumbnails").on("click", ".close", function(e) {
			var $target = $(e.target);
			var idx = $target.attr('data-idx');
			uploadFile[0].upload = 'disable'; //삭제된 항목은 업로드하지 않기 위해 플래그 생성
			$target.parent().remove(); //프리뷰 삭제
		});
	</script>

</body>
</html>