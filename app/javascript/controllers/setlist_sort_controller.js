import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item", "number"]

  connect() {
    this.dragged = null
  }

  dragStart(event) {
    this.dragged = event.currentTarget
    event.dataTransfer.effectAllowed = "move"
    event.dataTransfer.setData("text/plain", event.currentTarget.dataset.setlistSongId)
    event.currentTarget.classList.add("opacity-60")
  }

  dragEnd(event) {
    event.currentTarget.classList.remove("opacity-60")
    this.dragged = null
  }

  dragOver(event) {
    event.preventDefault()
    event.currentTarget.classList.add("bg-slate-50")
  }

  dragLeave(event) {
    event.currentTarget.classList.remove("bg-slate-50")
  }

  drop(event) {
    event.preventDefault()
    const target = event.currentTarget
    target.classList.remove("bg-slate-50")
    if (!this.dragged || target === this.dragged) return

    const container = this.dragged.parentElement
    const items = Array.from(container.children)
    const draggedIndex = items.indexOf(this.dragged)
    const targetIndex = items.indexOf(target)
    if (draggedIndex < targetIndex) {
      container.insertBefore(this.dragged, target.nextSibling)
    } else {
      container.insertBefore(this.dragged, target)
    }

    this.persistOrder()
    this.updateNumbers()
  }

  persistOrder() {
    const order = this.itemTargets.map((item) => item.dataset.setlistSongId)
    const token = document.querySelector("meta[name='csrf-token']").content
    const setlistId = this.element.dataset.setlistId

    fetch(`/setlists/${setlistId}/setlist_songs/reorder`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": token,
        "Accept": "application/json"
      },
      body: JSON.stringify({ order })
    })
  }

  updateNumbers() {
    this.itemTargets.forEach((item, index) => {
      const number = item.querySelector("[data-setlist-sort-target='number']")
      if (number) {
        number.textContent = `${index + 1}.`
      }
    })
  }
}
