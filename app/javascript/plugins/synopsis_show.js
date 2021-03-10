const show = (event) => {
  const synopsis = event.currentTarget.querySelector(".synopsis");
  synopsis.toggleAttribute("hidden");
};

const initSynopsisShow = () => {
  const posters = document.querySelectorAll(".reco-poster");
  if (posters) {
    posters.forEach((poster) => {
      poster.addEventListener("click", show);
    });
  }
};
export { initSynopsisShow };
