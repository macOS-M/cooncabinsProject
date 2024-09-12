document.addEventListener("turbo:load", function() {
  const bookingForm = document.getElementById('booking-form');
  const showCreditCardModalBtn = document.getElementById('open-payment-modal');
  const confirmPaymentBtn = document.getElementById('confirm-payment');
  const totalPriceField = document.getElementById('total-price-input');
  const totalPriceModalField = document.getElementById('total-price');
  const creditCardModalElement = document.getElementById('creditCardModal');
  const creditCardNumberField = document.getElementById('credit-card-number');
  const expirationDateField = document.getElementById('expiration-date');
  const cvvField = document.getElementById('cvv');


  const creditCardModal = new bootstrap.Modal(creditCardModalElement);

  
  function validateCardDetails() {
    const cardNumber = creditCardNumberField.value.trim();
    const expirationDate = expirationDateField.value.trim();
    const cvv = cvvField.value.trim();

    if (!/^\d{16}$/.test(cardNumber)) {
      alert("Please enter a valid 16-digit credit card number.");
      return false;
    }

    if (!/^\d{2}\/\d{2}$/.test(expirationDate)) {
      alert("Please enter a valid expiration date in MM/YY format.");
      return false;
    }

    if (!/^\d{3}$/.test(cvv)) {
      alert("Please enter a valid 3-digit CVV.");
      return false;
    }

    const currentDate = new Date();
    const currentMonth = currentDate.getMonth() + 1;  
    const currentYear = currentDate.getFullYear() % 100;  

    const [inputMonth, inputYear] = expirationDate.split("/").map(num => parseInt(num));

    if (inputYear < currentYear || (inputYear === currentYear && inputMonth < currentMonth)) {
      alert("The credit card has expired.");
      return false;
    }

    return true;
  }

  showCreditCardModalBtn.addEventListener('click', function(event) {
    event.preventDefault();  

    const totalPrice = document.querySelector("#total-price").value;
    totalPriceField.value = totalPrice;  
    totalPriceModalField.value = totalPrice;  

    creditCardModal.show();  
  });

  confirmPaymentBtn.addEventListener('click', function(event) {
    event.preventDefault(); 

    if (validateCardDetails()) {
      bookingForm.submit(); 
    }
  });
});
