(()=>{

    const video = document.querySelector('.section0-video video');
    let section0_messageA = document.querySelector('.section0-video .a');
    let section0_messageB = document.querySelector('.section0-video .b');
    let section0_messageC = document.querySelector('.section0-video .c');

    let section0_messageImg = document.querySelector('.section0-video .d img');
    let section0_messageD = document.querySelector('.section0-video .d a');


    let msgDinterval;
    let msgAinterval;
    let videoInterval;
    let videoOpacity = 1;
    let msgDopacity = 0;
    let msgAopacity = 1;
    let msgBopacity = 0;
    let msgCopacity = 0;
    section0_messageB.style.opacity = 0;
    section0_messageC.style.opacity = 0;

    const changeVideoOpacity = function(){
        videoOpacity = videoOpacity - 0.1;
        if(videoOpacity >= 1) {
            videoOpacity = 1;
        } else if (videoOpacity < 0) {
            videoOpacity = 0;
        }
        video.style.opacity = videoOpacity;
    }

    const changeVideoMsgD = function(){
        msgDopacity = msgDopacity + 0.05;
        if(msgDopacity >= 1) {
            msgDopacity = 1;
        } else if (msgDopacity < 0) {
            msgDopacity = 0;
        }
        console.log(section0_messageImg.style.opacity);
        section0_messageImg.style.opacity = msgDopacity;
        section0_messageD.style.opacity = msgDopacity;
    }

    const changeVideoMsgA = function(){
       
        msgAopacity = msgAopacity - 0.1;
        if(msgAopacity >= 1) {
            msgAopacity = 1;
        } else if (msgAopacity < 0) {
            msgAopacity = 0;
        }
        section0_messageA.style.opacity = msgAopacity;
    }
    const changeVideoMsgBon = function(){
        msgBopacity = msgBopacity + 0.1;
        if(msgBopacity >= 1) {
            msgBopacity = 1;
        } else if (msgBopacity < 0) {
            msgBopacity = 0;
        }
        section0_messageB.style.opacity = msgBopacity;
    }
    const changeVideoMsgBoff = function(){
        msgBopacity = msgBopacity - 0.1;
        if(msgBopacity >= 1) {
            msgBopacity = 1;
        } else if (msgBopacity < 0) {
            msgBopacity = 0;
        }
        section0_messageB.style.opacity = msgBopacity;
    }
    const changeVideoMsgCon = function(){
        msgCopacity = msgCopacity + 0.1;
        if(msgCopacity >= 1) {
            msgCopacity = 1;
        } else if (msgCopacity < 0) {
            msgCopacity = 0;
        }
        section0_messageC.style.opacity = msgCopacity;
    }
    const changeVideoMsgCoff = function(){
        msgCopacity = msgCopacity - 0.1;
        if(msgCopacity >= 1) {
            msgCopacity = 1;
        } else if (msgCopacity < 0) {
            msgCopacity = 0;
        }
        section0_messageC.style.opacity = msgCopacity;
    }

    setTimeout(()=>{
        video.style.width = '100%'; // 너비 확대
        video.style.height = '100%'; // 높이 확대
    }, 800);

    setTimeout(()=>{
        videoInterval = setInterval(changeVideoOpacity, 150);
    }, 8000);

    setTimeout(()=>{
        msgDinterval = setInterval(changeVideoMsgD, 100);
    }, 8000);

    setTimeout(()=>{
        msgAinterval = setInterval(changeVideoMsgA, 10);
    }, 2500);

    setTimeout(()=>{
        msgBoninterval = setInterval(changeVideoMsgBon, 10);
    }, 2600);

    setTimeout(()=>{
        clearInterval(msgBoninterval);
        msgBoffinterval = setInterval(changeVideoMsgBoff, 10);
    }, 5200);

    setTimeout(()=>{
        clearInterval(msgBoffinterval);
        msgConinterval = setInterval(changeVideoMsgCon, 10);
    }, 5300);

    setTimeout(()=>{
        clearInterval(msgConinterval);
        msgCoffinterval = setInterval(changeVideoMsgCoff, 10);
    }, 8000);


    setTimeout(()=>{
        clearInterval(videoInterval);
        clearInterval(msgDinterval);
        clearInterval(msgAinterval);
    }, 10000);
    

})();
