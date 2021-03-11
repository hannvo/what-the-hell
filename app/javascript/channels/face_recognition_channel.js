import consumer from "./consumer";
import { initBiographyExpand } from "../plugins/biography_expand";

const initFaceRecognitionCable = () => {
  const loadingScreen = document.getElementById("loading-screen");
  if (loadingScreen) {
    const id = loadingScreen.dataset.cableId;
    consumer.subscriptions.create(
      { channel: "FaceRecognitionChannel", client: id },
      {
        received(data) {
          console.log(data);
          document.body.innerHTML = data.response;
          initBiographyExpand();
        },
      }
    );
  }
};

export { initFaceRecognitionCable };
