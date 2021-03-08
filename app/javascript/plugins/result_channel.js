import consumer from "../channels/consumer";

const initResultCable = () => {
  const loadingAnimation = document.getElementById("loading-animation");
  if (loadingAnimation) {
    const id = loadingAnimation.dataset.resultId;

    consumer.subscriptions.create(
      { channel: "ResultChannel", id: id },
      {
        received(data) {
          console.log(data); // called when data is broadcast in the cable
        },
      }
    );
  }
};

export { initResultCable };
