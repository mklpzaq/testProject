<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<title>chatting</title>
		<style>
			.col-md-2, .col-md-10 {
				padding: 0;
			}
			
			.panel {
				margin-bottom: 0px;
			}
			
			.chat-window {
				width: 80%;
				height: 1000px;
			}
			
			.chat-window>div>.panel {
				border-radius: 5px 5px 0 0;
			}
			
			.icon_minim {
				padding: 2px 10px;
			}
			
			.msg_container_base {
				background: #e5e5e5;
				margin: 0;
				padding: 0 10px 10px;
				min-height: 500px;
				max-height: 500px;
				overflow-x: hidden;
			}
			
			.top-bar {
				background: #666;
				color: white;
				padding: 10px;
				position: relative;
				overflow: hidden;
			}
			
			.msg_receive {
				padding-left: 0;
				margin-left: 0;
			}
			
			.msg_sent {
				padding-bottom: 20px !important;
				margin-right: 0;
			}
			
			.messages {
				background: white;
				padding: 10px;
				border-radius: 2px;
				box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
				max-width: 100%;
			}
			
			.messages>p {
				font-size: 13px;
				margin: 0 0 0.2rem 0;
			}
			
			.messages>time {
				font-size: 11px;
				color: #ccc;
			}
			
			.msg_container {
				padding: 10px;
				overflow: hidden;
				display: flex;
			}
			
			img {
				display: block;
				width: 200px;
			}
			
			.avatar {
				position: relative;
			}
			
			.base_receive>.avatar:after {
				content: "";
				position: absolute;
				top: 0;
				right: 0;
				width: 0;
				height: 0;
				border: 5px solid #FFF;
				border-left-color: rgba(0, 0, 0, 0);
				border-bottom-color: rgba(0, 0, 0, 0);
			}
			
			.base_sent {
				justify-content: flex-end;
				align-items: flex-end;
			}
			
			.base_sent>.avatar:after {
				content: "";
				position: absolute;
				bottom: 0;
				left: 0;
				width: 0;
				height: 0;
				border: 5px solid white;
				border-right-color: transparent;
				border-top-color: transparent;
				box-shadow: 1px 1px 2px rgba(black, 0.2);
				//
				not
				quite
				perfect
				but
				close
			}
			
			.msg_sent>time {
				float: right;
			}
			
			.msg_container_base::-webkit-scrollbar-track {
				-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
				background-color: #F5F5F5;
			}
			
			.msg_container_base::-webkit-scrollbar {
				width: 12px;
				background-color: #F5F5F5;
			}
			
			.msg_container_base::-webkit-scrollbar-thumb {
				-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
				background-color: #555;
			}
			
			.btn-group.dropup {
				position: fixed;
				left: 0px;
				bottom: 0;
			}
		</style>
		<script>
			/* $(document).ready(function(){ */
				/* var textarea = document.getElementById('messageWindow'); */
				alert('다시돌아옴');
				var textarea = '';
				/* var textarea = $('#messageWindow'); */
				var webSocket = new WebSocket('ws://localhost:80/my/broadcasting');
				/* var inputMessage = document.getElementById('inputMessage'); */
				/* var inputMessage = $('#inputMessage'); */
				var inputMessage = '';
				webSocket.onerror = function(event) {
					onError(event);
				};
				webSocket.onopen = function(event) {
					alert('open : ' + event);
					onOpen(event);
				};
				webSocket.onmessage = function(event) {
					/* alert('message : ' + event); */
					onMessage(event);
				};
				function onMessage(event) {
					/* textarea.value += "상대 : " + event.data + "\n"; */
					/* textarea.val() += "상대 : " + event.data + "\n"; */
					/* alert('onMessage(event) event : ' + event.data); */
					
					$('#messageWindow').val(textarea + '상대 : ' + event.data + '\n');
					textarea += '상대 : ' + event.data + '\n';
					/* textarea += $('#messageWindow').val(); */
				}
				function onOpen() {
					/* alert('onOpen(event) event:' + event.data); */
					/* textarea.value += "연결 성공\n"; */
					/* textarea.val() += '연결 성공\n'; */
					//========================
					/* $('#messageWindow').val(textarea + 'xx님이 접속하였습니다.\n');
					textarea += 'xx님이 접속하였습니다.\n'; */
					//=============================
					/* textarea += $('#messageWindow').val();
					webSocket.send('xx님이 접속하였습니다.\n'); */
					/* textarea += $('#messageWindow').val(); */
					$('#messageWindow').val('접속 성공.\n');
					textarea += '접속 성공\n';
					webSocket.send('xx님이 접속하였습니다.');
					
				}
				function onError(event) {
					alert(event.data);
				}
				function send() {
					/* textarea.value += "나 : " + inputMessage.value + "\n"; */
					$('#messageWindow').val(textarea + '나 : ' + $('#inputMessage').val() + "\n");
					textarea += '나 : ' + $('#inputMessage').val() + "\n";
					/* $('#messageWindow').val(textarea); */
					/* textarea += $('#messageWindow').val(); */
					/* webSocket.send(inputMessage.value); */
					/* webSocket.send($('#inputMessage').val()); */
					/* webSocket.send('하이'); */
					webSocket.send($('#inputMessage').val());
					$('#inputMessage').val('');
					/* inputMessage.value = "" */;
				}
			/* }); */
			
		</script>
	</head>
	<body>
		<div class="container">
		<!-- ============================== -->
		<fieldset>
			<textarea id="messageWindow" rows="10" cols="50" readonly="true"></textarea>
			<br/>
			<input id="inputMessage" type="text"/>
			<input type="submit" value="send" onclick="send()" />
		</fieldset>
		<!-- ============================== -->
			<div class="jumbotron">
				<h1>ITKey 코딩 교육 채팅</h1>
				<p>현재 화면은 Spring Socket을 이용한 코딩교육을 위한 화면입니다.</p>
			</div>
	
			<div class="col-xs-12 col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading top-bar">
						<div class="col-md-8 col-xs-8">
							<h3 class="panel-title">
								<span class="glyphicon glyphicon-comment"></span> ITKey 전체 채팅
							</h3>
						</div>
					</div>
					<div class="panel-body msg_container_base">
						<div class="row msg_container base_sent">
							<div class="col-md-10 col-xs-10">
								<div class="messages msg_sent">
									<p>안녕하세요 식사는 하셨나요?</p>
									<time datetime="2009-11-13T20:00">51분 전</time>
								</div>
							</div>
							<div class="col-md-2 col-xs-2 avatar">
								<img
									src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg"
									class=" img-responsive ">
							</div>
						</div>
						<div class="row msg_container base_receive">
							<div class="col-md-2 col-xs-2 avatar">
								<img
									src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg"
									class=" img-responsive ">
							</div>
							<div class="col-md-10 col-xs-10">
								<div class="messages msg_receive">
									<p>네! 밥은 먹었어요 출근은 하셨나요!?</p>
									<time datetime="2009-11-13T20:00">51분 전</time>
								</div>
							</div>
						</div>
					</div>
					<div class="input-group">
						<input id="btn-input" type="text"
							class="form-control input-sm chat_input" placeholder="내용을 작성하세요." />
						<span class="input-group-btn">
							<button class="btn btn-primary btn-sm" id="btn-chat">보내기</button>
						</span>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>