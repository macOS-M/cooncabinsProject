document.addEventListener('DOMContentLoaded', function() {
  const bookingForm = document.getElementById('booking-form');
  const startDateField = document.getElementById('start-date');
  const endDateField = document.getElementById('end-date');
  const totalPriceField = document.getElementById('total-price-input');
  const cabinPriceField = document.getElementById('cabin-price');
  const creditCardModal = new bootstrap.Modal(document.getElementById('creditCardModal'));

  function calculateTotalPrice() {
    const startDate = new Date(startDateField.value);
    const endDate = new Date(endDateField.value);
    const cabinPrice = parseFloat(cabinPriceField.value);

    if (startDate && endDate && cabinPrice) {
      const timeDiff = endDate - startDate;
      const dayDiff = Math.ceil(timeDiff / (1000 * 3600 * 24)); // Convert time difference to days
      const totalPrice = cabinPrice * dayDiff;
      return totalPrice.toFixed(2); 
    }
    return 0;
  }

  bookingForm.addEventListener('submit', function(event) {
    event.preventDefault();

    const totalPrice = calculateTotalPrice();
    totalPriceField.value = totalPrice;
    document.getElementById('total-price').value = `${totalPrice}`;

    creditCardModal.show(); 
  });

  // Update total price when dates are changed
  startDateField.addEventListener('change', function() {
    const totalPrice = calculateTotalPrice();
    totalPriceField.value = totalPrice;
  });

  endDateField.addEventListener('change', function() {
    const totalPrice = calculateTotalPrice();
    totalPriceField.value = totalPrice;
  });
});
