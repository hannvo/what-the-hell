import { Controller } from "stimulus";
import Typed from "typed.js";

export default class extends Controller {
  static targets = ["loadingScreen"];

  connect() {
    console.log("here");
    this.loadingScreenTarget.classList.remove("hidden");
    typeLoadingText();
  }
}

const initLoadingScreen = () => {
  const loadingScreen = document.getElementById("loading-screen");
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
