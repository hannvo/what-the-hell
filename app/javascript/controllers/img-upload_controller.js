import { Controller } from "stimulus";
import Typed from "typed.js";

export default class extends Controller {
  static targets = ["submit", "loadingScreen"];

  update() {
    this.submitTarget.click();
    initLoadingScreen();
  }
}

const initLoadingScreen = () => {
  const loadingScreen = document.getElementById("loading-screen");
  loadingScreen.classList.remove("hidden");
  typeLoadingText();
};

const typeLoadingText = () => {
  const options = {
    strings: [
      "Calculating facial symmetry...",
      "Processing cheekbone geometry...",
      "De-interlacing nosebridge parallax...",
    ],
    typeSpeed: 60,
    startDelay: 15,
    loop: true,
    showCursor: false,
    shuffle: true,
  };

  const typed = new Typed(".loading-subtitle", options);
};
