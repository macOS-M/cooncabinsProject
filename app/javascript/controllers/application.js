import { Application } from "@hotwired/stimulus";
import "../rating";



const application = Application.start()

application.debug = false
window.Stimulus   = application



export { application }

document.addEventListener('turbo:load', function() {
  const swiper = new Swiper('.swiper', { 
    loop: false,
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
    scrollbar: {
      el: '.swiper-scrollbar',
    },
  });
});

document.addEventListener("turbo:load", () => {
  document.querySelectorAll('[data-confirm]').forEach((element) => {
    element.addEventListener('click', function(event) {
      const message = this.getAttribute('data-confirm');
      if (!confirm(message)) {
        event.preventDefault();
      }
    });
  });
});