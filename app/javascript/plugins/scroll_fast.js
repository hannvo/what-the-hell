export { initScrollFast };

const scrollToBio = (event) => {
  if (window.scrollY < 670) {
    window.scrollTo({ top: 679, left: 0, behavior: "smooth" });
  } else {
    window.removeEventListener("scroll", scrollToBio);
  }

}

const initScrollFast = () => {
  const bio = document.getElementById('biography');
  if (bio) {
    window.addEventListener("scroll", scrollToBio);
  }
}
