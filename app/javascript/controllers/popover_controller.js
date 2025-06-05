import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    document.querySelectorAll('.think_value').forEach(element => {
      new coreui.Popover(element, {
        trigger: "hover",
        html: false
      });
    });
  }
} 
