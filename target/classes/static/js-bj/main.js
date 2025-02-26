(() => {
    let roller = document.querySelector('.rolling-list');
    roller.id = 'roller1'; 

    let clone = roller.cloneNode(true);
    clone.id = 'roller2';
    document.querySelector('.wrap').appendChild(clone); 

    document.querySelector('#roller1').style.left = '0px';
    document.querySelector('#roller2').style.left = document.querySelector('.rolling-list ul').offsetWidth + 'px';

    roller.classList.add('original');
    clone.classList.add('clone');

    document.querySelectorAll('.rolling-list ul li').forEach(function(imageItem, index) {
        let imageWrap = imageItem.querySelector('.image-wrap');
        let image = imageWrap.querySelector('img');
        let originalTransitionDuration = window.getComputedStyle(image).transitionDuration;

        imageItem.addEventListener('mouseenter', function() {
            image.style.transitionDuration = '1s';
            image.style.animationPlayState = 'paused';
            image.style.transform = 'translateY(-100px)';
            roller.style.animationPlayState = 'paused'; // 이미지에 커서를 가져다 대면 애니메이션 멈춤
            if (index < document.querySelectorAll('.rolling-list ul li').length - 1) {
                document.querySelectorAll('.rolling-list ul li')[index + 1].querySelector('img').style.animationPlayState = 'paused'; // 다음 이미지의 애니메이션도 멈춤
            }
            clone.style.animationPlayState = 'paused'; // 복제된 롤링 이미지도 애니메이션 멈춤
            if (index < document.querySelectorAll('.rolling-list ul li').length - 1) {
                document.querySelectorAll('.rolling-list ul li')[index + 1].querySelector('.clone')
            }
        });
        imageItem.addEventListener('mouseleave', function() {
            image.style.transitionDuration = originalTransitionDuration;
            image.style.animationPlayState = 'running';
            image.style.transform = 'translateY(0)';
            roller.style.animationPlayState = 'running'; // 이미지에 커서를 벗어나면 애니메이션 다시 시작
            if (index < document.querySelectorAll('.rolling-list ul li').length - 1) {
                document.querySelectorAll('.rolling-list ul li')[index + 1].querySelector('img').style.animationPlayState = 'running'; // 다음 이미지의 애니메이션도 다시 시작
            }
            clone.style.animationPlayState = 'running'; // 복제된 롤링 이미지의 애니메이션도 다시 시작
            if (index < document.querySelectorAll('.rolling-list ul li').length - 1) {
                document.querySelectorAll('.rolling-list ul li')[index + 1]
            }
        });
    });

    



})();