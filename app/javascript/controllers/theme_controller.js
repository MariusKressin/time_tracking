import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
		static targets = [ 'redPrimary', 'orangePrimary', 'tealPrimary', 'bluePrimary', 'indigoPrimary', 'slatePrimary',
											 'redAccent', 'orangeAccent', 'tealAccent', 'blueAccent', 'indigoAccent', 'slateAccent',
											 'ri', 'ro', 'tb', 'ib', 'bs', 'si',
											 'primaryForm', 'accentForm' ];

		update() {
				if (this.riTarget.checked) {
						this.clearOptions();
						this.redPrimaryTarget.checked = true;
						this.indigoAccentTarget.checked = true;
				} else if (this.roTarget.checked) {
						this.clearOptions();
						this.redPrimaryTarget.checked = true;
						this.orangeAccentTarget.checked = true;
				} else if (this.tbTarget.checked) {
						this.clearOptions();
						this.tealPrimaryTarget.checked = true;
						this.blueAccentTarget.checked = true;
				} else if (this.ibTarget.checked) {
						this.clearOptions();
						this.indigoPrimaryTarget.checked = true;
						this.blueAccentTarget.checked = true;
				} else if (this.bsTarget.checked) {
						this.clearOptions();
						this.bluePrimaryTarget.checked = true;
						this.slateAccentTarget.checked = true;
				} else if (this.siTarget.checked) {
						this.clearOptions();
						this.slatePrimaryTarget.checked = true;
						this.indigoAccentTarget.checked = true;
				}
		}

		clearOptions() {
				this.redPrimaryTarget.checked = false;
				this.orangePrimaryTarget.checked = false;
				this.tealPrimaryTarget.checked = false;
				this.bluePrimaryTarget.checked = false;
				this.indigoPrimaryTarget.checked = false;
				this.slatePrimaryTarget.checked = false;
				this.redAccentTarget.checked = false;
				this.orangeAccentTarget.checked = false;
				this.tealAccentTarget.checked = false;
				this.blueAccentTarget.checked = false;
				this.indigoAccentTarget.checked = false;
				this.slateAccentTarget.checked = false;
		}

		async submit() {
				await fetch(this.primaryFormTarget.action, {
						method: this.primaryFormTarget.method,
						headers: this.primaryFormTarget.headers,
						body: new FormData(this.primaryFormTarget),
				});
				this.accentFormTarget.submit();
		}
}
