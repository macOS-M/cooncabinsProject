import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";
import interactionPlugin from "@fullcalendar/interaction";
import axios from "https://cdn.skypack.dev/axios";

document.addEventListener("turbo:load", function() {
  const calendarEl = document.getElementById("calendar");
  const cabinSelect = document.getElementById("cabin_select");
  let selectedEvent = null; 

  if (calendarEl) {  
    let calendar = new Calendar(calendarEl, {
      plugins: [dayGridPlugin, interactionPlugin],
      initialView: "dayGridMonth",
      events: function(fetchInfo, successCallback, failureCallback) {
        const cabinId = cabinSelect ? cabinSelect.value : null;
        const url = cabinId ? `/bookings/calendar_events?cabin_id=${cabinId}` : "/bookings/calendar_events";

        axios.get(url)
          .then(response => {
            successCallback(response.data);
          })
          .catch(error => {
            console.error("Error fetching events:", error);
            failureCallback(error);
          });
      },
      eventClick: function(info) {
        info.jsEvent.preventDefault();
        selectedEvent = info.event; 

        
        const details = `User: ${selectedEvent.title}<br>Start: ${selectedEvent.start}<br>End: ${selectedEvent.end}`;
        document.getElementById('eventDetails').innerHTML = details;

        const eventModal = new bootstrap.Modal(document.getElementById('eventModal'), {});
        eventModal.show();
      }
    });

    calendar.render();

    if (cabinSelect) {
      cabinSelect.addEventListener("change", function() {
        calendar.refetchEvents();
      });
    }

    const cancelBookingButton = document.getElementById('cancelBookingButton');
    cancelBookingButton.addEventListener('click', function() {
      if (selectedEvent) {
        const confirmed = confirm(`Are you sure you want to cancel this booking for ${selectedEvent.title}?`);
        if (confirmed) {
          axios.delete(`/bookings/${selectedEvent.id}`, {
  headers: {
    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  }
})
.then(response => {
  if (response.status === 200) {
    selectedEvent.remove();  
    alert('Booking cancelled successfully.');
  }
})
.catch(error => {
  console.error("Error cancelling booking:", error);
  alert('Failed to cancel the booking.');
});

          
          const eventModal = bootstrap.Modal.getInstance(document.getElementById('eventModal'));
          eventModal.hide();
        }
      }
    });
  }
});
