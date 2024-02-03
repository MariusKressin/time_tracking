import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
		static targets = [ 'radio1', 'radio2', 'option1', 'option2', 'hours', 'minutes', 'start', 'end' ];

		connect() {
				if (this.radio2Target.checked) this.option2();
				else this.option1();
				this.updateDiff();
		}

		option1() {
				this.option1Target.classList.remove('hidden');
				this.option2Target.classList.add('hidden');
		}

		option2() {
				this.option1Target.classList.add('hidden');
				this.option2Target.classList.remove('hidden');
		}

		updateTime() {
				this.endTarget.value = new Date().toLocaleString('sv').slice(0, -3);
				this.startTarget.value = new Date(new Date() - this.hoursTarget.value * 3600000 - this.minutesTarget.value * 60000).toLocaleString('sv').slice(0, -3);
		}

		updateDiff() {
				this.hoursTarget.value = Math.floor( (new Date(this.endTarget.value) - new Date(this.startTarget.value))/3600000 );
				this.minutesTarget.value = Math.floor( ((new Date(this.endTarget.value) - new Date(this.startTarget.value))/60000) % 60 );
		}
}
