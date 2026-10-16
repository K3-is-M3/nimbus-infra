
document.addEventListener("DOMContentLoaded", () => {
  const toggle = document.querySelector(".nav-toggle");
  const links = document.querySelector("#nav-links");
  const year = document.querySelector("#current-year");

  if (year) {
    year.textContent = new Date().getFullYear();
  }

  if (toggle && links) {
    const closeMenu = () => {
      toggle.setAttribute("aria-expanded", "false");
      toggle.setAttribute("aria-label", "Open navigation");
      links.classList.remove("is-open");
    };

    toggle.addEventListener("click", () => {
      const opening =
        toggle.getAttribute("aria-expanded") !== "true";

      toggle.setAttribute("aria-expanded", String(opening));
      toggle.setAttribute(
        "aria-label",
        opening ? "Close navigation" : "Open navigation"
      );

      links.classList.toggle("is-open", opening);
    });

    links.querySelectorAll("a").forEach((link) => {
      link.addEventListener("click", closeMenu);
    });

    document.addEventListener("click", (event) => {
      if (
        !toggle.contains(event.target) &&
        !links.contains(event.target)
      ) {
        closeMenu();
      }
    });

    document.addEventListener("keydown", (event) => {
      if (event.key === "Escape") {
        closeMenu();
        toggle.focus();
      }
    });

    window.addEventListener("resize", () => {
      if (window.innerWidth > 760) {
        closeMenu();
      }
    });
  }
});
