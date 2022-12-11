document.addEventListener("turbo:load", function() {
    let navItems = document.querySelectorAll('.nav-item')
    let burger = document.querySelector('#burger');
    let list = document.querySelector('#list');
    let nav = document.querySelector('#nav')

    navItems.forEach((item) => {
        item.addEventListener("click", function() {
             burger.name = 'close'
             list.classList.add('hidden');
             nav.classList.remove('bg-lm-1');
             nav.classList.remove('dark:bg-dm-1');
        });
      })
});
