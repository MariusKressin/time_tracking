import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
		static targets = [ 'snackbar', 'content' ];

		open(content) {
				this.snackbarTarget.classList.remove('hidden');
				this.contentTarget.innerHTML = content || '';
				window.setTimeout(this.close.bind(this), 7000);
		}

		close() {
				this.snackbarTarget.classList.add('hidden');
				this.contentTarget.innerHTML = '';
		}
}
