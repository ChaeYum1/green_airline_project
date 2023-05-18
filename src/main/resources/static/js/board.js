$(document).ready(function() {
	// 테이블 내 행이 클릭되면 이벤트 발생
	$(".tr--boardList").on("click", function() {
		// 클릭된 행의 id 이름을 가져옴
		// $(this)는 이벤트가 발생한 대상 자체를 가리킴
		// id 이름에서 board.id만 가져옴
		let boardId = parseInt($(this).attr("id").split("boardDetail")[1]);
		console.log(boardId);
		let date = ($(this).children().eq(4));

		$.ajax({
			type: "GET",
			url: `/board/detail/${boardId}`,
			contentType: 'application/json; charset=utf-8'
		}).done((board) => {

			$(".board--title").text(board.title);
			$(".board--content").text(board.content);
			$(".board--userId").text(board.userId);
			$(".board--viewCount").text(board.viewCount);
			
			$(".board--heart").text(board.heart);
			
			$(".board--date").text(date.text());

		}).fail((error) => {
			console.log(error);
		});
	});
});

$(document).ready(function(){
	//#boardDetail${board.heart}
	$(".board--heart").on("click", function(){
		let boardId = parseInt($(this).attr("id").split("boardDetail")[1]);
		let likeCount = document.getElementById("likeCount");
		let likeval = document.getElementById("likeCheck");
		
		console.log(boardId);
		console.log(likeCount);
		console.log(likeval);
		
		$.ajax({
			type: "POST",
			url: `/board/detail/${boardId}`,
			contentType: 'application/json; charset=utf-8'
		}).done((board) => {
			console.log(board);

			$(".board--heart").text("asfsdlfjsd");

		}).fail((error) => {
			console.log(error);
		});
	});
});