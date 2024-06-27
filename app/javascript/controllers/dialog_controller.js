import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  confirm(event) {
    event.preventDefault();
    const currentTarget = event.currentTarget;

    Swal.fire({
      title: 'Are you sure?',
      text: 'This action cannot be undone.',
      icon: 'warning',
      showCancelButton: true,
      cancelButtonText: 'No',
      confirmButtonText: 'Yes',
    })
      .then(res => !res.isConfirmed || currentTarget.form.submit());
  }

  topic_confirm(event) {
    event.preventDefault();
    const currentTarget = event.currentTarget;

    Swal.fire({
      title: 'Are you sure?',
      text: 'This topic and all hours associated with it will be permanently deleted.',
      icon: 'warning',
      showCancelButton: true,
      cancelButtonText: 'No',
      confirmButtonText: 'Yes',
    })
      .then(res => !res.isConfirmed || currentTarget.form.submit());
  }

  user_confirm(event) {
    event.preventDefault();
    const currentTarget = event.currentTarget;

    Swal.fire({
      title: 'Are you sure?',
      text: 'This user and all hours associated with it will be permanently deleted.',
      icon: 'warning',
      showCancelButton: true,
      cancelButtonText: 'No',
      confirmButtonText: 'Yes',
    })
      .then(res => !res.isConfirmed || currentTarget.form.submit());
  }
}
