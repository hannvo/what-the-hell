import consumer from "./consumer";

const initMovieRecommendationCable = () => {
  const movieRecommendationSection = document.getElementById(
    "movie-recommendation-section"
  );
  if (movieRecommendationSection) {
    const id = movieRecommendationSection.dataset.cableId;
    consumer.subscriptions.create(
      { channel: "MovieRecommendationChannel", client: id },
      {
        received(data) {
          movieRecommendationSection.insertAdjacentHTML(
            "beforeend",
            data.response
          );
        },
      }
    );
  }
};

export { initMovieRecommendationCable };
