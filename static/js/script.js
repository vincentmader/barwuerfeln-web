// Scroll-reveal via IntersectionObserver
const observer = new IntersectionObserver(
    (entries) => entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); }),
    { threshold: 0.08 }
);
document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

// Drag-to-scroll on screenshot track
const track = document.querySelector('.screenshot-track');
if (track) {
    let isDown = false, startX, scrollLeft;

    track.addEventListener('mousedown', e => {
        isDown = true;
        startX = e.pageX - track.offsetLeft;
        scrollLeft = track.scrollLeft;
    });
    track.addEventListener('mouseleave', () => { isDown = false; });
    track.addEventListener('mouseup',    () => { isDown = false; });
    track.addEventListener('mousemove',  e => {
        if (!isDown) return;
        e.preventDefault();
        const x = e.pageX - track.offsetLeft;
        track.scrollLeft = scrollLeft - (x - startX) * 1.5;
    });
}
