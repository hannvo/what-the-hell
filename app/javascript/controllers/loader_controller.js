import { Controller } from "stimulus";
import Typed from "typed.js";
import consumer from "../channels/consumer";

export default class extends Controller {
  static targets = ["loadingScreen"];

  connect() {
    this.loadingScreenTarget.classList.remove("hidden");
    const loaderController = this;
    typeLoadingText();
    //initSubscription(cableId);
  }
}

const initSubscription = () => {
  cableId = parseInt(this.loadingScreenTarget.dataset.cableId);
  consumer.subscriptions.create(
    { channel: "FaceRecognitionChannel", client: cableId },
    {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
      },
    }
  );
};

const typeLoadingText = () => {
  const options = {
    strings: [
      "Calculating chin width",
      "Processing cheekbones",
      "Checking eye colour",
    ],
    typeSpeed: 60,
    startDelay: 3000,
    loop: true,
    showCursor: false,
    shuffle: true,
  };

  const typed = new Typed(".loading-subtitle", options);
};
