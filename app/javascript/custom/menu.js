document.addEventListener("turbo:load", function() {
    let burger = document.querySelector('#burger');
    let list = document.querySelector('#list');

    burger.addEventListener("click", function() {
        if(burger.name === 'menu'){
            burger.name = "close";
            list.classList.remove('top-[-400px]');
            list.classList.add('top-[61px]');
            list.classList.add('opacity-100');
        } else {
            burger.name = "menu";
            list.classList.add('top-[-400px]');
            list.classList.remove('top-[61px]');
            list.classList.remove('opacity-100');
        }
    });
  });
