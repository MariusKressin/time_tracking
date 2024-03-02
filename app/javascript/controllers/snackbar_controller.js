import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
		static targets = [ 'snackbar', 'content', 'notice', 'alert', 'color' ];
		timeoutQueue = [];

		connect() {
				if (this.alertTarget.innerHTML) {
						this.alert(this.alertTarget.innerHTML);
				} else if (this.noticeTarget.innerHTML) {
						this.open(this.noticeTarget.innerHTML);
				}
		}

		open(content) {
				this.snackbarTarget.classList.remove('hidden');
				this.snackbarTarget.classList.remove('translate-y-10');
				this.snackbarTarget.classList.remove('opacity-0');
				this.contentTarget.innerHTML = content || '';
				this.timeoutQueue.push(window.setTimeout(this.close.bind(this), 7000));
		}

		alert(content) {
				this.colorTarget.style.backgroundColor = '#AA4433';
				this.open(content);
		}

		close() {
				this.snackbarTarget.classList.add('translate-y-10');
				this.snackbarTarget.classList.add('opacity-0');
				window.setTimeout((() => {
						this.snackbarTarget.classList.add('hidden');
						this.contentTarget.innerHTML = '';
						this.colorTarget.style.backgroundColor = '';
				}).bind(this), 500)
				for (let q of this.timeoutQueue) {
						window.clearTimeout(q);
				}
		}
}
