document.addEventListener('DOMContentLoaded', function() {
  setTimeout(function() {
    const flashMessage = document.querySelector('.alert'); 
    if (flashMessage) {
      flashMessage.style.display = 'none'; 
    }
  }, 3000); 
});