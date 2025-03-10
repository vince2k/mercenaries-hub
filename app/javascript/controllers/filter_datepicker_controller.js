// app/javascript/controllers/filter_datepicker_controller.js
import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["datepicker", "startDate", "endDate"];
  static values = { bookedDates: Array };

  connect() {
    console.log("Filter Datepicker controller connected");
    const bookedDates = this.bookedDatesValue;
    console.log("Booked dates for filter:", bookedDates);

    flatpickr(this.datepickerTarget, {
      mode: "range",
      dateFormat: "d/m/Y",
      disable: bookedDates,
      minDate: "today",
      locale: { firstDayOfWeek: 1 },
      onChange: (selectedDates) => {
        if (selectedDates.length === 2) {
          const formatDate = (date) => {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, "0");
            const day = String(date.getDate()).padStart(2, "0");
            return `${year}-${month}-${day}`;
          };

          if (this.hasStartDateTarget) {
            this.startDateTarget.value = formatDate(selectedDates[0]);
          }
          if (this.hasEndDateTarget) {
            this.endDateTarget.value = formatDate(selectedDates[1]);
          }

          // Met à jour le champ visible
          this.datepickerTarget.value = `${selectedDates[0].toLocaleDateString("fr-FR")} au ${selectedDates[1].toLocaleDateString("fr-FR")}`;

          // Soumet le formulaire automatiquement (optionnel)
          this.element.closest("form").submit();
        }
      }
    });
  }
}
