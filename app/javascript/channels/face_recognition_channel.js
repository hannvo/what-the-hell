import consumer from "./consumer";

const initFaceRecognitionCable = () => {
  const loadingScreen = document.getElementById("loading-screen");
  if (loadingScreen) {
    const id = loadingScreen.dataset.cableId;
    console.log(id);
    consumer.subscriptions.create(
      { channel: "FaceRecognitionChannel", client: id },
      {
        received(data) {
          loadingScreen.innerHTML = data.response;
        },
      }
    );
  }
};

export { initFaceRecognitionCable };
