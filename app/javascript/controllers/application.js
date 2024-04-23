import { Application } from "@hotwired/stimulus"
import Swal from 'sweetalert2';

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
window.Swal = Swal;

export { application }
