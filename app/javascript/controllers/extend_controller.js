import { Controller } from '@hotwired/stimulus';


export default class extends Controller {
	static targets = ['menu', 'chevron', 'chevContainer'];

	toggleMenu() {
		if (this.chevronTarget) this.chevronTarget.classList.toggle('rotate-180');
		this.menuTarget.classList.toggle('opacity-0');
		this.menuTarget.classList.toggle('-translate-y-2');
		if (this.menuTarget.classList.contains('invisible')) {
			return this.menuTarget.classList.remove('invisible');
		}
		window.setTimeout((() => { this.menuTarget.classList.toggle('invisible') }).bind(this), 200);
	}

        toggleSidebar(){
		if (this.chevronTarget) this.chevronTarget.classList.toggle('rotate-180');
		if (this.chevContainerTarget) {
			this.chevContainerTarget.classList.toggle('translate-x-72');
                        if (this.chevContainerTarget.classList.contains('translate-x-72')) {
                                this.chevContainerTarget.style.transform = '';
			} else {
				this.chevContainerTarget.style.transform = `translate(${this.menuTarget.getBoundingClientRect().width}px, 0)`;
                        }
                }
		this.menuTarget.classList.toggle('-translate-x-72');
        }

	closeMenu() {
		if (this.chevronTarget) this.chevronTarget.classList.remove('rotate-180');
		this.menuTarget.classList.add('opacity-0');
		this.menuTarget.classList.add('-translate-x-20');
		window.setTimeout((() => { this.menuTarget.classList.add('invisible') }).bind(this), 200);
	}

	closeSidebar() {
		if (this.chevronTarget) this.chevronTarget.classList.remove('rotate-180');
		if (this.chevContainerTarget) {
			this.chevContainerTarget.classList.add('translate-x-72');
			this.chevContainerTarget.style.transform = '';
                }
		this.menuTarget.classList.add('-translate-x-72');
	}
}
