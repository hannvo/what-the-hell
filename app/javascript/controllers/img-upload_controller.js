import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["submit", "loadingScreen"];

  update() {
    this.submitTarget.click();
    const loadingScreen = document.getElementById("loading-screen");
    loadingScreen.classList.remove("hidden");
  }
}
