import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["query"];

  connect() {
    console.log("Search controller connected");
  }

  updateMap(event) {
    clearTimeout(this.searchTimeout);

    this.searchTimeout = setTimeout(() => {
      const searchTerm = event.target.value.trim().toLowerCase();
      console.log("🔍 Recherche en cours :", searchTerm);

      if (!searchTerm) return;

      const markers = window.mapController.markersMap;
      if (!markers) {
        console.error("Erreur : Aucun marqueur n'est chargé");
        return;
      }

      const foundMarkerEntry = Object.entries(markers).find(([name, marker]) =>
        name.includes(searchTerm)
      );

      if (foundMarkerEntry) {
        const [matchedName, foundMarker] = foundMarkerEntry;
        console.log("Mercenaire trouvé :", matchedName);

        window.mapController.map.flyTo({
          center: foundMarker.getLngLat(),
          zoom: 12,
        });

        foundMarker.togglePopup();
      } else {
        console.warn("Aucun mercenaire trouvé pour :", searchTerm);
      }
    }, 300);
  }
}
