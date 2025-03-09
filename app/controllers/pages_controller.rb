class PagesController < ApplicationController
  def home
    @mercenaries = Mercenary.limit(6)

    # returns the best 6 rated mercenaries
    @best6_mercenaries = best_rated
  end

  def best_rated
    @mercenaries_array = Mercenary.all
    @m_id = 0
    @average_rating = []
    @bookings = @mercenaries_array.map { |mercenary| mercenary.bookings}
    # .map car c'est un array, on récupère les avis
    # @reviews = @bookings.map {|booking| booking.review}

    # pour chaque mercenaire on récupère la note moyenne de ses avis
    # on itère sur l'array de tous les mercenaires
    @mercenaries_array.each do |item|
      # pour chaque mercenaire on récupère son id
      @m_id = item.id
      # pour chaque mercenaire on récupère les bookings
      @mercenary_bookings = item.bookings
      # Pour chaque booking on récupère les avis / la moyenne des notes
      # on initialise la variable à 0
      @average_mercenary_rating = 0
      @mercenary_rating_array = []
      # on itère sur les bookings pour récupérer les avis pour chaque booking
      @mercenary_bookings.each do |booking|
        # si pas d'avis donné alors la note est 0
        if booking.review == nil
          @mercenary_rating_array << 0
        else
          # si des avis sont donnés alors on récupère les notes de chaque avis
          @mercenary_rating_array << booking.review.rating
        end

        # si plusieurs notes on fait la moyenne
        if @mercenary_rating_array.count > 1
          @average = @mercenary_rating_array.inject{ |sum, el| sum + el }.to_f / @mercenary_rating_array.size
        else
          # sinon on récupère la note du seul avis
          @average = @mercenary_rating_array.first
        end
      end
      # on stocke l'identifiant du mercenaire et sa note globale de tous ses bookings
      @average_rating << [@m_id, @average]
    end
    # on retourne les 6 meilleurs notes avec les identifiants de mecenaires
    @average_rating.max(6)
  end
end
