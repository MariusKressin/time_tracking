import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
		static targets = ['details', 'nonDetails', 'nonDetails2', 'container'];

		toggleDetails() {
				this.detailsTarget.classList.toggle('hidden');
				this.nonDetailsTarget.classList.toggle('hidden');
				this.nonDetails2Target.classList.toggle('hidden');
				this.containerTarget.classList.toggle('bg-slate-200');
				this.containerTarget.classList.toggle('bg-white');
		}
}
