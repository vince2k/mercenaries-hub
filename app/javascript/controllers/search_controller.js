import { Controller } from "@hotwired/stimulus";

// Fonction utilitaire : distance de Levenshtein
function levenshteinDistance(a, b) {
  const dp = Array.from({ length: a.length + 1 }, () => new Array(b.length + 1).fill(0));

  for (let i = 0; i <= a.length; i++) dp[i][0] = i;
  for (let j = 0; j <= b.length; j++) dp[0][j] = j;

  for (let i = 1; i <= a.length; i++) {
    for (let j = 1; j <= b.length; j++) {
      if (a[i - 1] === b[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1];
      } else {
        dp[i][j] = 1 + Math.min(
          dp[i - 1][j],    // Suppression
          dp[i][j - 1],    // Insertion
          dp[i - 1][j - 1] // Substitution
        );
      }
    }
  }

  return dp[a.length][b.length];
}

export default class extends Controller {
  static targets = ["query"];

  connect() {
    console.log("Search controller connected");
  }

  updateMap(event) {
    clearTimeout(this.searchTimeout);

    this.searchTimeout = setTimeout(() => {
      const searchTerm = event.target.value.trim().toLowerCase();
      console.log("Recherche en cours :", searchTerm);

      if (!searchTerm) return;

      if (!window.mapController || !window.mapController.markersMap) {
        console.error("Erreur : mapController ou markersMap n'est pas défini ");
        return;
      }

      const markersMap = window.mapController.markersMap;

      const foundMarkerEntry = Object.entries(markersMap).find(([name, marker]) => {
        if (name.length !== searchTerm.length) return false;

        // Calcule la distance de Levenshtein
        const distance = levenshteinDistance(name, searchTerm);
        // Tolère jusqu'à 2 fautes
        return distance <= 2;
      });

      if (foundMarkerEntry) {
        const [matchedName, foundMarker] = foundMarkerEntry;
        console.log("Mercenaire trouvé (fuzzy match) :", matchedName);

        window.mapController.map.flyTo({
          center: foundMarker.getLngLat(),
          zoom: 12
        });

        foundMarker.togglePopup();
      } else {
        console.warn("Aucun mercenaire trouvé pour :", searchTerm);
      }
    }, 300);
  }
}
