import confetti from "canvas-confetti";
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["name", "details", "btnCollapse", "txtCollapse"];

  connect() {
    confetti({
      particleCount: 100,
      spread: 70,
      origin: { y: 0.6 },
    });
  }


  toggleCollapse() {
    this.btnCollapseTarget.classList.toggle("active");
    const text = this.element.nextElementSibling;
    text.style.display === "block"
      ? (text.style.display = "none")
      : (text.style.display = "block");
  }
}
