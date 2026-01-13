import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  copy(event) {
    const target = event.currentTarget.dataset.copyTarget
    const node = document.querySelector(target)
    if (!node) return

    const text = node.textContent.trim()
    navigator.clipboard.writeText(text)
  }
}
