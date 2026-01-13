import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  copy(event) {
    const target = event.currentTarget.dataset.copyTarget
    const node = document.querySelector(target)
    if (!node) return

    const text = node.textContent.trim()
    if (navigator.clipboard && window.isSecureContext) {
      navigator.clipboard.writeText(text).then(() => {
        this.flashSuccess(event.currentTarget)
      }).catch(() => {
        this.copyFallback(text, event.currentTarget)
      })
    } else {
      this.copyFallback(text, event.currentTarget)
    }
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

  copyFallback(text, button) {
    const textarea = document.createElement("textarea")
    textarea.value = text
    textarea.setAttribute("readonly", "")
    textarea.style.position = "absolute"
    textarea.style.left = "-9999px"
    document.body.appendChild(textarea)
    textarea.select()
    const ok = document.execCommand("copy")
    document.body.removeChild(textarea)
    if (ok) {
      this.flashSuccess(button)
    }
  }
}
