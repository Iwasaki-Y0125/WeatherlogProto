import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["video"];

  connect() {
    this.setupVideoBackground();
  }

  setupVideoBackground() {
    if (this.hasVideoTarget) {
      this.videoTarget.play();
      this.handleResize();
    }
  }

  handleResize() {
    // レスポンシブ対応
    if (window.innerWidth <= 768) {
      this.videoTarget.pause();
    } else {
      this.videoTarget.play();
    }
  }
}
