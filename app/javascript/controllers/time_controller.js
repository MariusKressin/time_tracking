import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
		static targets = ['mhand', 'hhand', 'clockin', 'clockout', 'submit'];
		active = false;
		interval = null;
		listener = null;
		minutes = 0;

		connect() {
				if (localStorage.getItem('beginning')) {
						const now = new Date();
						const begin = new Date(localStorage.getItem('beginning'));
						const diff = now - begin;
						if (diff > 61200000) return;
						this.minutes = Math.floor(diff / 6000) / 10;
						this.clockoutTarget.href = `/hours/new?minutes=${Math.round(this.minutes)}`;
						this.activate();
				}
		}

		activate(e) {
				if (!this.minutes) this.save();
				this.clockinTarget.classList.toggle('hidden');
				this.clockoutTarget.classList.toggle('hidden');
				this.active = !this.active;
				if (this.active) {
						this.listener = window.addEventListener('beforeunload', this.alert);
						this.startLogging();
				} else {
						this.endLogging(e);
						window.removeEventListener('beforeunload', this.listener);
				}
		}

		startLogging() {
				this.interval = window.setInterval((() => {
						this.minutes += 0.1;
						this.clockoutTarget.href = `/hours/new?minutes=${Math.round(this.minutes)}`;
						if (this.minutes < 1) this.clockoutTarget.href = '/hours/new';
				}).bind(this), 6000);
				this.mhandTarget.classList.add('animate-spin');
				this.hhandTarget.classList.add('animate-slowspin');
		}

		endLogging(e) {
				if (this.minutes < 1) e.preventDefault();
				if (!this.active) localStorage.removeItem('beginning');
				window.clearInterval(this.interval);
				this.interval = null;
				this.mhandTarget.classList.remove('animate-spin');
				this.hhandTarget.classList.remove('animate-slowspin');
		}

		save() {
				localStorage.setItem('beginning', new Date());
		}

		disconnect() {
				if (!this.active) localStorage.removeItem('beginning');
		}
}
