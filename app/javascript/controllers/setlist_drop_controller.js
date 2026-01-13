import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  dragStart(event) {
    const songId = event.currentTarget.dataset.songId
    if (!songId) return

    event.dataTransfer.effectAllowed = "copy"
    event.dataTransfer.setData("text/plain", songId)
    event.currentTarget.classList.add("ring-2", "ring-slate-300")
  }

  dragEnd(event) {
    event.currentTarget.classList.remove("ring-2", "ring-slate-300")
  }

  dragOver(event) {
    event.preventDefault()
    event.currentTarget.classList.add("bg-slate-100")
  }

  dragLeave(event) {
    event.currentTarget.classList.remove("bg-slate-100")
  }

  async drop(event) {
    event.preventDefault()
    const target = event.currentTarget
    target.classList.remove("bg-slate-100")

    const songId = event.dataTransfer.getData("text/plain")
    const setlistId = target.dataset.setlistId
    if (!songId || !setlistId) return

    const token = document.querySelector("meta[name='csrf-token']").content
    const response = await fetch(`/setlists/${setlistId}/setlist_songs`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": token,
        "Accept": "application/json"
      },
      body: JSON.stringify({ song_id: songId })
    })

    if (!response.ok) {
      target.classList.add("text-red-600")
      setTimeout(() => target.classList.remove("text-red-600"), 1500)
      return
    }

    target.classList.add("text-emerald-700")
    setTimeout(() => target.classList.remove("text-emerald-700"), 1500)
  }
}
