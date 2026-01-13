import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "select"]

  connect() {
    this.updateAction()
  }

  updateAction() {
    const setlistId = this.selectTarget.value
    if (!setlistId) return

    const base = this.formTarget.dataset.baseUrl
    this.formTarget.action = base.replace("SETLIST_ID", setlistId)
  }
}
