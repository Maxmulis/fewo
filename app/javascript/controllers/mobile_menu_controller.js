import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    const menu = this.element.closest('nav').querySelector('[data-mobile-menu-target="menu"]')
    menu.classList.toggle("hidden")
  }
}
