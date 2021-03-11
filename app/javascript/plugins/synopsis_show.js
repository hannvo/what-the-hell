const show = (event) => {
  const movieRecData = event.currentTarget.dataset;
  console.log(movieRecData);
const title = `${movieRecData.recTitle} <span class="movie-rec-year">(${movieRecData.recYear.slice(0,4)})</span>`;
  document.getElementById("reco-movie-title").innerHTML = title ;
  document.getElementById("reco-movie-description").innerText = movieRecData.recDescription;
};

const initSynopsisShow = () => {
  const posters = document.querySelectorAll(".reco-poster");
    console.log(posters);
  if (posters) {
    posters.forEach((poster) => {
      poster.addEventListener("click", show);
    });
  }
};

export { initSynopsisShow };
