import confetti from "canvas-confetti";
import { Controller } from "stimulus";
require("canvas-confetti");

export default class extends Controller {
  static targets = ["name", "details"];

  connect() {
    confetti({
      particleCount: 100,
      spread: 70,
      origin: { y: 0.6 },
    });
  }

  fixName() {
    if (window.scrollY > 580) {
      this.nameTarget.classList.add("fixed-name");
    } else {
      this.nameTarget.classList.remove("fixed-name");
    }
  }

  showDetails() {
    if (window.scrollY > 580) {
      this.detailsTarget.classList.remove("hidden");
    } else {
      this.detailsTarget.classList.add("hidden");
    }
  }
}
