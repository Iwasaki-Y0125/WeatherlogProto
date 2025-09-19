import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-symptoms"
export default class extends Controller {
  static targets = ["button", "hiddenField"]
  static values = { selectedSymptoms: Array }

  connect() {
    this.selectedSymptomsValue = []
  }

  toggleSymptom(event) {
    const button = event.currentTarget
    const symptom = button.dataset.symptom

    if (this.selectedSymptomsValue.includes(symptom)) {
      // 選択解除
      this.selectedSymptomsValue = this.selectedSymptomsValue.filter(s => s !== symptom)
      button.classList.remove('bg-red-950')
      button.classList.add('bg-gray-300')
    } else {
      // 選択
      this.selectedSymptomsValue = [...this.selectedSymptomsValue, symptom]
      button.classList.remove('bg-gray-300')
      button.classList.add('bg-red-950')
    }

    // 隠しフィールドに選択された症状を設定
    this.hiddenFieldTarget.value = this.selectedSymptomsValue.join(',')
  }
}
