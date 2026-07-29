// Show tooltip after 3 seconds
setTimeout(() => {
  const tt = document.getElementById('electrobot-tooltip');
  if (tt) {
    tt.style.display = 'block';
    setTimeout(() => { tt.style.display = 'none'; }, 5000);
  }
}, 3000);

function toggleElectroBot() {
  const win = document.getElementById('electrobot-window');
  const tt = document.getElementById('electrobot-tooltip');
  if (tt) tt.style.display = 'none'; // hide tooltip if open
  
  if (win.style.display === 'none' || win.style.display === '') {
    win.style.display = 'block';
  } else {
    win.style.display = 'none';
  }
}