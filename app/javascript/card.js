document.addEventListener('DOMContentLoaded', function() {
  const bookingForm = document.getElementById('booking-form');
  const creditCardModal = new bootstrap.Modal(document.getElementById('creditCardModal'));
  const creditCardForm = document.getElementById('credit-card-form');
  const confirmPaymentButton = document.getElementById('confirm-payment');

  bookingForm.addEventListener('submit', function(event) {
    event.preventDefault(); 
    creditCardModal.show();
  });

  confirmPaymentButton.addEventListener('click', function() {
    const cardNumber = document.getElementById('credit-card-number').value;
    const expirationDate = document.getElementById('expiration-date').value;
    const cvv = document.getElementById('cvv').value;

    if (validateCreditCard(cardNumber, expirationDate, cvv)) {
      bookingForm.submit();
    } else {
      alert('Invalid credit card details.');
    }
  });

  function validateCreditCard(number, expirationDate, cvv) {
    const cardNumber = number.replace(/\s+/g, ''); 
    const [expMonth, expYear] = expirationDate.split('/').map(Number);


    if (!isValidCardNumber(cardNumber)) {
      return false;
    }

    if (!isValidExpirationDate(expMonth, expYear)) {
      return false;
    }

    if (!isValidCVV(cvv)) {
      return false;
    }
  
    return true;
  }

  function isValidCardNumber(number) {
    return /^\d+$/.test(number) && number.length >= 13 && number.length <= 19;
  }
  
  function isValidExpirationDate(month, year) {
    if (isNaN(month) || isNaN(year)) {
      return false;
    }
  
    const currentDate = new Date();
    const currentMonth = currentDate.getMonth() + 1;
    const currentYear = currentDate.getFullYear() % 100;
  
    if (year < currentYear || (year === currentYear && month < currentMonth)) {
      return false;
    }
  
    if (month < 1 || month > 12) {
      return false;
    }
  
    return true;
  }
  
  function isValidCVV(cvv) {
    return /^\d+$/.test(cvv) && cvv.length >= 3 && cvv.length <= 4;
  }
  
});
