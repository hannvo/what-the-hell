import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["name"];

  fixName() {
    if (window.scrollY > 650) {
      this.nameTarget.classList.add("fixed-name");
    } else {
      this.nameTarget.classList.remove("fixed-name");
    }
  }
}
