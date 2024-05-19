import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
		static targets = ['alert', 'notice'];

		close_alert() {
				this.alertTarget.classList.add('hidden');
		}

		close_notice() {
				this.noticeTarget.classList.add('hidden');
		}
}
