import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["postalCode", "status"]

  connect() {
    console.log("PostalCode controller connected")
  }

  validatePostalCode() {
    const postalCode = this.postalCodeTarget.value

    if (!postalCode) {
      this.clearStatus()
      return
    }

    if (postalCode.length !== 7 || !/^\d{7}$/.test(postalCode)) {
      this.showStatus("7桁の数字で入力してください", "error")
    } else {
      this.showStatus("郵便番号が正しい形式です", "success")
    }
  }

  showStatus(message, type) {
    if (this.hasStatusTarget) {
      this.statusTarget.textContent = message
      this.statusTarget.className = this.getStatusClass(type)
    }
  }

  clearStatus() {
    if (this.hasStatusTarget) {
      this.statusTarget.textContent = ""
    }
  }

  getStatusClass(type) {
    const baseClass = "text-xs mt-1 "
    switch(type) {
      case "success":
        return baseClass + "text-green-600"
      case "error":
        return baseClass + "text-red-600"
      default:
        return baseClass + "text-gray-600"
    }
  }
}
