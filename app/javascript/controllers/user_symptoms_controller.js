import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "hiddenContainer"]

  connect() {
    this.selectedSymptoms = new Set()
  }

  toggleSymptom(event) {
    const button = event.currentTarget
    const symptomId = button.dataset.symptomId
    const symptomName = button.dataset.symptomName

    if (this.selectedSymptoms.has(symptomId)) {
      // 選択解除
      this.selectedSymptoms.delete(symptomId)
      button.classList.remove("bg-red-900")
      button.classList.add("bg-gray-500")
      this.removeHiddenField(symptomId)
    } else {
      // 選択
      this.selectedSymptoms.add(symptomId)
      button.classList.remove("bg-gray-500")
      button.classList.add("bg-red-900")
      this.addHiddenField(symptomId)
    }
  }

  addHiddenField(symptomId) {
    const container = this.hiddenContainerTarget
    const index = container.children.length

    // user_symptoms_attributes用の隠しフィールドを作成
    const hiddenDiv = document.createElement('div')
    hiddenDiv.dataset.symptomId = symptomId
    hiddenDiv.innerHTML = `
      <input type="hidden" name="user[user_symptoms_attributes][${index}][symptom_id]" value="${symptomId}">
    `

    container.appendChild(hiddenDiv)
  }

  removeHiddenField(symptomId) {
    const container = this.hiddenContainerTarget
    const targetDiv = container.querySelector(`div[data-symptom-id="${symptomId}"]`)
    if (targetDiv) {
      container.removeChild(targetDiv)
    }
  }
}
