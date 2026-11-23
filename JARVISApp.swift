<!DOCTYPE html>

<html lang="ko">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<meta name="theme-color" content="#020914">

<title>J.A.R.V.I.S.</title>

<style>

*{box-sizing:border-box}

body{

 margin:0;background:#020914;color:#65eaff;

 font-family:Arial,sans-serif;text-align:center;

 min-height:100vh;padding:25px 18px;

}

h1{letter-spacing:7px;margin-top:35px}

#clock{font-size:19px;color:#b4eaff}

.circle{

 width:210px;height:210px;border:2px solid #36dfff;

 border-radius:50%;margin:45px auto;

 display:flex;align-items:center;justify-content:center;

 box-shadow:0 0 25px #00bfff, inset 0 0 25px #007da8;

 animation:pulse 3s infinite;

}

.circle span{font-size:22px;letter-spacing:4px}

@keyframes pulse{

 50%{box-shadow:0 0 45px #00bfff,inset 0 0 40px #007da8}

}

button{

 background:#06283c;color:#70eaff;border:1px solid #25cfff;

 padding:14px 20px;border-radius:10px;margin:6px;

 font-size:15px;

}

input{

 width:90%;padding:15px;background:#071b2b;

 color:white;border:1px solid #25cfff;border-radius:9px;

 margin:15px 0;

}

#output{

 min-height:65px;padding:15px;color:white;

 border:1px solid #14516c;border-radius:10px;

 line-height:1.6;

}

small{color:#729bad}

</style>

</head>

<body>

<h1>J.A.R.V.I.S.</h1>

<div id="clock"></div>

<div class="circle">

 <span id="status">ONLINE</span>

</div>

<div id="output">안녕하세요. JARVIS 시스템이 준비되었습니다.</div>

<input id="command" placeholder="명령을 입력하세요">

<div>

<button onclick="runCommand()">명령 실행</button>

<button onclick="listen()">음성 명령</button>

<button onclick="speak('무엇을 도와드릴까요?')">음성 테스트</button>

</div>

<p><small>PERSONAL AI ASSISTANT SYSTEM</small></p>

<script>

const output=document.getElementById("output");

const statusText=document.getElementById("status");

function clock(){

 document.getElementById("clock").textContent=

 new Date().toLocaleString("ko-KR");

}

setInterval(clock,1000);

clock();

function speak(text){

 output.textContent=text;

 if(!("speechSynthesis" in window)) return;

 speechSynthesis.cancel();

 const msg=new SpeechSynthesisUtterance(text);

 msg.lang="ko-KR";

 msg.rate=1;

 speechSynthesis.speak(msg);

}

function runCommand(){

 const value=document.getElementById("command").value.trim();

 if(!value)return;

 const q=value.toLowerCase();

 if(q.includes("안녕")){

  speak("안녕하세요. 자비스입니다.");

 }

 else if(q.includes("시간")){

  speak("현재 시간은 "+new Date().toLocaleTimeString("ko-KR")+"입니다.");

 }

 else if(q.includes("날짜")){

  speak("오늘은 "+new Date().toLocaleDateString("ko-KR")+"입니다.");

 }

 else if(q.includes("검색")){

  speak("검색 페이지를 열겠습니다.");

  window.open("https://www.google.com/search?q="+

  encodeURIComponent(value.replace("검색","")),"_blank");

 }

 else if(q.includes("유튜브")){

  speak("유튜브를 열겠습니다.");

  window.open("https://www.youtube.com","_blank");

 }

 else if(q.includes("도움말")){

  speak("안녕, 시간, 날짜, 검색, 유튜브 명령을 사용할 수 있습니다.");

 }

 else{

  speak("아직 배우지 못한 명령입니다. 도움말을 확인해 주세요.");

 }

}

function listen(){

 const SpeechRecognition=

 window.SpeechRecognition||window.webkitSpeechRecognition;

 if(!SpeechRecognition){

  speak("이 브라우저에서는 음성 인식을 지원하지 않습니다.");

  return;

 }

 const recognition=new SpeechRecognition();

 recognition.lang="ko-KR";

 recognition.interimResults=false;

 statusText.textContent="LISTENING";

 recognition.onresult=(event)=>{

  document.getElementById("command").value=

  event.results[0][0].transcript;

  runCommand();

 };

 recognition.onerror=()=>{

  statusText.textContent="ONLINE";

  speak("음성 인식에 문제가 발생했습니다.");

 };

 recognition.onend=()=>statusText.textContent="ONLINE";

 recognition.start();

}

</script>

</body>

</html>
