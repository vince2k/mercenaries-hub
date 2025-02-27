# Nettoyage des tables dans le bon ordre : mercenaires d'abord, puis utilisateurs
Mercenary.destroy_all
puts "Table mercenaries nettoyée !"
User.destroy_all
puts "Table users nettoyée !"

# Création des 3 utilisateurs (compatible avec Devise)
users = [
  User.new(
    email: "john.doe@example.com",
    first_name: "John",
    last_name: "Doe",
    nickname: "Johnny",
    password: "password123"
  ),
  User.new(
    email: "jane.smith@example.com",
    first_name: "Jane",
    last_name: "Smith",
    nickname: "Janie",
    password: "password123"
  ),
  User.new(
    email: "mike.wilson@example.com",
    first_name: "Mike",
    last_name: "Wilson",
    nickname: "Mikey",
    password: "password123"
  )
]

# Sauvegarde des utilisateurs avec gestion des erreurs
users.each_with_index do |user, index|
  begin
    user.save!
    puts "Utilisateur #{index + 1} (#{user.email}) créé avec succès !"
  rescue StandardError => e
    puts "Erreur lors de la création de l'utilisateur #{index + 1} : #{e.message}"
  end
end

puts "#{User.count} utilisateurs ajoutés à la base de données !"

# Création des mercenaires avec URLs d'images directes
mercenaries = [
  # User 1 (John Doe)
  {
    name: "John Rambo",
    specialty: "Survie et guérilla",
    bio: "Ancien béret vert, expert en survie dans les pires conditions et maître de la guérilla.",
    price_per_day: 1200,
    address: "Forêt de Hope, Colorado, USA",
    user_id: users[0].id,
    photo_url: "https://img.rts.ch/articles/2019/image/jqdogq-25970995.image?w=1280&h=720"
  },
  {
    name: "Wonder Woman",
    specialty: "Combat mythique",
    bio: "Princesse amazone de Themyscira, dotée de force surhumaine et d’un lasso de vérité.",
    price_per_day: 2000,
    address: "Île de Themyscira, Mer Égée",
    user_id: users[0].id,
    photo_url: "https://www.radiofrance.fr/s3/cruiser-production/2021/10/d34e0294-c579-48f5-a6c9-1d7af3deb6c0/1200x680_1200x680-wonder-woman-1984.jpg"
  },
  {
    name: "Chuck Norris",
    specialty: "Combat ultime",
    bio: "Légende vivante, capable de terrasser n’importe qui d’un simple regard.",
    price_per_day: 1500,
    address: "Ranch Norris, Texas, USA",
    user_id: users[0].id,
    photo_url: "https://media.gettyimages.com/id/525603356/fr/photo/chuck-norris-poses-with-two-uzis-his-sleeveless-denim-shirt-unbuttoned-to-his-waist-publicity.jpg?s=612x612&w=gi&k=20&c=pNPFch6zbQgmYqAiIj6g8dwui09ItFllocQxWDWo5AM="
  },
  {
    name: "Agence tous risques",
    specialty: "Tout-en-un",
    bio: "Équipe de choc prête à tout : planification, explosifs et improvisation.",
    price_per_day: 3000,
    address: "QG mobile, Los Angeles, USA",
    user_id: users[0].id,
    photo_url: "https://images2.minutemediacdn.com/image/upload/c_fill,w_720,ar_16:9,f_auto,q_auto,g_auto/shape/cover/sport/a-team-1-4bac746d6d38f0aa6ce70a97629a3918.jpg"
  },
  {
    name: "James Bond",
    specialty: "Espionnage et gadgets",
    bio: "Agent 007 au service de Sa Majesté, maître des gadgets et des martinis.",
    price_per_day: 1000,
    address: "MI6, Londres, Royaume-Uni",
    user_id: users[0].id,
    photo_url: "https://www.ecranlarge.com/content/uploads/2025/02/james-bond-daniel-craig-reagit-a-la-main-mise-damazon-sur-la-saga-1260x708.jpg"
  },
  {
    name: "Natasha Romanoff",
    specialty: "Infiltration et combat",
    bio: "Veuve Noire, ex-agent du KGB devenue experte en espionnage pour les Avengers.",
    price_per_day: 1050,
    address: "Base secrète SHIELD, New York, USA",
    user_id: users[0].id,
    photo_url: "https://media.licdn.com/dms/image/v2/C4E12AQH5xZoisRSXwQ/article-cover_image-shrink_720_1280/article-cover_image-shrink_720_1280/0/1555420431630?e=2147483647&v=beta&t=NOfXkQDXyOa-_FmzH2sRgPNxU5PMO0l76My_cQQx7u0"
  },
  {
    name: "Motoko Kusanagi",
    specialty: "Cybercombat",
    bio: "Cyborg d’élite, leader de la Section 9 dans un monde futuriste.",
    price_per_day: 1250,
    address: "Niihama, Japon futuriste",
    user_id: users[0].id,
    photo_url: "https://cdn-www.konbini.com/files/2024/05/Feat-ghost-inf-the-shell.jpg?width=3840&quality=75&format=webp"
  },

  # User 2 (Jane Smith)
  {
    name: "OSS 117",
    specialty: "Espionnage et humour",
    bio: "Agent secret français aussi maladroit que charmeur, expert en quiproquos.",
    price_per_day: 900,
    address: "Paris, France",
    user_id: users[1].id,
    photo_url: "https://d32gva8s8jjsl4.cloudfront.net/img/p/1/1/3/5/9/11359-cover_large.jpg"
  },
  {
    name: "Ellen Ripley",
    specialty: "Combat extraterrestre",
    bio: "Survivante légendaire face aux xénomorphes, courage et détermination incarnés.",
    price_per_day: 850,
    address: "Vaisseau Nostromo, espace profond",
    user_id: users[1].id,
    photo_url: "https://www.fulguropop.com/wp-content/uploads/2020/03/aliens-1-1200x649.jpg"
  },
  {
    name: "MacGyver",
    specialty: "Bricolage et explosifs",
    bio: "Génie de l’improvisation, transforme un trombone en arme fatale.",
    price_per_day: 650,
    address: "Phoenix Foundation, Californie, USA",
    user_id: users[1].id,
    photo_url: "https://i0.wp.com/scriiipt.com/wp-content/uploads/2024/09/macgyver.png?fit=1200%2C675&ssl=1"
  },
  {
    name: "Agent 47",
    specialty: "Assassinat furtif",
    bio: "Tueur à gages génétiquement modifié, précision chirurgicale garantie.",
    price_per_day: 1300,
    address: "Lieu inconnu, monde entier",
    user_id: users[1].id,
    photo_url: "https://www.rostercon.com/wp-content/uploads/2014/01/hitman-agent-47.jpg"
  },
  {
    name: "Vegeta",
    specialty: "Puissance Saiyan",
    bio: "Prince des Saiyans, guerrier d’une force dévastatrice et d’un ego monumental.",
    price_per_day: 2500,
    address: "Capsule Corp, West City, Terre DBZ",
    user_id: users[1].id,
    photo_url: "https://pm1.aminoapps.com/6778/5496aa3e2a85852a118cf6bbccc9192938710deav2_00.jpg"
  },
  {
    name: "The Punisher",
    specialty: "Vengeance brutale",
    bio: "Justicier impitoyable, traque les criminels sans relâche.",
    price_per_day: 1100,
    address: "Hell’s Kitchen, New York, USA",
    user_id: users[1].id,
    photo_url: "https://ew.com/thmb/gb8what92jHBR5tInysOU1QShjY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Jon-Bernthal-Daredevil-Born-Again-Set-1-040324-068b3bb6a6204864a21655e7c6a63fda.jpg"
  },
  {
    name: "Les Expendables",
    specialty: "Destruction massive",
    bio: "Équipe de mercenaires vétérans, experts en chaos et explosions.",
    price_per_day: 3500,
    address: "Base secrète, Nouvelle-Orléans, USA",
    user_id: users[1].id,
    photo_url: "https://image.jeuxvideo.com/medias-md/168624/1686238626-7233-card.jpg"
  },
  {
    name: "Lara Croft",
    specialty: "Exploration et combat",
    bio: "Aventurière intrépide, chasseuse de trésors et combattante aguerrie.",
    price_per_day: 975,
    address: "Manoir Croft, Surrey, Royaume-Uni",
    user_id: users[1].id,
    photo_url: "https://sm.ign.com/ign_fr/news/t/tomb-raide/tomb-raider-dev-reveals-lara-crofts-official-redesign_kxdj.jpg"
  },

  # User 3 (Mike Wilson)
  {
    name: "Charlie's Angels",
    specialty: "Espionnage et discrétion",
    bio: "Trio d’agents secrets, aussi élégantes que mortelles.",
    price_per_day: 2550,
    address: "Agence Townsend, Los Angeles, USA",
    user_id: users[2].id,
    photo_url: "https://images.bauerhosting.com/legacy/empire-tmdb/films/4327/images/AfXk5IqMZuznjjvEkrQuzQ9A5U6.jpg?ar=16%3A9&fit=crop&crop=top&auto=format&w=1440&q=80"
  },
  {
    name: "The Suicide Squad",
    specialty: "Missions suicide",
    bio: "Équipe de criminels recrutés pour des missions désespérées.",
    price_per_day: 2800,
    address: "Prison de Belle Reve, Louisiane, USA",
    user_id: users[2].id,
    photo_url: "https://www.urban-comics.com/wp-content/uploads/2016/11/maxresdefault.jpg"
  },
  {
    name: "Sarah Connor",
    specialty: "Résistance et survie",
    bio: "Mère de la résistance contre Skynet, experte en combat et survie.",
    price_per_day: 950,
    address: "Cachette mobile, Californie, USA",
    user_id: users[2].id,
    photo_url: "https://focus.telerama.fr/2024/10/25/44/52/4101/2734/1200/0/60/0/48a3e0e_1729852231702-terminator-2-1991-30.jpg"
  },
  {
    name: "Ethan Hunt",
    specialty: "Missions impossibles",
    bio: "Agent de l’IMF, spécialiste des opérations à haut risque.",
    price_per_day: 1100,
    address: "QG IMF, Washington D.C., USA",
    user_id: users[2].id,
    photo_url: "https://media.ouest-france.fr/v1/pictures/MjAxNTAzMzBkODRlMDkzNmEwMjNjMjg0Y2QwNTIwM2U2MDJlOGQ?width=1260&height=708&focuspoint=50%2C25&cropresize=1&client_id=bpeditorial&sign=d8c61adcb68b707cf45af8a72e8c784e495ec944a69594b49613575fb9ff2cf2"
  },
  {
    name: "Mad Max",
    specialty: "Conduite et chaos",
    bio: "Survivant solitaire dans un monde post-apocalyptique, maître de la route.",
    price_per_day: 875,
    address: "Wasteland, Australie",
    user_id: users[2].id,
    photo_url: "https://i.namu.wiki/i/4ymCTIio1yEIJvNOcZjPfenRdmvvixzLD49_xUCpJTyY6rIO79iqAIWMiMYK3Xzc-wCa3anSI1GBWf-H_I8oWA.webp"
  },
  {
    name: "Himiko Toga",
    specialty: "Infiltration et chaos",
    bio: "Membre dérangée de la Ligue des Vilains, experte en déguisement.",
    price_per_day: 800,
    address: "Repaire secret, Japon",
    user_id: users[2].id,
    photo_url: "https://images7.alphacoders.com/137/thumb-1920-1378892.png"
  }
]

# Sauvegarde des mercenaires avec gestion des erreurs
mercenaries.each_with_index do |mercenary_data, index|
  begin
    Mercenary.create!(mercenary_data)
    puts "Mercenaire #{index + 1} (#{mercenary_data[:name]}) créé avec succès !"
  rescue StandardError => e
    puts "Erreur lors de la création du mercenaire #{index + 1} : #{e.message}"
  end
end

puts "#{Mercenary.count} mercenaires/héros d'action ajoutés à la base de données !"
