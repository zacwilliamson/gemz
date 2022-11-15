document.addEventListener("turbo:load", function() {
    // let userTheme = localStorage.getItem('theme')
    let dark_mode_btn = document.querySelector('#dark-mode');
    // On page load or when changing themes, best to add inline in `head` to avoid FOUC
    if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark')
        dark_mode_btn.name = 'moon-outline';
    } else {
        document.documentElement.classList.remove('dark')
        dark_mode_btn.name = 'sunny-outline';
    }

    dark_mode_btn.addEventListener("click", function() {
        if(dark_mode_btn.name === 'sunny-outline'){
            dark_mode_btn.name = 'moon-outline';
            document.documentElement.classList.add('dark')
            localStorage.theme = 'dark'
        } else {
            dark_mode_btn.name = 'sunny-outline';
            document.documentElement.classList.remove('dark')
            localStorage.theme = 'light'
        }
    });
  });