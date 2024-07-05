import { Controller } from '@hotwired/stimulus';


export default class extends Controller {
	static targets = ['menu', 'chevron', 'chevContainer', 'back'];

	toggleMenu() {
		if (this.chevronTarget) this.chevronTarget.classList.toggle('rotate-180');
		this.menuTarget.classList.toggle('opacity-0');
		this.menuTarget.classList.toggle('-translate-y-2');
		if (this.menuTarget.classList.contains('invisible')) {
			return this.menuTarget.classList.remove('invisible');
		}
		window.setTimeout((() => { this.menuTarget.classList.toggle('invisible') }).bind(this), 200);
	}

	toggleSidebar() {
		if (this.chevronTarget) this.chevronTarget.classList.toggle('rotate-180');
		if (this.chevContainerTarget) {
			this.chevContainerTarget.classList.toggle('translate-x-72');
			if (this.chevContainerTarget.classList.contains('translate-x-72')) {
				this.chevContainerTarget.style.transform = '';
			} else {
				this.chevContainerTarget.style.transform = `translate(${this.menuTarget.getBoundingClientRect().width}px, 0)`;
			}
		}
		this.backTarget.classList.toggle('opacity-0');
		this.menuTarget.classList.toggle('-translate-x-72');
		if (this.backTarget) {
			if (this.backTarget.classList.contains('hidden')) {
				this.backTarget.classList.remove('hidden');
			} else {
				window.setTimeout((() => { this.backTarget.classList.add('hidden') }).bind(this), 200);
            }
		}
	}

	closeMenu() {
		if (this.chevronTarget) this.chevronTarget.classList.remove('rotate-180');
		this.menuTarget.classList.add('opacity-0');
		this.menuTarget.classList.add('-translate-y-2');
		window.setTimeout((() => { this.menuTarget.classList.add('invisible') }).bind(this), 200);
	}

	closeSidebar() {
		if (this.chevronTarget) this.chevronTarget.classList.remove('rotate-180');
		if (this.chevContainerTarget) {
			this.chevContainerTarget.classList.add('translate-x-72');
			this.chevContainerTarget.style.transform = '';
		}
		if (this.backTarget) {
			this.backTarget.classList.add('opacity-0');
			window.setTimeout((() => { this.backTarget.classList.add('hidden') }).bind(this), 200);
		}
		this.menuTarget.classList.add('-translate-x-72');
	}
}
