document.addEventListener("turbo:load", function() {

  const stars = document.querySelectorAll('.rating-star');
  
  function updateStars(rating, color) {
    stars.forEach((star, index) => {
      star.style.color = index < rating ? color : 'grey';
    });
  }
  

  stars.forEach(star => {
    star.addEventListener('mouseover', function() {
      const index = Array.from(stars).indexOf(star);
      updateStars(index + 1, 'gold');
    });
    
    star.addEventListener('mouseout', function() {
      const selectedRating = document.querySelector('input[name="review[rating]"]:checked');
      const rating = selectedRating ? parseInt(selectedRating.value) : 0;
      updateStars(rating, 'gold');
    });
    
    star.addEventListener('click', function() {
      const index = Array.from(stars).indexOf(star);
      const rating = index + 1;
      document.querySelector(`input[name="review[rating]"][value="${rating}"]`).checked = true;
      updateStars(rating, 'gold');
    });
  });
  

  const selectedRating = document.querySelector('input[name="review[rating]"]:checked');
  const rating = selectedRating ? parseInt(selectedRating.value) : 0;
  updateStars(rating, 'gold');
});
