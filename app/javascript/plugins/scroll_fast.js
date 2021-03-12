export { initScrollFast };

const scrollToBio = (event) => {
  const bio = document.getElementById('biography');
  const bioPosition = bio.scrollTop
  if (window.scrollY < 670) {
    bio.scrollIntoView();
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
