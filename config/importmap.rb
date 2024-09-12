# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "swiper" # @11.1.9
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"

pin "@fullcalendar/core", to: "https://cdn.skypack.dev/@fullcalendar/core"
pin "@fullcalendar/daygrid", to: "https://cdn.skypack.dev/@fullcalendar/daygrid"
pin "@fullcalendar/interaction", to: "https://cdn.skypack.dev/@fullcalendar/interaction"
pin "axios", to: "https://cdn.skypack.dev/axios"

