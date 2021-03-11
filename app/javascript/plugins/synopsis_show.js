const show = (event) => {
  const posters = document.querySelectorAll(".reco-poster");
  posters.forEach((poster) => {poster.style.border = "1px solid #fff";});
  event.currentTarget.style.border = "1px solid #f4cb6d";
  const movieRecData = event.currentTarget.dataset;
  const title = `${movieRecData.recTitle} <span class="movie-rec-year">(${movieRecData.recYear.slice(0,4)})</span>`;
  document.getElementById("reco-movie-title").innerHTML = title ;
  document.getElementById("reco-movie-description").innerText = movieRecData.recDescription;
};

const initSynopsisShow = () => {
  const posters = document.querySelectorAll(".reco-poster");
  if (posters) {
    posters.forEach((poster) => {
      poster.addEventListener("click", show);
    });
    posters[0].click();
  }
};

export { initSynopsisShow };
