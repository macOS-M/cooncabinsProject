import { Application } from "@hotwired/stimulus";




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