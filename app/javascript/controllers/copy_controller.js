import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  copy(event) {
    const target = event.currentTarget.dataset.copyTarget
    const node = document.querySelector(target)
    if (!node) return

    const text = node.textContent.trim()
    navigator.clipboard.writeText(text).then(() => {
      this.flashSuccess(event.currentTarget)
    })
  }

  flashSuccess(button) {
    const icon = button.querySelector("[data-copy-icon]")
    if (!icon) return

    const original = icon.textContent
    icon.textContent = "✓"
    button.classList.add("text-emerald-600")

    setTimeout(() => {
      icon.textContent = original
      button.classList.remove("text-emerald-600")
    }, 1200)
  }
}
