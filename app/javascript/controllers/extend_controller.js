import { Controller } from '@hotwired/stimulus';


export default class extends Controller {
		static targets = ['menu', 'chevron'];

		toggle() {
				if (this.chevronTarget) this.chevronTarget.classList.toggle('rotate-180');
				this.menuTarget.classList.toggle('opacity-0');
				this.menuTarget.classList.toggle('-translate-y-2');
				if (this.menuTarget.classList.contains('invisible')) {
						return this.menuTarget.classList.remove('invisible');
				}
				window.setTimeout((() => {this.menuTarget.classList.toggle('invisible')}).bind(this), 200);
		}

		close() {
				if (this.chevronTarget) this.chevronTarget.classList.remove('rotate-180');
				this.menuTarget.classList.add('opacity-0');
				this.menuTarget.classList.add('-translate-y-2');
				window.setTimeout((() => {this.menuTarget.classList.add('invisible')}).bind(this), 200);
		}
}
