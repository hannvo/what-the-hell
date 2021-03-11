import consumer from "./consumer";

const initMovieCable = () => {
  const movieCardSection = document.getElementById("movie-card-section");
  if (movieCardSection) {
    const movieCards = document.getElementById("movie-cards");
    const id = movieCardSection.dataset.cableId;
    consumer.subscriptions.create(
      { channel: "MovieInfoChannel", client: id },
      {
        received(data) {
          movieCards.insertAdjacentHTML("beforeend", data.response);
        },
      }
    );
  }
};

export { initMovieCable };
