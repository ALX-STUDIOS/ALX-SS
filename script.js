(function () {
    const uiContainer  = document.getElementById('uiContainer');
    const titleEl      = document.getElementById('uiTitle');
    const messageEl    = document.getElementById('uiMessage');
    const footerEl     = document.getElementById('uiFooter');
    const requesterEl  = document.getElementById('uiRequester');
    const enterButton  = document.getElementById('enterButton');
    const timerEl      = document.getElementById('timer');
    const timerCircle  = document.querySelector('.timer-circle');
    const notifSound   = document.getElementById('notificationSound');
    const alertSound   = document.getElementById('alertSound');
    const endVideo     = document.getElementById('endVideo');

    const CIRCUMFERENCE = 2 * Math.PI * 45;
    timerCircle.style.strokeDasharray = `${CIRCUMFERENCE} ${CIRCUMFERENCE}`;
    timerCircle.style.strokeDashoffset = CIRCUMFERENCE;

    let state = {
        active:       false,
        timeLeft:     0,
        duration:     30,
        alertAt:      5,
        alertFired:   false,
        playEndVideo: true,
        discord:      '',
        interval:     null,
    };

    function setProgress(percent) {
        const offset = CIRCUMFERENCE - (percent / 100) * CIRCUMFERENCE;
        timerCircle.style.strokeDashoffset = offset;
    }

    function safePlay(audio) {
        if (!audio) return;
        try { audio.currentTime = 0; } catch (_) {}
        const p = audio.play();
        if (p && typeof p.catch === 'function') p.catch(() => {});
    }

    function notifyClose() {
        fetch(`https://${GetParentResourceName()}/closeUI`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: '{}'
        }).catch(() => {});
    }

    function playEndVideo() {
        endVideo.classList.add('visible');
        endVideo.muted = false;
        endVideo.volume = 1.0;

        const p = endVideo.play();
        if (p && typeof p.catch === 'function') {
            p.catch(() => {
                endVideo.muted = true;
                endVideo.play().then(() => {
                    setTimeout(() => { endVideo.muted = false; }, 800);
                }).catch(() => {
                    notifyClose();
                });
            });
        }
    }

    function tick() {
        if (state.timeLeft > 0) {
            state.timeLeft--;
            timerEl.textContent = state.timeLeft;
            setProgress(((state.duration - state.timeLeft) / state.duration) * 100);

            if (state.alertAt > 0 && state.timeLeft === state.alertAt && !state.alertFired) {
                state.alertFired = true;
                safePlay(alertSound);
            }
        } else {
            clearInterval(state.interval);
            state.interval = null;
            if (state.active && state.playEndVideo) {
                playEndVideo();
            } else if (state.active) {
                notifyClose();
            }
        }
    }

    function applyConfig(cfg) {
        cfg = cfg || {};
        state.duration     = Number(cfg.duration) > 0 ? Number(cfg.duration) : 30;
        state.alertAt      = Number.isFinite(Number(cfg.alertAt)) ? Number(cfg.alertAt) : 5;
        state.playEndVideo = cfg.playEndVideo !== false;
        state.discord      = cfg.discord || '';

        titleEl.textContent     = cfg.title     || '';
        messageEl.textContent   = cfg.message   || '';
        footerEl.textContent    = cfg.footer    || '';
        enterButton.textContent = cfg.button    || 'Aceptar';
        requesterEl.textContent = cfg.requester || '';
    }

    function openUI(cfg) {
        applyConfig(cfg);

        state.timeLeft   = state.duration;
        state.alertFired = false;
        state.active     = true;

        timerEl.textContent = state.timeLeft;
        setProgress(0);

        uiContainer.classList.add('visible');
        endVideo.classList.remove('visible');
        endVideo.pause();
        try { endVideo.currentTime = 0; } catch (_) {}

        safePlay(notifSound);

        clearInterval(state.interval);
        state.interval = setInterval(tick, 1000);
    }

    function closeUI() {
        state.active = false;
        clearInterval(state.interval);
        state.interval = null;

        uiContainer.classList.remove('visible');
        endVideo.classList.remove('visible');
        endVideo.pause();
        try { endVideo.currentTime = 0; } catch (_) {}

        if (notifSound) { notifSound.pause(); try { notifSound.currentTime = 0; } catch (_) {} }
        if (alertSound) { alertSound.pause(); try { alertSound.currentTime = 0; } catch (_) {} }

        state.timeLeft = 0;
        timerEl.textContent = '0';
        setProgress(0);
    }

    endVideo.addEventListener('ended', () => {
        endVideo.classList.remove('visible');
        closeUI();
        notifyClose();
    });

    enterButton.addEventListener('click', () => {
        if (state.discord) {
            try { window.invokeNative('openUrl', state.discord); } catch (_) {}
        }
    });

    window.addEventListener('message', (event) => {
        const data = event.data || {};
        if (data.type === 'openUI') {
            openUI(data.config);
        } else if (data.type === 'closeUI') {
            closeUI();
        }
    });

    closeUI();
})();
