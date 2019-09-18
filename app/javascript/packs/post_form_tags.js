document.addEventListener('turbolinks:load', function(){
    var post_form_tags_all = document.getElementById('post-form-tags-all');
    var post_form_tags_active = document.getElementById('post-form-tags-active');

    if (post_form_tags_all && post_form_tags_active){
        
        hidden_tags_ids = [];
        post_tags_active = document.getElementById('post_tags_active');
        
        hidden_tags_fill(hidden_tags_ids, post_form_tags_active, post_tags_active);

        post_form_tags_all.addEventListener('click', tags_add.bind(null, post_form_tags_active, post_tags_active, hidden_tags_ids));
        post_form_tags_active.addEventListener('click', tag_remove.bind(null, post_tags_active, hidden_tags_ids));
    }
});

var tags_add = function(tags_active, hidden_tags, hidden_tags_ids, event){
    event.preventDefault();
    if (event.target.tagName == 'SPAN' || event.target.tagName == 'span'){
        
        tag = event.target;

        new_tag = document.createElement('span');
        new_tag.id = tag.id;
        new_tag.innerText = tag.innerText;

        if (tags_active.children.length){
            add_tag_checker = true;
            for (var i = 0; i < tags_active.children.length; i++) {
                if (tags_active.children[i].id == tag.id){    
                    console.log('Такой тег уже существует');
                    add_tag_checker = false;
                }
            }
            if (add_tag_checker == true){
                hidden_tags_ids.push(new_tag.id);
                tags_active.append(new_tag);
            }
        }else{
            hidden_tags_ids.push(new_tag.id);
            tags_active.append(new_tag);
        }
        hidden_tags.value = hidden_tags_ids.join(',');
    }
}

var tag_remove = function(hidden_tags,  hidden_tags_ids, event){
    event.preventDefault();
    if (event.target.tagName == 'SPAN' || event.target.tagName == 'span'){
        tag = event.target;
        for (let i=0; i < hidden_tags_ids.length; i++){
            if (hidden_tags_ids[i] == tag.id){
                hidden_tags_ids.splice(i,1);
            }
        }
        hidden_tags.value = hidden_tags_ids.join(',');
        tag.remove();
    }
}

var hidden_tags_fill = function (hidden_tags_ids, tags_active, post_tags_active){
    if (tags_active.children.length){
        for (var i = 0; i < tags_active.children.length; i++) {
            hidden_tags_ids.push(tags_active.children[i].id)
        }
    }
    post_tags_active.value = hidden_tags_ids.join(',');
}
    

