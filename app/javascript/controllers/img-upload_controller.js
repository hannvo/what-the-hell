import { Controller } from "stimulus";
import Typed from "typed.js";

export default class extends Controller {
  static targets = ["submit"];

  update() {
    this.submitTarget.click();
  }
}
