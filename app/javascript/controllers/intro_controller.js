import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="intro"
export default class extends Controller {
  // 操作したいHTML要素を定義
  static targets = ["content", "stepIndicator"]

  // 初期化時に実行される
  connect() {
    console.log("Introコントローラーが接続されました！")
    this.currentStep = 1
    this.totalSteps = 3
  }

  // 次のステップへ進む
  nextStep() {
    if (this.currentStep < this.totalSteps) {
      this.currentStep++
      this.loadStep(this.currentStep)
    }
  }

  // 前のステップに戻る
  prevStep() {
    if (this.currentStep > 1) {
      this.currentStep--
      this.loadStep(this.currentStep)
    }
  }

    // ステップを読み込む（ここでAjaxを使う）
  loadStep(stepNumber) {
    // フェードアウト効果
    this.contentTarget.classList.add('opacity-50')

    // Ajax通信
    fetch(`/intro/step/${stepNumber}`, {
      headers: {
        'Accept': 'text/html',
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    .then(response => response.text())
    .then(html => {
      // 内容を更新
      this.contentTarget.innerHTML = html

      // フェードイン効果
      this.contentTarget.classList.remove('opacity-50')
      this.contentTarget.classList.add('transition-opacity', 'duration-300')

      // ステップインジケーターを更新
      this.updateStepIndicator()
    })
    .catch(error => {
      console.error('エラーが発生しました:', error)
      alert('読み込みに失敗しました')
    })
  }

  // ステップインジケーターを更新
  updateStepIndicator() {
    if (this.hasStepIndicatorTarget) {
      this.stepIndicatorTarget.textContent = `${this.currentStep} / ${this.totalSteps}`
    }
  }
}