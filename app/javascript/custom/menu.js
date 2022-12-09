document.addEventListener("turbo:load", function() {
    let burger = document.querySelector('#burger');
    let list = document.querySelector('#list');
    let nav = document.querySelector('#nav')

    if(burger.name === 'menu'){
        list.classList.add('hidden');
        nav.classList.remove('bg-lm-1');
        nav.classList.remove('dark:bg-dm-1');
    }

     burger.addEventListener("click", function() {
        if(burger.name === 'menu'){
            burger.name = "close";
            list.classList.remove('hidden');
            nav.classList.add('bg-lm-1');
            nav.classList.add('dark:bg-dm-1');
            
        } else {
            burger.name = "menu";
            list.classList.add('hidden');
            nav.classList.remove('bg-lm-1');
            nav.classList.remove('dark:bg-dm-1');
        }
    });
});
