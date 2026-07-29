// Sidebar toggle
  function toggleSidebar() {
    const sb = document.getElementById('ahSidebar');
    const ov = document.getElementById('sidebarOverlay');
    sb.classList.toggle('open');
    ov.classList.toggle('show');
  }

  // Auto-dismiss toasts after 4s
  document.querySelectorAll('.ah-toast').forEach(t => {
    setTimeout(() => { t.style.opacity = '0'; t.style.transform = 'translateX(50px)'; setTimeout(() => t.remove(), 300); }, 4000);
  });

  // Delete modal
  function confirmDelete(url, msg) {
    document.getElementById('deleteModalMsg').textContent = msg || 'Are you sure you want to delete this item?';
    document.getElementById('deleteForm').action = url;
    document.getElementById('deleteModal').classList.add('show');
  }
  function closeDeleteModal() {
    document.getElementById('deleteModal').classList.remove('show');
  }