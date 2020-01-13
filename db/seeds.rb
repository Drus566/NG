# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create users
User.create!(name:  "Примерный",
    email: "example@railstutorial.org",
    password:              "123456",
    password_confirmation: "123456")

User.create!(
    name: "Андрей",
    email: "ahdpeu566@mail.ru",
    password: "q1o0o0q1h6",
    password_confirmation: "q1o0o0q1h6"
)

User.create!(
    name: "Игорь",
    email: "igor@mail.ru",
    password: "123456",
    password_confirmation: "123456"
)

User.create!(
    name: "Павел",
    email: "pavel@mail.ru",
    password: "123456",
    password_confirmation: "123456"
)

# Create tags
Tag.create(name: "Игры")
Tag.create(name: "Просьбы")
Tag.create(name: "Такси")
Tag.create(name: "Магазин")
Tag.create(name: "Товары")
Tag.create(name: "Школа")
Tag.create(name: "Наука")

#Create posts
users = User.all
3.times do 
    users.each do |user|
        content = "Вене́ция (итал. Venezia [veˈnɛttsia] Информация о файле слушать, вен. Venesia) — город на северо-востоке Италии. Административный центр области Венеция и провинции Венеция. Образует коммуну, разделённую на 6 самоуправляемых районов. Покровителем города считается апостол Марк, евангелист, чьи мощи хранятся здесь же в Соборе Св. Марка, в связи с чем в город всегда приезжало много паломников-христиан со всего мира. "
        random_number_content = Random.rand(0..5)
        random_number_tag = Random.rand(1..10)
        if random_number_content == 0
            content = "Людови́ко Эйна́уди (итал. Ludovico Einaudi; род. 23 ноября 1955, Турин, Италия) — итальянский композитор и пианист. Обучался в Миланской консерватории имени Джузеппе Верди, а также у композитора Лучано Берио. Начал свою карьеру в качестве классического композитора, вскоре добавив в свои произведения другие стили, включая поп- и рок-музыку, этническую и народную музыку"
        elsif random_number_content == 1
            content = "Ита́лия (итал. Italia [iˈtaːlja], официальное название — Италья́нская Респу́блика (итал. Repubblica Italiana)) — государство в Южной Европе, в центре Средиземноморья. Входит в Евросоюз и НАТО с момента их создания, является третьей по величине экономикой еврозоны. "
        elsif random_number_content == 2
            content = "Швейца́рия (нем. die Schweiz, фр. Suisse, итал. Svizzera, романш. Svizra), официально — Швейца́рская Конфедера́ция (лат. Confoederatio Helvetica, нем. Schweizerische Eidgenossenschaft, фр. Confédération suisse, итал. Confederazione Svizzera, романш. Confederaziun svizra) — суверенное государство, расположенное на стыке западной, центральной и южной Европы."
        elsif random_number_content == 3
            content = "А́встрия (нем. Österreich, МФА (нем.): [ˈøːstɐˌʁaɪç] Информация о файле слушать), официальное название — Австри́йская Респу́блика (Republik Österreich) — государство в Центральной Европе. Население составляет 8,46 млн человек, территория — 83 879 км². Занимает 94-е место в мире по численности населения и 112-е по территории."
        elsif random_number_content == 4
            content = "Ио́сиф Виссарио́нович Ста́лин (настоящая фамилия — Джугашви́ли, груз. იოსებ ჯუღაშვილი; 6 декабря 1878 (по официальной версии — 9 декабря 1879), Гори, Тифлисская губерния, Российская империя — 5 марта 1953, Ближняя дача, Волынское, Кунцевский район, Московская область, РСФСР, СССР) — российский революционер, советский политический, государственный, военный и партийный деятель. С 21 января 1924 по 5 марта 1953 — руководитель Советского государства. Маршал Советского Союза (1943). Генералиссимус Советского Союза (1945)."
        end
        post = user.posts.create!(content: content)
        if (random_number_tag < 8)
            random_tag = Tag.find(random_number_tag)
            post.tags << random_tag
        end
    end
end

#Create comments
user = User.first
second_user = User.second
post = user.posts.first 

first_comment = post.comments.new(content: "Прием, я первый, проверка связи, прием...")
first_comment.user = user
first_comment.save 

reply_first_comment = post.comments.build(content: "Прием, я второй, как слышно, прием...", parent: first_comment, user: second_user)
reply_first_comment.save

#Create likes
first_user = User.first 
first_user_post = first_user.posts.first

like = first_user_post.likes.create(vote: true, user: first_user)

second_user = User.second
second_user_posts = second_user.posts

second_user_posts.each do |post|
    like = post.likes.create(vote: true, user: first_user)
end

third_user = User.third
third_user_posts = third_user.posts

third_user_posts.each do |post|
    like = post.likes.create(vote: false, user: first_user)
end

# Create catalogs
sport = Catalog.create(name: "Спортзалы")
medicine = Catalog.create(name: "Больницы")
auto = Catalog.create(name: "Автозапчасти")

# Create catalog_items
kvoter = CatalogItem.create(
    name: "Квотер",
    address: "п.Новосергиевка, ул. Конституции, д.33.",
    phone: "+7 (922) 817-57-47",
    shedule: "ежедневно: 10:00 - 18:00.",
    info: "www.kvoter-auto.ru"
)
lada = CatalogItem.create(
    name: "Новосергиевка-ЛАДА",
    address: "п.Новосергиевка, ул. Грейдерная, 35",
    phone: "8 (35339) 9-18-60",
    shedule: "ежедневно: 10:00 - 18:00.",
    info: "Точные координаты на карте: долгота — 53.635378, широта — 52.090057."
)
hospital = CatalogItem.create(
    name: "ГБУЗ Новосергиевская районная больница",
    address: "Новосергиевка, ул. Базарная, 10",
    phone: "+7 (353) 392-13-06",
    shedule: " понедельник-пятница с 9-00 до 17-00, суббота с 9-00 до 13-00",
    info: "Номер для вызова скорой по смс 8 919 843 85 52"
)
hospital = CatalogItem.create(
    name: "ГБУЗ Новосергиевская районная больница",
    address: "Новосергиевка, ул. Базарная, 10",
    phone: "+7 (353) 392-13-06",
    shedule: "понедельник-пятница с 9-00 до 17-00, суббота с 9-00 до 13-00",
    info: "Номер для вызова скорой по смс 8 919 843 85 52"
)
clinic = CatalogItem.create(
    name: "Белая роза",
    address: "п.Новосергиевка пр-т Калинина д 140",
    phone: "+7 (35339)2-90-03",
    shedule: "понедельник-пятница с 9-00 до 19-30, суббота с 9-00 до 14-00",
    info: "mail:belayaroza16@mail.ru, сайт www.belayaroza56.com"
)
dolphin = CatalogItem.create(
    name: "МАУДО ДЮСШ Новосергиевского района",
    address: "п.Новосергиевка ул Красноармейская",
    shedule: "Режим  работы: с 14.00 до 21.00",
    info: "Медицинская справка для посещения бассейна. К плаванию допускается группа не более 10 человек."
)
hospital.catalogs << medicine
clinic.catalogs << medicine
kvoter.catalogs << auto
lada.catalogs << auto
dolphin.catalogs << sport

#Create news ..mayby soon deprecated
user = User.first
user.articles.create(title: "Первая новость", body: "Это первая проверочная новость")
user.articles.create(title: "Вторая новость", body: "Это вторая проверочная новость")

puts "Database was successfull seeded"