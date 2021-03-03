import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["submit"];

  update() {
    this.submitTarget.click();
  }
}
