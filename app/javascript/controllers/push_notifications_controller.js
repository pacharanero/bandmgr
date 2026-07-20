import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "status"]
  static values = { vapidPublicKey: String }

  connect() {
    this.refresh()
  }

  async enable() {
    if (!this.supported()) {
      this.setStatus("Browser notifications are not supported here.")
      return
    }

    const permission = await Notification.requestPermission()
    if (permission !== "granted") {
      this.setStatus("Notifications were not enabled.")
      return
    }

    const registration = await navigator.serviceWorker.register("/service-worker.js")
    const subscription = await registration.pushManager.getSubscription() || await registration.pushManager.subscribe({
      userVisibleOnly: true,
      applicationServerKey: this.urlBase64ToUint8Array(this.vapidPublicKeyValue)
    })

    const subscriptionData = subscription.toJSON()
    const response = await fetch("/push_subscriptions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({
        push_subscription: {
          endpoint: subscriptionData.endpoint,
          p256dh: subscriptionData.keys.p256dh,
          auth: subscriptionData.keys.auth
        }
      })
    })

    if (!response.ok) throw new Error("Could not save notification settings")

    this.setEnabled()
  }

  async refresh() {
    if (!this.vapidPublicKeyValue) {
      this.setStatus("Ask the self-hosting administrator to configure VAPID keys.")
      this.buttonTarget.disabled = true
      return
    }

    if (!this.supported() || Notification.permission !== "granted") return

    const registration = await navigator.serviceWorker.register("/service-worker.js")
    if (await registration.pushManager.getSubscription()) this.setEnabled()
  }

  supported() {
    return "serviceWorker" in navigator && "PushManager" in window && "Notification" in window
  }

  setEnabled() {
    this.buttonTarget.disabled = true
    this.buttonTarget.textContent = "Notifications enabled"
    this.setStatus("Replies will be delivered to this browser.")
  }

  setStatus(message) {
    this.statusTarget.textContent = message
  }

  urlBase64ToUint8Array(value) {
    const padding = "=".repeat((4 - value.length % 4) % 4)
    const base64 = (value + padding).replace(/-/g, "+").replace(/_/g, "/")
    const rawData = window.atob(base64)
    return Uint8Array.from(rawData, (character) => character.charCodeAt(0))
  }
}
