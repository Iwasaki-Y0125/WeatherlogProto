import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["checkbox", "submitButton"];
  static classes = ["enabled", "disabled"];

  connect() {
    this.updateButtonState();
  }

  toggleSubmit() {
    this.updateButtonState();
  }

  updateButtonState() {
    const isChecked = this.checkboxTarget.checked;

    if (isChecked) {
      // チェックされた時の処理
      this.submitButtonTarget.classList.remove(
        "pointer-events-none",
        "bg-gray-300",
      );
      this.submitButtonTarget.classList.add("bg-red-950", "hover:bg-red-800");
    } else {
      // チェックが外された時の処理
      this.submitButtonTarget.classList.remove(
        "bg-red-950",
        "hover:bg-red-800"
      );
      this.submitButtonTarget.classList.add(
        "pointer-events-none",
        "bg-gray-300"
      );
    }
  }

  // オプション: スクロール位置を監視
  trackScrollProgress(event) {
    const element = event.currentTarget;
    const scrollPercent =
      (element.scrollTop / (element.scrollHeight - element.clientHeight)) * 100;

    if (scrollPercent >= 95) {
      console.log("利用規約を最後まで読みました");
    }
  }
}
