{
    const nav = document.querySelector(".navbar");
    const btn = document.getElementById("downbtn");

    let lastY = window.scrollY;
    console.log(lastY);
    window.addEventListener("scroll", () => {
                if (window.scrollY > 0 && lastY < window.scrollY) {
            nav.classList.add("navbar_hidden");
        } else {
            nav.classList.remove("navbar_hidden");
        }
        lastY = window.scrollY;

        setTimeout(() => {
            if (lastY < 100) {
                btn.classList.remove("btnup");
            } else if (lastY > 400) {
                btn.classList.add("btnup");
            }

        }, 500);
    });
}
{
    const btn = document.getElementById("downbtn");
    btn.addEventListener("click", () => {
         if (btn.classList.contains("btnup")) {
            document.body.scrollTop = document.documentElement.scrollTop = 0;
            btn.classList.remove("btnup");
         } else {
            btn.classList.add("btnup");
            document.getElementById("about").scrollIntoView();
         }
    });
}
