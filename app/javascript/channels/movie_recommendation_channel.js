import consumer from "./consumer";
import { initSynopsisShow } from "../plugins/synopsis_show";

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
          initSynopsisShow();
        },
      }
    );
  }
};

export { initMovieRecommendationCable };
