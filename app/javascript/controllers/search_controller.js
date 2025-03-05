import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["query"];

  updateMap(event) {
    const searchTerm = event.target.value.trim().toLowerCase();
    console.log("Recherche utilisateur :", searchTerm);

    const markers = window.mapController.markersMap;
    if (!markers) {
      console.error("Erreur : Aucun marqueur n'est chargé !");
      return;
    }

    const foundMarker = markers[searchTerm];

    if (foundMarker) {
      console.log("Mercenaire trouvé :", searchTerm);
      window.mapController.map.flyTo({
        center: foundMarker.getLngLat(),
        zoom: 12
      });
      foundMarker.togglePopup();
    } else {
      console.warn("Aucun mercenaire trouvé pour :", searchTerm);
    }
  }
}
