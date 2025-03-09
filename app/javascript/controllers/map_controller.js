import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    console.log("Map controller connected!");

    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/dark-v10"
    });

    window.mapController = this;

    this.markersMap = {};

    this.addMarkersToMap();
    this.fitMapToMarkers();
  }

  addMarkersToMap() {
    this.markersMap = {};

    this.markersValue.forEach(marker => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);

      const newMarker = new mapboxgl.Marker({ color: "#1f3148" })
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);

      const normalizedName = marker.name.toLowerCase().trim();
      this.markersMap[normalizedName] = newMarker;
    });

    console.log("Marqueurs chargés :", this.markersMap);
  }

  fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach(marker => {
      bounds.extend([marker.lng, marker.lat]);
    });
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}
