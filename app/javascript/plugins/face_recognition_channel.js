import consumer from "../channels/consumer";

const initFaceRecognitionCable = () => {
  const loadingAnimation = document.getElementById("loading-animation");
  if (loadingAnimation) {
    const id = loadingAnimation.dataset.resultId;

    consumer.subscriptions.create(
      { channel: "FaceRecognitionChannel", client: id },
      {
        received(data) {
          console.log(data); // called when data is broadcast in the cable
        },
      }
    );
  }
};

export { initFaceRecognitionCable };
