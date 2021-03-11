import consumer from "./consumer";

const initCastCable = () => {
  const castSection = document.getElementById("cast-section");
  if (castSection) {
    const actorCards = document.getElementById("actor-cards");
    //const castLoading = document.getElementById("cast-loading");
    const id = castSection.dataset.cableId;
    console.log(id);
    consumer.subscriptions.create(
      { channel: "CastChannel", client: id },
      {
        received(data) {
          actorCards.insertAdjacentHTML("beforeend", data.response);
        },
      }
    );
  }
};

export { initCastCable };
