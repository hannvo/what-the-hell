import consumer from "./consumer";

const initCastCable = () => {
  const castLoading = document.getElementById("cast-loading");
  if (castLoading) {
    const id = castLoading.dataset.cableId;
    console.log(id);
    consumer.subscriptions.create(
      { channel: "FaceRecognitionChannel", client: id },
      {
        received(data) {
          document.body.innerHTML = data.response;
          initBiographyExpand();
        },
      }
    );
  }
};

export { initCastCable };
