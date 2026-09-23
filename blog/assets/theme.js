// shared_preferences uses this key for the Flutter portfolio's theme.
(() => {
  const key = 'flutter.theme_mode';
  let theme = 'dark';
  try {
    const stored = JSON.parse(localStorage.getItem(key));
    if (stored === 'light' || stored === 'dark') theme = stored;
  } catch (_) { /* Storage can be unavailable; the toggle still works. */ }
  const apply = () => {
    document.documentElement.dataset.theme = theme;
    document.querySelector('meta[name="theme-color"]')?.setAttribute('content', theme === 'dark' ? '#080810' : '#F5F7FF');
  };
  apply();
  document.addEventListener('DOMContentLoaded', () => {
    const button = document.querySelector('.theme-toggle');
    const label = () => button.setAttribute('aria-label', `Switch to ${theme === 'dark' ? 'light' : 'dark'} mode`);
    button.hidden = false;
    label();
    button.addEventListener('click', () => {
      theme = theme === 'dark' ? 'light' : 'dark';
      apply();
      label();
      try { localStorage.setItem(key, JSON.stringify(theme)); } catch (_) { /* Optional persistence. */ }
    });
  });
})();
