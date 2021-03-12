import consumer from "./consumer";

const initCastCable = () => {
  const castSection = document.getElementById("cast-section");
  if (castSection) {
    const id = castSection.dataset.cableId;
    const actorCards = document.getElementById("actor-cards");
    const subtitleSection = document.getElementById("cast-subtitle-section");
    const loadingSpinner = document.getElementById("cast-loading");
    consumer.subscriptions.create(
      { channel: "CastChannel", client: id },
      {
        received(data) {
          if (data.response["result"]) {
            window.location.replace(`/results/${data.response["actor"]["id"]}`);
          } else if (data.common_actors) {
            subtitleSection.innerHTML = data.response;
          } else {
            loadingSpinner.style.display = "none";
            actorCards.insertAdjacentHTML("beforeend", data.response);
          }
        },
      }
    );
  }
};

export { initCastCable };
