document.addEventListener("turbo:load", function() {
    let dark_mode_btn = document.querySelector('#dark-mode');
    
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