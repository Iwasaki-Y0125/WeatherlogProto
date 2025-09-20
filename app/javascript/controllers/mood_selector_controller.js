import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["wrapper", "radio"];

  select(event) {
    // 全ての選択を解除
    this.wrapperTargets.forEach((wrapper) => {
      wrapper.classList.remove("selected");
    });

    // 全てのラジオボタンを未選択に
    this.radioTargets.forEach((radio) => {
      radio.checked = false;
    });

    // クリックされた要素を選択状態に
    const wrapper = event.currentTarget.querySelector(
      '[data-mood-selector-target="wrapper"]'
    );
    const radio = event.currentTarget.querySelector('input[type="radio"]');

    if (wrapper && radio) {
      wrapper.classList.add("selected");
      radio.checked = true;
    }
  }
}
