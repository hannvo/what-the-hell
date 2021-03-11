import consumer from "./consumer";

const initCastCable = () => {
  const castSection = document.getElementById("cast-section");
  if (castSection) {
    const actorCards = document.getElementById("actor-cards");
    const id = castSection.dataset.cableId;
    consumer.subscriptions.create(
      { channel: "CastChannel", client: id },
      {
        received(data) {
          if (data.response["result"]) {
            window.location.replace(`/results/${data.response["actor"]["id"]}`);
          } else {
            actorCards.insertAdjacentHTML("beforeend", data.response);
          }
        },
      }
    );
  }
};

export { initCastCable };
