
// находим контейнер постов и вешаем обработчик

document.addEventListener('turbolinks:load', function(){
    var posts_wrapper = document.getElementById('posts-wrapper');
    if (posts_wrapper){
        posts_wrapper.addEventListener('click', close_post_comment_form);
    }
});

// функция закрытия формы создания/редактирования комментария 
var close_post_comment_form = function(event){
    
    if (event.target.className == "post-comment-form-close"){
        post_comment_form_close = event.target;
        // если это форма для создания первоначального комментария, то...
        // находим форму создания первоначального комментария
        // вынимаем post id из action ...
        // находим пост 
        // проверяем нужный ли это нам пост
        // если нет, то получаем пост поиском среди DOM элементов
        // находим ссылку создания формы ввода нового комментария
        // устанавливаем ссылку на создание формы нового комментария
        if (post_comment_form_close.getAttribute('data-reply') == 'false'){
            post_comment_form = post_comment_form_close.parentElement.parentElement;
            post_comment_form_action = post_comment_form.getAttribute('action');
            post_id = post_comment_form_action.split('/')[2];
            post = post_comment_form.parentElement.parentElement.parentElement;
            check_post_attirubte = post.getAttribute('id');
            post_comment_create_link = post.querySelector('.post-comment-create-link');
            post_comment_create_link.setAttribute('href', `/posts/${post_id}/comments/new`);
            post_comment_create_link.setAttribute('data-remote', 'true');
            post.lastChild.remove();
        
        // Если это форма для создания комментария с родитилем тоесть reply ответ, то...
        // ищем нужный коммент
        // получаем нужные ссылки для редактирования/создания коммента
        // получаем ссылку на айди коммента
        // удаляем форму редактирования/создания коммента
        // прописываем нужные атрибуты для работы ссылок редактирования/создания коммента
        } else if (post_comment_form_close.getAttribute('data-reply') == 'true'){
            post_comment_form = post_comment_form_close.parentElement.parentElement;
            post_comment = post_comment_form.parentElement.parentElement.parentElement;
            post_comment_create_link = post_comment.querySelector('.post-comment-create-link');
            post_comment_edit_link = post_comment.querySelector('.post-comment-edit-link');
            post_comment_link = post_comment.querySelector('#comment_link').value;
            post_comment_create_wrapper = post_comment_form.parentElement.parentElement;
            post_comment_create_wrapper.remove();
            post_comment_create_link.setAttribute('href', `${post_comment_link}/reply`);
            post_comment_create_link.setAttribute('data-remote', 'true');
            post_comment_edit_link.setAttribute('href', `${post_comment_link}/edit`);
            post_comment_edit_link.setAttribute('data-remote', 'true');
        }
    }
}
