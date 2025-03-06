# Nettoyage des tables dans le bon ordre pour éviter les erreurs de dépendance
Review.destroy_all if defined?(Review)
puts "Table reviews nettoyée !"
Booking.destroy_all if defined?(Booking)
puts "Table bookings nettoyée !"
Mercenary.destroy_all
puts "Table mercenaries nettoyée !"
User.destroy_all
puts "Table users nettoyée !"

# Création des 3 utilisateurs (compatible avec Devise)
users = [
  User.new(email: "john.doe@example.com", first_name: "John", last_name: "Doe", nickname: "Johnny", password: "password123"),
  User.new(email: "jane.smith@example.com", first_name: "Jane", last_name: "Smith", nickname: "Janie", password: "password123"),
  User.new(email: "mike.wilson@example.com", first_name: "Mike", last_name: "Wilson", nickname: "Mikey", password: "password123")
]

users.each_with_index do |user, index|
  begin
    user.save!
    puts "Utilisateur #{index + 1} (#{user.email}) créé avec succès !"
  rescue StandardError => e
    puts "Erreur lors de la création de l'utilisateur #{index + 1} : #{e.message}"
  end
end
puts "#{User.count} utilisateurs ajoutés à la base de données !"

# Création des 36 mercenaires avec leurs URLs mises à jour
mercenaries = [
  # User 1 (John Doe) - 12 mercenaires
  { name: "John Rambo", specialty: "Survie et guérilla", bio: "Expert en survie dans les pires conditions.", price_per_day: 1200, address: "Chamonix, France", user_id: users[0].id, photo_url: "https://img.rts.ch/articles/2019/image/jqdogq-25970995.image?w=1280&h=720" },
  { name: "Wonder Woman", specialty: "Combat mythique", bio: "Guerrière légendaire à la force surhumaine.", price_per_day: 2000, address: "Nice, France", user_id: users[0].id, photo_url: "https://www.radiofrance.fr/s3/cruiser-production/2021/10/d34e0294-c579-48f5-a6c9-1d7af3deb6c0/1200x680_1200x680-wonder-woman-1984.jpg" },
  { name: "Chuck Norris", specialty: "Combat ultime", bio: "Légende invincible du combat rapproché.", price_per_day: 1500, address: "Biarritz, France", user_id: users[0].id, photo_url: "https://media.gettyimages.com/id/525603356/fr/photo/chuck-norris-poses-with-two-uzis-his-sleeveless-denim-shirt-unbuttoned-to-his-waist-publicity.jpg?s=612x612&w=gi&k=20&c=pNPFch6zbQgmYqAiIj6g8dwui09ItFllocQxWDWo5AM=" },
  { name: "L'agence tous risques", specialty: "Improvisation tactique", bio: "Groupe polyvalent pour missions extrêmes.", price_per_day: 3000, address: "Paris, France", user_id: users[0].id, photo_url: "https://images2.minutemediacdn.com/image/upload/c_fill,w_720,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/a-team-1-4bac746d6d38f0aa6ce70a97629a3918.jpg" },
  { name: "James Bond", specialty: "Espionnage et gadgets", bio: "Agent secret avec gadgets dernier cri.", price_per_day: 1000, address: "Londres, Royaume-Uni", user_id: users[0].id, photo_url: "https://www.ecranlarge.com/content/uploads/2025/02/james-bond-daniel-craig-reagit-a-la-main-mise-damazon-sur-la-saga-1260x708.jpg" },
  { name: "Natasha Romanoff", specialty: "Infiltration et combat", bio: "Espionne agile et mortelle.", price_per_day: 1050, address: "Strasbourg, France", user_id: users[0].id, photo_url: "https://media.licdn.com/dms/image/v2/C4E12AQH5xZoisRSXwQ/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1555420431630?e=2147483647&v=beta&t=NOfXkQDXyOa-_FmzH2sRgPNxU5PMO0l76My_cQQx7u0" },
  { name: "Motoko Kusanagi", specialty: "Cybercombat", bio: "Cyborg experte en piratage et combat.", price_per_day: 1250, address: "Genève, Suisse", user_id: users[0].id, photo_url: "https://cdn-www.konbini.com/files/2024/05/Feat-ghost-inf-the-shell.jpg?width=3840&quality=75&format=webp" },
  { name: "Blade", specialty: "Combat rapproché", bio: "Chasseur de vampires impitoyable.", price_per_day: 950, address: "Lyon, France", user_id: users[0].id, photo_url: "https://www.filmsfantastiques.com/wp-content/uploads/2020/09/Blade-photo-2-1024x590.jpg" },
  { name: "John Spartan", specialty: "Combat ultime", bio: "Soldat d’élite des années 90.", price_per_day: 1300, address: "Marseille, France", user_id: users[0].id, photo_url: "https://static1.srcdn.com/wordpress/wp-content/uploads/2019/06/Sylvester-Stallone-as-John-Spartan-in-Demolition-Man.jpg" },
  { name: "Claire Redfield", specialty: "Survie et guérilla", bio: "Survivante face aux zombies.", price_per_day: 900, address: "Bruxelles, Belgique", user_id: users[0].id, photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTNKy2yUPi8mAnGjrE7ytUp6FV6tL9bxf6nA&s" },
  { name: "Tony Stark", specialty: "Technologie et combat", bio: "Génie milliardaire avec une armure high-tech.", price_per_day: 2500, address: "Zurich, Suisse", user_id: users[0].id, photo_url: "https://sm.ign.com/t/ign_fr/news/l/live-like-/live-like-tony-stark-by-renting-his-avengers-endgame-cabin_84ja.1200.jpg" },
  { name: "Jason Bourne", specialty: "Infiltration et combat", bio: "Agent amnésique aux réflexes mortels.", price_per_day: 1100, address: "Berlin, Allemagne", user_id: users[0].id, photo_url: "https://static1.srcdn.com/wordpress/wp-content/uploads/2023/04/jason-bourne-in-the-bourne-identity.png" },

  # User 2 (Jane Smith) - 12 mercenaires
  { name: "OSS 117", specialty: "Espionnage et humour", bio: "Espion maladroit mais efficace.", price_per_day: 900, address: "Paris, France", user_id: users[1].id, photo_url: "https://d32gva8s8jjsl4.cloudfront.net/img/p/1/1/3/5/9/11359-cover_large.jpg" },
  { name: "Ellen Ripley", specialty: "Combat extraterrestre", bio: "Chasseuse d’aliens sans peur.", price_per_day: 850, address: "Lille, France", user_id: users[1].id, photo_url: "https://www.fulguropop.com/wp-content/uploads/2020/03/aliens-1-1200x649.jpg" },
  { name: "MacGyver", specialty: "Bricolage et explosifs", bio: "Roi de l’improvisation avec des outils.", price_per_day: 650, address: "Grenoble, France", user_id: users[1].id, photo_url: "https://i0.wp.com/scriiipt.com/wp-content/uploads/2024/09/macgyver.png?fit=1200%2C675&ssl=1" },
  { name: "Agent 47", specialty: "Assassinat furtif", bio: "Tueur silencieux et précis.", price_per_day: 1300, address: "Luxembourg, Luxembourg", user_id: users[1].id, photo_url: "https://www.rostercon.com/wp-content/uploads/2014/01/hitman-agent-47.jpg" },
  { name: "Vegeta", specialty: "Puissance Saiyan", bio: "Guerrier surpuissant au tempérament explosif.", price_per_day: 2500, address: "Turin, Italie", user_id: users[1].id, photo_url: "https://pm1.aminoapps.com/6778/5496aa3e2a85852a118cf6bbccc9192938710deav2_00.jpg" },
  { name: "The Punisher", specialty: "Vengeance brutale", bio: "Justicier sans pitié contre le crime.", price_per_day: 1100, address: "Barcelone, Espagne", user_id: users[1].id, photo_url: "https://ew.com/thmb/gb8what92jHBR5tInysOU1QShjY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Jon-Bernthal-Daredevil-Born-Again-Set-1-040324-068b3bb6a6204864a21655e7c6a63fda.jpg" },
  { name: "The Expendables", specialty: "Destruction massive", bio: "Équipe pour missions explosives.", price_per_day: 3500, address: "Bordeaux, France", user_id: users[1].id, photo_url: "https://image.jeuxvideo.com/medias-md/168624/1686238626-7233-card.jpg" },
  { name: "Lara Croft", specialty: "Exploration et combat", bio: "Aventurière chasseuse de trésors.", price_per_day: 975, address: "Lisbonne, Portugal", user_id: users[1].id, photo_url: "https://sm.ign.com/ign_fr/news/t/tomb-raide/tomb-raider-dev-reveals-lara-crofts-official-redesign_kxdj.jpg" },
  { name: "Dom Toretto", specialty: "Conduite et chaos", bio: "Pilote expert vivant pour la famille.", price_per_day: 1200, address: "Milan, Italie", user_id: users[1].id, photo_url: "https://www.booska-p.com/wp-content/uploads/2021/09/fast-and-furious-une-serie-sur-dom-toretto-sans-vin-diesel-649.jpg" },
  { name: "Tony Montana", specialty: "Drogue et violence", bio: "Parrain de la mafia cubaine à Montpellier.", price_per_day: 1800, address: "Montpellier, France", user_id: users[1].id, photo_url: "https://media.lessentiel.lu/18/image/2023/12/05/9142a14e-0548-447b-b277-ad29ad7cb37c.jpeg?auto=format%2Ccompress%2Cenhance&fit=max&w=1200&h=1200&rect=0%2C0%2C600%2C375&s=b99546583c8fd88e5340d186e41d2571" },
  { name: "Indiana Jones", specialty: "Exploration et combat", bio: "Archéologue aventurier intrépide.", price_per_day: 1100, address: "Madrid, Espagne", user_id: users[1].id, photo_url: "https://images.prismic.io/barnebys/144e1b6f-8f03-46db-8a2b-5a54971b823d_hero.webp?w=1200&h=600&fit=crop&crop=faces&auto=format%2Ccompress&cs=tinysrgb" },


  # User 3 (Mike Wilson) - 13 mercenaires
  { name: "Charlie's Angels", specialty: "Espionnage et discrétion", bio: "Trio féminin d’espionnes élégantes.", price_per_day: 2550, address: "Cannes, France", user_id: users[2].id, photo_url: "https://images.bauerhosting.com/legacy/empire-tmdb/films/4327/images/AfXk5IqMZuznjjvEkrQuzQ9A5U6.jpg?ar=16%3A9&fit=crop&crop=top&auto=format&w=1440&q=80" },
  { name: "The Suicide Squad", specialty: "Missions suicide", bio: "Groupe pour missions désespérées.", price_per_day: 2800, address: "Toulouse, France", user_id: users[2].id, photo_url: "https://www.urban-comics.com/wp-content/uploads/2016/11/maxresdefault.jpg" },
  { name: "Sarah Connor", specialty: "Résistance et survie", bio: "Survivante déterminée face aux machines.", price_per_day: 950, address: "Bruges, Belgique", user_id: users[2].id, photo_url: "https://focus.telerama.fr/2024/10/25/44/52/4101/2734/1200/0/60/0/48a3e0e_1729852231702-terminator-2-1991-30.jpg" },
  { name: "Ethan Hunt", specialty: "Missions impossibles", bio: "Expert en opérations à risque.", price_per_day: 1100, address: "Amsterdam, Pays-Bas", user_id: users[2].id, photo_url: "https://media.ouest-france.fr/v1/pictures/MjAxNTAzMzBkODRlMDkzNmEwMjNjMjg0Y2QwNTIwM2U2MDJlOGQ?width=1260&height=708&focuspoint=50%2C25&cropresize=1&client_id=bpeditorial&sign=d8c61adcb68b707cf45af8a72e8c784e495ec944a69594b49613575fb9ff2cf2" },
  { name: "Mad Max", specialty: "Conduite et chaos", bio: "Pilote intrépide dans un monde en ruines.", price_per_day: 875, address: "Brest, France", user_id: users[2].id, photo_url: "https://i.namu.wiki/i/4ymCTIio1yEIJvNOcZjPfenRdmvvixzLD49_xUCpJTyY6rIO79iqAIWMiMYK3Xzc-wCa3anSI1GBWf-H_I8oWA.webp" },
  { name: "Himiko Toga", specialty: "Infiltration et chaos", bio: "Maîtresse du déguisement et du désordre.", price_per_day: 800, address: "Liège, Belgique", user_id: users[2].id, photo_url: "https://images7.alphacoders.com/137/thumb-1920-1378892.png" },
  { name: "Leon", specialty: "Assassinat furtif", bio: "Tueur professionnel au cœur tendre.", price_per_day: 1400, address: "Naples, Italie", user_id: users[2].id, photo_url: "https://medias.spotern.com/spots/w640/357/357700-1719928606.jpg" },
  { name: "T-800", specialty: "Combat mécanique", bio: "Cyborg indestructible, expert en neutralisation de menaces.", price_per_day: 1500, address: "Rennes, France", user_id: users[2].id, photo_url: "https://www.lesuricate.org/wp-content/uploads/2014/04/terminator.jpg" },
  { name: "Katniss Everdeen", specialty: "Survie et guérilla", bio: "Archer habile et résistante.", price_per_day: 850, address: "Nancy, France", user_id: users[2].id, photo_url: "https://image.over-blog.com/BB1TH0fciX9JHAKt3XYq_-pzp8M=/filters:no_upscale()/image%2F0556198%2F20230813%2Fob_0bb9ff_katniss-again-in-new-lsquohunger-games.jpeg" },
  { name: "Bruce Wayne", specialty: "Stratégie militaire", bio: "Justicier masqué maître de la tactique.", price_per_day: 2000, address: "Francfort, Allemagne", user_id: users[2].id, photo_url: "https://static1.purepeople.com/articles/2/77/96/2/@/597230-christian-bale-alias-bruce-wayne-alias-580x0-3.jpg" },
  { name: "Trinity", specialty: "Cybercombat", bio: "Hacker et combattante agile.", price_per_day: 1200, address: "Berlin, Allemagne", user_id: users[2].id, photo_url: "https://www.eklecty-city.fr/wp-content/uploads/2021/04/matrix-movie-picture-06.jpg" },
  { name: "Dwayne Johnson", specialty: "Destruction massive", bio: "Force brute et charisme explosif.", price_per_day: 1700, address: "Toulon, France", user_id: users[2].id, photo_url: "https://buzzdestars.b-cdn.net/wp-content/uploads/2023/07/dwayne-johnson-the-rock.jpg" },
  { name: "Nikita", specialty: "Assassinat et espionnage", bio: "Tueuse d’élite et espionne, formée dans l’ombre pour des missions secrètes.", price_per_day: 1100, address: "Paris, France", user_id: users[2].id, photo_url: "https://cdn.artphotolimited.com/images/5ff5a529bd40b83c5a537440/1000x1000/nikita-scene-de-la-premiere-mission.jpg" }

]

# Sauvegarde des mercenaires avec gestion des erreurs pour les images
mercenaries.each_with_index do |mercenary_data, index|
  begin
    mercenary = Mercenary.new(mercenary_data.except(:photo_url))
    begin
      downloaded_image = URI.open(mercenary_data[:photo_url])
      mercenary.picture.attach(io: downloaded_image, filename: "#{mercenary_data[:name].parameterize}.jpg", content_type: "image/jpeg")
      puts "Image attachée pour #{mercenary_data[:name]}."
    rescue OpenURI::HTTPError, Errno::ENOENT, SocketError => e
      puts "Erreur lors du téléchargement de l'image pour #{mercenary_data[:name]} : #{e.message}. Mercenaire créé sans image."
    end
    mercenary.save!
    puts "Mercenaire #{index + 1} (#{mercenary_data[:name]}) créé avec succès !"
  rescue StandardError => e
    puts "Erreur lors de la création du mercenaire #{index + 1} : #{e.message}"
  end
end
puts "#{Mercenary.count} mercenaires ajoutés à la base de données !"

# Création des bookings avec reviews (aucun utilisateur ne réserve son propre mercenaire)
bookings = [
  # John Doe (users[0]) réserve des mercenaires de Jane Smith (users[1]) et Mike Wilson (users[2])
  { user_id: users[0].id, mercenary_id: Mercenary.find_by(name: "OSS 117").id, start_date: Date.today + 2, end_date: Date.today + 4, total_price: 3 * 900, mission_purpose: "Espionnage discret", mission_place: "Côte d’Azur", review: nil, status: "pending" }, # En attente
  { user_id: users[0].id, mercenary_id: Mercenary.find_by(name: "Ellen Ripley").id, start_date: Date.today + 1, end_date: Date.today + 3, total_price: 3 * 850, mission_purpose: "Chasse aux créatures", mission_place: "Alpes", review: nil, status: "assigned" }, # Assignée
  { user_id: users[0].id, mercenary_id: Mercenary.find_by(name: "MacGyver").id, start_date: Date.today - 5, end_date: Date.today - 3, total_price: 3 * 650, mission_purpose: "Sabotage artisanal", mission_place: "Bretagne", review: nil, status: "cancelled" }, # Annulée
  { user_id: users[0].id, mercenary_id: Mercenary.find_by(name: "Agent 47").id, start_date: Date.today - 1, end_date: Date.today + 1, total_price: 3 * 1300, mission_purpose: "Assassinat précis", mission_place: "Luxembourg", review: nil, status: "in_progress" }, # En cours
  { user_id: users[0].id, mercenary_id: Mercenary.find_by(name: "Charlie's Angels").id, start_date: Date.today - 4, end_date: Date.today - 2, total_price: 3 * 2550, mission_purpose: "Infiltration élégante", mission_place: "Paris", review: { rating: 4, content: "Très classe." }, status: "over" }, # Terminée avec review
  { user_id: users[0].id, mercenary_id: Mercenary.find_by(name: "Ethan Hunt").id, start_date: Date.today - 6, end_date: Date.today - 3, total_price: 4 * 1100, mission_purpose: "Vol de données", mission_place: "Bruxelles", review: nil, status: "over" }, # Terminée sans review
  { user_id: users[0].id, mercenary_id: Mercenary.find_by(name: "Sarah Connor").id, start_date: Date.today - 8, end_date: Date.today - 5, total_price: 4 * 950, mission_purpose: "Résistance aux machines", mission_place: "Lyon", review: { rating: 5, content: "Impressionnante !" }, status: "completed" }, # Réussie avec review
  { user_id: users[0].id, mercenary_id: Mercenary.find_by(name: "Mad Max").id, start_date: Date.today - 10, end_date: Date.today - 7, total_price: 4 * 875, mission_purpose: "Course dans le désert", mission_place: "Sahara", review: nil, status: "completed" }, # Réussie sans review
  { user_id: users[0].id, mercenary_id: Mercenary.find_by(name: "The Suicide Squad").id, start_date: Date.today - 12, end_date: Date.today - 9, total_price: 4 * 2800, mission_purpose: "Mission désespérée", mission_place: "Lille", review: { rating: 2, content: "Trop de chaos." }, status: "failed" }, # Échouée avec review
  { user_id: users[0].id, mercenary_id: Mercenary.find_by(name: "Leon").id, start_date: Date.today - 14, end_date: Date.today - 11, total_price: 4 * 1400, mission_purpose: "Assassinat discret", mission_place: "Naples", review: nil, status: "failed" }, # Échouée sans review

  # Jane Smith (users[1]) réserve des mercenaires de John Doe (users[0]) et Mike Wilson (users[2])
  { user_id: users[1].id, mercenary_id: Mercenary.find_by(name: "John Rambo").id, start_date: Date.today + 2, end_date: Date.today + 4, total_price: 3 * 1200, mission_purpose: "Survie en forêt", mission_place: "Massif des Vosges", review: nil, status: "pending" }, # En attente
  { user_id: users[1].id, mercenary_id: Mercenary.find_by(name: "Wonder Woman").id, start_date: Date.today + 1, end_date: Date.today + 3, total_price: 3 * 2000, mission_purpose: "Récupérer un artefact", mission_place: "Corse", review: nil, status: "assigned" }, # Assignée
  { user_id: users[1].id, mercenary_id: Mercenary.find_by(name: "Chuck Norris").id, start_date: Date.today - 5, end_date: Date.today - 3, total_price: 3 * 1500, mission_purpose: "Combat contre une milice", mission_place: "Pyrénées", review: nil, status: "cancelled" }, # Annulée
  { user_id: users[1].id, mercenary_id: Mercenary.find_by(name: "James Bond").id, start_date: Date.today - 1, end_date: Date.today + 1, total_price: 3 * 1000, mission_purpose: "Espionnage sophistiqué", mission_place: "Londres", review: nil, status: "in_progress" }, # En cours
  { user_id: users[1].id, mercenary_id: Mercenary.find_by(name: "Natasha Romanoff").id, start_date: Date.today - 4, end_date: Date.today - 2, total_price: 3 * 1050, mission_purpose: "Infiltration", mission_place: "Strasbourg", review: { rating: 5, content: "Parfaite." }, status: "over" }, # Terminée avec review
  { user_id: users[1].id, mercenary_id: Mercenary.find_by(name: "Blade").id, start_date: Date.today - 6, end_date: Date.today - 3, total_price: 4 * 950, mission_purpose: "Chasse nocturne", mission_place: "Paris", review: nil, status: "over" }, # Terminée sans review
  { user_id: users[1].id, mercenary_id: Mercenary.find_by(name: "T-800").id, start_date: Date.today - 8, end_date: Date.today - 5, total_price: 4 * 1500, mission_purpose: "Neutralisation", mission_place: "Rennes", review: { rating: 4, content: "Efficace." }, status: "completed" }, # Réussie avec review
  { user_id: users[1].id, mercenary_id: Mercenary.find_by(name: "Katniss Everdeen").id, start_date: Date.today - 10, end_date: Date.today - 7, total_price: 4 * 850, mission_purpose: "Guérilla", mission_place: "Nancy", review: nil, status: "completed" }, # Réussie sans review
  { user_id: users[1].id, mercenary_id: Mercenary.find_by(name: "Jason Bourne").id, start_date: Date.today - 12, end_date: Date.today - 9, total_price: 4 * 1100, mission_purpose: "Combat furtif", mission_place: "Berlin", review: { rating: 3, content: "Moyen." }, status: "failed" }, # Échouée avec review
  { user_id: users[1].id, mercenary_id: Mercenary.find_by(name: "The Punisher").id, start_date: Date.today - 14, end_date: Date.today - 11, total_price: 4 * 1100, mission_purpose: "Vengeance brutale", mission_place: "Barcelone", review: nil, status: "failed" }, # Échouée sans review

  # Mike Wilson (users[2]) réserve des mercenaires de John Doe (users[0]) et Jane Smith (users[1])
  { user_id: users[2].id, mercenary_id: Mercenary.find_by(name: "Tony Stark").id, start_date: Date.today + 2, end_date: Date.today + 4, total_price: 3 * 2500, mission_purpose: "Technologie avancée", mission_place: "Zurich", review: nil, status: "pending" }, # En attente
  { user_id: users[2].id, mercenary_id: Mercenary.find_by(name: "John Spartan").id, start_date: Date.today + 1, end_date: Date.today + 3, total_price: 3 * 1300, mission_purpose: "Combat ultime", mission_place: "Marseille", review: nil, status: "assigned" }, # Assignée
  { user_id: users[2].id, mercenary_id: Mercenary.find_by(name: "Claire Redfield").id, start_date: Date.today - 5, end_date: Date.today - 3, total_price: 3 * 900, mission_purpose: "Survie zombies", mission_place: "Bruxelles", review: nil, status: "cancelled" }, # Annulée
  { user_id: users[2].id, mercenary_id: Mercenary.find_by(name: "L'agence tous risques").id, start_date: Date.today - 1, end_date: Date.today + 1, total_price: 3 * 3000, mission_purpose: "Improvisation tactique", mission_place: "Paris", review: nil, status: "in_progress" }, # En cours
  { user_id: users[2].id, mercenary_id: Mercenary.find_by(name: "Motoko Kusanagi").id, start_date: Date.today - 4, end_date: Date.today - 2, total_price: 3 * 1250, mission_purpose: "Cybercombat", mission_place: "Genève", review: { rating: 5, content: "Incroyable." }, status: "over" }, # Terminée avec review
  { user_id: users[2].id, mercenary_id: Mercenary.find_by(name: "Lara Croft").id, start_date: Date.today - 6, end_date: Date.today - 3, total_price: 4 * 975, mission_purpose: "Fouilles archéologiques", mission_place: "Provence", review: nil, status: "over" }, # Terminée sans review
  { user_id: users[2].id, mercenary_id: Mercenary.find_by(name: "The Expendables").id, start_date: Date.today - 8, end_date: Date.today - 5, total_price: 4 * 3500, mission_purpose: "Destruction massive", mission_place: "Bordeaux", review: { rating: 4, content: "Puissant." }, status: "completed" }, # Réussie avec review
  { user_id: users[2].id, mercenary_id: Mercenary.find_by(name: "Dom Toretto").id, start_date: Date.today - 10, end_date: Date.today - 7, total_price: 4 * 1200, mission_purpose: "Conduite et chaos", mission_place: "Milan", review: nil, status: "completed" }, # Réussie sans review
  { user_id: users[2].id, mercenary_id: Mercenary.find_by(name: "Vegeta").id, start_date: Date.today - 12, end_date: Date.today - 9, total_price: 4 * 2500, mission_purpose: "Puissance Saiyan", mission_place: "Turin", review: { rating: 2, content: "Trop arrogant." }, status: "failed" }, # Échouée avec review
  { user_id: users[2].id, mercenary_id: Mercenary.find_by(name: "James Bond").id, start_date: Date.today - 14, end_date: Date.today - 11, total_price: 4 * 1000, mission_purpose: "Infiltration", mission_place: "Munich", review: nil, status: "failed" }, # Échouée sans review
]

# Sauvegarde des bookings et ajout des reviews
bookings.each_with_index do |booking_data, index|
  begin
    booking = Booking.new(booking_data.except(:review, :status))
    booking.status = booking_data[:status] # Appliquer le statut manuellement
    booking.save!
    if booking_data[:review]
      Review.create!(booking_id: booking.id, rating: booking_data[:review][:rating], content: booking_data[:review][:content])
      puts "Booking #{index + 1} avec revue créé avec succès !"
    else
      puts "Booking #{index + 1} créé avec succès (sans revue) !"
    end
  rescue StandardError => e
    puts "Erreur lors de la création du booking #{index + 1} : #{e.message}"
  end
end
puts "#{Booking.count} bookings et #{Review.count} reviews ajoutés à la base de données !"
