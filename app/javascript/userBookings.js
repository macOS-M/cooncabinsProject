document.addEventListener("turbo:load", function() {
    const modalEl = document.getElementById('bookingModal');
    
   

    


    modalEl.addEventListener('show.bs.modal', function(event) {
      const button = event.relatedTarget; 
      if (!button) {
        console.error('No related target found for modal.');
        return;
      }
      
      const bookingId = button.getAttribute('data-id');
      
      if (bookingId) {
        fetch(`/bookings/${bookingId}.json`)
          .then(response => response.json())
          .then(booking => {
            document.getElementById('modalCabinName').textContent = booking.cabin.name;
            document.getElementById('modalStartDate').textContent = booking.start_date;
            document.getElementById('modalEndDate').textContent = booking.end_date;
            document.getElementById('modalTotalPrice').textContent = booking.total_price;
          })
          .catch(error => {
            console.error('Error fetching booking data:', error);
          });
      } else {
        console.error('Booking ID not found on the button.');
      }
    });
});
